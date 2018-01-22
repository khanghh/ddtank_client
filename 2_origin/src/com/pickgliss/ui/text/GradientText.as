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
      
      public function GradientText()
      {
         super();
      }
      
      public function set gradientRotation(param1:Number) : void
      {
         _gradientRotation = param1;
      }
      
      public function set colors(param1:String) : void
      {
         var _loc3_:int = 0;
         if(param1 == _colorStyle)
         {
            return;
         }
         _colorStyle = param1;
         _colors = [];
         var _loc2_:Array = _colorStyle.split("|");
         _loc3_ = 0;
         while(_loc3_ < _loc2_.length)
         {
            _colors.push(_loc2_[_loc3_].split(","));
            _loc3_++;
         }
         onPropertiesChanged("color");
      }
      
      public function set alphas(param1:String) : void
      {
         if(param1 == _alphaStyle)
         {
            return;
         }
         _alphaStyle = param1;
         if(_alphas)
         {
            _alphas = [];
         }
         _alphas = _alphaStyle.split(",");
         onPropertiesChanged("alpha");
      }
      
      public function set ratios(param1:String) : void
      {
         if(param1 == _ratioStyle)
         {
            return;
         }
         _ratioStyle = param1;
         if(_ratios)
         {
            _ratios = [];
         }
         _ratios = _ratioStyle.split(",");
         onPropertiesChanged("ratio");
      }
      
      public function set filterString(param1:String) : void
      {
         if(_filterString == param1)
         {
            return;
         }
         _filterString = param1;
         frameFilters = ComponentFactory.Instance.creatFrameFilters(_filterString);
      }
      
      public function set frameFilters(param1:Array) : void
      {
         if(_frameFilter == param1)
         {
            return;
         }
         _frameFilter = param1;
         onPropertiesChanged("frameFilters");
      }
      
      public function set text(param1:String) : void
      {
         _textField.text = param1;
         refreshBox();
      }
      
      public function get text() : String
      {
         return _textField.text;
      }
      
      public function set htmlText(param1:String) : void
      {
         _textField.htmlText = param1;
         refreshBox();
      }
      
      public function get htmlText() : String
      {
         return _textField.htmlText;
      }
      
      public function set textSize(param1:int) : void
      {
         if(_textSize == param1)
         {
            return;
         }
         _textSize = param1;
         onPropertiesChanged("textSize");
      }
      
      public function get textSize() : int
      {
         return _textSize;
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
         _textSize = int(_textField.defaultTextFormat.size);
         onPropertiesChanged("textField");
      }
      
      public function set textFieldStyle(param1:String) : void
      {
         if(param1 == _textFieldStyle)
         {
            return;
         }
         _textFieldStyle = param1;
         textField = ComponentFactory.Instance.creat(_textFieldStyle);
      }
      
      override protected function addChildren() : void
      {
         if(_textField)
         {
            addChild(_textField);
            _textField.cacheAsBitmap = true;
         }
         if(_gradientBox)
         {
            _gradientBox.x = _textField.x;
            _gradientBox.y = _textField.y;
            addChild(_gradientBox);
            _gradientBox.cacheAsBitmap = true;
            _gradientBox.mask = _textField;
         }
      }
      
      override public function get width() : Number
      {
         return _textField.width;
      }
      
      public function get textWidth() : Number
      {
         return _textField.textWidth;
      }
      
      public function getCharIndexAtPoint(param1:Number, param2:Number) : int
      {
         return _textField.getCharIndexAtPoint(param1,param2);
      }
      
      public function setFrame(param1:int) : void
      {
         if(_currentFrame == param1)
         {
            return;
         }
         _currentFrame = param1;
         refreshBox();
         filters = _frameFilter[param1 - 1];
      }
      
      override protected function onProppertiesUpdate() : void
      {
         super.onProppertiesUpdate();
         if(_changedPropeties["textField"] || _changedPropeties["color"] || _changedPropeties["alpha"] || _changedPropeties["ratio"] || _changedPropeties["textSize"])
         {
            refreshBox();
         }
         if(_changedPropeties["frameFilters"])
         {
            filters = _frameFilter[0];
         }
      }
      
      override public function dispose() : void
      {
         if(_textField)
         {
            ObjectUtils.disposeObject(_textField);
         }
         _textField = null;
         if(_gradientBox)
         {
            _gradientBox.graphics.clear();
         }
         _gradientBox = null;
         super.dispose();
      }
      
      private function refreshBox() : void
      {
         var _loc1_:TextFormat = _textField.getTextFormat();
         _loc1_.size = _textSize;
         _textField.setTextFormat(_loc1_);
         if(_textField.textWidth > _textField.width)
         {
            var _loc2_:* = _textField.textWidth + 8;
            _textField.width = _loc2_;
            _width = _loc2_;
         }
         _currentMatrix = new Matrix();
         _currentMatrix.createGradientBox(_textField.width,_textField.height,3.14159265358979 / 2,0,0);
         if(_gradientBox == null)
         {
            _gradientBox = new Shape();
         }
         _gradientBox.graphics.clear();
         _gradientBox.graphics.beginGradientFill("linear",_colors[_currentFrame - 1],_alphas,_ratios,_currentMatrix);
         _gradientBox.graphics.drawRect(0,0,_textField.width,_textField.height);
         _gradientBox.graphics.endFill();
      }
   }
}
