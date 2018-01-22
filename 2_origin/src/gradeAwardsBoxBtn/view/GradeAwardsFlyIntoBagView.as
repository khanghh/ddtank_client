package gradeAwardsBoxBtn.view
{
   import bagAndInfo.cell.BagCell;
   import com.greensock.TweenMax;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.view.MainToolBar;
   import flash.geom.Point;
   import flash.utils.setTimeout;
   
   public class GradeAwardsFlyIntoBagView
   {
      
      private static var totalCellFlying:int;
      
      private static var tooMuch:Boolean = false;
       
      
      public function GradeAwardsFlyIntoBagView()
      {
         super();
      }
      
      public function onFrameClose(param1:Array) : void
      {
         var _loc4_:* = null;
         var _loc6_:int = 0;
         var _loc5_:* = null;
         var _loc3_:* = null;
         if(param1 == null)
         {
            return;
         }
         var _loc2_:BaseButton = MainToolBar.Instance.goBagBtn;
         if(_loc2_ && _loc2_.parent)
         {
            _loc4_ = MainToolBar.Instance.localToGlobal(new Point(_loc2_.x,_loc2_.y));
         }
         else
         {
            _loc4_ = new Point(MainToolBar.Instance.x,MainToolBar.Instance.y);
         }
         _loc6_ = 0;
         while(_loc6_ < param1.length)
         {
            if(!tooMuch)
            {
               if(totalCellFlying > 11)
               {
                  tooMuch = true;
                  setTimeout(notTooMuchNow,2000);
               }
               totalCellFlying = Number(totalCellFlying) + 1;
               _loc5_ = param1[_loc6_] as InventoryItemInfo;
               _loc3_ = new BagCell(0,_loc5_);
               _loc3_.x = StageReferance.stageWidth * 0.5;
               _loc3_.y = StageReferance.stageHeight * 0.5;
               TweenMax.to(_loc3_,0.8,{
                  "onStart":onFlyStart,
                  "onStartParams":[_loc3_],
                  "delay":_loc6_ * 0.1,
                  "x":_loc4_.x,
                  "y":_loc4_.y,
                  "onComplete":onGoodsIconFlied,
                  "onCompleteParams":[_loc3_]
               });
               _loc6_++;
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
