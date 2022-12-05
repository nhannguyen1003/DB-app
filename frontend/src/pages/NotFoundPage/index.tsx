import { Button } from "@mui/material";
import { useStyles } from "./styled";
import WarningIcon from "@mui/icons-material/Warning";
import { useNavigate } from "react-router-dom";
import { theme } from "../../themes/theme";

function NotFoundPage() {
  const classes = useStyles();
  const navigate = useNavigate();

  return (
    <div>
      <div className={classes.code}>404</div>
      <div className={classes.status}>
        Page Not Found <WarningIcon fontSize="small" />
      </div>
      <div className={classes.message}>
        We couldn′t find the page you are looking for.
      </div>
      <img
        className={classes.img}
        src="https://demos.themeselection.com/marketplace/materio-mui-react-nextjs-admin-template/demo-4/images/pages/404.png"
      />
      <Button
        variant="contained"
        style={{
          backgroundColor: theme.color.primary,
        }}
        onClick={() => {
          navigate("/");
        }}
      >
        BACK TO HOME
      </Button>
    </div>
  );
}

export default NotFoundPage;
