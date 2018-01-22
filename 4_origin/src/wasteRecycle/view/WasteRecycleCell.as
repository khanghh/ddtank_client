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
       
      
      public function WasteRecycleCell(param1:int, param2:DisplayObject = null)
      {
         super(param1,null,true,param2,true);
      }
      
      override public function dragDrop(param1:DragEffect) : void
      {
         var _loc2_:* = null;
         if(param1.action == "move" && param1.source is WasteRecycleGoodsCell)
         {
            _loc2_ = param1.data as InventoryItemInfo;
            if(_loc2_)
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
      
      override public function dragStop(param1:DragEffect) : void
      {
         SoundManager.instance.playButtonSound();
         if(param1.target != null)
         {
            if(param1.action == "none")
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
