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
      
      override public function set selected(value:Boolean) : void
      {
         _selected = value;
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
      
      public function set selectedIcon(display:DisplayObject) : void
      {
         if(_selectedIcon == display)
         {
            return;
         }
         ObjectUtils.disposeObject(_selectedIcon);
         _selectedIcon = display;
         onPropertiesChanged("icon");
      }
      
      public function set selectedIconInnerRectString(value:String) : void
      {
         if(_selectedIconInnerRectString == value)
         {
            return;
         }
         _selectedIconInnerRectString = value;
         _selectedIconInnerRect = ClassUtils.CreatInstance("com.pickgliss.geom.InnerRectangle",ComponentFactory.parasArgs(_selectedIconInnerRectString));
         onPropertiesChanged("iconInnerRect");
      }
      
      public function set selectedIconStyle(stylename:String) : void
      {
         if(_selectedIconStyle == stylename)
         {
            return;
         }
         _selectedIconStyle = stylename;
         _selectedIcon = ComponentFactory.Instance.creat(_selectedIconStyle);
      }
      
      public function set unselectedIcon(display:DisplayObject) : void
      {
         if(_unselectedIcon == display)
         {
            return;
         }
         ObjectUtils.disposeObject(_unselectedIcon);
         _unselectedIcon = display;
         onPropertiesChanged("icon");
      }
      
      public function set unselectedIconInnerRectString(value:String) : void
      {
         if(_unselectedIconInnerRectString == value)
         {
            return;
         }
         _unselectedIconInnerRectString = value;
         _unselectedIconInnerRect = ClassUtils.CreatInstance("com.pickgliss.geom.InnerRectangle",ComponentFactory.parasArgs(_unselectedIconInnerRectString));
         onPropertiesChanged("iconInnerRect");
      }
      
      public function set unselectedIconStyle(stylename:String) : void
      {
         if(_unselectedIconStyle == stylename)
         {
            return;
         }
         _unselectedIconStyle = stylename;
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
      
      override public function setFrame(frameIndex:int) : void
      {
         super.setFrame(frameIndex);
         DisplayUtils.setFrame(_selectedIcon,frameIndex);
         DisplayUtils.setFrame(_unselectedIcon,frameIndex);
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
