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
   
   public class ScoreShape extends Bitmap implements Disposeable
   {
      
      ddt_internal static const size:int = 22;
       
      
      private var _style:int;
      
      public function ScoreShape(param1:int = 0)
      {
         _style = param1;
         super(null,"auto",true);
      }
      
      public function setScore(param1:int) : void
      {
         var _loc5_:* = null;
         var _loc8_:int = 0;
         var _loc2_:int = 0;
         var _loc9_:int = 0;
         var _loc6_:String = param1.toString();
         if(_style == 1)
         {
            _loc5_ = LittleGameManager.Instance.Current.bigNum;
         }
         else
         {
            _loc5_ = LittleGameManager.Instance.Current.normalNum;
         }
         _loc2_ = _loc5_.width / 11;
         _loc8_ = _loc5_.height;
         var _loc3_:BitmapData = new BitmapData((_loc6_.length + 1) * _loc2_,_loc8_,true,0);
         var _loc7_:Rectangle = new Rectangle(_loc5_.width - _loc2_,0,_loc2_,_loc8_);
         _loc3_.copyPixels(_loc5_,_loc7_,new Point(0,0));
         var _loc4_:int = _loc6_.length;
         _loc9_ = 0;
         while(_loc9_ < _loc4_)
         {
            _loc7_.x = int(_loc6_.substr(_loc9_,1)) * _loc2_;
            _loc3_.copyPixels(_loc5_,_loc7_,new Point(_loc2_ * (_loc9_ + 1),0));
            _loc9_++;
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
