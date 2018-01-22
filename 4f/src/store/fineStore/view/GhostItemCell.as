package store.fineStore.view
{
   import bagAndInfo.cell.BagCell;
   import bagAndInfo.cell.DragEffect;
   import baglocked.BaglockedManager;
   import com.pickgliss.events.InteractiveEvent;
   import com.pickgliss.ui.ComponentFactory;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.DragManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.geom.Point;
   import store.StoreCell;
   import store.equipGhost.EquipGhostManager;
   import store.equipGhost.data.EquipGhostData;
   import store.equipGhost.data.GhostData;
   
   public class GhostItemCell extends StoreCell
   {
       
      
      public function GhostItemCell(param1:int){super(null,null);}
      
      override protected function addEnchantMc() : void{}
      
      override public function dragDrop(param1:DragEffect) : void{}
      
      override protected function __doubleClickHandler(param1:InteractiveEvent) : void{}
      
      override public function set info(param1:ItemTemplateInfo) : void{}
      
      override public function dispose() : void{}
   }
}
