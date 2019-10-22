import { ReactNode } from 'react';
import {
  NavigationParams,
  NavigationDescriptor,
  NavigationInjectedProps
} from 'react-navigation';

export interface NativeNavigationPopover {
  sourceViewNativeID: string;
  contentSize: NativeNavigatorSize;
  sourceRect?: NativeNavigatorRect;
  directions?: NativeNavigatorDirection[];
}

export interface NativeNavigationOptions {
  transition?: NativeNavigatorTransitions;
  translucent?: boolean;
  gestureEnabled?: boolean;
  headerLeft?: ReactNode;
  headerCenter?: ReactNode;
  headerRight?: ReactNode;
  headerBackgroundColor?: string;
  headerBorderColor?: string;
  headerHidden?: boolean;
  popover?: NativeNavigationPopover;
}

export interface NavigationNativeRouterConfig {
  headerMode?: NativeNavigatorHeaderModes;
  mode?: NativeNavigatorModes;
  initialRouteName: string;
  defaultNavigationOptions?: NativeNavigationOptions;
}

export enum NativeNavigatorTransitions {
  None = 'none',
  SlideFromTop = 'slideFromTop',
  SlideFromRight = 'slideFromRight',
  SlideFromBottom = 'slideFromBottom',
  SlideFromLeft = 'slideFromLeft'
}

export enum NativeNavigatorModes {
  Stack = 'stack',
  Modal = 'modal', // modal 为背景透明的界面
  Split = 'split' // todo
}

export enum NativeNavigatorHeaderModes {
  None = 'none',
  Float = 'float'
}

export type NativeNavigationDescriptor = NavigationDescriptor<
  NavigationParams,
  NativeNavigationOptions
>;

export interface NativeNavigationDescriptorMap {
  [key: string]: NativeNavigationDescriptor;
}

export interface NativeNavigatorsProps extends NavigationInjectedProps {
  navigationConfig: NavigationNativeRouterConfig;
  screenProps?: any;
  descriptors: NativeNavigationDescriptorMap;
}

export enum NativeNavigationHeaderTypes {
  Center = 'center',
  Left = 'left',
  Right = 'right'
}

export interface NativeNavigatorSize {
  width: number;
  height: number;
}

export interface NativeNavigatorRect {
  x: number;
  y: number;
  width: number;
  height: number;
}

export enum NativeNavigatorDirection {
  Up = 'up',
  Down = 'down',
  Left = 'left',
  Right = 'right'
}
