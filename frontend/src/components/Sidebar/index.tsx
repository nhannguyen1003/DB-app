import { Drawer, List } from "@mui/material";
import { sidebarConfig } from "../../layouts/Configs/sidebar";
import SidebarItem from "./SidebarItem";
import SidebarItemCollapse from "./SidebarItemCollapse";
import { theme } from "../../themes/theme";
import Logo from "../Logo";

function Sidebar() {
  return (
    <Drawer
      variant="permanent"
      sx={{
        "& .MuiDrawer-paper": {
          width: "250px",
          backgroundColor: theme.color.dark,
          color: theme.color.text,
          borderColor: theme.color.primary + "50",
        },
      }}
    >
      <Logo />
      <List disablePadding>
        {sidebarConfig.map((sider, index) => {
          return sider.children ? (
            <SidebarItemCollapse sider={sider} key={index} />
          ) : (
            <SidebarItem sider={sider} key={index} />
          );
        })}
      </List>
    </Drawer>
  );
}

export default Sidebar;
