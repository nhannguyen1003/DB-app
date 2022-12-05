import { useState, lazy, Suspense } from "react";
import { BrowserRouter, Navigate, useRoutes } from "react-router-dom";
import LoadingIndicator from "./components/LoadingIndicator";

// Layout Dashboard
const DASH_BOARD = lazy(() => import("./layouts/DashBoard"));
const PORTAL = lazy(() => import("./layouts/Portal"));
const COURSE_PAGE = lazy(() => import("./pages/CoursePage"));
const NEW_COURSE_PAGE = lazy(() => import("./pages/CoursePage/NewCourse"));
const EDIT_COURSE_PAGE = lazy(() => import("./pages/CoursePage/EditCourse"));
const CHAPTER_PAGE = lazy(() => import("./pages/ChapterPage"));

// layout Portal
const NOT_AUTHENTICATION_PAGE = lazy(
  () => import("./pages/NotAuthenticationPage")
);
const SIGN_IN_PAGE = lazy(() => import("./pages/SignInPage"));
const SIGN_UP_PAGE = lazy(() => import("./pages/SignUpPage"));
// Not Found
const NOT_FOUND_PAGE = lazy(() => import("./pages/NotFoundPage"));

function RouterGuards() {
  const [isAuthenticated, setIsAuthenticated] = useState<boolean>(true);
  
  const dashboards = useRoutes([
    {
      element: <DASH_BOARD />,
      children: [
        { index: true, element: <COURSE_PAGE /> },
        { path: "/create-course", element: <NEW_COURSE_PAGE />},
        { path: "/edit-course/:id", element: <EDIT_COURSE_PAGE />},
        { path: "/chapter", element: <CHAPTER_PAGE /> },
      ],
    },
    {
      path: "*",
      element: <NOT_FOUND_PAGE />,
    },
  ]);

  const portals = useRoutes([
    {
      element: <PORTAL />,
      children: [
        { path: "/", element: <Navigate to="/sign-in" /> },
        { path: "/sign-in", element: <SIGN_IN_PAGE /> },
        { path: "/sign-up", element: <SIGN_UP_PAGE /> },
      ],
    },
    {
      path: "*",
      element: <NOT_AUTHENTICATION_PAGE />,
    },
  ]);

  return isAuthenticated ? dashboards : portals;
}

function Routing() {
  return (
    <>
      <BrowserRouter>
        <Suspense fallback={<LoadingIndicator />}>
          <RouterGuards />
        </Suspense>
      </BrowserRouter>
    </>
  );
}

export default Routing;
