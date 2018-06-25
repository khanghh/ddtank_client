package magicStone.components
{
   import bagAndInfo.cell.DragEffect;
   import baglocked.BaglockedManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import ddt.interfaces.IDragable;
   import ddt.manager.DragManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import flash.utils.setTimeout;
   
   public class MgStoneLockBtn extends SimpleBitmapButton implements IDragable
   {
       
      
      public function MgStoneLockBtn()
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
      
      private function clickthis(e:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         this.dragStart(stage.mouseX,stage.mouseY);
      }
      
      public function getSource() : IDragable
      {
         return this;
      }
      
      public function dragStop(effect:DragEffect) : void
      {
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         if(effect.target is MgStoneCell)
         {
            (effect.target as MgStoneCell).lockMgStone();
            setTimeout(continueDrag,75);
         }
      }
      
      private function continueDrag() : void
      {
         if(stage)
         {
            dragStart(stage.mouseX,stage.mouseY);
         }
      }
      
      public function dragStart(stageX:Number, stageY:Number) : void
      {
         var dragAsset:Bitmap = ComponentFactory.Instance.creatBitmap("asset.beadSystem.beadInset.lockIcon");
         DragManager.startDrag(this,this,dragAsset,stageX,stageY,"move",false);
      }
      
      override public function get width() : Number
      {
         return 81;
      }
      
      override public function get height() : Number
      {
         return 31;
      }
   }
}
