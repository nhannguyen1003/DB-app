import { Button } from "@mui/material";
import { useStyles } from "./styled";
import { useNavigate } from "react-router-dom";
import { theme } from "../../themes/theme";

function NotAuthenticationPage({}) {
  const classes = useStyles();
  const navigate = useNavigate();

  return (
    <div>
      <div className={classes.code}>401</div>
      <div className={classes.status}>
        Unauthorized
      </div>
      <div className={classes.message}>
        Please sign-in to your account and start the adventure.
      </div>
      <img
        className={classes.img}
        src="https://demos.themeselection.com/marketplace/materio-mui-react-nextjs-admin-template/demo-4/images/pages/404.png"
      />
      <Button variant="contained" style={{ backgroundColor: theme.color.primary}} onClick={() => {
        navigate("/sign-in");
      }}>BACK TO LOGIN</Button>
    </div>
  );
}

export default NotAuthenticationPage;
