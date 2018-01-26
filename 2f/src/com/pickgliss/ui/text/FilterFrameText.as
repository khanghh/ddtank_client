package com.pickgliss.ui.text
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import flash.text.TextField;
   import flash.text.TextFormat;
   
   public class FilterFrameText extends TextField implements Disposeable
   {
      
      public static const P_frameFilters:String = "frameFilters";
      
      public static var isInputChangeWmode:Boolean = true;
       
      
      protected var _currentFrameIndex:int;
      
      protected var _filterString:String;
      
      protected var _frameFilter:Array;
      
      protected var _frameTextFormat:Vector.<TextFormat>;
      
      protected var _id:int;
      
      protected var _width:Number;
      
      protected var _height:Number;
      
      protected var _isAutoFitLength:Boolean = false;
      
      public var stylename:String;
      
      protected var _textFormatStyle:String;
      
      public function FilterFrameText(){super();}
      
      public static function getStringWidthByTextField(param1:String, param2:int = 14, param3:String = "Arial", param4:String = "left", param5:Boolean = true) : Number{return 0;}
      
      public function dispose() : void{}
      
      public function set filterString(param1:String) : void{}
      
      public function set frameFilters(param1:Array) : void{}
      
      public function get id() : int{return 0;}
      
      public function set id(param1:int) : void{}
      
      public function setFocus() : void{}
      
      public function setFrame(param1:int) : void{}
      
      protected function set textFormat(param1:TextFormat) : void{}
      
      public function set textFormatStyle(param1:String) : void{}
      
      public function get textFormatStyle() : String{return null;}
      
      public function set isAutoFitLength(param1:Boolean) : void{}
      
      override public function set visible(param1:Boolean) : void{}
      
      override public function set text(param1:String) : void{}
      
      override public function set htmlText(param1:String) : void{}
      
      override public function set width(param1:Number) : void{}
      
      override public function set height(param1:Number) : void{}
      
      override public function set type(param1:String) : void{}
   }
}
