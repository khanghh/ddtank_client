package horse.amulet
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
   
   public class HorseAmuletLockButton extends SimpleBitmapButton implements IDragable
   {
       
      
      public function HorseAmuletLockButton()
      {
         super();
      }
      
      override protected function __onMouseClick(event:MouseEvent) : void
      {
         if(_enable)
         {
            SoundManager.instance.playButtonSound();
            this.dragStart(stage.mouseX,stage.mouseY);
         }
      }
      
      public function dragStart(stageX:Number, stageY:Number) : void
      {
         var dragAsset:Bitmap = ComponentFactory.Instance.creatBitmap("asset.beadSystem.beadInset.lockIcon");
         DragManager.startDrag(this,this,dragAsset,stageX,stageY,"move",false);
      }
      
      public function getSource() : IDragable
      {
         return this;
      }
      
      public function dragStop(effect:DragEffect) : void
      {
         SoundManager.instance.playButtonSound();
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         if(effect.target is HorseAmuletCell)
         {
            if((effect.target as HorseAmuletCell).Lock())
            {
               setTimeout(continueDrag,75);
            }
         }
      }
      
      private function continueDrag() : void
      {
         if(stage)
         {
            dragStart(stage.mouseX,stage.mouseY);
         }
      }
   }
}
