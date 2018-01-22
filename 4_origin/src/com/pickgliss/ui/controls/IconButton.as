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
      
      public function IconButton()
      {
         super();
      }
      
      override public function dispose() : void
      {
         if(_icon)
         {
            ObjectUtils.disposeObject(_icon);
         }
         _icon = null;
         super.dispose();
      }
      
      public function set icon(param1:DisplayObject) : void
      {
         if(_icon == param1)
         {
            return;
         }
         ObjectUtils.disposeObject(_icon);
         _icon = param1;
         onPropertiesChanged("icon");
      }
      
      public function set iconInnerRectString(param1:String) : void
      {
         if(_iconInnerRectString == param1)
         {
            return;
         }
         _iconInnerRectString = param1;
         _iconInnerRect = ClassUtils.CreatInstance("com.pickgliss.geom.InnerRectangle",ComponentFactory.parasArgs(_iconInnerRectString));
         onPropertiesChanged("iconInnerRect");
      }
      
      public function set iconStyle(param1:String) : void
      {
         if(_iconStyle == param1)
         {
            return;
         }
         _iconStyle = param1;
         icon = ComponentFactory.Instance.creat(_iconStyle);
      }
      
      override protected function addChildren() : void
      {
         super.addChildren();
         if(_icon)
         {
            addChild(_icon);
         }
      }
      
      override protected function onProppertiesUpdate() : void
      {
         super.onProppertiesUpdate();
         if(_changedPropeties["width"] || _changedPropeties["height"] || _changedPropeties["iconInnerRect"] || _changedPropeties["icon"])
         {
            updateIconPos();
         }
      }
      
      protected function updateIconPos() : void
      {
         if(_icon && _iconInnerRect)
         {
            DisplayUtils.layoutDisplayWithInnerRect(_icon,_iconInnerRect,_width,_height);
         }
      }
      
      override public function setFrame(param1:int) : void
      {
         super.setFrame(param1);
         DisplayUtils.setFrame(_icon,param1);
      }
   }
}
