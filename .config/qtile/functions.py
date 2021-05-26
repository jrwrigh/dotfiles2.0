from libqtile.lazy import lazy
from libqtile.log_utils import logger

    # Display handling
from Xlib import display as xdisplay

def get_num_monitors():
    """Get the number of monitors activated on the computer"""
    num_monitors = 0
    try:
        display = xdisplay.Display()
        screen = display.screen()
        resources = screen.root.xrandr_get_screen_resources()._data

        for output in resources['outputs']:
            monitor = display.xrandr_get_output_info(output, resources['config_timestamp'])._data
            preferred = False
            if "preferred" in monitor.keys():
                preferred = monitor['preferred']
            elif "num_preferred" in monitor.keys():
                preferred = monitor['num_preferred']
            if preferred:
                num_monitors += 1
    except Exception:
        # always setup at least one monitor
        return 1
    else:
        return num_monitors


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
            qtile.cmd_to_screen(j)
            group.cmd_toscreen()

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

    return _viewGroup
