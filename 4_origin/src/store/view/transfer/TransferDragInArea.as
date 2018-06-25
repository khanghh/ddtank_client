package store.view.transfer
{
   import bagAndInfo.cell.DragEffect;
   import baglocked.BaglockedManager;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.interfaces.IAcceptDrag;
   import ddt.manager.DragManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import flash.display.Sprite;
   
   public class TransferDragInArea extends Sprite implements IAcceptDrag
   {
      
      public static const RECTWIDTH:int = 345;
      
      public static const RECTHEIGHT:int = 360;
       
      
      private var _cells:Vector.<TransferItemCell>;
      
      public function TransferDragInArea(cells:Vector.<TransferItemCell>)
      {
         super();
         _cells = cells;
         graphics.beginFill(255,0);
         graphics.drawRect(0,0,345,360);
         graphics.endFill();
      }
      
      public function dragDrop(effect:DragEffect) : void
      {
         var hasCell:Boolean = false;
         var i:int = 0;
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var info:InventoryItemInfo = effect.data as InventoryItemInfo;
         if(info && effect.action != "split")
         {
            effect.action = "none";
            hasCell = false;
            for(i = 0; i < _cells.length; )
            {
               if(_cells[i].info == null)
               {
                  _cells[i].dragDrop(effect);
                  if(effect.target)
                  {
                     break;
                  }
               }
               else if(_cells[i].info == info)
               {
                  hasCell = true;
               }
               i++;
            }
            if(effect.target == null)
            {
               if(!hasCell)
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("store.view.transfer.info"));
               }
               DragManager.acceptDrag(this);
            }
         }
      }
      
      public function dispose() : void
      {
         _cells = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
