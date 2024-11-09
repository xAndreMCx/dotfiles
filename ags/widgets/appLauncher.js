export function appLauncher() {
  return Widget.Button({
    child: Widget.Icon({
      className: "arch_logo",
      icon: "arch-symbolic",
    }),
    onClicked: () => Utils.execAsync("tofi-run")
  });
}