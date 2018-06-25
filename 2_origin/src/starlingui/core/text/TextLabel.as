package starlingui.core.text
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.StarlingObjectUtils;
   import flash.display.BitmapData;
   import flash.text.TextField;
   import starling.display.Image;
   import starling.display.Sprite;
   
   public class TextLabel extends Sprite
   {
       
      
      private var _styleName:String = "";
      
      private var _fImage:Image;
      
      private var _fText:TextField;
      
      private var _text:String;
      
      public function TextLabel(styleName:String = "")
      {
         super();
         this.touchable = false;
         _styleName = styleName;
         _fText = _styleName == ""?new TextField():ComponentFactory.Instance.creatComponentByStylename(_styleName);
         _fText.mouseEnabled = false;
         this.x = _fText.x;
         this.y = _fText.y;
         var _loc2_:int = 0;
         _fText.y = _loc2_;
         _fText.x = _loc2_;
      }
      
      public function drawText() : void
      {
         StarlingObjectUtils.disposeObject(_fImage,true);
         if(_text == null || _text == "")
         {
            return;
         }
         _fText.htmlText = _text;
         var btmd:BitmapData = drawTextToBitmapData();
         _fImage = Image.fromBitmapData(btmd,false);
         _fImage.touchable = false;
         btmd.dispose();
         addChild(_fImage);
      }
      
      public function set text(value:String) : void
      {
         if(_text == value)
         {
            return;
         }
         _text = value;
         _fText.htmlText = _text;
         drawText();
      }
      
      public function get text() : String
      {
         return _text;
      }
      
      public function setFrame(frameIndex:int) : void
      {
         frameText.setFrame(frameIndex);
         drawText();
      }
      
      public function set textFormatStyle(stylename:String) : void
      {
         if(frameText.textFormatStyle == stylename)
         {
            return;
         }
         frameText.textFormatStyle = stylename;
         drawText();
      }
      
      public function set isAutoFitLength(value:Boolean) : void
      {
         frameText.isAutoFitLength = value;
      }
      
      public function set fText(value:TextField) : void
      {
         _fText = value;
      }
      
      public function get fText() : TextField
      {
         return _fText;
      }
      
      public function get frameText() : FilterFrameText
      {
         return _fText as FilterFrameText;
      }
      
      private function drawTextToBitmapData() : BitmapData
      {
         var btmd:BitmapData = new BitmapData(_fText.width,_fText.height,true,16777215);
         if(text == "" || text == null || _fText.width <= 0 || _fText.height <= 0)
         {
            throw new Error("drawText to BitmapData failed!");
         }
         btmd.draw(_fText);
         return btmd;
      }
      
      override public function dispose() : void
      {
         StarlingObjectUtils.disposeObject(_fImage,true);
         _fText = null;
         _fImage = null;
         super.dispose();
      }
   }
}
