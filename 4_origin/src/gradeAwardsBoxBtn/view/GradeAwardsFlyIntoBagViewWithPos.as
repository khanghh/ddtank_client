package gradeAwardsBoxBtn.view
{
   import bagAndInfo.cell.BagCell;
   import com.greensock.TweenMax;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.view.MainToolBar;
   import flash.geom.Point;
   import flash.utils.setTimeout;
   
   public class GradeAwardsFlyIntoBagViewWithPos
   {
      
      private static var totalCellFlying:int;
      
      private static var tooMuch:Boolean = false;
       
      
      public function GradeAwardsFlyIntoBagViewWithPos()
      {
         super();
      }
      
      public function onFrameClose(param1:Array, param2:Array) : void
      {
         var _loc5_:* = null;
         var _loc7_:int = 0;
         var _loc6_:* = null;
         var _loc4_:* = null;
         if(param1 == null || param1.length == 0)
         {
            return;
         }
         var _loc3_:BaseButton = MainToolBar.Instance.goBagBtn;
         if(_loc3_ && _loc3_.parent)
         {
            _loc5_ = MainToolBar.Instance.localToGlobal(new Point(_loc3_.x,_loc3_.y));
         }
         else
         {
            _loc5_ = new Point(MainToolBar.Instance.x,MainToolBar.Instance.y);
         }
         _loc7_ = 0;
         while(_loc7_ < param1.length)
         {
            if(!tooMuch)
            {
               if(totalCellFlying > 11)
               {
                  tooMuch = true;
                  setTimeout(notTooMuchNow,2000);
               }
               totalCellFlying = Number(totalCellFlying) + 1;
               _loc6_ = param1[_loc7_] as InventoryItemInfo;
               _loc4_ = new BagCell(0,_loc6_);
               _loc4_.x = param2[_loc7_].x;
               _loc4_.y = param2[_loc7_].y;
               TweenMax.to(_loc4_,0.8,{
                  "onStart":onFlyStart,
                  "onStartParams":[_loc4_],
                  "delay":_loc7_ * 0.1,
                  "x":_loc5_.x,
                  "y":_loc5_.y,
                  "onComplete":onGoodsIconFlied,
                  "onCompleteParams":[_loc4_]
               });
               _loc7_++;
               continue;
            }
            break;
         }
      }
      
      private function notTooMuchNow() : void
      {
         tooMuch = false;
      }
      
      private function onFlyStart(param1:BagCell) : void
      {
         LayerManager.Instance.addToLayer(param1,2);
      }
      
      private function onGoodsIconFlied(param1:BagCell) : void
      {
         totalCellFlying = Number(totalCellFlying) - 1;
         totalCellFlying = Math.max(0,totalCellFlying);
         param1.parent && param1.parent.removeChild(param1);
         param1.dispose();
         param1 = null;
      }
   }
}
