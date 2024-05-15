declare module 'vue-router' {
    import { Component } from 'vue';
    import { RouteRecordRaw, Router, RouterOptions, NavigationGuardNext, RouteLocationNormalized } from 'vue-router';
    
    export interface RouteMeta {
      [key: string]: any;
    }
  
    export interface RouteRecord {
      path: string;
      component: Component;
      name?: string;
      children?: RouteRecord[];
      meta?: RouteMeta;
    }
  
    export function createRouter(options: RouterOptions): Router;
    export function createWebHistory(base?: string): History;
  
    export {
      RouteRecordRaw,
      Router,
      RouterOptions,
      NavigationGuardNext,
      RouteLocationNormalized
    }
  }
  
  // src/shims-vue.d.ts
declare module '*.vue' {
    import { DefineComponent } from 'vue';
    const component: DefineComponent<{}, {}, any>;
    export default component;
  }
  