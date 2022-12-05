import { Avatar, IconButton, InputBase, Paper } from "@mui/material";
import SearchIcon from "@mui/icons-material/Search";
import { theme } from "../../themes/theme";

function Header() {
  return (
    <div
      style={{
        height: "60px",
        display: "flex",
        justifyContent: "space-between",
        alignContent: "center",
        backgroundColor: theme.color.secondary,
      }}
    >
      <div
        style={{
          display: "flex",
          alignItems: "center",
          width: 300,
          border: "none",
          outline: "none",
          backgroundColor: "transparent",
        }}
      >
        <IconButton sx={{ p: "10px", color: theme.color.text }} aria-label="menu">
          <SearchIcon />
        </IconButton>
        <InputBase
          sx={{ ml: 1, backgroundColor: "transparent", color:theme.color.text }}
          placeholder="Search"
        />
      </div>

      <div
        style={{
          display: "flex",
          alignItems: "center",
          padding: "0px 20px",
        }}
      >
        <Avatar
          alt="Remy Sharp"
          src="https://demos.themeselection.com/marketplace/materio-mui-react-nextjs-admin-template/demo-4/images/avatars/1.png"
        />
      </div>
    </div>
  );
}

export default Header;
