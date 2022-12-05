import React from 'react'
import { Backdrop, CircularProgress } from "@mui/material";

const LoadingIndicator: React.FC = () => {
  return (
    <>
        <Backdrop open={true}>
          <CircularProgress color="inherit" />
        </Backdrop>
    </>
  )
}

export default LoadingIndicator