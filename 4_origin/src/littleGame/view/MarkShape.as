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
   
   public class MarkShape extends Bitmap implements Disposeable
   {
       
      
      public function MarkShape(param1:int)
      {
         super(null,"auto",true);
         setTime(param1);
      }
      
      public function setTime(param1:int) : void
      {
         var _loc10_:int = 0;
         if(param1 < 0)
         {
            return;
         }
         var _loc3_:BitmapData = LittleGameManager.Instance.Current.markBack.clone();
         var _loc4_:String = param1.toString();
         var _loc7_:BitmapData = LittleGameManager.Instance.Current.bigNum;
         var _loc2_:int = _loc7_.width / 11;
         var _loc9_:int = _loc7_.height;
         var _loc5_:int = param1 < 10?145:118;
         var _loc8_:Rectangle = new Rectangle(_loc7_.width - _loc2_,0,_loc2_,_loc9_);
         var _loc6_:int = _loc4_.length;
         _loc10_ = 0;
         while(_loc10_ < _loc6_)
         {
            _loc8_.x = int(_loc4_.substr(_loc10_,1)) * _loc2_;
            _loc3_.copyPixels(_loc7_,_loc8_,new Point(_loc5_ + _loc2_ * _loc10_,0));
            _loc10_++;
         }
         if(bitmapData)
         {
            bitmapData.dispose();
         }
         bitmapData = _loc3_;
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
