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
      
      public function MinimizeFrame()
      {
         super();
      }
      
      override protected function addChildren() : void
      {
         super.addChildren();
         if(_minimizeButton)
         {
            addChild(_minimizeButton);
         }
      }
      
      public function set minimizeRectString(param1:String) : void
      {
         if(_minimizeRectString == param1)
         {
            return;
         }
         _minimizeRectString = param1;
         _minimizeInnerRect = ClassUtils.CreatInstance("com.pickgliss.geom.InnerRectangle",ComponentFactory.parasArgs(_minimizeRectString));
         onPropertiesChanged("closeInnerRect");
      }
      
      public function get minimizeButton() : BaseButton
      {
         return _minimizeButton;
      }
      
      public function set minimizeButton(param1:BaseButton) : void
      {
         if(_minimizeButton == param1)
         {
            return;
         }
         if(_minimizeButton)
         {
            _minimizeButton.removeEventListener("click",__onMinimizeClick);
            ObjectUtils.disposeObject(_minimizeButton);
         }
         _minimizeButton = param1;
         onPropertiesChanged("minimizeButton");
      }
      
      public function set minimizeStyle(param1:String) : void
      {
         if(_minimizeStyle == param1)
         {
            return;
         }
         _minimizeStyle = param1;
         minimizeButton = ComponentFactory.Instance.creat(_minimizeStyle);
      }
      
      protected function updateMinimizePos() : void
      {
         if(_minimizeButton && _minimizeInnerRect)
         {
            DisplayUtils.layoutDisplayWithInnerRect(_minimizeButton,_minimizeInnerRect,_width,_height);
         }
      }
      
      override protected function onProppertiesUpdate() : void
      {
         super.onProppertiesUpdate();
         if(_changedPropeties["minimizeButton"])
         {
            _minimizeButton.addEventListener("click",__onMinimizeClick);
         }
         if(_changedPropeties["minimizeButton"] || _changedPropeties["minimizeInnerRect"])
         {
            updateMinimizePos();
         }
      }
      
      protected function __onMinimizeClick(param1:MouseEvent) : void
      {
         onResponse(5);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         if(_minimizeButton)
         {
            _minimizeButton.removeEventListener("click",__onMinimizeClick);
            ObjectUtils.disposeObject(_minimizeButton);
         }
         _minimizeButton = null;
      }
   }
}
