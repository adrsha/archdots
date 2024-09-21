const systemtray = await Service.import("systemtray");
const network = await Service.import("network");
const bluetooth = await Service.import("bluetooth");
const battery = await Service.import("battery");
const hyprland = await Service.import("hyprland");

const css = "./config.css";
import { Workspaces, Clients } from "./hyprlandmodule.js";

const bluetoothIndicator = () => {
  return Widget.Icon({
    icon: bluetooth
      .bind("enabled")
      .as((on) => `bluetooth-${on ? "active" : "disabled"}-symbolic`),
  });
};

const batteryProgress = Widget.CircularProgress({
  rounded: true,
  visible: battery.bind("available"),
  value: battery.bind("percent").as((p) => (p > 0 ? p / 100 : 0)),
  class_name: battery.bind("charging").as((c) => (c ? "batC" : "batD")),
});

const WifiIndicator = () =>
  Widget.EventBox({
    onPrimaryClick: () => {
      App.ToggleWindow("calendar");
    },
    child: Widget.Box({
      vertical: true,
      tooltip_markup: `     ${network.wifi?.ssid || "Not Connected"}\n󰾅    ${network.wifi?.strength == -1 ? "No Signal" : network.wifi?.strength}`,
      children: [
        Widget.Icon({
          icon: network.wifi.bind("icon_name"),
        }),
      ],
    }),
  });

const WiredIndicator = () =>
  Widget.Icon({
    icon: network.wired.bind("icon_name"),
  });

const NetworkIndicator = () =>
  Widget.Stack({
    children: {
      wifi: WifiIndicator(),
      wired: WiredIndicator(),
    },
    shown: network.bind("primary").as((p) => p || "wifi"),
  });

function Calendar() {
  const box = Widget.Calendar({
    showDayNames: true,
    showDetails: false,
    showHeading: true,
    showWeekNumbers: true,
  });

  const window = Widget.Window({
    margins: [10, 10, 10, 10],
    class_name: "calendar",
    name: "calendar",
    anchor: ["bottom", "left"],
    layer: "overlay",
    visible: false,
    child: box,
  });

  return window;
}

function Clock() {
  const min_var = Variable("", {
    poll: [10000, `date '+%0M'`],
  });
  const hour_var = Variable("", {
    poll: [10000, `date '+%0l'`],
  });
  const date_value = Utils.exec(`sh -c 'date "+%D"'`);
  return Widget.EventBox({
    onPrimaryClick: () => {
      App.ToggleWindow("calendar");
    },
    child: Widget.Box({
      class_name: "clock",
      vertical: true,
      children: [
        Widget.Label({
          useMarkup: true,
          label: hour_var.bind(),
          tooltip_markup: `<span font='Kalam Regular 14'>${date_value}</span>`,
        }),
        Widget.Label({
          useMarkup: true,
          label: min_var.bind(),
          tooltip_markup: `<span font='Kalam Regular 14'>${date_value}</span>`,
        }),
      ],
    }),
  });
}

function Systemtray() {
  return Widget.Box({
    class_name: "systemtray",
    spacing: 1,
    vertical: true,
    homogeneous: false,
    children: systemtray.bind("items").as((items) =>
      items.map((item) =>
        Widget.Button({
          class_name: "tray_item",
          child: Widget.Icon({ icon: item.bind("icon"), size: 16 }),
          tooltip_markup: item
            .bind("tooltip_markup")
            .as((text) => text.replaceAll("&", "&amp;")),
          on_primary_click: (_, event) => item.activate(event),
          on_secondary_click: (_, event) => item.openMenu(event),
        }),
      ),
    ),
  });
}
//}}}

function Top() {
  return Widget.Box({
    vertical: true,
    spacing: 8,
    children: [Workspaces()],
  });
}

function Center() {
  return Widget.Box({
    vertical: true,
    css: "font-size: 30px;",
    homogeneous: true,
    children: [
      Widget.Box({
        class_name: "clientsTray",
        spacing: 5,
        vertical: true,
        setup: (self) => {
          self.hook(hyprland, () => {
            self.children = Clients(hyprland.clients);
            self.visible = self.children.length > 0;
          });
        },
      }),
    ],
  });
}

function Bottom() {
  return Widget.Box({
    vertical: true,
    sensitive: true,
    vpack: "end",
    spacing: 8,
    children: [
      batteryProgress,
      Systemtray(),
      NetworkIndicator(),
      bluetoothIndicator(),
      Clock(),
    ],
  });
}
function bar(monitor = 0) {
  return Widget.Window({
    margins: [0, 0, 0, 0],
    name: `bar-${monitor}`,
    sensitive: true,
    anchor: ["top", "left", "bottom"],
    class_name: "bar",
    exclusivity: "exclusive",
    child: Widget.Box({
      class_name: "mainBar",
      child: Widget.CenterBox({
        vertical: true,
        startWidget: Top(),
        centerWidget: Center(),
        endWidget: Bottom(),
      }),
    }),
  });
}

function quote(monitor = 0) {
  return Widget.Window({
    margins: [10, 10, 10, 10],
    sensitive: true,
    sensitive: true,
    class_name: "quote",
    anchor: ["left", "top", "right"],
    child: Widget.Label("THE GOAL"),
  });
}

App.config({
  style: css,
  windows: [bar(0), Calendar(), quote()],
});
