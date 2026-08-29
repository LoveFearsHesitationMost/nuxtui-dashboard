// 侧边栏路由配置
import type { NavigationMenuItem } from "@nuxt/ui";

export interface SidebarRoute {
  label: string;
  icon: string;
  to: string;
  active?: boolean;
  children?: SidebarRoute[];
}

export const sidebarMainRoutes = [
  {
    label: "首页",
    icon: "i-lucide-home",
    to: "/dashboard/home",
    active: true,
  },
  {
    label: "课程中心",
    icon: "i-lucide-book-open",
    to: "/dashboard/courses",
    children: [
      {
        label: "我的课程",
        icon: "i-lucide-bookmark",
        to: "/dashboard/courses/my",
      },
      {
        label: "推荐课程",
        icon: "i-lucide-thumbs-up",
        to: "/dashboard/courses/recommended",
      },
    ],
  },
  {
    label: "题库练习",
    icon: "i-lucide-file-text",
    to: "/dashboard/practice",
    children: [
      {
        label: "每日一题",
        icon: "i-lucide-calendar",
        to: "/dashboard/practice/daily",
      },
      {
        label: "专项练习",
        icon: "i-lucide-target",
        to: "/dashboard/practice/specialized",
      },
    ],
  },
  {
    label: "学习统计",
    icon: "i-lucide-chart-line",
    to: "/dashboard/statistics",
  },
  {
    label: "积分商城",
    icon: "i-lucide-gift",
    to: "/dashboard/shop",
  },
  {
    label: "个人中心",
    icon: "i-lucide-user",
    to: "/dashboard/profile",
  },
] satisfies NavigationMenuItem[];

export const sidebarExternalRoutes = [
  {
    label: "Feedback",
    icon: "i-lucide-message-circle",
    to: "https://github.com/nuxt-ui-templates/dashboard",
    target: "_blank",
  },
  {
    label: "Help & Support",
    icon: "i-lucide-info",
    to: "https://github.com/nuxt-ui-templates/dashboard",
    target: "_blank",
  },
] satisfies NavigationMenuItem[];

// 路由元数据配置
export const routeMeta = {
  "/dashboard/home": {
    title: "首页",
    breadcrumb: ["仪表盘", "首页"],
  },
  "/dashboard/courses": {
    title: "课程中心",
    breadcrumb: ["仪表盘", "课程中心"],
  },
  "/dashboard/courses/my": {
    title: "我的课程",
    breadcrumb: ["仪表盘", "课程中心", "我的课程"],
  },
  "/dashboard/courses/recommended": {
    title: "推荐课程",
    breadcrumb: ["仪表盘", "课程中心", "推荐课程"],
  },
  "/dashboard/practice": {
    title: "题库练习",
    breadcrumb: ["仪表盘", "题库练习"],
  },
  "/dashboard/practice/daily": {
    title: "每日一题",
    breadcrumb: ["仪表盘", "题库练习", "每日一题"],
  },
  "/dashboard/practice/specialized": {
    title: "专项练习",
    breadcrumb: ["仪表盘", "题库练习", "专项练习"],
  },
  "/dashboard/statistics": {
    title: "学习统计",
    breadcrumb: ["仪表盘", "学习统计"],
  },
  "/dashboard/shop": {
    title: "积分商城",
    breadcrumb: ["仪表盘", "积分商城"],
  },
  "/dashboard/profile": {
    title: "个人中心",
    breadcrumb: ["仪表盘", "个人中心"],
  },
};
