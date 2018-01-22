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
      
      public function TextLabel(param1:String = ""){super();}
      
      public function drawText() : void{}
      
      public function set text(param1:String) : void{}
      
      public function get text() : String{return null;}
      
      public function setFrame(param1:int) : void{}
      
      public function set textFormatStyle(param1:String) : void{}
      
      public function set isAutoFitLength(param1:Boolean) : void{}
      
      public function set fText(param1:TextField) : void{}
      
      public function get fText() : TextField{return null;}
      
      public function get frameText() : FilterFrameText{return null;}
      
      private function drawTextToBitmapData() : BitmapData{return null;}
      
      override public function dispose() : void{}
   }
}
