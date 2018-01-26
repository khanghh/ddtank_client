package com.pickgliss.ui.controls
{
   import com.pickgliss.geom.InnerRectangle;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.DisplayUtils;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import flash.events.Event;
   
   public class SelectedIconButton extends SelectedButton
   {
      
      public static const P_icon:String = "icon";
      
      public static const P_iconInnerRect:String = "iconInnerRect";
       
      
      protected var _selectedIcon:DisplayObject;
      
      protected var _selectedIconInnerRect:InnerRectangle;
      
      protected var _selectedIconInnerRectString:String;
      
      protected var _selectedIconStyle:String;
      
      protected var _unselectedIcon:DisplayObject;
      
      protected var _unselectedIconInnerRect:InnerRectangle;
      
      protected var _unselectedIconInnerRectString:String;
      
      protected var _unselectedIconStyle:String;
      
      public function SelectedIconButton(){super();}
      
      override public function dispose() : void{}
      
      override public function set selected(param1:Boolean) : void{}
      
      public function set selectedIcon(param1:DisplayObject) : void{}
      
      public function set selectedIconInnerRectString(param1:String) : void{}
      
      public function set selectedIconStyle(param1:String) : void{}
      
      public function set unselectedIcon(param1:DisplayObject) : void{}
      
      public function set unselectedIconInnerRectString(param1:String) : void{}
      
      public function set unselectedIconStyle(param1:String) : void{}
      
      override protected function addChildren() : void{}
      
      override protected function onProppertiesUpdate() : void{}
      
      override public function setFrame(param1:int) : void{}
      
      protected function updateIconPos() : void{}
   }
}
