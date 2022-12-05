import { useStyles } from "./styled";
import { theme } from "../../themes/theme";
import TextField from "@mui/material/TextField";
import { Button } from "@mui/material";
import Checkbox from "@mui/material/Checkbox";
import CourseTable from "../../components/Table/Course";
import { useState } from "react";
import { useNavigate } from "react-router-dom";

export interface Course {
  CourseId: number;
  ProviderID: number;
  CourseName: string;
  StartedDate: string;
  FinishedDate: string;
  Level: string;
  Description: string;
  Subject: string;
  Syllabus: string;
  NumberOfLearners: number;
  NumberOfChapters: number;
  NumberOfAssignments: number;
}

function CoursePage() {
  const classes = useStyles();

  const [courses, setCourses] = useState<Course[]>([
    {
      CourseId: 1234,
      ProviderID: 2345,
      CourseName: "Database",
      StartedDate: "20/12/2022",
      FinishedDate: "20/12/2022",
      Level: "Junior",
      Description: "",
      Subject: "Computer science",
      Syllabus: "Database Tutorial",
      NumberOfLearners: 10,
      NumberOfChapters: 10,
      NumberOfAssignments: 10,
    },
    {
      CourseId: 1234,
      ProviderID: 2345,
      CourseName: "Database",
      StartedDate: "20/12/2022",
      FinishedDate: "20/12/2022",
      Level: "Junior",
      Description: "",
      Subject: "Computer science",
      Syllabus: "Database Tutorial",
      NumberOfLearners: 10,
      NumberOfChapters: 10,
      NumberOfAssignments: 10,
    },
    {
      CourseId: 1234,
      ProviderID: 2345,
      CourseName: "Database",
      StartedDate: "20/12/2022",
      FinishedDate: "20/12/2022",
      Level: "Junior",
      Description: "",
      Subject: "Computer science",
      Syllabus: "Database Tutorial",
      NumberOfLearners: 10,
      NumberOfChapters: 10,
      NumberOfAssignments: 10,
    },
    {
      CourseId: 1234,
      ProviderID: 2345,
      CourseName: "Database",
      StartedDate: "20/12/2022",
      FinishedDate: "20/12/2022",
      Level: "Junior",
      Description: "",
      Subject: "Computer science",
      Syllabus: "Database Tutorial",
      NumberOfLearners: 10,
      NumberOfChapters: 10,
      NumberOfAssignments: 10,
    },
    {
      CourseId: 1234,
      ProviderID: 2345,
      CourseName: "Database",
      StartedDate: "20/12/2022",
      FinishedDate: "20/12/2022",
      Level: "Junior",
      Description: "",
      Subject: "Computer science",
      Syllabus: "Database Tutorial",
      NumberOfLearners: 10,
      NumberOfChapters: 10,
      NumberOfAssignments: 10,
    },
    {
      CourseId: 1234,
      ProviderID: 2345,
      CourseName: "Database",
      StartedDate: "20/12/2022",
      FinishedDate: "20/12/2022",
      Level: "Junior",
      Description: "",
      Subject: "Computer science",
      Syllabus: "Database Tutorial",
      NumberOfLearners: 10,
      NumberOfChapters: 10,
      NumberOfAssignments: 10,
    },
    {
      CourseId: 1234,
      ProviderID: 2345,
      CourseName: "Database",
      StartedDate: "20/12/2022",
      FinishedDate: "20/12/2022",
      Level: "Junior",
      Description: "",
      Subject: "Computer science",
      Syllabus: "Database Tutorial",
      NumberOfLearners: 10,
      NumberOfChapters: 10,
      NumberOfAssignments: 10,
    },
  ]);

  const navigate = useNavigate();

  return (
    <div className={classes.root}>
      <div
        style={{
          backgroundColor: theme.color.secondary,
          borderTopLeftRadius: "5px",
          borderTopRightRadius: "5px",
        }}
      >
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
            Course Management
          </div>
          <div className="flex items-center">
            <TextField
              label="Search courses"
              size="small"
              className={classes.input}
            />
            <Button
              variant="contained"
              style={{
                backgroundColor: theme.color.primary,
                marginLeft: "20px",
              }}
              onClick={() => {
                navigate("/create-course");
              }}
            >
              Create Course
            </Button>
          </div>
        </div>

        <div className={classes.table}>
          <div
            className="flex flex-row items-center text-sm"
            style={{
              backgroundColor: theme.color.light,
              padding: "10px",
            }}
          >
            <div className="basis-1/12 flex justify-left">
              <Checkbox style={{ color: theme.color.primary }} />
            </div>
            <div className="basis-1/12  flex justify-left">ID</div>
            <div className="basis-3/12  flex justify-left">NAME</div>
            <div className="basis-1/12  flex justify-left">START</div>
            <div className="basis-1/12  flex justify-left">FINISH</div>
            <div className="basis-1/12  flex justify-left">LEVEL</div>
            <div className="basis-3/12  flex justify-left">SUBJECT</div>
            <div className="basis-1/12  flex justify-left">ACTIONS</div>
          </div>

          {courses.map((course, index) => {
            return <CourseTable course={course} key={index} />;
          })}
        </div>
      </div>
    </div>
  );
}

export default CoursePage;
