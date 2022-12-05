import { makeStyles } from "@mui/styles";
import { theme } from "../../themes/theme";

export const useStyles = makeStyles({
  root: {
    padding: "20px",
    marginTop: "10px",
  },
  input: {
    "& .MuiOutlinedInput-input": {
      color: theme.color.text,
    },
    "& .MuiFormLabel-root": {
      color: theme.color.text + "50",
      "&.Mui-focused": {
        color: theme.color.primary,
      },
    },
    "& .MuiOutlinedInput-notchedOutline": {
      borderColor: theme.color.text + "50",
    },
    "& .MuiOutlinedInput-root": {
      "&:hover fieldset": {
        borderColor: theme.color.text + "80",
      },
      "&.Mui-focused fieldset": {
        borderColor: theme.color.primary,
      },
    },
    "& .MuiSvgIcon-root": {
      color: theme.color.text,
    },
  },
  table: {
    minHeight: "500px",
    height: "500px",
    borderTop: "1px solid",
    borderTopColor: theme.color.text + "50",
    overflow: "scroll",
  },
  textArea: {
    backgroundColor: "transparent",
    color: theme.color.text + "50",
    width: "100%",
    border: "1px solid",
    borderColor: theme.color.gray + "50",
    padding: "13px",
    borderRadius: "5px",
    "&:focus": {
      outline: "1px solid",
      outlineColor: theme.color.primary,
    },
    "&::placeholder": {
      color: theme.color.text + "50",
    },
  },
});
