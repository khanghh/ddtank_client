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
      
      public function TextLabel(param1:String = "")
      {
         super();
         this.touchable = false;
         _styleName = param1;
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
         var _loc1_:BitmapData = drawTextToBitmapData();
         _fImage = Image.fromBitmapData(_loc1_,false);
         _fImage.touchable = false;
         _loc1_.dispose();
         addChild(_fImage);
      }
      
      public function set text(param1:String) : void
      {
         if(_text == param1)
         {
            return;
         }
         _text = param1;
         _fText.htmlText = _text;
         drawText();
      }
      
      public function get text() : String
      {
         return _text;
      }
      
      public function setFrame(param1:int) : void
      {
         frameText.setFrame(param1);
         drawText();
      }
      
      public function set textFormatStyle(param1:String) : void
      {
         if(frameText.textFormatStyle == param1)
         {
            return;
         }
         frameText.textFormatStyle = param1;
         drawText();
      }
      
      public function set isAutoFitLength(param1:Boolean) : void
      {
         frameText.isAutoFitLength = param1;
      }
      
      public function set fText(param1:TextField) : void
      {
         _fText = param1;
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
         var _loc1_:BitmapData = new BitmapData(_fText.width,_fText.height,true,16777215);
         if(text == "" || text == null || _fText.width <= 0 || _fText.height <= 0)
         {
            throw new Error("drawText to BitmapData failed!");
         }
         _loc1_.draw(_fText);
         return _loc1_;
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
