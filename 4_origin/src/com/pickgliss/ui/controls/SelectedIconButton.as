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
      
      public function SelectedIconButton()
      {
         super();
      }
      
      override public function dispose() : void
      {
         super.dispose();
      }
      
      override public function set selected(param1:Boolean) : void
      {
         _selected = param1;
         if(_selectedButton)
         {
            _selectedButton.visible = _selected;
         }
         if(_unSelectedButton)
         {
            _unSelectedButton.visible = !_selected;
         }
         if(_selectedIcon)
         {
            _selectedIcon.visible = _selected;
         }
         if(_unselectedIcon)
         {
            _unselectedIcon.visible = !_selected;
         }
         dispatchEvent(new Event("select"));
         drawHitArea();
      }
      
      public function set selectedIcon(param1:DisplayObject) : void
      {
         if(_selectedIcon == param1)
         {
            return;
         }
         ObjectUtils.disposeObject(_selectedIcon);
         _selectedIcon = param1;
         onPropertiesChanged("icon");
      }
      
      public function set selectedIconInnerRectString(param1:String) : void
      {
         if(_selectedIconInnerRectString == param1)
         {
            return;
         }
         _selectedIconInnerRectString = param1;
         _selectedIconInnerRect = ClassUtils.CreatInstance("com.pickgliss.geom.InnerRectangle",ComponentFactory.parasArgs(_selectedIconInnerRectString));
         onPropertiesChanged("iconInnerRect");
      }
      
      public function set selectedIconStyle(param1:String) : void
      {
         if(_selectedIconStyle == param1)
         {
            return;
         }
         _selectedIconStyle = param1;
         _selectedIcon = ComponentFactory.Instance.creat(_selectedIconStyle);
      }
      
      public function set unselectedIcon(param1:DisplayObject) : void
      {
         if(_unselectedIcon == param1)
         {
            return;
         }
         ObjectUtils.disposeObject(_unselectedIcon);
         _unselectedIcon = param1;
         onPropertiesChanged("icon");
      }
      
      public function set unselectedIconInnerRectString(param1:String) : void
      {
         if(_unselectedIconInnerRectString == param1)
         {
            return;
         }
         _unselectedIconInnerRectString = param1;
         _unselectedIconInnerRect = ClassUtils.CreatInstance("com.pickgliss.geom.InnerRectangle",ComponentFactory.parasArgs(_unselectedIconInnerRectString));
         onPropertiesChanged("iconInnerRect");
      }
      
      public function set unselectedIconStyle(param1:String) : void
      {
         if(_unselectedIconStyle == param1)
         {
            return;
         }
         _unselectedIconStyle = param1;
         _unselectedIcon = ComponentFactory.Instance.creat(_unselectedIconStyle);
      }
      
      override protected function addChildren() : void
      {
         super.addChildren();
         if(_selectedIcon)
         {
            addChild(_selectedIcon);
         }
         if(_unselectedIcon)
         {
            addChild(_unselectedIcon);
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
      
      override public function setFrame(param1:int) : void
      {
         super.setFrame(param1);
         DisplayUtils.setFrame(_selectedIcon,param1);
         DisplayUtils.setFrame(_unselectedIcon,param1);
      }
      
      protected function updateIconPos() : void
      {
         if(_unselectedIcon && _unselectedIconInnerRect)
         {
            DisplayUtils.layoutDisplayWithInnerRect(_unselectedIcon,_unselectedIconInnerRect,_width,_height);
         }
         if(_selectedIcon && _selectedIconInnerRect)
         {
            DisplayUtils.layoutDisplayWithInnerRect(_selectedIcon,_selectedIconInnerRect,_width,_height);
         }
      }
   }
}
