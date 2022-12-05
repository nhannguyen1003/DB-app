import { makeStyles } from "@mui/styles";
import { theme } from "../../themes/theme";

export const useStyles = makeStyles({
  input: {
    "& .MuiOutlinedInput-input": {
      color: theme.color.text,
    },
    "& .MuiFormLabel-root": {
      color: theme.color.text + "50",
      '&.Mui-focused': {
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
      '&.Mui-focused fieldset': {
        borderColor: theme.color.primary,
      },
    },
  },
});
