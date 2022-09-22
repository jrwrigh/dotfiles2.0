from typing import List  # noqa: F401
import os
import subprocess

from libqtile import bar, layout, widget, hook
from libqtile.config import Click, Drag, Group, Key, EzKey, Screen, KeyChord
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal
from libqtile.log_utils import logger
from libqtile import qtile

from plasma import Plasma

import functions as f
from theme import monokai
from floating_rules import floating_matches

from pathlib import Path
import os

try:
    import aiomanhole
except ImportError:
    aiomanhole = None

from importlib import reload
reload(f)

num_screens = f.get_num_monitors()
logger.warning(f'Number of monitors: {num_screens}')
logger.warning(f'Monitor resolutions:{f.get_monitor_resolutions()}')
backup_monitor = 'eDP-1'

mod = "mod4"
terminal = guess_terminal()

wallpaper_envvar = 'QTILE_WALLPAPER'
wallpaper_mode = 'fill'
wallpaper_default = Path('~/.local/share/backgrounds/SquareTopMountain_4K.jpg').expanduser()
wallpaper_dir = Path('~/.local/share/backgrounds/').expanduser()
if  wallpaper_envvar in os.environ.keys():
    logger.warning(f'Found ${wallpaper_envvar}: {os.environ[wallpaper_envvar]}')
    wallpaper = Path(os.environ[wallpaper_envvar]).expanduser()
else:
    logger.warning(f"Didn't find ${wallpaper_envvar}. Using {wallpaper_default} instead")
    wallpaper = wallpaper_default

escapeKeys = ['q', '<Return>', 'C-<bracketleft>', '<BackSpace>']
escapeChord = [ EzKey(key, lazy.ungrab_chord()) for key in  escapeKeys]

keys = [
    # Switch between windows
    EzKey('M-h', lazy.layout.left(),  f.warp_cursor_here(), desc='Switch focus left'),
    EzKey('M-l', lazy.layout.right(), f.warp_cursor_here(), desc='Switch focus right'),
    EzKey('M-j', lazy.layout.down(),  f.warp_cursor_here(), desc='Switch focus lower'),
    EzKey('M-k', lazy.layout.up(),    f.warp_cursor_here(), desc='Switch focus upper'),

    EzKey('M-S-h', lazy.layout.move_left(),  f.warp_cursor_here()),
    EzKey('M-S-l', lazy.layout.move_right(), f.warp_cursor_here()),
    EzKey('M-S-j', lazy.layout.move_down(),  f.warp_cursor_here()),
    EzKey('M-S-k', lazy.layout.move_up(),    f.warp_cursor_here()),

    EzKey('M-A-h', lazy.layout.integrate_left(),  f.warp_cursor_here()),
    EzKey('M-A-l', lazy.layout.integrate_right(), f.warp_cursor_here()),
    EzKey('M-A-j', lazy.layout.integrate_down(),  f.warp_cursor_here()),
    EzKey('M-A-k', lazy.layout.integrate_up(),    f.warp_cursor_here()),

    KeyChord([mod], 'q', [
        EzKey('v',   lazy.layout.mode_horizontal(),       lazy.ungrab_chord()),
        EzKey('h',   lazy.layout.mode_vertical(),         lazy.ungrab_chord()),
        EzKey('S-v', lazy.layout.mode_horizontal_split(), lazy.ungrab_chord()),
        EzKey('S-h', lazy.layout.mode_vertical_split(),   lazy.ungrab_chord()),
        *escapeChord
    ], mode='(h)orizontal, (v)ertical, (H)orizontal split, (V)ertical split'),

    EzKey('M-C-h', lazy.layout.grow_width(-30)),
    EzKey('M-C-l', lazy.layout.grow_width(30)),
    EzKey('M-C-j', lazy.layout.grow_height(-30)),
    EzKey('M-C-k', lazy.layout.grow_height(30)),
    EzKey('M-r',   lazy.layout.reset_size()),

    EzKey('M-S-<space>', lazy.window.toggle_floating(),   f.warp_cursor_here()),
    EzKey('M-<space>',   f.toggle_focus_floating(),       f.warp_cursor_here()),
    EzKey('M-f',         lazy.window.toggle_fullscreen(), f.warp_cursor_here()),

    KeyChord([mod], 'm', [
        EzKey('m',  f.move_next_screen(), lazy.ungrab_chord()),
        EzKey('s',   lazy.next_screen(), lazy.ungrab_chord()),
        *escapeChord
    ], mode='(s)wap or (m)ove to other screen'),
    EzKey('M-s', lazy.next_screen(), f.warp_cursor_here()),
    EzKey('M-b', f.set_wallpaper(wallpaper_dir, mode=wallpaper_mode),
          f.warp_cursor_here()),

    # Volume normally handled automatically by pa-applet
    EzKey('M-S-C-k',      lazy.spawn('playerctl play-pause'.split(' '))),
    EzKey('M-S-C-j',      lazy.spawn('playerctl previous'.split(' '))),
    EzKey('M-S-C-l',      lazy.spawn('playerctl next'.split(' '))),
    EzKey('M-S-C-<Up>',   lazy.spawn('pactl set-sink-volume @DEFAULT_SINK@ +10%'.split(' '))),
    EzKey('M-S-C-<Down>', lazy.spawn('pactl set-sink-volume @DEFAULT_SINK@ -10%'.split(' '))),
    EzKey('M-S-C-m',      lazy.spawn('pactl set-sink-mute @DEFAULT_SINK@ toggle'.split(' '))),

    EzKey('M-t',   lazy.spawn('pkill picom'.split(' '))),
    EzKey('M-C-t', lazy.spawn('picom -b'.split(' '))),
    EzKey('M-S-d', f.set_one_screen()),

    Key([mod], 'Return', lazy.spawn(terminal), f.warp_cursor_here()),

    # Toggle between different layouts as defined below
    Key([mod], 'Tab', lazy.next_layout(), f.warp_cursor_here()),
    Key([mod, 'shift'], 'q', lazy.window.kill(), f.warp_cursor_here()),
    EzKey('M-d', lazy.spawn('dmenu_recency'), f.warp_cursor_here()),
    EzKey('M-z', lazy.spawn('morc_menu'), f.warp_cursor_here()),

    Key([mod, 'shift'], 'r', lazy.restart()),
]

SystemStatus = '(l)ock, (e)xit, switch_(u)ser, (s)uspend, (h)ibernate, (Shift+r)eboot, (Shift+s)hutdown'
keys.append(
    KeyChord([mod], '0', [
        EzKey('l',   lazy.spawn('i3exit_custom lock'),        lazy.ungrab_chord()),
        EzKey('s',   lazy.spawn('i3exit_custom suspend'),     lazy.ungrab_chord()),
        EzKey('u',   lazy.spawn('i3exit_custom switch_user'), lazy.ungrab_chord()),
        EzKey('e',   lazy.spawn('i3exit_custom logout'),      lazy.ungrab_chord()),
        EzKey('h',   lazy.spawn('i3exit_custom hibernate'),   lazy.ungrab_chord()),
        EzKey('S-r', lazy.spawn('i3exit_custom reboot'),      lazy.ungrab_chord()),
        EzKey('S-s', lazy.spawn('i3exit_custom shutdown'),    lazy.ungrab_chord()),
        *escapeChord
    ], mode=SystemStatus)
)


groups = [Group(i) for i in '123456789']
for group in groups:
    keys.extend([
        Key([mod], group.name, f.viewGroup(group.name),
            desc='Switch to group {}'.format(group.name)),

        Key([mod, 'shift'], group.name, lazy.window.togroup(group.name, switch_group=True),
            desc='Switch to & move focused window to group {}'.format(group.name)),
    ])

## Make MutScratch Group
minscr = f.MutScratch()
groups.append(Group(''))

keys.extend( [
    EzKey('M-S-<minus>', minscr.add2Scratch()),
    EzKey('M-C-<minus>', minscr.removeScratch()),
    EzKey('M-<minus>',   minscr.toggleScratch()),
] )

hook.subscribe.startup_complete(minscr.qtile_startup)

plasma_kwargs = dict(
        border_normal       = '#333333',
        border_focus        = monokai.green,
        border_normal_fixed = '#006863',
        border_focus_fixed  = '#00e8dc',
        border_width        = 1,
        border_width_single = 0
)

screen_res = f.get_monitor_resolutions()
if any(res[0] >= 3840 for res in screen_res):
    plasma_kwargs |= dict(
        margin        = 3,
        margin_single = 0,
    )
else:
    plasma_kwargs |= dict(
        margin        = 2,
        margin_single = 0,
    )

layouts = [
    Plasma( **plasma_kwargs),
    layout.TreeTab(sections=[''], panel_width=80),
]


widget_defaults = dict(
    font       = 'Hack Nerd Font',
    fontsize   = 13,
    padding    = 3,
    background = monokai.black
)
extension_defaults = widget_defaults.copy()


def init_widgets():
    widgets = [
        widget.CurrentLayout(),
        widget.GroupBox(
            highlight_method           = 'box',
            this_current_screen_border = monokai.green,
            this_screen_border         = monokai.yellow,
            use_mouse_wheel            = False,
            disable_drag               = True),
        widget.WindowName(),
        widget.Chord(
            chords_colors={
                SystemStatus: ("#ff0000", "#ffffff"),
            },
        ),
        widget.Memory(
            format      = '{MemUsed: .2f}G ({MemPercent}%)',
            measure_mem = 'G',
            background  = monokai.aqua,
            foreground  = monokai.black,
        ),
        widget.CPU(
            format     = '{freq_current}GHz{load_percent:5.1f}%',
            background = monokai.pink),
        widget.Battery(
            format         = '{char} {percent:2.0%}',
            charge_char    = '',
            discharge_char = '',
            full_char      = ' ',
        ),
        widget.CheckUpdates(),
        widget.Clock(
            format     = '%Y-%m-%d %a %H:%M',
            background = monokai.lightblack2
        ),
        widget.Systray(),
    ]
    return widgets

primary_screen_kwargs = dict(
    top            = bar.Bar(init_widgets(), 20),
    wallpaper      = wallpaper.as_posix(),
    wallpaper_mode = wallpaper_mode
)

if any(res[0] >= 3840 for res in screen_res):
    primary_screen_kwargs.update(dict(
    left=bar.Gap(10), right=bar.Gap(10), bottom=bar.Gap(10)))

screens = [ Screen(**primary_screen_kwargs) ]

for _ in range(1, num_screens):
    screens.append(Screen(top            = bar.Bar(init_widgets()[:-1], 20),
                          wallpaper      = wallpaper.as_posix(),
                          wallpaper_mode = wallpaper_mode)
                    )

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front())
]

floating_layout = layout.Floating(float_rules=floating_matches)

dgroups_key_binder         = None
dgroups_app_rules          = []  # type: List
follow_mouse_focus         = True
bring_front_click          = False
cursor_warp                = False
auto_fullscreen            = True
focus_on_window_activation = "urgent"
reconfigure_screens        = True

@hook.subscribe.startup_once
def start_once():
    home = os.path.expanduser('~')
    subprocess.call([home + '/.config/qtile/autostart.sh'])


@hook.subscribe.startup_complete
def aiomanhole_start():
    """Start aiomanhole to access qtile's python process.

    To access the process, run `nc localhost 7113`
    """
    if aiomanhole:
        aiomanhole.start_manhole(port=7113, namespace={"qtile": qtile})

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
