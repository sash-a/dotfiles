# Copyright (c) 2010 Aldo Cortesi
# Copyright (c) 2010, 2014 dequis
# Copyright (c) 2012 Randall Ma
# Copyright (c) 2012-2014 Tycho Andersen
# Copyright (c) 2012 Craig Barnes
# Copyright (c) 2013 horsik
# Copyright (c) 2013 Tao Sauvage
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

import os
import shutil
import subprocess

from libqtile import bar, hook, layout, qtile
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
from qtile_extras import widget
from qtile_extras.widget.decorations import RectDecoration
from qtile_extras.widget.groupbox2 import GroupBoxRule

mod = "mod4"
terminal = "ghostty"  # guess_terminal()
home = os.path.expanduser("~")

has_nvidia_gpu = shutil.which("nvidia-smi") is not None
is_laptop = os.environ.get("QTILE_DEVICE_TYPE", "desktop") == "laptop"

keys = [
    # A list of available commands that can be bound to keys can be found
    # at https://docs.qtile.org/en/latest/manual/config/lazy.html
    # Switch between windows
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    Key(
        [mod, "shift"], "h", lazy.layout.shuffle_left(), desc="Move window to the left"
    ),
    Key(
        [mod, "shift"],
        "l",
        lazy.layout.shuffle_right(),
        desc="Move window to the right",
    ),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),
    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key([mod, "control"], "h", lazy.layout.grow_left(), desc="Grow window to the left"),
    Key(
        [mod, "control"], "l", lazy.layout.grow_right(), desc="Grow window to the right"
    ),
    Key([mod, "control"], "j", lazy.layout.grow_down(), desc="Grow window down"),
    Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key(
        [mod, "shift"],
        "Return",
        lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack",
    ),
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod], "q", lazy.window.kill(), desc="Kill focused window"),
    Key(
        [mod],
        "f",
        lazy.window.toggle_fullscreen(),
        desc="Toggle fullscreen on the focused window",
    ),
    Key(
        [mod],
        "t",
        lazy.window.toggle_floating(),
        desc="Toggle floating on the focused window",
    ),
    Key([mod, "control"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    # Rofi menus
    Key(
        [mod],
        "space",
        lazy.spawn(
            f"rofi -show drun -theme {home}/.config/rofi/launchers/type-1/style-7.rasi"
        ),
        desc="Launch rofi",
    ),
    Key(
        [mod],
        "p",
        lazy.spawn(f"{home}/.config/rofi/powermenu/type-1/powermenu.sh"),
        desc="Launch Power Menu",
    ),
    Key(
        [mod],
        "m",
        lazy.spawn(f"{home}/.config/rofi/applets/bin/mpd.sh"),
        desc="Control Music",
    ),
    Key(
        [mod],
        "v",
        lazy.spawn(f"{home}/.config/rofi/applets/bin/volume.sh"),
        desc="Control Volume",
    ),
    # Misc hotkeys
    Key(
        ["mod1", "shift"],
        "s",
        lazy.spawn("flameshot gui"),
        desc="Take a screenshot",
    ),
]


groups = [
    Group(name="1", matches=[Match(wm_class="ghostty")]),
    Group(name="2", matches=[Match(wm_class="brave-browser")]),
    Group(name="3", matches=[Match(wm_class="Slack")]),
    Group(name="4", matches=[Match(wm_class="ncspot")]),
    Group(name="5", matches=[Match(wm_class="steam")]),
    Group(name="6"),
    Group(name="7"),
    Group(name="8"),
    # Group(name="", matches=[Match(wm_class="ghostty")]),
    # Group(name="󰈹", matches=[Match(wm_class="brave-browser")]),
    # Group(name="", matches=[Match(wm_class="Slack")]),
]

for i, group in enumerate(groups, 1):
    keys.extend(
        [
            # mod + group number = switch to group
            Key(
                ["mod1"],
                str(i),
                lazy.group[group.name].toscreen(),
                desc=f"Switch to group {group.name}",
            ),
            # mod + shift + group number = switch to & move focused window to group
            Key(
                ["mod1", "shift"],
                str(i),
                lazy.window.togroup(group.name, switch_group=True),
                desc=f"Switch to & move focused window to group {group.name}",
            ),
            # Or, use below if you prefer not to switch to that group.
            # # mod + shift + group number = move focused window to group
            # Key([mod, "shift"], i.name, lazy.window.togroup(i.name),
            #     desc="move focused window to group {}".format(i.name)),
        ]
    )

layouts = [
    layout.MonadTall(
        border_focus="#A7C080", border_normal="#000000", border_width=2, margin=4
    ),
    layout.Columns(
        border_focus="#A7C080", border_normal="#000000", border_width=2, margin=4
    ),
    layout.Max(),
    # Try more layouts by unleashing below layouts.
    # layout.Stack(num_stacks=2),
    # layout.Bsp(),
    # layout.Matrix(),
    # layout.MonadTall(),
    # layout.MonadWide(),
    # layout.RatioTile(),
    # layout.Tile(),
    # layout.TreeTab(),
    # layout.VerticalTile(),
    # layout.Zoomy(),
]

widget_defaults = {
    "font": "Fira Sans Mono",
    "fontsize": 17,
    "padding": 3,
}
extension_defaults = widget_defaults.copy()

decoration_group = {
    "decorations": [
        RectDecoration(
            colour="#48584E50",
            radius=10,
            filled=True,
            padding_y=0,
            group=True,
            clip=True,
        )
    ],
}


rules = [
    GroupBoxRule(text="◉").when(GroupBoxRule.SCREEN_THIS),
    ~GroupBoxRule(text="○").when(GroupBoxRule.SCREEN_THIS),
]

widgets_left = [
    widget.Spacer(length=15),
    widget.GroupBox2(rules=rules, padding=5, **decoration_group),
    # widget.GroupBox(
    #     highlight_method="line",
    #     highlight_color="#A7C080",
    #     other_current_screen_border="#A7C080",
    #     this_current_screen_border="#A7C080",
    #     padding=15,
    #     **decoration_group,
    # ),
]
widgets_centre = [
    widget.Clock(format="%d-%m %a %H:%M", fontsize=17, padding=15, **decoration_group)
]

# left widgets
gpu_widget = widget.GenPollCommand(
    cmd="nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits",
    fmt="{:<2}%",
    max_chars=10,
    update_interval=1,
    shell=True,
    **decoration_group,
)

widgets_right = (
    [
        widget.Spacer(10, **decoration_group),
        widget.Image(
            filename="~/.config/qtile/icons/cpu-modified.png",
            padding=1,
            margin=5,
            **decoration_group,
        ),
        # TODO: icons (needs to be images :/)
        widget.CPU(
            format="{load_percent:<3.1f}%",
            max_chars=10,
            **decoration_group,
            padding=1,
        ),
        widget.Spacer(15, **decoration_group),
        widget.Image(
            filename="~/.config/qtile/icons/ram.png",
            padding=1,
            margin=3,
            **decoration_group,
        ),
        widget.Memory(
            format="{MemPercent:<2.0f}%",
            max_chars=10,
            padding=1,
            **decoration_group,
        ),
        widget.Spacer(10, **decoration_group),
    ]
    + (
        [
            widget.Image(
                filename="~/.config/qtile/icons/gpu.png",
                padding=1,
                margin=3,
                **decoration_group,
            ),
            gpu_widget,
            widget.Spacer(15, **decoration_group),
        ]
        if has_nvidia_gpu
        else []
    )
    + [widget.Spacer(length=15)]
    # TODO: check this works on laptop
    + (
        [
            widget.Brightness(**decoration_group, padding=15),
            widget.Battery(**decoration_group, padding=15),
        ]
        if is_laptop
        else []
    )
    + [
        # TODO:  this is moving the bar??
        # Rofit widget on mouse click?
        # widget.Net(
        #     # format="    {down:.0f}{down_suffix} ↓↑ {up:.0f}{up_suffix}",
        #     format="    {total:<3.0f} ↓↑",
        #     min_width=500,
        #     max_chars=20,
        #     **decoration_group,
        # ),
        widget.Spacer(length=11, **decoration_group),
        widget.Volume(fmt="{}", padding=10, **decoration_group),
        widget.TextBox(
            fmt="⏻",
            max_chars=1,
            mouse_callbacks={
                "Button1": lambda: qtile.spawn(
                    f"{home}/.config/rofi/powermenu/type-1/powermenu.sh"
                )
            },
            padding=10,
            **decoration_group,
        ),
        widget.Spacer(length=15, **decoration_group),
        widget.Spacer(length=15),
    ]
)
widgets = [
    *widgets_left,
    widget.Spacer(length=bar.STRETCH),
    *widgets_centre,
    widget.Spacer(length=bar.STRETCH),
    *widgets_right,
]

screens = [
    Screen(
        top=bar.Bar(
            widgets,
            32,
            background="#00000000",
            margin=[4, 4, 4, 4],
        ),
        wallpaper=f"{home}/Pictures/fog_forest_1.png",
        wallpaper_mode="stretch",
        bottom=bar.Gap(5),
        left=bar.Gap(5),
        right=bar.Gap(5),
        # You can uncomment this variable if you see that on X11 floating resize/moving is laggy
        # By default we handle these events delayed to already improve performance, however your system might still be struggling
        # This variable is set to None (no cap) by default, but you can set it to 60 to indicate that you limit it to 60 events per second
        # x11_drag_polling_rate = 60,
    ),
]

# Drag floating layouts.
mouse = [
    Drag(
        [mod],
        "Button1",
        lazy.window.set_position_floating(),
        start=lazy.window.get_position(),
    ),
    Drag(
        [mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()
    ),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []
follow_mouse_focus = True
bring_front_click = False
floats_kept_above = True
cursor_warp = False
floating_layout = layout.Floating(
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
    ]
)
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# When using the Wayland backend, this can be used to configure input devices.
wl_input_rules = None

# xcursor theme (string or None) and size (integer) for Wayland backend
wl_xcursor_theme = None
wl_xcursor_size = 24

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"


@hook.subscribe.startup_once
def autostart():
    script = os.path.expanduser(f"{home}/.config/qtile/autostart.sh")
    subprocess.run([script])
