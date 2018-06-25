package horse.amulet
{
   import bagAndInfo.cell.DragEffect;
   import baglocked.BaglockedManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import ddt.interfaces.IDragable;
   import ddt.manager.DragManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   
   public class HorseAmuletSmashButton extends SimpleBitmapButton implements IDragable
   {
       
      
      public function HorseAmuletSmashButton()
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
         var dragAsset:Bitmap = ComponentFactory.Instance.creatBitmap("asset.horseAmulet.smashIcon");
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
         if(effect.target is HorseAmuletEquipCell)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.horseAmulet.smashEquipTips"));
            return;
         }
         if(effect.target is HorseAmuletActivateCell)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.horseAmulet.smashActivateTips"));
            return;
         }
         if(effect.target is HorseAmuletCell)
         {
            if((effect.target as HorseAmuletCell).itemInfo.cellLocked)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.horseAmulet.smashLockTips"));
               return;
            }
            (effect.target as HorseAmuletCell).smash();
         }
      }
   }
}
