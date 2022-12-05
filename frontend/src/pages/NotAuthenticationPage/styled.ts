import { makeStyles } from "@mui/styles";
import { theme } from "../../themes/theme";

export const useStyles = makeStyles({
    code: {
        fontSize: "80px",
        fontWeight: "bold",
    },
    status: {
        fontSize: "20px",
        fontWeight: "bold",
        display: "flex",
        justifyContent: "center",
        alignItems: "center",
    },
    message: {
        color: theme.color.gray,
        fontWeight: 400,
    },
    img: {
        height: "400px",
        margin: "20px auto",
    },
})
