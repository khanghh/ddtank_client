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
      
      public function onFrameClose(infos:Array, startPosArr:Array) : void
      {
         var globalPoint:* = null;
         var i:int = 0;
         var info:* = null;
         var bag:* = null;
         if(infos == null || infos.length == 0)
         {
            return;
         }
         var goBagBtn:BaseButton = MainToolBar.Instance.goBagBtn;
         if(goBagBtn && goBagBtn.parent)
         {
            globalPoint = MainToolBar.Instance.localToGlobal(new Point(goBagBtn.x,goBagBtn.y));
         }
         else
         {
            globalPoint = new Point(MainToolBar.Instance.x,MainToolBar.Instance.y);
         }
         for(i = 0; i < infos.length; )
         {
            if(!tooMuch)
            {
               if(totalCellFlying > 11)
               {
                  tooMuch = true;
                  setTimeout(notTooMuchNow,2000);
               }
               totalCellFlying = Number(totalCellFlying) + 1;
               info = infos[i] as InventoryItemInfo;
               bag = new BagCell(0,info);
               bag.x = startPosArr[i].x;
               bag.y = startPosArr[i].y;
               TweenMax.to(bag,0.8,{
                  "onStart":onFlyStart,
                  "onStartParams":[bag],
                  "delay":i * 0.1,
                  "x":globalPoint.x,
                  "y":globalPoint.y,
                  "onComplete":onGoodsIconFlied,
                  "onCompleteParams":[bag]
               });
               i++;
               continue;
            }
            break;
         }
      }
      
      private function notTooMuchNow() : void
      {
         tooMuch = false;
      }
      
      private function onFlyStart(tag:BagCell) : void
      {
         LayerManager.Instance.addToLayer(tag,2);
      }
      
      private function onGoodsIconFlied(tag:BagCell) : void
      {
         totalCellFlying = Number(totalCellFlying) - 1;
         totalCellFlying = Math.max(0,totalCellFlying);
         tag.parent && tag.parent.removeChild(tag);
         tag.dispose();
         tag = null;
      }
   }
}
