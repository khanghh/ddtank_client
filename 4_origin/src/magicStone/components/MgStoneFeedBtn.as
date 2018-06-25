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
      
      override public function dragStop(effect:DragEffect) : void
      {
         if(effect.target is MgStoneCell && (effect.target as MgStoneCell).info && (effect.target as MgStoneCell).place > 31)
         {
            MagicStoneControl.instance.singleFeedCell = effect.target as MgStoneCell;
            MagicStoneControl.instance.singleFeedFunc(null);
         }
         else
         {
            dispatchEvent(new Event("stopfeed"));
         }
      }
      
      override public function dragStart(stageX:Number, stageY:Number) : void
      {
         var dragAsset:Bitmap = ComponentFactory.Instance.creatBitmap("beadSystem.feedIcon");
         DragManager.startDrag(this,this,dragAsset,stageX,stageY,"move",false);
      }
   }
}
