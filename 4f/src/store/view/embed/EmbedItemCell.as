package store.view.embed
{
   import bagAndInfo.cell.DragEffect;
   import baglocked.BaglockedManager;
   import com.pickgliss.ui.ComponentFactory;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.events.StoreEmbedEvent;
   import ddt.manager.DragManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import store.StoreCell;
   
   public class EmbedItemCell extends StoreCell
   {
       
      
      public function EmbedItemCell(param1:int){super(null,null);}
      
      override public function dragDrop(param1:DragEffect) : void{}
      
      override public function dispose() : void{}
   }
}
