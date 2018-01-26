package com.pickgliss.ui.text
{
   import com.pickgliss.geom.IntPoint;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.DisplayObjectViewport;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.utils.DisplayUtils;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.ui.Mouse;
   
   public class TextArea extends ScrollPanel
   {
      
      public static const P_textField:String = "textField";
       
      
      protected var _currentTextHeight:int = 0;
      
      protected var _enable:Boolean = true;
      
      protected var _textField:FilterFrameText;
      
      protected var _textStyle:String;
      
      public function TextArea(){super();}
      
      override public function dispose() : void{}
      
      public function get editable() : Boolean{return false;}
      
      public function set editable(param1:Boolean) : void{}
      
      public function get enable() : Boolean{return false;}
      
      public function set enable(param1:Boolean) : void{}
      
      public function get maxChars() : int{return 0;}
      
      public function set maxChars(param1:int) : void{}
      
      public function get text() : String{return null;}
      
      public function set text(param1:String) : void{}
      
      public function set htmlText(param1:String) : void{}
      
      public function get htmlText() : String{return null;}
      
      public function get textField() : FilterFrameText{return null;}
      
      public function set textField(param1:FilterFrameText) : void{}
      
      public function set textStyle(param1:String) : void{}
      
      override protected function layoutComponent() : void{}
      
      override protected function onProppertiesUpdate() : void{}
      
      private function __onTextAreaClick(param1:MouseEvent) : void{}
      
      private function __onTextAreaOut(param1:MouseEvent) : void{}
      
      private function __onTextAreaOver(param1:MouseEvent) : void{}
      
      private function __onTextChanged(param1:Event) : void{}
      
      private function __onTextKeyDown(param1:KeyboardEvent) : void{}
      
      public function upScrollArea() : void{}
   }
}
