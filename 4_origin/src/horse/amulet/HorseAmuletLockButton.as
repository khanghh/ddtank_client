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
      
      override protected function __onMouseClick(param1:MouseEvent) : void
      {
         if(_enable)
         {
            SoundManager.instance.playButtonSound();
            this.dragStart(stage.mouseX,stage.mouseY);
         }
      }
      
      public function dragStart(param1:Number, param2:Number) : void
      {
         var _loc3_:Bitmap = ComponentFactory.Instance.creatBitmap("asset.beadSystem.beadInset.lockIcon");
         DragManager.startDrag(this,this,_loc3_,param1,param2,"move",false);
      }
      
      public function getSource() : IDragable
      {
         return this;
      }
      
      public function dragStop(param1:DragEffect) : void
      {
         SoundManager.instance.playButtonSound();
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         if(param1.target is HorseAmuletCell)
         {
            if((param1.target as HorseAmuletCell).Lock())
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
