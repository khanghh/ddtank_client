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
      
      public function set button($button:BaseButton) : void
      {
         if(_button == $button)
         {
            return;
         }
         ObjectUtils.disposeObject(_button);
         _button = $button;
         onPropertiesChanged("button");
      }
      
      public function get button() : BaseButton
      {
         return _button;
      }
      
      public function set buttonStyle(stylename:String) : void
      {
         if(_buttonStyle == stylename)
         {
            return;
         }
         _buttonStyle = stylename;
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
      
      public function set currentSelectedIndex(val:int) : void
      {
         _listPanel.list.currentSelectedIndex = val;
      }
      
      public function get currentSelectedItem() : *
      {
         return _currentSelectedItem;
      }
      
      public function set defaultShowState(state:int) : void
      {
         if(_defaultShowState == state)
         {
            return;
         }
         _defaultShowState = state;
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
      
      public function set listInnerRect(rect:InnerRectangle) : void
      {
         if(_listInnerRect != null && _listInnerRect.equals(rect))
         {
            return;
         }
         _listInnerRect = rect;
         onPropertiesChanged("listInnerRect");
      }
      
      public function set listInnerRectString(value:String) : void
      {
         if(_listInnerRectString == value)
         {
            return;
         }
         _listInnerRectString = value;
         listInnerRect = ClassUtils.CreatInstance("com.pickgliss.geom.InnerRectangle",ComponentFactory.parasArgs(_listInnerRectString));
      }
      
      public function get listPanel() : ListPanel
      {
         return _listPanel;
      }
      
      public function set listPanel($list:ListPanel) : void
      {
         if(_listPanel == $list)
         {
            return;
         }
         if(_listPanel)
         {
            _listPanel.list.removeEventListener("listItemClick",__onItemChanged);
         }
         ObjectUtils.disposeObject(_listPanel);
         _listPanel = $list;
         _listPanel.list.addEventListener("listItemClick",__onItemChanged);
         onPropertiesChanged("listPanel");
      }
      
      public function set listPanelStyle(stylename:String) : void
      {
         if(_listPanelStyle == stylename)
         {
            return;
         }
         _listPanelStyle = stylename;
         listPanel = ComponentFactory.Instance.creat(_listPanelStyle);
      }
      
      public function set selctedPropName(propname:String) : void
      {
         if(_selctedPropName == propname)
         {
            return;
         }
         _selctedPropName = propname;
      }
      
      public function get textField() : TextField
      {
         return _textField;
      }
      
      public function set textField(field:TextField) : void
      {
         if(_textField == field)
         {
            return;
         }
         _textField = field;
         onPropertiesChanged("textField");
      }
      
      public function set textInnerRect(rect:InnerRectangle) : void
      {
         if(_textInnerRect != null && _textInnerRect.equals(rect))
         {
            return;
         }
         _textInnerRect = rect;
         onPropertiesChanged("textInnerRect");
      }
      
      public function set textInnerRectString(rectvalue:String) : void
      {
         if(_textRectString == rectvalue)
         {
            return;
         }
         _textRectString = rectvalue;
         textInnerRect = ClassUtils.CreatInstance("com.pickgliss.geom.InnerRectangle",ComponentFactory.parasArgs(_textRectString));
      }
      
      public function set textStyle(stylename:String) : void
      {
         if(_textStyle == stylename)
         {
            return;
         }
         _textStyle = stylename;
         textField = ComponentFactory.Instance.creat(_textStyle);
      }
      
      public function set enable(value:Boolean) : void
      {
         this._button.enable = value;
         if(!value)
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
      
      protected function __onItemChanged(event:ListItemEvent) : void
      {
         _currentSelectedItem = event.cell;
         _currentSelectedCellValue = event.cellValue;
         _currentSelectedIndex = event.index;
         if(_selctedPropName != null)
         {
            _textField.text = event.cell[_selctedPropName];
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
      
      protected function __onStageClick(event:MouseEvent) : void
      {
         var target:DisplayObject = event.target as DisplayObject;
         if(!DisplayUtils.isTargetOrContain(target,this) && !DisplayUtils.isTargetOrContain(target,_listPanel))
         {
            return;
         }
         if(DisplayUtils.isTargetOrContain(target,_button) || DisplayUtils.isTargetOrContain(target,_listPanel.list))
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
      
      protected function __onStageDown(event:MouseEvent) : void
      {
         var target:DisplayObject = event.target as DisplayObject;
         if(DisplayUtils.isTargetOrContain(target,_listPanel) || DisplayUtils.isTargetOrContain(target,this))
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
         var listRect:Rectangle = _listInnerRect.getInnerRect(_width,_height);
         _listPanel.x = _comboboxZeroPos.x + listRect.x;
         _listPanel.y = _comboboxZeroPos.y + listRect.y;
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
      
      protected function updateListSize(event:InteractiveEvent = null) : void
      {
         if(_listPanel == null)
         {
            return;
         }
         var listRect:Rectangle = _listInnerRect.getInnerRect(_width,_height);
         if(_snapItemHeight)
         {
            _listPanel.height = _listPanel.list.getViewSize().height + _listPanel.getShowHScrollbarExtendHeight();
         }
         else
         {
            _listPanel.height = listRect.height;
         }
         _listPanel.width = listRect.width;
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
      
      public function set snapItemHeight(value:Boolean) : void
      {
         if(_snapItemHeight == value)
         {
            return;
         }
         _snapItemHeight = value;
         onPropertiesChanged("snapItemHeight");
      }
      
      protected function __onAddToStage(event:Event) : void
      {
         onPosChanged();
      }
   }
}
