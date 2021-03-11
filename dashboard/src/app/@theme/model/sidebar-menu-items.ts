import { SidebarMenuItemsChildren } from "./sidebar-menu-items-children";

export interface SidebarMenuItems {
    id?: string;                            // [optional]: use if there is children for this item
    title?: string;                         // [optional]: item title, optional if translate is used
    link?: string;                          // [optional]: item link
    children?: SidebarMenuItemsChildren[];  // [optional]: use if there is subitem for this item
    translate?: string;                     // [Required]: word translation item 
    icon?: string;                          // [Required]: item icon
}