import { Outlet, useLocation } from "react-router-dom";
import Header from "../../components/Header";
import Sidebar from "../../components/Sidebar";

import { useDispatch } from "react-redux";
import { setSiderState } from "../../redux/features/sider";
import { useEffect } from 'react';

function LayoutDashBoard() {

  const location = useLocation();
  const dispatch = useDispatch();
  
  useEffect(()=>{
    dispatch(setSiderState(location.pathname))
  })

  return (
    <>
      <div className="flex flex-row">
        <div className="basis-1/6">
          <Sidebar />
        </div>
        <div className="basis-5/6">
          <Header />
          <Outlet />
        </div>
      </div>
    </>
  );
}

export default LayoutDashBoard;
