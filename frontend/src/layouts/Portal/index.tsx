import React from 'react'
import { Outlet } from 'react-router-dom'

function LayoutPortal() {
  return (
    <div>
      <Outlet />
    </div>
  )
}

export default LayoutPortal