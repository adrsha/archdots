const hyprland = await Service.import("hyprland");
const { GLib, Gio } = imports.gi;
const decoder = new TextDecoder();

function getIconNameFromClass(windowClass) {
    let formattedClass = windowClass.replace(/\s+/g, "-").toLowerCase();
    let homeDir = GLib.get_home_dir();
    let systemDataDirs = GLib.get_system_data_dirs().map((dir) => dir + "/applications");
    let dataDirs = systemDataDirs.concat([homeDir + "/.local/share/applications"]);
    let icon;

    for (let dir of dataDirs) {
        let applicationsGFile = Gio.File.new_for_path(dir);

        let enumerator;
        try {
            enumerator = applicationsGFile.enumerate_children(
                "standard::name,standard::type",
                Gio.FileQueryInfoFlags.NONE,
                null
            );
        } catch (e) {
            continue;
        }

        let fileInfo;
        while ((fileInfo = enumerator.next_file(null)) !== null) {
            let desktopFile = fileInfo.get_name();
            if (desktopFile.endsWith(".desktop")) {
                let fileContents = GLib.file_get_contents(dir + "/" + desktopFile);
                let matches = /Icon=(\S+)/.exec(decoder.decode(fileContents[1]));
                if (matches && matches[1]) {
                    if (desktopFile.toLowerCase().includes(formattedClass)) {
                        icon = matches[1];
                        break;
                    }
                }
            }
        }

        enumerator.close(null);
        if (icon) break;
    }
    return Utils.lookUpIcon(icon) ? icon : "image-missing";
}

let globalWidgets = [];
export function Clients(clients) {
    const currentClientIds = clients.map((client) => client.pid);
    globalWidgets = globalWidgets.filter((widget) => currentClientIds.includes(widget.attribute.pid));

    clients.forEach((client) => {
        if (client.class === "Alacritty") return;

        let widget = globalWidgets.find((w) => w.attribute.pid === client.pid);
        if (widget) {
            widget.tooltip_markup = client.title;
        } else {
            let icon;
            if (client.class === "com.github.Aylur.ags") {
                icon =
                    client.initialTitle === "Settings"
                    ? "emblem-system-symbolic"
                    : client.initialTitle === "Emoji Picker"
                    ? "face-smile-symbolic"
                    : undefined;
            } else {
                icon = getIconNameFromClass(client.class);
            }

            widget = Widget.Button({
                attribute: { pid: client.pid },
                child: Widget.Icon({ icon }),
                tooltip_markup: client.title,
                on_clicked: () => focus(client)
            });
            globalWidgets.push(widget);
        }
    });
    return globalWidgets;
}
//Workspaces{{{
export function Workspaces() {
  let activeId = hyprland.active.workspace.bind("id");
  return Widget.Box({
    class_name: `workspaces`,
    homogeneous: false,
    vertical: true,
    spacing: 0,
    // children: Array.from({ length: 6 }, (_, i) => i + 1).map((i) => Widget.Button({
    children: ["一", "二", "三", "四", "五"].map((v, i) => {
      let ws_id = i + 1;
      return Widget.Button({
        attribute: `${ws_id}`,
        label: v,
        // label: activeId.as( active => active != ws_id && `` || `󱥸` ),
        // class_name: activeId.as( active => active == i ? "focused" : hyprland.workspaces[i].windows != 0 ? "occupied" : "" ),
        on_clicked: () => {
          hyprland.messageAsync(`dispatch workspace ${ws_id}`);
        },
        setup: (self) => {
          self.hook(hyprland, (self) => {
            if (hyprland.active.workspace.id == ws_id) {
              // self.label = `󰸵`;
              self.class_name = "focused";
            } else if (hyprland.active.workspace.id != ws_id) {
              // self.label = `󰸶`;
              self.class_name = "";
              hyprland.workspaces.forEach((ws) => {
                if (ws.id == ws_id) {
                  if (ws.windows != 0) {
                    // self.label = "󰸸"; //󰸴
                    self.class_name = "occupied";
                  }
                }
              });
              // self.class_name = "occupied"
              // self.toggleClassName("focused",false)
            }
            // hyprland.active.workspace.id == i ? self.class_names = ["focused"] : self.class_names = []
            // hyprland.workspaces[i].windows == 0 ?
          });
        },
      });
    }),
  });
}
