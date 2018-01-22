package com.pickgliss.ui.controls
{
   import com.greensock.TweenLite;
   import com.pickgliss.events.InteractiveEvent;
   import com.pickgliss.events.ListItemEvent;
   import com.pickgliss.geom.InnerRectangle;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.ComponentSetting;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.DisplayUtils;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   
   [Event(name="stateChange",type="com.pickgliss.events.InteractiveEvent")]
   public class ComboBox extends Component
   {
      
      public static const P_button:String = "button";
      
      public static const P_defaultShowState:String = "currentShowState";
      
      public static const P_listInnerRect:String = "listInnerRect";
      
      public static const P_listPanel:String = "listPanel";
      
      public static const P_textField:String = "textField";
      
      public static const P_textInnerRect:String = "textInnerRect";
      
      protected static const COMBOX_HIDE_STATE:int = 0;
      
      protected static const COMBOX_SHOW_STATE:int = 1;
      
      public static var HIDE:int = 0;
      
      public static var SHOW:int = 1;
      
      public static const P_snapItemHeight:String = "snapItemHeight";
       
      
      protected var _button:BaseButton;
      
      protected var _buttonStyle:String;
      
      protected var _comboboxZeroPos:Point;
      
      protected var _currentSelectedCellValue;
      
      protected var _currentSelectedIndex:int = -1;
      
      protected var _currentSelectedItem;
      
      protected var _defaultShowState:int = 0;
      
      protected var _listInnerRect:InnerRectangle;
      
      protected var _listInnerRectString:String;
      
      protected var _listPanel:ListPanel;
      
      protected var _listPanelStyle:String;
      
      protected var _maskExtends:int = 100;
      
      protected var _maskShape:Shape;
      
      protected var _selctedPropName:String;
      
      protected var _state:int;
      
      protected var _textField:TextField;
      
      protected var _textInnerRect:InnerRectangle;
      
      protected var _textRectString:String = "textRectString";
      
      protected var _textStyle:String;
      
      protected var _tweenY:int;
      
      protected var _maxHeight:int = 540;
      
      protected var _easeType:int = 1;
      
      private var mGrayLayer:Sprite;
      
      protected var _snapItemHeight:Boolean;
      
      public function ComboBox()
      {
         super();
      }
      
      public function set button(param1:BaseButton) : void
      {
         if(_button == param1)
         {
            return;
         }
         ObjectUtils.disposeObject(_button);
         _button = param1;
         onPropertiesChanged("button");
      }
      
      public function get button() : BaseButton
      {
         return _button;
      }
      
      public function set buttonStyle(param1:String) : void
      {
         if(_buttonStyle == param1)
         {
            return;
         }
         _buttonStyle = param1;
         button = ComponentFactory.Instance.creat(_buttonStyle);
      }
      
      public function get currentSelectedCellValue() : *
      {
         return _currentSelectedCellValue;
      }
      
      public function get currentSelectedIndex() : int
      {
         return _currentSelectedIndex;
      }
      
      public function set currentSelectedIndex(param1:int) : void
      {
         _listPanel.list.currentSelectedIndex = param1;
      }
      
      public function get currentSelectedItem() : *
      {
         return _currentSelectedItem;
      }
      
      public function set defaultShowState(param1:int) : void
      {
         if(_defaultShowState == param1)
         {
            return;
         }
         _defaultShowState = param1;
         onPropertiesChanged("currentShowState");
      }
      
      override public function dispose() : void
      {
         if(_listPanel && _listPanel.list)
         {
            _listPanel.list.removeStateListener(updateListSize);
         }
         StageReferance.stage.removeEventListener("click",__onStageClick);
         StageReferance.stage.removeEventListener("mouseDown",__onStageDown);
         removeEventListener("addedToStage",__onAddToStage);
         if(_listPanel && _listPanel.list)
         {
            _listPanel.list.removeEventListener("listItemClick",__onItemChanged);
         }
         ObjectUtils.disposeObject(_listPanel);
         _listPanel = null;
         ObjectUtils.disposeObject(_button);
         _button = null;
         ObjectUtils.disposeObject(_textField);
         _textField = null;
         ObjectUtils.disposeObject(_maskShape);
         _maskShape = null;
         _listInnerRect = null;
         super.dispose();
      }
      
      public function doHide() : void
      {
         if(_state == HIDE)
         {
            return;
         }
         if(_listPanel.vectorListModel == null)
         {
            return;
         }
         if(_listPanel.vectorListModel.getSize() == 0)
         {
            return;
         }
         _defaultShowState = 0;
         TweenLite.killTweensOf(_listPanel);
         TweenLite.to(_listPanel,ComponentSetting.COMBOBOX_HIDE_TIME,{
            "y":_comboboxZeroPos.y - _listPanel.height,
            "ease":ComponentSetting.COMBOBOX_HIDE_EASE_FUNCTION,
            "onComplete":onHideComplete
         });
         _state = HIDE;
      }
      
      public function doShow() : void
      {
         if(_state == SHOW)
         {
            return;
         }
         if(_listPanel.vectorListModel == null)
         {
            return;
         }
         if(_listPanel.vectorListModel.getSize() == 0)
         {
            return;
         }
         onPosChanged();
         _defaultShowState = 1;
         if(_listPanel)
         {
            ComponentSetting.COMBOX_LIST_LAYER.addChild(_listPanel.asDisplayObject());
         }
         ComponentSetting.COMBOX_LIST_LAYER.addChild(_maskShape);
         TweenLite.killTweensOf(_listPanel);
         TweenLite.to(_listPanel,ComponentSetting.COMBOBOX_SHOW_TIME,{
            "y":_tweenY,
            "ease":ComponentSetting.COMBOBOX_SHOW_EASE_FUNCTION
         });
         _state = SHOW;
      }
      
      public function set listInnerRect(param1:InnerRectangle) : void
      {
         if(_listInnerRect != null && _listInnerRect.equals(param1))
         {
            return;
         }
         _listInnerRect = param1;
         onPropertiesChanged("listInnerRect");
      }
      
      public function set listInnerRectString(param1:String) : void
      {
         if(_listInnerRectString == param1)
         {
            return;
         }
         _listInnerRectString = param1;
         listInnerRect = ClassUtils.CreatInstance("com.pickgliss.geom.InnerRectangle",ComponentFactory.parasArgs(_listInnerRectString));
      }
      
      public function get listPanel() : ListPanel
      {
         return _listPanel;
      }
      
      public function set listPanel(param1:ListPanel) : void
      {
         if(_listPanel == param1)
         {
            return;
         }
         if(_listPanel)
         {
            _listPanel.list.removeEventListener("listItemClick",__onItemChanged);
         }
         ObjectUtils.disposeObject(_listPanel);
         _listPanel = param1;
         _listPanel.list.addEventListener("listItemClick",__onItemChanged);
         onPropertiesChanged("listPanel");
      }
      
      public function set listPanelStyle(param1:String) : void
      {
         if(_listPanelStyle == param1)
         {
            return;
         }
         _listPanelStyle = param1;
         listPanel = ComponentFactory.Instance.creat(_listPanelStyle);
      }
      
      public function set selctedPropName(param1:String) : void
      {
         if(_selctedPropName == param1)
         {
            return;
         }
         _selctedPropName = param1;
      }
      
      public function get textField() : TextField
      {
         return _textField;
      }
      
      public function set textField(param1:TextField) : void
      {
         if(_textField == param1)
         {
            return;
         }
         _textField = param1;
         onPropertiesChanged("textField");
      }
      
      public function set textInnerRect(param1:InnerRectangle) : void
      {
         if(_textInnerRect != null && _textInnerRect.equals(param1))
         {
            return;
         }
         _textInnerRect = param1;
         onPropertiesChanged("textInnerRect");
      }
      
      public function set textInnerRectString(param1:String) : void
      {
         if(_textRectString == param1)
         {
            return;
         }
         _textRectString = param1;
         textInnerRect = ClassUtils.CreatInstance("com.pickgliss.geom.InnerRectangle",ComponentFactory.parasArgs(_textRectString));
      }
      
      public function set textStyle(param1:String) : void
      {
         if(_textStyle == param1)
         {
            return;
         }
         _textStyle = param1;
         textField = ComponentFactory.Instance.creat(_textStyle);
      }
      
      public function set enable(param1:Boolean) : void
      {
         this._button.enable = param1;
         if(!param1)
         {
            mGrayLayer = new Sprite();
            mGrayLayer.width = 500;
            mGrayLayer.height = 500;
            mGrayLayer.alpha = 0.5;
            addChild(mGrayLayer);
         }
         else if(mGrayLayer && mGrayLayer.parent)
         {
            mGrayLayer.parent.removeChild(mGrayLayer);
         }
      }
      
      public function get enable() : Boolean
      {
         return this._button.enable;
      }
      
      protected function __onItemChanged(param1:ListItemEvent) : void
      {
         _currentSelectedItem = param1.cell;
         _currentSelectedCellValue = param1.cellValue;
         _currentSelectedIndex = param1.index;
         if(_selctedPropName != null)
         {
            _textField.text = param1.cell[_selctedPropName];
         }
         dispatchEvent(new InteractiveEvent("stateChange"));
      }
      
      override protected function addChildren() : void
      {
         super.addChildren();
         if(_button)
         {
            addChild(_button);
         }
         if(_textField)
         {
            addChild(_textField);
         }
      }
      
      override protected function init() : void
      {
         _maskShape = new Shape();
         addEventListener("addedToStage",__onAddToStage);
         StageReferance.stage.addEventListener("click",__onStageClick);
         StageReferance.stage.addEventListener("mouseDown",__onStageDown);
         super.init();
      }
      
      protected function __onStageClick(param1:MouseEvent) : void
      {
         var _loc2_:DisplayObject = param1.target as DisplayObject;
         if(!DisplayUtils.isTargetOrContain(_loc2_,this) && !DisplayUtils.isTargetOrContain(_loc2_,_listPanel))
         {
            return;
         }
         if(DisplayUtils.isTargetOrContain(_loc2_,_button) || DisplayUtils.isTargetOrContain(_loc2_,_listPanel.list))
         {
            if(_state == HIDE)
            {
               doShow();
            }
            else
            {
               doHide();
            }
         }
      }
      
      protected function __onStageDown(param1:MouseEvent) : void
      {
         var _loc2_:DisplayObject = param1.target as DisplayObject;
         if(DisplayUtils.isTargetOrContain(_loc2_,_listPanel) || DisplayUtils.isTargetOrContain(_loc2_,this))
         {
            return;
         }
         doHide();
      }
      
      protected function onHideComplete() : void
      {
         if(_listPanel && _listPanel.parent)
         {
            _listPanel.parent.removeChild(_listPanel.asDisplayObject());
         }
         if(_maskShape && _maskShape.parent)
         {
            _maskShape.parent.removeChild(_maskShape);
         }
      }
      
      override protected function onPosChanged() : void
      {
         _comboboxZeroPos = DisplayUtils.getPointFromObject(new Point(0,0),this,ComponentSetting.COMBOX_LIST_LAYER);
         if(_comboboxZeroPos.y + _listInnerRect.para2 + _listInnerRect.para4 > _maxHeight)
         {
            _tweenY = _comboboxZeroPos.y - _listInnerRect.para4;
            _easeType = 2;
         }
         else
         {
            _tweenY = _comboboxZeroPos.y + _listInnerRect.para2;
            _easeType = 1;
         }
         updateListPos();
         updateMask();
      }
      
      override protected function onProppertiesUpdate() : void
      {
         super.onProppertiesUpdate();
         if(_changedPropeties["listInnerRect"] || _changedPropeties["height"] || _changedPropeties["width"] || _changedPropeties["currentShowState"] || _changedPropeties["listPanel"])
         {
            onPosChanged();
            updateListSize();
            if(_listPanel)
            {
               _listPanel.list.addStateListener(updateListSize);
            }
         }
         if(_changedPropeties["textInnerRect"] || _changedPropeties["height"] || _changedPropeties["width"])
         {
            DisplayUtils.layoutDisplayWithInnerRect(_textField,_textInnerRect,_width,_height);
         }
         if(_changedPropeties["height"] || _changedPropeties["width"])
         {
            _button.beginChanges();
            _button.width = _width;
            _button.height = _height;
            _button.commitChanges();
         }
      }
      
      protected function updateListPos() : void
      {
         if(_listInnerRect == null || _listPanel == null)
         {
            return;
         }
         var _loc1_:Rectangle = _listInnerRect.getInnerRect(_width,_height);
         _listPanel.x = _comboboxZeroPos.x + _loc1_.x;
         _listPanel.y = _comboboxZeroPos.y + _loc1_.y;
         if(_defaultShowState == 0)
         {
            if(_easeType == 1)
            {
               _listPanel.y = _comboboxZeroPos.y - _listPanel.height;
            }
            else
            {
               _listPanel.y = _comboboxZeroPos.y;
            }
         }
         else if(_defaultShowState == 1)
         {
            _listPanel.y = _comboboxZeroPos.y + _listInnerRect.para2;
         }
      }
      
      protected function updateListSize(param1:InteractiveEvent = null) : void
      {
         if(_listPanel == null)
         {
            return;
         }
         var _loc2_:Rectangle = _listInnerRect.getInnerRect(_width,_height);
         if(_snapItemHeight)
         {
            _listPanel.height = _listPanel.list.getViewSize().height + _listPanel.getShowHScrollbarExtendHeight();
         }
         else
         {
            _listPanel.height = _loc2_.height;
         }
         _listPanel.width = _loc2_.width;
         _maskShape = DisplayUtils.drawRectShape(_listPanel.width + 2 * _maskExtends,_listPanel.height + _maskExtends * 2,_maskShape);
         updateMask();
      }
      
      protected function updateMask() : void
      {
         if(!_listPanel)
         {
            return;
         }
         _listPanel.mask = _maskShape;
         _maskShape.x = _comboboxZeroPos.x - _maskExtends;
         _maskShape.y = _easeType == 1?_comboboxZeroPos.y + _height:Number(_comboboxZeroPos.y - _maskShape.height);
      }
      
      public function set snapItemHeight(param1:Boolean) : void
      {
         if(_snapItemHeight == param1)
         {
            return;
         }
         _snapItemHeight = param1;
         onPropertiesChanged("snapItemHeight");
      }
      
      protected function __onAddToStage(param1:Event) : void
      {
         onPosChanged();
      }
   }
}
