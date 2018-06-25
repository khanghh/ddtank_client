package wasteRecycle.view
{
   import bagAndInfo.cell.BagCell;
   import bagAndInfo.cell.DragEffect;
   import baglocked.BaglockedManager;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.DragManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.display.DisplayObject;
   
   public class WasteRecycleCell extends BagCell
   {
       
      
      public function WasteRecycleCell(index:int, bg:DisplayObject = null)
      {
         super(index,null,true,bg,true);
      }
      
      override public function dragDrop(effect:DragEffect) : void
      {
         var info:* = null;
         if(effect.action == "move" && effect.source is WasteRecycleGoodsCell)
         {
            info = effect.data as InventoryItemInfo;
            if(info)
            {
               SocketManager.Instance.out.sendClearStoreBag();
               DragManager.acceptDrag(this,"none");
            }
         }
         else
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.wasteRecycle.notMove"));
         }
      }
      
      override public function dragStop(effect:DragEffect) : void
      {
         SoundManager.instance.playButtonSound();
         if(effect.target != null)
         {
            if(effect.action == "none")
            {
               locked = false;
            }
         }
         else
         {
            locked = false;
         }
      }
      
      override public function dragStart() : void
      {
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         super.dragStart();
      }
   }
}
