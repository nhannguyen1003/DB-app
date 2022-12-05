import LayersIcon from '@mui/icons-material/Layers';
import CalendarViewMonthIcon from '@mui/icons-material/CalendarViewMonth';
import SlideshowIcon from '@mui/icons-material/Slideshow';
import ArticleIcon from '@mui/icons-material/Article';
import WorkspacePremiumIcon from '@mui/icons-material/WorkspacePremium';
import AssignmentTurnedInIcon from '@mui/icons-material/AssignmentTurnedIn';
import ChatIcon from '@mui/icons-material/Chat';
import SpeedIcon from '@mui/icons-material/Speed';

export interface MenuItemType {
    label: string;
    path: string;
    icon?: React.ReactNode;
    children?: MenuItemType[];
}

export const sidebarConfig: MenuItemType[] = [
    {
        label: "Courses",
        path: "/",
        icon: <LayersIcon />,
        children: [
            {
                label: "All courses",
                path: "/",
            },
            {
                label: "New course",
                path: "/create-course",
            }
        ]
    },
    {
        label: "Chapters",
        path: "/chapter",
        icon: <CalendarViewMonthIcon />,
        children: [
            {
                label: "All chapters",
                path: "/chapter",
            },
            {
                label: "New chapter",
                path: "/create-chapter",
            }
        ]
    },
    {
        label: "Videos",
        path: "/video",
        icon: <SlideshowIcon />,
        children: [
            {
                label: "All videos",
                path: "/video",
            },
            {
                label: "New video",
                path: "/create-video",
            }
        ]
    },
    {
        label: "Documents",
        path: "/document",
        icon: <ArticleIcon />,
        children: [
            {
                label: "All documents",
                path: "/document",
            },
            {
                label: "New document",
                path: "/create-document",
            }
        ]
    },
    {
        label: "Certificates",
        path: "/certificate",
        icon: <WorkspacePremiumIcon />,
        children: [
            {
                label: "All certificates",
                path: "/certificate",
            },
            {
                label: "New certificate",
                path: "/create-certificate",
            }
        ]
    },
    {
        label: "Assignments",
        path: "/assignment",
        icon: <AssignmentTurnedInIcon />,
        children: [
            {
                label: "All assignments",
                path: "/assignment",
            },
            {
                label: "New chapters",
                path: "/create-assignment",
            }
        ]
    },
    {
        label: "Feedbacks",
        path: "/feedback",
        icon: <ChatIcon />,
        children: [
            {
                label: "All feedbacks",
                path: "/feedback",
            },
            {
                label: "New chapters",
                path: "/create-feedback",
            }
        ]
    },
    {
        label: "Final Tests",
        path: "/final-test",
        icon: <SpeedIcon />,
        children: [
            {
                label: "All final tests",
                path: "/final-test",
            },
            {
                label: "New final test",
                path: "/create-final-test",
            }
        ]
    }
]