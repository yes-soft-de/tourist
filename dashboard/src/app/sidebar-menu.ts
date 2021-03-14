import { title } from "node:process";
import { SidebarMenuItems } from "./@theme/model/sidebar-menu-items";

export const SIDEBAR_MENU_ITEM: SidebarMenuItems[] = [
    {
        title: 'Dashboard',
        translate: 'dashboard',
        icon: 'fa fa-tachometer',
        link: '/'
    },
    {
        title: 'Regions',
        id: 'regions',
        translate: 'regions',
        icon: 'fa fa-institution',
        children: [
            {
                translate: 'all-regions',
                link: '/regions'
            },
            {
                translate: 'new-region',
                link: '/regions/add'
            }
        ]
    }
];
