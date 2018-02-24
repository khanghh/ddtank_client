package com.pickgliss.ui.controls
{
   import com.pickgliss.geom.InnerRectangle;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.DisplayUtils;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.MouseEvent;
   
   public class MinimizeFrame extends Frame
   {
      
      public static const P_minimizeButton:String = "minimizeButton";
      
      public static const P_minimizeRect:String = "minimizeInnerRect";
       
      
      protected var _minimizeButton:BaseButton;
      
      protected var _minimizeInnerRect:InnerRectangle;
      
      protected var _minimizeRectString:String;
      
      protected var _minimizeStyle:String;
      
      public function MinimizeFrame(){super();}
      
      override protected function addChildren() : void{}
      
      public function set minimizeRectString(param1:String) : void{}
      
      public function get minimizeButton() : BaseButton{return null;}
      
      public function set minimizeButton(param1:BaseButton) : void{}
      
      public function set minimizeStyle(param1:String) : void{}
      
      protected function updateMinimizePos() : void{}
      
      override protected function onProppertiesUpdate() : void{}
      
      protected function __onMinimizeClick(param1:MouseEvent) : void{}
      
      override public function dispose() : void{}
   }
}
