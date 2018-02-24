package store.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class StoneCellFrame extends Sprite
   {
       
      
      private var _textField:FilterFrameText;
      
      private var _textFieldX:Number;
      
      private var _textFieldY:Number;
      
      private var _bg:Bitmap;
      
      private var _text:String;
      
      private var _textStyle:String;
      
      private var _backStyle:String;
      
      public function StoneCellFrame(){super();}
      
      public function set label(param1:String) : void{}
      
      private function init() : void{}
      
      public function dispose() : void{}
      
      public function get textStyle() : String{return null;}
      
      public function set textStyle(param1:String) : void{}
      
      public function get backStyle() : String{return null;}
      
      public function set backStyle(param1:String) : void{}
      
      public function get textFieldX() : Number{return 0;}
      
      public function set textFieldX(param1:Number) : void{}
      
      public function get textFieldY() : Number{return 0;}
      
      public function set textFieldY(param1:Number) : void{}
   }
}
