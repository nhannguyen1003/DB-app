import { Checkbox, IconButton } from "@mui/material";
import { makeStyles } from "@mui/styles";
import { Course } from "../../../pages/CoursePage";
import { theme } from "../../../themes/theme";

import DeleteOutlineIcon from "@mui/icons-material/DeleteOutline";
import VisibilityOutlinedIcon from "@mui/icons-material/VisibilityOutlined";
import MoreVertIcon from "@mui/icons-material/MoreVert";

const useStyles = makeStyles({
  root: {
    "&:hover": {
      backgroundColor: theme.color.light,
    },
    display: "flex",
    alignItems: "center",
    fontSize: "14px",
    padding: "10px",
  },
});

function CourseTable({ course }: { course: Course }) {
  const classes = useStyles();

  return (
    <div className={classes.root}>
      <div className="basis-1/12 flex justify-left">
        <Checkbox style={{ color: theme.color.primary }} />
      </div>
      <div
        className="basis-1/12  flex justify-left"
        style={{
          color: theme.color.primary,
        }}
      >
        #{course.CourseId}
      </div>
      <div className="basis-3/12  flex justify-left">{course.CourseName}</div>
      <div
        className="basis-1/12  flex justify-left"
        style={{ color: theme.color.text + "aa" }}
      >
        {course.StartedDate}
      </div>
      <div
        className="basis-1/12  flex justify-left"
        style={{ color: theme.color.text + "aa" }}
      >
        {course.FinishedDate}
      </div>
      <div
        className="basis-1/12  flex justify-left"
      >
        <span style={{
          backgroundColor: theme.color.primary + "50",
          padding: " 5px 10px",
          borderRadius: "5px",
          color: theme.color.primary
        }}>
          {course.Level}
        </span>
      </div>
      <div className="basis-3/12  flex justify-left">{course.Subject}</div>
      <div className="basis-1/12  flex justify-left">
        <IconButton aria-label="delete">
          <DeleteOutlineIcon style={{ color: theme.color.text + "aa" }} />
        </IconButton>
        <IconButton aria-label="delete">
          <VisibilityOutlinedIcon style={{ color: theme.color.text + "aa" }} />
        </IconButton>
        <IconButton aria-label="delete">
          <MoreVertIcon style={{ color: theme.color.text + "aa" }} />
        </IconButton>
      </div>
    </div>
  );
}

export default CourseTable;
