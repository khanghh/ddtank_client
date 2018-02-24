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
      
      public function TransferDragInArea(param1:Vector.<TransferItemCell>){super();}
      
      public function dragDrop(param1:DragEffect) : void{}
      
      public function dispose() : void{}
   }
}
