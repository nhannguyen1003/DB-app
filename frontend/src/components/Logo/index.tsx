import React from "react";
import { theme } from "../../themes/theme";
import SchoolIcon from "@mui/icons-material/School";
import RadioButtonCheckedIcon from "@mui/icons-material/RadioButtonChecked";

function Logo() {
  return (
    <a
      href="/"
      style={{
        height: "60px",
        marginBottom: "10px",
        display: "flex",
        alignItems: "center",
        justifyContent: "center",
        fontWeight: "700",
        letterSpacing: "1px",
        fontSize: "20px",
        backgroundColor: "transparent",
        maxWidth: "250px",
      }}
    >
      <SchoolIcon
        fontSize="large"
        style={{
          marginRight: "10px",
          color: theme.color.primary,
        }}
      />
      COURSERA
      <RadioButtonCheckedIcon
        fontSize="small"
        style={{
          marginLeft: "25px",
          color: theme.color.primary,
        }}
      />
    </a>
  );
}

export default Logo;
