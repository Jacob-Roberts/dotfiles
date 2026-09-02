-- Keep only your personal keybinding overrides here. Add new bindings or
-- unbind defaults before replacing them.

-- See current bindings and descriptions:
--   omarchy menu keybindings --print

-- To disable every Omarchy default binding, set this in
-- ~/.config/hypr/hyprland.lua before require("default.hypr.omarchy"), then add
-- only the bindings you want below:
--   omarchy_default_bindings = false

-- To disable all preinstalled app/webapp bindings, set:
--   omarchy_preinstalled_bindings = false

-- Add a new binding.
-- o.bind("SUPER + SHIFT + R", "SSH", "alacritty -e ssh your-server")

-- Change an existing binding by unbinding it first, then binding the key again.
-- This example changes SUPER+SPACE from the launcher to the Omarchy root menu.
-- hl.unbind("SUPER + SPACE")
-- o.bind("SUPER + SPACE", "Omarchy menu", "omarchy-menu toggle root")

-- Disable a default binding without replacing it.
-- hl.unbind("SUPER + SHIFT + B")

-- Logitech MX Keys examples:
-- o.bind("SUPER + SHIFT + S", nil, "omarchy-capture-screenshot")
-- o.bind("SUPER + H", nil, "voxtype record toggle")
-- o.bind("SUPER + PERIOD", nil, "omarchy-shell shell toggle omarchy.emojis")

hl.unbind("SUPER + SHIFT + A")
hl.unbind("SUPER + SHIFT + ALT + A")
hl.unbind("SUPER + SHIFT + ALT + E")
hl.unbind("SUPER + SHIFT + C")
-- o.bind("SUPER + SHIFT + C", "Proton Calendar", "omarchy-launch-or-focus-webapp", "https://calendar.proton.me")
hl.unbind("SUPER + SHIFT + CTRL + G")
hl.unbind("SUPER + SHIFT + E")
-- o.bind("SUPER + SHIFT + E", "Proton Mail", "omarchy-launch-or-focus-webapp", "https://mail.proton.me")
hl.unbind("SUPER + SHIFT + M")
-- o.bind("SUPER + SHIFT + M", "", "omarchy-menu toggle root")
hl.unbind("SUPER + SHIFT + O")
hl.unbind("SUPER + SHIFT + P")
-- o.bind("SUPER + SHIFT + P", "") -- IMmich
hl.unbind("SUPER + SHIFT + S")
hl.unbind("SUPER + SHIFT + SLASH")
-- o.bind("SUPER + SHIFT + SLASH", "") -- bitwarden
