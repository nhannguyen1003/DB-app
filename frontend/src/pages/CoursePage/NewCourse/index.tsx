import { Button, TextField } from "@mui/material";
import React from "react";
import { theme } from "../../../themes/theme";
import { useStyles } from "./../styled";
import { Dayjs } from "dayjs";
import { AdapterDayjs } from "@mui/x-date-pickers/AdapterDayjs";
import { LocalizationProvider } from "@mui/x-date-pickers/LocalizationProvider";
import { DatePicker } from "@mui/x-date-pickers/DatePicker";
import TextareaAutosize from "@mui/material/TextareaAutosize";
import AddIcon from "@mui/icons-material/Add";
import Logo from "../../../components/Logo";

function NewCourse() {
  const classes = useStyles();
  const [dateStart, setDateStart] = React.useState<Dayjs | null>(null);
  const [dateFinish, setDateFinish] = React.useState<Dayjs | null>(null);
  return (
    <div className={classes.root}>
      <div
        style={{
          backgroundColor: theme.color.secondary,
          borderTopLeftRadius: "5px",
          borderTopRightRadius: "5px",
          minHeight: "600px",
        }}
      >
        <Logo />
        <div
          style={{
            padding: "20px",
          }}
          className="flex flex-row items-center justify-between"
        >
          <div
            style={{
              border: "1px solid",
              borderColor: theme.color.text + "50",
              padding: "7px 10px",
              borderRadius: "5px",
            }}
          >
            Create New Course
          </div>
        </div>

        <div
          className="flex flex-row"
          style={{
            padding: "20px",
          }}
        >
          <div className="basis-1/4">
            <TextField
              fullWidth
              label="Name"
              defaultValue=""
              className={classes.input}
              style={{
                marginBottom: "20px",
              }}
              size="small"
            />
            <LocalizationProvider dateAdapter={AdapterDayjs}>
              <DatePicker
                label="Start Date"
                value={dateStart}
                onChange={(newValue) => {
                  setDateStart(newValue);
                }}
                className={classes.input}
                renderInput={(params) => (
                  <TextField
                    size="small"
                    fullWidth
                    style={{
                      marginBottom: "20px",
                    }}
                    {...params}
                  />
                )}
              />
            </LocalizationProvider>
            <LocalizationProvider dateAdapter={AdapterDayjs}>
              <DatePicker
                label="Finish Date"
                value={dateFinish}
                onChange={(newValue) => {
                  setDateFinish(newValue);
                }}
                className={classes.input}
                renderInput={(params) => (
                  <TextField
                    size="small"
                    fullWidth
                    style={{
                      marginBottom: "20px",
                    }}
                    {...params}
                  />
                )}
              />
            </LocalizationProvider>
            <TextField
              fullWidth
              label="Level"
              defaultValue=""
              className={classes.input}
              style={{
                marginBottom: "20px",
              }}
              size="small"
            />

            <div className="text-left">
              <Button
                variant="contained"
                style={{
                  backgroundColor: theme.color.primary,
                }}
                startIcon={<AddIcon />}
              >
                Create Course
              </Button>
            </div>
          </div>

          <div className="basis-1/4 flex justify-left ml-10">
            <div>
              <TextField
                fullWidth
                label="Subject"
                defaultValue=""
                className={classes.input}
                style={{
                  marginBottom: "20px",
                }}
                size="small"
              />
              <TextField
                fullWidth
                label="Syllabus"
                defaultValue=""
                className={classes.input}
                style={{
                  marginBottom: "20px",
                }}
                size="small"
              />
              <TextareaAutosize
                placeholder="Description"
                className={classes.textArea}
                minRows={3}
              />
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}

export default NewCourse;
