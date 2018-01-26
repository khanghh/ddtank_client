package com.pickgliss.ui.text
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Shape;
   import flash.geom.Matrix;
   import flash.text.TextField;
   import flash.text.TextFormat;
   
   public class GradientText extends Component
   {
      
      public static const P_alpha:String = "alpha";
      
      public static const P_color:String = "color";
      
      public static const P_frameFilters:String = "frameFilters";
      
      public static const P_ratio:String = "ratio";
      
      public static const P_textField:String = "textField";
      
      public static const P_size:String = "textSize";
       
      
      protected var _filterString:String;
      
      protected var _frameFilter:Array;
      
      private var _colorStyle:String = "";
      
      private var _alphaStyle:String = "";
      
      private var _ratioStyle:String = "";
      
      private var _colors:Array;
      
      private var _alphas:Array;
      
      private var _ratios:Array;
      
      private var _gradientRotation:Number = 90;
      
      private var _currentFrame:int = 1;
      
      private var _currentMatrix:Matrix;
      
      private var _gradientBox:Shape;
      
      private var _textField:TextField;
      
      private var _textFieldStyle:String = "";
      
      private var _textSize:int;
      
      public function GradientText(){super();}
      
      public function set gradientRotation(param1:Number) : void{}
      
      public function set colors(param1:String) : void{}
      
      public function set alphas(param1:String) : void{}
      
      public function set ratios(param1:String) : void{}
      
      public function set filterString(param1:String) : void{}
      
      public function set frameFilters(param1:Array) : void{}
      
      public function set text(param1:String) : void{}
      
      public function get text() : String{return null;}
      
      public function set htmlText(param1:String) : void{}
      
      public function get htmlText() : String{return null;}
      
      public function set textSize(param1:int) : void{}
      
      public function get textSize() : int{return 0;}
      
      public function get textField() : TextField{return null;}
      
      public function set textField(param1:TextField) : void{}
      
      public function set textFieldStyle(param1:String) : void{}
      
      override protected function addChildren() : void{}
      
      override public function get width() : Number{return 0;}
      
      public function get textWidth() : Number{return 0;}
      
      public function getCharIndexAtPoint(param1:Number, param2:Number) : int{return 0;}
      
      public function setFrame(param1:int) : void{}
      
      override protected function onProppertiesUpdate() : void{}
      
      override public function dispose() : void{}
      
      private function refreshBox() : void{}
   }
}
