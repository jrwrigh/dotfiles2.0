import libqtile
from libqtile.lazy import lazy
from libqtile.log_utils import logger

    # Display handling
from Xlib import display as xdisplay
from Xlib.ext.randr import Connected as RR_Connected
import re, glob

def is_closed_lid(output: str):
    """Determine if laptop lid is closed

    Taken from autorandr: https://github.com/phillipberndt/autorandr/blob/4f010c576/autorandr.py#L99-L108"""
    if not re.match(r'(eDP(-?[0-9]\+)*|LVDS(-?[0-9]\+)*)', output):
        return False
    lids = glob.glob("/proc/acpi/button/lid/*/state")
    if len(lids) == 1:
        state_file = lids[0]
        with open(state_file) as f:
            content = f.read()
            return "close" in content
    return False

def get_num_monitors():
    """Get the number of monitors activated on the computer"""
    num_monitors = 0
    try:
        display = xdisplay.Display()
        screen = display.screen()
        resources = screen.root.xrandr_get_screen_resources()._data

        for output in resources['outputs']:
            monitor = display.xrandr_get_output_info(output, resources['config_timestamp'])._data
            if monitor['connection'] == RR_Connected and not is_closed_lid(monitor['name']):
                num_monitors += 1
    except Exception:
        return 1 #always return at least 1 monitor
    else:
        return num_monitors


def get_monitor_resolutions() -> list[tuple]:
    """Resolutions of monitors"""
    resolutions = []
    try:
        display = xdisplay.Display()
        screen = display.screen()
        resources = screen.root.xrandr_get_screen_resources()._data

        for output in resources['outputs']:
            monitor = display.xrandr_get_output_info(output, resources['config_timestamp'])._data
            if monitor['connection'] == RR_Connected and not is_closed_lid(monitor['name']) and monitor['crtc']:
                crtc = display.xrandr_get_crtc_info(monitor['crtc'], resources['config_timestamp'])._data
                resolutions.append((crtc['width'], crtc['height']))
    except Exception:
        logger.error('Failed to get monitor resolutions', exc_info=True)
        return [(0,0)]
    else:
        return resolutions


def get_XScreen_resolution():
    """Get resolution of XScreen (not monitors)"""
    try:
        display = xdisplay.Display()
        screen = display.screen()
    except Exception:
        return (0, 0)
    else:
        return (screen.width_in_pixels, screen.height_in_pixels)

def ungrab_chord():
    """Shortened version for ungrabing keychords"""
    @lazy.function
    def _ungrab_chord(qtile):
        qtile.ungrab_chord()
    return _ungrab_chord

def warp_cursor_here_win(win):
    if win is not None:
        win.window.warp_pointer(win.width // 2, win.height // 2)

def warp_cursor_here():
    '''Warp the cursor to the currently focused window'''
    @lazy.function
    def _warp_cursor_here(qtile):
        win = qtile.current_window
        warp_cursor_here_win(win)
    return _warp_cursor_here


def swap_next_screen():
    """Doesn't work"""
    @lazy.function
    def _swap_next_screen(qtile):
        if len(qtile.screens) != 2: return
        i = qtile.screens.index(qtile.current_screen)

        if qtile.current_group:
            group = qtile.screens[i - 1].group
            qtile.groups[group.name].cmd_toscreen()
    return _swap_next_screen


def move_next_screen():
    @lazy.function
    def _move_next_screen(qtile):
        if len(qtile.screens) != 2: return
        i = qtile.screens.index(qtile.current_screen)
        j = 0 if i == 1 else 1

        if qtile.current_group:
            group = qtile.current_group
            logger.warning(f'Move group "{group.name}" from screen {i}->{j}')
            qtile.focus_screen(j)
            group.cmd_toscreen()
            warp_cursor_here_win(group.current_window)

    return _move_next_screen


def viewGroup(name):
    '''Smarter group view switching

    Display group on current screen if not otherwise displayed. If group is
    already displayed, switch focus to that screen

    Modified from: https://gist.github.com/TauPan/9c09bd9defc5ac3c9e06#file-config-py-L86-L103
    '''
    @lazy.function
    def _viewGroup(qtile):

        group = qtile.groups_map[name]
        if group != qtile.current_group:
            if group.screen:
                qtile.cmd_to_screen(group.screen.index)
                warp_cursor_here_win(qtile.current_window)
            else:
                group.cmd_toscreen()
                warp_cursor_here_win(qtile.current_window)

    return _viewGroup

def toggle_focus_floating():
    '''Toggle focus between floating window and other windows in group'''

    @lazy.function
    def _toggle_focus_floating(qtile):
        group = qtile.current_group
        switch = 'non-float' if qtile.current_window.floating else 'float'
        logger.debug(f'toggle_focus_floating: switch = {switch}\t current_window: {qtile.current_window}')
        logger.debug(f'focus_history: {group.focus_history}')


        for win in reversed(group.focus_history):
            logger.debug(f'{win}: {win.floating}')
            if switch=='float' and win.floating:
                # win.focus(warp=False)
                group.focus(win)
                return
            if switch=='non-float' and not win.floating:
                # win.focus(warp=False)
                group.focus(win)
                return
    return _toggle_focus_floating


class MutScratch(object):


    def __init__(self, win_attr='mutscratch', grp_attr='mutscratch_history', grp_name=''):

        self.win_attr = win_attr
        self.grp_attr = grp_attr
        self.grp_name = grp_name

        self.win_stack = []

    def add2Scratch(self):
        '''Add current window to the MutScratch system'''
        @lazy.function
        def _add2Scratch(qtile):
            win = qtile.current_window
            win.hide()
            win.floating = True
            setattr(win, self.win_attr, True)

            win.togroup(self.grp_name)
            self.win_stack.append(win)

        return _add2Scratch


    def removeScratch(self):
        '''Remove current window from MutScratch system'''
        @lazy.function
        def _removeScratch(qtile):
            win = qtile.current_window
            setattr(win, self.win_attr, False)

            if win in self.win_stack:
                self.win_stack.remove(win)
        return _removeScratch


    def toggleScratch(self):
        '''Toggle between hiding/showing MinScratch windows'''
        @lazy.function
        def _toggleScratch(qtile):
            win = qtile.current_window
            if getattr(win, self.win_attr, False):
                self._pushScratch(win)
            else:
                self._popScratch(qtile, win)
        return _toggleScratch


    def qtile_startup(self):
        '''Initialize MinScratch group on restarts

        Put
            hook.subscribe.startup_complete(<MutScratch>.qtile_startup)
        in your config.py to initialize the windows in the MutScratch group
        '''

        qtile = libqtile.qtile
        group = qtile.groups_map[self.grp_name]

        wins = list(group.windows)
        for win in wins:
            win.floating = True
            setattr(win, self.win_attr, True)

        self.win_stack = list(group.windows)

    def _pushScratch(self, win):
        win.togroup(self.grp_name)
        self.win_stack.append(win)

    def _popScratch(self, qtile, win):
        group = qtile.groups_map[self.grp_name]
        if set(self.win_stack) != group.windows:
            logger.warning(f"{self}'s win_stack and {group}'s windows have mismatching windows: "
                           f"{set(self.win_stack).symmetric_difference(group.windows)}")
            self.win_stack = list(group.windows)
        if self.win_stack:
            win = self.win_stack.pop(0)
            win.togroup(qtile.current_group.name)
