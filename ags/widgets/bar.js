import { appLauncher } from "./appLauncher.js";
import { powerButton } from "./powerMenu.js";

export { bar };

const hyprland = await Service.import('hyprland');

function hyprlandDispatch(workspace) {
  return hyprland.messageAsync(`dispatch workspace ${workspace}`)
};

function hyprlandWorkspaces() {
  const workspaceBox = Widget.Box({
    className: "workspaces",
    children: Array.from({ length: 10 }, (_, i) => i + 1).map(i => {
      return Widget.Button({
        className: "workspace_btn",
        child: Widget.Label({ label: i.toString() }),
        onClicked: () => hyprlandDispatch(i)
      });
    }
    ),
  });
  workspaceBox.hook(hyprland.active.workspace, (self) => {
    self.children.forEach((child, i) => {
      // Set the workspace to be empty by default
      child.toggleClassName("workspace_btn_empty", true);

      hyprland.workspaces.forEach((workspace_entry, _) => {
        // Check if the workspace is empty
        if (workspace_entry.windows === 0) { // FIXME: dont think this check is necessary
          self.children[workspace_entry.id - 1].toggleClassName("workspace_btn_empty", true);
        } else {
          self.children[workspace_entry.id - 1].toggleClassName("workspace_btn_empty", false);
        }

        // Check if the workspace is active
        if (i + 1 === hyprland.active.workspace.id) {
          child.toggleClassName("workspace_btn_active", true);
        } else {
          child.toggleClassName("workspace_btn_active", false);
        }
      })
    })
  })
  return workspaceBox;
}

const date_and_time = Variable('', {
  // Updates every 15 sec
  poll: [15000, "date '+%A, %d %b %Y|%I:%M %p'"]
})

function datetime() {
  return Widget.Label({
    label: date_and_time.bind().as(out => {
      let [date, time] = out.split('|');
      return ` ${date} |  ${time}`;
    }),
    hpack: "center",
    hexpand: true,
  });
}

function focusTitle() {
  return Widget.Label({
    className: "focus_title",
    hpack: "end",
    hexpand: true,
    label: hyprland.active.client.bind("class"),
    visible: hyprland.active.client.bind("address").as((addr) => { return (addr === '' ? false : true) })
  });
}

function left() {
  return Widget.Box({
    className: "left_box module",
    children: [appLauncher(), hyprlandWorkspaces(), focusTitle()],
    spacing: 5,
    hpack: "start",
  });
}

function center() {
  return Widget.Box({
    className: "center_box module",
    child: datetime(),
    hpack: "center",
  });
}

function right() {
  return Widget.Box({
    child: powerButton(),
    className: "right_box module",
    hpack: "end",
  })
}


function bar() {
  return Widget.Window({
    monitor: 0,
    name: "bar",
    anchor: ['top', 'left', 'right'],
    exclusivity: 'exclusive',
    layer: "top",
    margins: [3, 10, 0, 10], // 10 px to line up with the window borders
    child: Widget.CenterBox({
      className: "bar",
      start_widget: left(),
      center_widget: center(),
      end_widget: right(),
    }),
  });
}