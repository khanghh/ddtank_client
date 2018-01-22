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
      
      public function StoneCellFrame()
      {
         super();
      }
      
      public function set label(param1:String) : void
      {
         if(_textField == null)
         {
            return;
         }
         _text = param1;
         _textField.text = _text;
         _textField.x = textFieldX;
         _textField.y = textFieldY;
      }
      
      private function init() : void
      {
         addChild(_bg);
         addChild(_textField);
      }
      
      public function dispose() : void
      {
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
         }
         _bg = null;
         if(_textField)
         {
            ObjectUtils.disposeObject(_textField);
         }
         _textField = null;
      }
      
      public function get textStyle() : String
      {
         return _textStyle;
      }
      
      public function set textStyle(param1:String) : void
      {
         if(param1 == null || param1.length == 0)
         {
            return;
         }
         _textStyle = param1;
         _textField = ComponentFactory.Instance.creatComponentByStylename(_textStyle);
         addChild(_textField);
      }
      
      public function get backStyle() : String
      {
         return _backStyle;
      }
      
      public function set backStyle(param1:String) : void
      {
         if(param1 == null || param1.length == 0)
         {
            return;
         }
         _backStyle = param1;
         _bg = ComponentFactory.Instance.creatBitmap(_backStyle);
         addChild(_bg);
      }
      
      public function get textFieldX() : Number
      {
         return _textFieldX;
      }
      
      public function set textFieldX(param1:Number) : void
      {
         _textFieldX = param1;
      }
      
      public function get textFieldY() : Number
      {
         return _textFieldY;
      }
      
      public function set textFieldY(param1:Number) : void
      {
         _textFieldY = param1;
      }
   }
}
