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
       
      
      public function MgStoneFeedBtn(){super();}
      
      override public function dragStop(param1:DragEffect) : void{}
      
      override public function dragStart(param1:Number, param2:Number) : void{}
   }
}
