package magicStone.components
{
   import bagAndInfo.cell.DragEffect;
   import beadSystem.controls.BeadFeedButton;
   import com.pickgliss.ui.ComponentFactory;
   import ddt.manager.DragManager;
   import flash.display.Bitmap;
   import flash.events.Event;
   import magicStone.MagicStoneControl;
   
   public class MgStoneFeedBtn extends BeadFeedButton
   {
       
      
      public function MgStoneFeedBtn()
      {
         super();
      }
      
      override public function dragStop(param1:DragEffect) : void
      {
         if(param1.target is MgStoneCell && (param1.target as MgStoneCell).info && (param1.target as MgStoneCell).place > 31)
         {
            MagicStoneControl.instance.singleFeedCell = param1.target as MgStoneCell;
            MagicStoneControl.instance.singleFeedFunc(null);
         }
         else
         {
            dispatchEvent(new Event("stopfeed"));
         }
      }
      
      override public function dragStart(param1:Number, param2:Number) : void
      {
         var _loc3_:Bitmap = ComponentFactory.Instance.creatBitmap("beadSystem.feedIcon");
         DragManager.startDrag(this,this,_loc3_,param1,param2,"move",false);
      }
   }
}
