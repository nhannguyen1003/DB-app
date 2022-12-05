import Logo from "../../components/Logo";
import { theme } from "../../themes/theme";

import Box from "@mui/material/Box";
import TextField from "@mui/material/TextField";
import { useStyles } from "./styled";
import FormControlLabel from "@mui/material/FormControlLabel";
import Checkbox from "@mui/material/Checkbox";
import { Link } from "react-router-dom";
import Button from "@mui/material/Button";

function SignInPage() {
  const classes = useStyles();

  return (
    <div className="flex flex-row h-screen">
      <div className="basis-2/3" style={{}}>
        <div>
          <Logo />
        </div>
        <div className="flex items-center justify-center">
          <img
            style={{
              height: "600px",
            }}
            src="https://demos.themeselection.com/marketplace/materio-mui-react-nextjs-admin-template/demo-4/images/pages/auth-v2-login-illustration-dark.png"
          />
        </div>
      </div>

      <div className="basis-1/3">
        <div
          style={{
            backgroundColor: theme.color.secondary,
          }}
          className="h-screen flex items-center justify-center"
        >
          <div className="text-left p-20">
            <h3 className="text-2xl font-bold">Welcome to Coursera</h3>
            <p
              style={{
                color: theme.color.gray,
              }}
              className="text-sm mb-10"
            >
              Please sign-in to your account and start the adventure in
              coursera.
            </p>
            <Box component="form" autoComplete="off">
              <TextField
                fullWidth
                label="Email"
                defaultValue=""
                className={classes.input}
                style={{
                  marginBottom: "20px",
                }}
              />

              <TextField
                fullWidth
                label="Password"
                defaultValue=""
                className={classes.input}
                style={{
                  marginBottom: "10px",
                }}
              />

              <div className="flex justify-between items-center mb-5">
                <FormControlLabel
                  control={
                    <Checkbox
                      style={{
                        color: theme.color.primary,
                      }}
                      defaultChecked
                    />
                  }
                  label="Remember Me"
                />
                <Link style={{ color: theme.color.primary }} to="/sign-up">
                  Forgot Password?
                </Link>
              </div>

              <Button
                variant="contained"
                style={{
                  backgroundColor: theme.color.primary,
                  width: "100%",
                  height: "45px",
                }}
                onClick={() => {}}
              >
                Login
              </Button>

              <div className="flex justify-center items-center m-5">
                <p>New on our platform?</p>
                <Link style={{ color: theme.color.primary, marginLeft: 10 }} to="/sign-up">Create an account</Link>
              </div>
            </Box>
          </div>
        </div>
      </div>
    </div>
  );
}

export default SignInPage;
