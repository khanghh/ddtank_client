package ddt.utils
{
   import com.pickgliss.ui.ComponentFactory;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class ImgNumConverter
   {
      
      private static var _instance:ImgNumConverter;
       
      
      public function ImgNumConverter()
      {
         super();
      }
      
      public static function get instance() : ImgNumConverter
      {
         if(!_instance)
         {
            _instance = new ImgNumConverter();
         }
         return _instance;
      }
      
      public function convertToImg(param1:int, param2:String, param3:int = 9) : Sprite
      {
         var _loc5_:* = null;
         var _loc7_:int = 0;
         var _loc4_:Sprite = new Sprite();
         var _loc8_:Array = [];
         if(param1 <= 0)
         {
            param1 = 0;
         }
         while(param1 >= 10)
         {
            _loc8_.push(param1 % 10);
            param1 = Math.floor(param1 / 10);
         }
         _loc8_.push(param1);
         var _loc6_:int = _loc8_.length;
         _loc7_ = 0;
         while(_loc7_ <= _loc6_ - 1)
         {
            _loc5_ = ComponentFactory.Instance.creat(param2 + _loc8_.pop());
            _loc5_.smoothing = true;
            _loc5_.x = _loc7_ * param3;
            _loc4_.addChild(_loc5_);
            _loc7_++;
         }
         return _loc4_;
      }
   }
}
