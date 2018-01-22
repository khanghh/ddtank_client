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
      
      public function TransferDragInArea(param1:Vector.<TransferItemCell>)
      {
         super();
         _cells = param1;
         graphics.beginFill(255,0);
         graphics.drawRect(0,0,345,360);
         graphics.endFill();
      }
      
      public function dragDrop(param1:DragEffect) : void
      {
         var _loc2_:Boolean = false;
         var _loc3_:int = 0;
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var _loc4_:InventoryItemInfo = param1.data as InventoryItemInfo;
         if(_loc4_ && param1.action != "split")
         {
            param1.action = "none";
            _loc2_ = false;
            _loc3_ = 0;
            while(_loc3_ < _cells.length)
            {
               if(_cells[_loc3_].info == null)
               {
                  _cells[_loc3_].dragDrop(param1);
                  if(param1.target)
                  {
                     break;
                  }
               }
               else if(_cells[_loc3_].info == _loc4_)
               {
                  _loc2_ = true;
               }
               _loc3_++;
            }
            if(param1.target == null)
            {
               if(!_loc2_)
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
