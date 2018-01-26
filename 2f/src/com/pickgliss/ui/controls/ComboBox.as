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
      
      public function ComboBox(){super();}
      
      public function set button(param1:BaseButton) : void{}
      
      public function get button() : BaseButton{return null;}
      
      public function set buttonStyle(param1:String) : void{}
      
      public function get currentSelectedCellValue() : *{return null;}
      
      public function get currentSelectedIndex() : int{return 0;}
      
      public function set currentSelectedIndex(param1:int) : void{}
      
      public function get currentSelectedItem() : *{return null;}
      
      public function set defaultShowState(param1:int) : void{}
      
      override public function dispose() : void{}
      
      public function doHide() : void{}
      
      public function doShow() : void{}
      
      public function set listInnerRect(param1:InnerRectangle) : void{}
      
      public function set listInnerRectString(param1:String) : void{}
      
      public function get listPanel() : ListPanel{return null;}
      
      public function set listPanel(param1:ListPanel) : void{}
      
      public function set listPanelStyle(param1:String) : void{}
      
      public function set selctedPropName(param1:String) : void{}
      
      public function get textField() : TextField{return null;}
      
      public function set textField(param1:TextField) : void{}
      
      public function set textInnerRect(param1:InnerRectangle) : void{}
      
      public function set textInnerRectString(param1:String) : void{}
      
      public function set textStyle(param1:String) : void{}
      
      public function set enable(param1:Boolean) : void{}
      
      public function get enable() : Boolean{return false;}
      
      protected function __onItemChanged(param1:ListItemEvent) : void{}
      
      override protected function addChildren() : void{}
      
      override protected function init() : void{}
      
      protected function __onStageClick(param1:MouseEvent) : void{}
      
      protected function __onStageDown(param1:MouseEvent) : void{}
      
      protected function onHideComplete() : void{}
      
      override protected function onPosChanged() : void{}
      
      override protected function onProppertiesUpdate() : void{}
      
      protected function updateListPos() : void{}
      
      protected function updateListSize(param1:InteractiveEvent = null) : void{}
      
      protected function updateMask() : void{}
      
      public function set snapItemHeight(param1:Boolean) : void{}
      
      protected function __onAddToStage(param1:Event) : void{}
   }
}
