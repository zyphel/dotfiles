# ----- Qtile config ------------------------------------------------

from libqtile import bar, layout, widget
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal

# from qtile_extras import widget
# from qtile_extras.widget.decorations import BorderDecoration
# from qtile_extras.widget.decorations import PowerLineDecoration

# ----- keybindings -------------------------------------------------

mod = 'mod1'
terminal = 'alacritty'

keys = [

    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key(
        [mod, 'shift'],
        'Return',
        lazy.layout.toggle_split(),
        desc='Toggle between split and unsplit sides of stack',
    ),
    Key([mod], 'Return', lazy.spawn(terminal), 
        desc='Launch terminal'),

    # ----- Qtile layout actions
    Key([mod], 'Tab', lazy.next_layout(), 
        desc='Toggle between layouts'),
    Key([mod], 'w', lazy.window.kill(), 
        desc='Kill focused window'),
    Key([mod, 'control'], 'r', lazy.reload_config(), 
        desc='Reload the config'),
    Key([mod, 'control'], 'q', lazy.shutdown(), 
        desc='Shutdown Qtile'),
    Key([mod], 'r', lazy.spawncmd(), 
        desc='Spawn a command using a prompt widget'),
    Key([mod], 'f', lazy.window.toggle_fullscreen(), 
        desc='Toggle window fullscreen'),

    # ----- Active Window Actions
    Key([mod, 'control'], 'h',
        lazy.layout.grow_right(),
        lazy.layout.grow(),
        lazy.layout.increase_ratio(),
        lazy.layout.delete(),
        desc='Increase active window size.'
        ),
    Key([mod, 'control'], 'Right',
        lazy.layout.grow_right(),
        lazy.layout.grow(),
        lazy.layout.increase_ratio(),
        lazy.layout.delete(),
        desc='Increase active window size.'
        ),
    Key([mod, 'control'], 'l',
        lazy.layout.grow_left(),
        lazy.layout.shrink(),
        lazy.layout.decrease_ratio(),
        lazy.layout.add(),
        desc='Decrease active window size.'
        ),
    Key([mod, 'control'], 'Left',
        lazy.layout.grow_left(),
        lazy.layout.shrink(),
        lazy.layout.decrease_ratio(),
        lazy.layout.add(),
        desc='Decrease active window size.'
        ),
    Key([mod, 'control'], 'k',
        lazy.layout.grow_up(),
        lazy.layout.grow(),
        lazy.layout.decrease_nmaster(),
        desc='Increase active window size.'
        ),
    Key([mod, 'control'], 'Up',
        lazy.layout.grow_up(),
        lazy.layout.grow(),
        lazy.layout.decrease_nmaster(),
        desc='Increase active window size.'
        ),
    Key([mod, 'control'], 'j',
        lazy.layout.grow_down(),
        lazy.layout.shrink(),
        lazy.layout.increase_nmaster(),
        desc='Decrease active window size.'
        ),
    Key([mod, 'control'], 'Down',
        lazy.layout.grow_down(),
        lazy.layout.shrink(),
        lazy.layout.increase_nmaster(),
        desc='Decrease active window size.'
        ),

    # ----- Window Focus (Arrows and Vim keys)
    Key([mod], 'Up', lazy.layout.up(),
        desc='Change focus to window above.'),
    Key([mod], 'Down', lazy.layout.down(),
        desc='Change focus to window below.'),
    Key([mod], 'Left', lazy.layout.left(),
        desc='Change focus to window on the left.'),
    Key([mod], 'Right', lazy.layout.right(),
        desc='Change focus to window on the right.'),
    Key([mod], 'k', lazy.layout.up(),
        desc='Change focus to window above.'),
    Key([mod], 'j', lazy.layout.down(),
        desc='Change focus to window below.'),
    Key([mod], 'h', lazy.layout.left(),
        desc='Change focus to window on the left.'),
    Key([mod], 'l', lazy.layout.right(),
        desc='Change focus to window on the right.'),

    # ----- Move windows around MonadTall/MonadWide Layouts
    Key([mod, 'shift'], 'Up', lazy.layout.shuffle_up(),
        desc='Shuffle window up.'),
    Key([mod, 'shift'], 'Down', lazy.layout.shuffle_down(),
        desc='Shuffle window down.'),
    Key([mod, 'shift'], 'Left', lazy.layout.swap_left(),
        desc='Shuffle window left.'),
    Key([mod, 'shift'], 'Right', lazy.layout.swap_right(),
        desc='Shuffle window right.'),
    Key([mod, 'shift'], 'k', lazy.layout.shuffle_up(),
        desc='Shuffle window up.'),
    Key([mod, 'shift'], 'j', lazy.layout.shuffle_down(),
        desc='Shuffle window down.'),
    Key([mod, 'shift'], 'h', lazy.layout.swap_left(),
        desc='Shuffle window left.'),
    Key([mod, 'shift'], 'l', lazy.layout.swap_right(),
        desc='Shuffle window right.'),

    # ----- applications 

    Key([mod], 'space', lazy.spawn('rofi -show drun'),
        desc='Run Rofi Launcher'),

    Key([mod, 'shift'], 'space', lazy.spawn('rofi -show window'),
        desc='Run Rofi Window'),

    Key([mod, 'shift'], 'p', lazy.spawn('rofi -show powermenu:~/.config/rofi/./rofi-power-menu'),
        desc='Run Rofi Powermenu'),
    
    Key([mod, 'shift'], 'b', lazy.spawn('firefox'),
        desc='Launch Firefox Browser'),

    Key([mod, 'shift'], 'f', lazy.spawn('pcmanfm'),
        desc='Launch pcmanfm file browser'),

    Key([mod, 'shift'], 'm', lazy.spawn('minecraft-launcher'),
        desc='Launch Minecraft'),

    Key([mod, 'shift'], "v", lazy.spawn("alacritty -e nvim"),
        desc='Launch Neovim'),

    # ----- enable audio
    Key([], 'XF86AudioMute', lazy.spawn('amixer -q set Master toggle')),
    Key([], 'XF86AudioLowerVolume', lazy.spawn('amixer -q sset Master 5%-')),
    Key([], 'XF86AudioRaiseVolume', lazy.spawn('amixer -q sset Master 5%+')),
]

groups = [Group(i) for i in '123456789']

for i in groups:
    keys.extend(
        [
            # mod1 + letter of group = switch to group
            Key(
                [mod],
                i.name,
                lazy.group[i.name].toscreen(),
                desc='Switch to group {}'.format(i.name),
            ),
            # mod1 + shift + letter of group = switch to & move focused window to group
            Key(
                [mod, 'shift'],
                i.name,
                lazy.window.togroup(i.name, switch_group=True),
                desc='Switch to & move focused window to group {}'.format(i.name),
            ),
            # Or, use below if you prefer not to switch to that group.
            # # mod1 + shift + letter of group = move focused window to group
            # Key([mod, 'shift'], i.name, lazy.window.togroup(i.name),
            #     desc='move focused window to group {}'.format(i.name)),
        ]
    )

layout_theme = {
        'margin':1,
        'border_focus':'#665c54',
        'border_normal':'#1d2021',
        'border_width':2,
        }

layouts = [
    layout.MonadTall(**layout_theme),
    layout.Max(),
    # layout.Columns(**layout_theme),
    # layout.Floating(**layout_theme)
    # Try more layouts by unleashing below layouts.
    # layout.Stack(num_stacks=2),
    # layout.Bsp(),
    # layout.Matrix(),
    # layout.MonadWide(),
    # layout.RatioTile(),
    # layout.Tile(),
]

# ----- bar and widgets ---------------------------------------------

widget_defaults = dict(
    font='FiraCode Nerd Font',
    fontsize=14,
    padding=8,
)

extension_defaults = widget_defaults.copy()

screens = [
    Screen(
        top=bar.Bar(
            [
                widget.Spacer(length = 2),
                widget.GroupBox(padding = 3),
                widget.Prompt(),
                widget.Chord(
                    chords_colors={
                        'launch': ('#ff0000', '#ffffff'),
                    },
                    name_transform=lambda name: name.upper(),
                ),
                widget.Spacer(bar.STRETCH),
                widget.Clock(
                    format = '%I:%M %p',
                    foreground = '#bdae93'),
                widget.Spacer(bar.STRETCH),
                widget.Volume(foreground = '#bdae93'),
                # widget.Systray(),
                widget.Clock(
                    format = '%A, %B %d',
                    foreground = '#bdae93'),
                # widget.CurrentLayout(foreground='#a89984'),
                widget.QuickExit(foreground = '#bdae93'),
                widget.Spacer(length = 2),
            ],
            24,
            # background = '#0e0e0e',
        ),
    ),
]

# Drag floating layouts.
mouse = [
    Drag([mod], 'Button1', lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag([mod], 'Button3', lazy.window.set_size_floating(), start=lazy.window.get_size()),
    Click([mod], 'Button2', lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class='confirmreset'),  # gitk
        Match(wm_class='makebranch'),  # gitk
        Match(wm_class='maketag'),  # gitk
        Match(wm_class='ssh-askpass'),  # ssh-askpass
        Match(title='branchdialog'),  # gitk
        Match(title='pinentry'),  # GPG key password entry
    ]
)
auto_fullscreen = True
focus_on_window_activation = 'smart'
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# When using the Wayland backend, this can be used to configure input devices.
wl_input_rules = None

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = 'Qtile'
