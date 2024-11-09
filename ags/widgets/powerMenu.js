export function powerButton() {
  return Widget.Button({
    hexpand: true,
    hpack: "end",
    child: Widget.Icon({
      icon: "power-symbolic",
    }),
    onClicked: () => App.toggleWindow("power_menu"),
  });
}

function powerMenuEntry(label, icon, command) {
  return Widget.Button({
    className: "power_menu_entry",
    child: Widget.Box({
      vertical: true,
      vexpand: true,
      vpack: "center",
      spacing: 5,
      children: [
        Widget.Icon({
          icon: icon,
        }),
        Widget.Label({
          label: label,
        }),
      ],
    }),
    onClicked: () => Utils.execAsync(command),
  });
}

export function powerMenu() {
  return Widget.Window({
    name: "power_menu",
    exclusivity: 'normal',
    layer: "top",
    visible: false,
    child: Widget.Box({
      className: "power_menu",
      vertical: true,
      children: [
        Widget.Box({
          className: "power_menu_entries",
          hexpand: true,
          hpack: "center",
          children: [
            powerMenuEntry("Lock", "arch-symbolic", "loginctl lock-session"),
            powerMenuEntry("Logout", "arch-symbolic", "loginctl terminate-session $XDG_SESSION_ID"),
            powerMenuEntry("Reboot", "arch-symbolic", "systemctl reboot"),
            powerMenuEntry("Shutdown", "system-shutdown-symbolic", "systemctl poweroff"),
          ]
        })
      ]
    })
  });
}