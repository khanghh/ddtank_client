package store.view.Compose
{
   import bagAndInfo.cell.DragEffect;
   import baglocked.BaglockedManager;
   import com.pickgliss.ui.ComponentFactory;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.DragManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.geom.Point;
   import store.StoreCell;
   
   public class ComposeItemCell extends StoreCell
   {
      
      public static const COMPOSE_TOP:int = 50;
       
      
      public function ComposeItemCell(param1:int){super(null,null);}
      
      override protected function addEnchantMc() : void{}
      
      override public function dragDrop(param1:DragEffect) : void{}
      
      override public function dispose() : void{}
   }
}
