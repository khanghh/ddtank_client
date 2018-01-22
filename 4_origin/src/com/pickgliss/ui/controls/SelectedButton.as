package com.pickgliss.ui.controls
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.DisplayUtils;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.PNGHitAreaFactory;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   [Event(name="select",type="flash.events.Event")]
   public class SelectedButton extends BaseButton implements ISelectable
   {
      
      public static const P_selectedStyle:String = "selectedStyle";
      
      public static const P_unSelectedStyle:String = "unSelectedStyle";
      
      public static const P_selected:String = "selected";
       
      
      protected var _selected:Boolean;
      
      protected var _selectedButton:DisplayObject;
      
      protected var _selectedStyle:String;
      
      protected var _unSelectedButton:DisplayObject;
      
      protected var _unSelectedStyle:String;
      
      private var _autoSelect:Boolean = true;
      
      private var _selectHitArea:Sprite;
      
      private var _unSelectHitArea:Sprite;
      
      public function SelectedButton()
      {
         super();
      }
      
      public function set autoSelect(param1:Boolean) : void
      {
         if(_autoSelect == param1)
         {
            return;
         }
         _autoSelect = param1;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_selectedButton);
         _selectedButton = null;
         ObjectUtils.disposeObject(_unSelectedButton);
         _unSelectedButton = null;
         ObjectUtils.disposeObject(_selectHitArea);
         ObjectUtils.disposeObject(_unSelectHitArea);
         _selectHitArea = null;
         _unSelectHitArea = null;
         super.dispose();
      }
      
      public function get selected() : Boolean
      {
         return _selected;
      }
      
      public function set selected(param1:Boolean) : void
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
         onPropertiesChanged("selected");
         dispatchEvent(new Event("select"));
         drawHitArea();
      }
      
      public function get selectedStyle() : String
      {
         return _selectedStyle;
      }
      
      public function set selectedStyle(param1:String) : void
      {
         if(_selectedStyle == param1)
         {
            return;
         }
         _selectedStyle = param1;
         onPropertiesChanged("selectedStyle");
      }
      
      override public function setFrame(param1:int) : void
      {
         super.setFrame(param1);
         if(_selectedButton)
         {
            DisplayUtils.setFrame(_selectedButton,_currentFrameIndex);
         }
         if(_unSelectedButton)
         {
            DisplayUtils.setFrame(_unSelectedButton,_currentFrameIndex);
         }
      }
      
      public function setSelectedButton(param1:DisplayObject) : void
      {
         ObjectUtils.disposeObject(_selectedButton);
         _selectedButton = param1;
         DisplayUtils.setDisplayObjectNotEnable(_selectedButton);
         setFrame(1);
      }
      
      public function setUnselectedButton(param1:DisplayObject) : void
      {
         ObjectUtils.disposeObject(_unSelectedButton);
         _unSelectedButton = param1;
         DisplayUtils.setDisplayObjectNotEnable(_unSelectedButton);
         setFrame(1);
      }
      
      public function get unSelectedStyle() : String
      {
         return _unSelectedStyle;
      }
      
      public function set unSelectedStyle(param1:String) : void
      {
         if(_unSelectedStyle == param1)
         {
            return;
         }
         _unSelectedStyle = param1;
         onPropertiesChanged("unSelectedStyle");
      }
      
      override protected function __onMouseClick(param1:MouseEvent) : void
      {
         super.__onMouseClick(param1);
         if(_autoSelect)
         {
            selected = !_selected;
         }
      }
      
      override protected function adaptHitArea() : void
      {
         _PNGHitArea.alpha = 0;
         _PNGHitArea.x = !!_selected?_selectedButton.x:Number(_unSelectedButton.x);
         _PNGHitArea.y = !!_selected?_selectedButton.y:Number(_unSelectedButton.y);
      }
      
      override protected function addChildren() : void
      {
         super.addChildren();
         if(_selectedButton)
         {
            addChild(_selectedButton);
         }
         if(_unSelectedButton)
         {
            addChild(_unSelectedButton);
         }
      }
      
      override protected function drawHitArea() : void
      {
         if(_PNGHitArea && contains(_PNGHitArea))
         {
            removeChild(_PNGHitArea);
         }
         if(_transparentEnable)
         {
            if(_selectHitArea == null)
            {
               _selectHitArea = PNGHitAreaFactory.drawHitArea(DisplayUtils.getDisplayBitmapData(_selectedButton));
            }
            if(_unSelectHitArea == null)
            {
               _unSelectHitArea = PNGHitAreaFactory.drawHitArea(DisplayUtils.getDisplayBitmapData(_unSelectedButton));
            }
            _PNGHitArea = !!_selected?_selectHitArea:_unSelectHitArea;
            adaptHitArea();
            _PNGHitArea.alpha = 0;
            hitArea = _PNGHitArea;
            addChild(_PNGHitArea);
         }
         else if(_PNGHitArea && contains(_PNGHitArea))
         {
            removeChild(_PNGHitArea);
         }
      }
      
      override protected function onProppertiesUpdate() : void
      {
         super.onProppertiesUpdate();
         if(_selected && _selectedButton)
         {
            _width = _selectedButton.width;
            _height = _selectedButton.height;
         }
         else if(!_selected && _unSelectedButton)
         {
            _width = _unSelectedButton.width;
            _height = _unSelectedButton.height;
         }
         if(_changedPropeties["unSelectedStyle"])
         {
            setUnselectedButton(ComponentFactory.Instance.creat(_unSelectedStyle));
            selected = _selected;
         }
         if(_changedPropeties["selectedStyle"])
         {
            setSelectedButton(ComponentFactory.Instance.creat(_selectedStyle));
            selected = _selected;
         }
      }
   }
}
