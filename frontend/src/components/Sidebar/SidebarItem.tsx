import { ListItemButton, ListItemIcon } from "@mui/material";
import { Link } from "react-router-dom";
import { MenuItemType } from "../../layouts/Configs/sidebar";
import RadioButtonUncheckedIcon from '@mui/icons-material/RadioButtonUnchecked';

import { useSelector, useDispatch } from "react-redux";
import { RootState } from "../../redux/store";
import { setSiderState } from "../../redux/features/sider";
import { theme } from "../../themes/theme";

function SidebarItem(props: { sider: MenuItemType }) {
  const { sider } = props;
  const { siderState } = useSelector((state: RootState) => state.siderState); 
  const dispatch = useDispatch();

  return (
    <>
      <ListItemButton
        component={Link}
        to={sider.path}
        sx={{
          "&: hover": {
            backgroundColor: siderState === sider.path ? theme.color.primary : theme.color.secondary,
          },
          backgroundColor: siderState === sider.path ?  theme.color.primary : theme.color.dark,
          borderTopRightRadius: "50px",
          borderBottomRightRadius: "50px",
          paddingY: "0px",
        }}
        onClick={() => {
          dispatch(setSiderState(sider.path));
        }}
      >
        <ListItemIcon
          sx={{
            color: theme.color.text,
            minWidth: "40px",
            padding: "10px",
          }}
        >
          <RadioButtonUncheckedIcon fontSize="small"/>
        </ListItemIcon>
        {sider.label}
      </ListItemButton>
    </>
  );
}

export default SidebarItem;
