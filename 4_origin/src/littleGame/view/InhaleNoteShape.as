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
   
   public class InhaleNoteShape extends Bitmap implements Disposeable
   {
       
      
      public function InhaleNoteShape(param1:int, param2:int)
      {
         super(null,"auto",true);
         setNote(param1,param2);
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
      
      public function setNote(param1:int, param2:int) : void
      {
         var _loc4_:BitmapData = LittleGameManager.Instance.Current.inhaleNeed.clone();
         var _loc6_:BitmapData = LittleGameManager.Instance.Current.bigNum;
         var _loc3_:int = _loc6_.width / 11;
         var _loc5_:Rectangle = new Rectangle(0,0,_loc3_,_loc6_.height);
         _loc5_.x = param2 * _loc3_;
         _loc4_.copyPixels(_loc6_,_loc5_,new Point(240,0));
         if(bitmapData)
         {
            bitmapData.dispose();
         }
         bitmapData = _loc4_;
      }
   }
}
