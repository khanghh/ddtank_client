package com.pickgliss.ui.controls
{
   import com.pickgliss.geom.InnerRectangle;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.DisplayUtils;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   
   public class IconButton extends TextButton
   {
      
      public static const P_icon:String = "icon";
      
      public static const P_iconInnerRect:String = "iconInnerRect";
       
      
      protected var _icon:DisplayObject;
      
      protected var _iconInnerRect:InnerRectangle;
      
      protected var _iconInnerRectString:String;
      
      protected var _iconStyle:String;
      
      public function IconButton(){super();}
      
      override public function dispose() : void{}
      
      public function set icon(param1:DisplayObject) : void{}
      
      public function set iconInnerRectString(param1:String) : void{}
      
      public function set iconStyle(param1:String) : void{}
      
      override protected function addChildren() : void{}
      
      override protected function onProppertiesUpdate() : void{}
      
      protected function updateIconPos() : void{}
      
      override public function setFrame(param1:int) : void{}
   }
}
