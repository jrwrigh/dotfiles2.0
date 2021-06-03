from libqtile.config import Match
from libqtile import layout
import re


# Run the utility of `xprop` to see the wm class and name of an X client.

floating_matches = [
    *layout.Floating.default_float_rules,
    Match(wm_class='confirmreset'),  # gitk
    Match(wm_class='makebranch'),  # gitk
    Match(wm_class='maketag'),  # gitk
    Match(wm_class='ssh-askpass'),  # ssh-askpass
    Match(title='branchdialog'),  # gitk
    Match(title='pinentry'),  # GPG key password entry

    # Custom Entries
    Match(title='alsamixer'),
    Match(wm_class='calamares'),
    Match(wm_class='Clipgrab'),
    Match(title='File Transfer*'),
    Match(wm_class='fpakman'),
    Match(wm_class='Galculator'),
    Match(wm_class='GParted'),
    Match(title='i3_help'),
    Match(wm_class='Lightdm-settings'),
    Match(wm_class='Lxappearance'),
    Match(wm_class='Manjaro-hello'),
    Match(wm_class='Manjaro Settings Manager'),
    Match(title='MuseScore: Play Panel'),
    Match(wm_class='Nitrogen'),
    Match(wm_class='Oblogout'),
    Match(wm_class='octopi'),
    Match(title='About Pale Moon'),
    Match(wm_class='Pamac-manager'),
    Match(wm_class='Pavucontrol'),
    Match(wm_class='qt5ct'),
    Match(wm_class='Qtconfig-qt4'),
    Match(wm_class='Simple-scan'),
    Match(wm_class='(?i)System-config-printer.py'),
    Match(wm_class='Skype'),
    Match(wm_class='Timeset-gui'),
    Match(wm_class='(?i)virtualbox'),
    Match(wm_class='Xfburn'),
    Match(wm_class='charmap'),
    Match(wm_class='Arandr'),
    Match(wm_class='Chromium', role='pop-up'),
    Match(wm_class='fontforge', title='FontForge'),
    Match(wm_class='Zotero', role=re.compile(r'^(?!.*browser).*$')),
    Match(title='^pdfpc - present'),
    Match(wm_class='Gnucash', title=re.compile(r'(?!.* - GnuCash)')),
    Match(title='LastPass: Free Password Manager'),
    Match(wm_class='kcharselect'),
]
