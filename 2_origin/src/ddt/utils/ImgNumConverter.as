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
      
      public function convertToImg(num:int, cmpStr:String, gap:int = 9) : Sprite
      {
         var img:* = null;
         var i:int = 0;
         var sp:Sprite = new Sprite();
         var numArr:Array = [];
         if(num <= 0)
         {
            num = 0;
         }
         while(num >= 10)
         {
            numArr.push(num % 10);
            num = Math.floor(num / 10);
         }
         numArr.push(num);
         var len:int = numArr.length;
         for(i = 0; i <= len - 1; )
         {
            img = ComponentFactory.Instance.creat(cmpStr + numArr.pop());
            img.smoothing = true;
            img.x = i * gap;
            sp.addChild(img);
            i++;
         }
         return sp;
      }
   }
}
