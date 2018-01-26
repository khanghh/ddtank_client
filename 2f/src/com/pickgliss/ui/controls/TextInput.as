package com.pickgliss.ui.controls
{
   import com.pickgliss.geom.InnerRectangle;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.DisplayUtils;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   
   public class TextInput extends Component
   {
      
      public static const P_back:String = "back";
      
      public static const P_focusBack:String = "focusBack";
      
      public static const P_focusBackgoundInnerRect:String = "focusBackOuterRect";
      
      public static const P_textField:String = "textField";
      
      public static const P_textInnerRect:String = "textInnerRect";
      
      public static const P_backgroundColor:String = "backgroundColor";
      
      public static const P_enable:String = "enable";
       
      
      protected var _back:DisplayObject;
      
      protected var _backStyle:String;
      
      protected var _focusBack:DisplayObject;
      
      protected var _focusBackgoundInnerRect:InnerRectangle;
      
      protected var _focusBackgoundInnerRectString:String;
      
      protected var _focusBackStyle:String;
      
      protected var _textField:TextField;
      
      protected var _textInnerRect:InnerRectangle;
      
      protected var _textInnerRectString:String;
      
      protected var _textStyle:String;
      
      protected var _backgroundColor:uint;
      
      protected var _filterString:String;
      
      protected var _frameFilter:Array;
      
      protected var _enable:Boolean = true;
      
      protected var _currentFrameIndex:int = 1;
      
      public function TextInput(){super();}
      
      public function set back(param1:DisplayObject) : void{}
      
      public function set backStyle(param1:String) : void{}
      
      public function set backgroundColor(param1:uint) : void{}
      
      public function get backgroundColor() : uint{return null;}
      
      public function set filterString(param1:String) : void{}
      
      public function get enable() : Boolean{return false;}
      
      public function set enable(param1:Boolean) : void{}
      
      protected function setFrame(param1:int) : void{}
      
      override public function dispose() : void{}
      
      public function set focusBack(param1:DisplayObject) : void{}
      
      public function set focusBackgoundInnerRectString(param1:String) : void{}
      
      public function set focusBackStyle(param1:String) : void{}
      
      public function get textField() : TextField{return null;}
      
      public function set textField(param1:TextField) : void{}
      
      public function set textInnerRectString(param1:String) : void{}
      
      public function set textStyle(param1:String) : void{}
      
      protected function __onFocusText(param1:Event) : void{}
      
      override protected function addChildren() : void{}
      
      public function set displayAsPassword(param1:Boolean) : void{}
      
      public function get displayAsPassword() : Boolean{return false;}
      
      public function set multiline(param1:Boolean) : void{}
      
      public function get multiline() : Boolean{return false;}
      
      public function set maxChars(param1:int) : void{}
      
      public function get maxChars() : int{return 0;}
      
      public function set autoSize(param1:String) : void{}
      
      public function get autoSize() : String{return null;}
      
      public function set text(param1:String) : void{}
      
      public function get text() : String{return null;}
      
      public function appendText(param1:String) : void{}
      
      public function setFocus() : void{}
      
      override protected function onProppertiesUpdate() : void{}
   }
}
