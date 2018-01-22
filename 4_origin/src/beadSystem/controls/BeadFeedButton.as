package beadSystem.controls
{
   import bagAndInfo.cell.DragEffect;
   import baglocked.BaglockedManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.cell.ICell;
   import ddt.interfaces.IDragable;
   import ddt.manager.DragManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class BeadFeedButton extends SimpleBitmapButton implements IDragable
   {
      
      public static const stopFeed:String = "stopfeed";
       
      
      public var isActive:Boolean = false;
      
      public function BeadFeedButton()
      {
         super();
         addEvt();
      }
      
      private function addEvt() : void
      {
         this.addEventListener("click",clickthis);
      }
      
      private function removeEvt() : void
      {
         this.removeEventListener("click",clickthis);
      }
      
      private function clickthis(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         this.dragStart(stage.mouseX,stage.mouseY);
      }
      
      override protected function init() : void
      {
         buttonMode = true;
         super.init();
      }
      
      public function dragAgain() : void
      {
         if(stage)
         {
            dragStart(stage.mouseX,stage.mouseY);
         }
      }
      
      public function dragStop(param1:DragEffect) : void
      {
         isActive = true;
         if(PlayerManager.Instance.Self.bagLocked && param1.target is ICell)
         {
            BaglockedManager.Instance.show();
            return;
         }
         SoundManager.instance.play("008");
         if(param1.target is BeadCell)
         {
            (param1.target as BeadCell).FeedBead();
         }
         else
         {
            dispatchEvent(new Event("stopfeed"));
         }
      }
      
      public function dragStart(param1:Number, param2:Number) : void
      {
         var _loc3_:Bitmap = ComponentFactory.Instance.creatBitmap("beadSystem.feedIcon");
         DragManager.startDrag(this,this,_loc3_,param1,param2,"move",false);
      }
      
      public function getSource() : IDragable
      {
         return this;
      }
   }
}
