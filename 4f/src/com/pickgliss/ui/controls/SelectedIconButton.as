package com.pickgliss.ui.controls{   import com.pickgliss.geom.InnerRectangle;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.utils.ClassUtils;   import com.pickgliss.utils.DisplayUtils;   import com.pickgliss.utils.ObjectUtils;   import flash.display.DisplayObject;   import flash.events.Event;      public class SelectedIconButton extends SelectedButton   {            public static const P_icon:String = "icon";            public static const P_iconInnerRect:String = "iconInnerRect";                   protected var _selectedIcon:DisplayObject;            protected var _selectedIconInnerRect:InnerRectangle;            protected var _selectedIconInnerRectString:String;            protected var _selectedIconStyle:String;            protected var _unselectedIcon:DisplayObject;            protected var _unselectedIconInnerRect:InnerRectangle;            protected var _unselectedIconInnerRectString:String;            protected var _unselectedIconStyle:String;            public function SelectedIconButton() { super(); }
            override public function dispose() : void { }
            override public function set selected(value:Boolean) : void { }
            public function set selectedIcon(display:DisplayObject) : void { }
            public function set selectedIconInnerRectString(value:String) : void { }
            public function set selectedIconStyle(stylename:String) : void { }
            public function set unselectedIcon(display:DisplayObject) : void { }
            public function set unselectedIconInnerRectString(value:String) : void { }
            public function set unselectedIconStyle(stylename:String) : void { }
            override protected function addChildren() : void { }
            override protected function onProppertiesUpdate() : void { }
            override public function setFrame(frameIndex:int) : void { }
            protected function updateIconPos() : void { }
   }}