package littleGame.view
{
   import com.pickgliss.ui.core.Disposeable;
   import ddt.ddt_internal;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import littleGame.LittleGameManager;
   
   use namespace ddt_internal;
   
   public class PriceShape extends Bitmap implements Disposeable
   {
       
      
      public function PriceShape(param1:int)
      {
         super(null,"auto",true);
         drawPrice(param1);
      }
      
      private function drawPrice(param1:int) : void
      {
         var _loc11_:int = 0;
         var _loc5_:BitmapData = LittleGameManager.Instance.Current.priceBack;
         var _loc6_:int = _loc5_.width;
         var _loc8_:BitmapData = LittleGameManager.Instance.Current.priceNum;
         var _loc3_:String = param1.toString();
         var _loc2_:int = _loc8_.width / 10;
         var _loc10_:int = _loc8_.height;
         var _loc4_:BitmapData = new BitmapData(_loc6_ + _loc3_.length * _loc2_,_loc5_.height,true,0);
         _loc4_.copyPixels(_loc5_,_loc5_.rect,new Point(0,0));
         var _loc9_:Rectangle = new Rectangle(0,0,_loc2_,_loc10_);
         var _loc7_:int = _loc3_.length;
         _loc11_ = 0;
         while(_loc11_ < _loc7_)
         {
            _loc9_.x = int(_loc3_.substr(_loc11_,1)) * _loc2_;
            _loc4_.copyPixels(_loc8_,_loc9_,new Point(_loc6_ + _loc2_ * _loc11_,0));
            _loc11_++;
         }
         if(bitmapData)
         {
            bitmapData.dispose();
         }
         bitmapData = _loc4_;
      }
      
      public function dispose() : void
      {
         if(bitmapData)
         {
            bitmapData.dispose();
         }
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
