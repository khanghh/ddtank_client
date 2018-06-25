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
      
      public function FilterFrameText()
      {
         super();
         autoSize = "left";
         mouseEnabled = false;
         _currentFrameIndex = 1;
         _frameTextFormat = new Vector.<TextFormat>();
      }
      
      public static function getStringWidthByTextField(str:String, size:int = 14, font:String = "Arial", autoSize:String = "left", bold:Boolean = true) : Number
      {
         var text:FilterFrameText = new FilterFrameText();
         text.defaultTextFormat = new TextFormat(font,size,0,bold);
         text.autoSize = autoSize;
         text.text = str;
         return text.width;
      }
      
      public function dispose() : void
      {
         _frameFilter = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         ComponentFactory.Instance.removeComponent(_id);
      }
      
      public function set filterString(filters:String) : void
      {
         if(_filterString == filters)
         {
            return;
         }
         _filterString = filters;
         frameFilters = ComponentFactory.Instance.creatFrameFilters(_filterString);
         setFrame(1);
      }
      
      public function set frameFilters(filter:Array) : void
      {
         if(_frameFilter == filter)
         {
            return;
         }
         _frameFilter = filter;
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function set id(value:int) : void
      {
         _id = value;
      }
      
      public function setFocus() : void
      {
         StageReferance.stage.focus = this;
      }
      
      public function setFrame(frameIndex:int) : void
      {
         _currentFrameIndex = frameIndex;
         if(_frameFilter != null && _frameFilter.length >= frameIndex)
         {
            filters = _frameFilter[frameIndex - 1];
         }
         if(_frameTextFormat != null && _frameTextFormat.length >= frameIndex)
         {
            textFormat = _frameTextFormat[frameIndex - 1];
         }
      }
      
      protected function set textFormat(tf:TextFormat) : void
      {
         if(tf == null)
         {
            return;
         }
         setTextFormat(tf);
         defaultTextFormat = tf;
      }
      
      public function set textFormatStyle(stylename:String) : void
      {
         var i:int = 0;
         var format:* = null;
         if(_textFormatStyle == stylename)
         {
            return;
         }
         _textFormatStyle = stylename;
         var frameTextFormats:Array = ComponentFactory.parasArgs(_textFormatStyle);
         _frameTextFormat = new Vector.<TextFormat>();
         for(i = 0; i < frameTextFormats.length; )
         {
            format = ComponentFactory.Instance.model.getSet(frameTextFormats[i]);
            _frameTextFormat.push(format);
            i++;
         }
         setFrame(1);
      }
      
      public function get textFormatStyle() : String
      {
         return _textFormatStyle;
      }
      
      public function set isAutoFitLength(value:Boolean) : void
      {
         _isAutoFitLength = value;
      }
      
      override public function set visible(value:Boolean) : void
      {
         .super.visible = value;
      }
      
      override public function set text(value:String) : void
      {
         var tempIndex:int = 0;
         .super.text = value;
         if(_isAutoFitLength && textWidth > width)
         {
            tempIndex = getCharIndexAtPoint(width - 22,5);
            .super.text = text.substring(0,tempIndex) + "...";
         }
         if(_width > 0 || _height > 0)
         {
            if(wordWrap == true)
            {
               width = _width;
            }
         }
         setFrame(_currentFrameIndex);
      }
      
      override public function set htmlText(value:String) : void
      {
         if(_width > 0 || _height > 0)
         {
            if(wordWrap == true)
            {
               width = _width;
            }
         }
         setFrame(_currentFrameIndex);
         .super.htmlText = value;
      }
      
      override public function set width(value:Number) : void
      {
         _width = value;
         .super.width = value;
      }
      
      override public function set height(value:Number) : void
      {
         _height = value;
         .super.height = value;
      }
      
      override public function set type(value:String) : void
      {
         if(value == "input")
         {
            mouseEnabled = true;
         }
         .super.type = value;
      }
   }
}
