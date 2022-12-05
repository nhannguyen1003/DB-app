import {
  Collapse,
  List,
  ListItemButton,
  ListItemIcon,
  ListItemText,
  Typography,
} from "@mui/material";
import React, { useState } from "react";
import { MenuItemType } from "../../layouts/Configs/sidebar";

import ExpandLessOutlinedIcon from "@mui/icons-material/ExpandLessOutlined";
import ExpandMoreOutlinedIcon from "@mui/icons-material/ExpandMoreOutlined";
import SidebarItem from "./SidebarItem";

import { useSelector } from "react-redux";
import { RootState } from "../../redux/store";
import { useEffect } from 'react';
import { theme } from "../../themes/theme";

function SidebarItemCollapse(props: { sider: MenuItemType }) {
  const { sider } = props;
  const { siderState } = useSelector((state: RootState) => state.siderState);
  const [open, setOpen] = useState(false);

  useEffect(() => {
    if (sider.path === siderState) {
      setOpen(true);
    }
  })

  return (
    <>
      <ListItemButton onClick={() => setOpen(!open)}>
        <ListItemIcon
          sx={{
            color: theme.color.text,
            minWidth: "40px",
          }}
        >
          {sider.icon}
        </ListItemIcon>
        <ListItemText
          disableTypography
          primary={<Typography>{sider.label}</Typography>}
        />
        {open ? <ExpandLessOutlinedIcon /> : <ExpandMoreOutlinedIcon />}
      </ListItemButton>
      <Collapse in={open} timeout="auto">
        <List>
          {sider.children?.map((side, index) => {
            return side.children ? (
              <SidebarItemCollapse sider={side} key={index} />
            ) : (
              <SidebarItem sider={side} key={index} />
            );
          })}
        </List>
      </Collapse>
    </>
  );
}

export default SidebarItemCollapse;
