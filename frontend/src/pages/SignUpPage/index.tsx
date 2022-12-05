import {
  Box,
  Button,
  Checkbox,
  FormControlLabel,
  TextField,
} from "@mui/material";
import React from "react";
import { Link } from "react-router-dom";
import Logo from "../../components/Logo";
import { theme } from "../../themes/theme";
import { useStyles } from "./styled";

function SignUpPage() {
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
            src="https://demos.themeselection.com/marketplace/materio-mui-react-nextjs-admin-template/demo-4/images/pages/auth-v2-register-illustration-dark.png"
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
            <h3 className="text-2xl font-bold">Adventure starts here</h3>
            <p
              style={{
                color: theme.color.gray,
              }}
              className="text-sm mb-10"
            >
              Make your app management easy and fun.
            </p>
            <Box component="form" autoComplete="off">
              <TextField
                fullWidth
                label="Username"
                defaultValue=""
                className={classes.input}
                style={{
                  marginBottom: "20px",
                }}
              />
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

              <div className="flex items-center mb-5">
                <FormControlLabel
                  style={{
                    marginRight: 5,
                  }}
                  control={
                    <Checkbox
                      style={{
                        color: theme.color.primary,
                      }}
                      defaultChecked
                    />
                  }
                  label="I agree to"
                />
                <Link style={{ color: theme.color.primary }} to="/sign-up">
                  privacy policy & terms
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
                Sign Up
              </Button>

              <div className="flex justify-center items-center m-5">
                <p>Already have an account?</p>
                <Link
                  style={{ color: theme.color.primary, marginLeft: 10 }}
                  to="/sign-in"
                >
                  Sign in instead
                </Link>
              </div>
            </Box>
          </div>
        </div>
      </div>
    </div>
  );
}

export default SignUpPage;
