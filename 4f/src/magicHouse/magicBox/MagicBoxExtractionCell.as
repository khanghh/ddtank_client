package magicHouse.magicBox
{
   import bagAndInfo.cell.DragEffect;
   import baglocked.BaglockedManager;
   import com.pickgliss.ui.ComponentFactory;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.DragManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import flash.display.Sprite;
   import store.StoreCell;
   
   public class MagicBoxExtractionCell extends StoreCell
   {
       
      
      private var _aler:MagicBoxExtractionSelectedNumAlertFrame;
      
      public function MagicBoxExtractionCell(param1:Sprite, param2:int){super(null,null);}
      
      override public function set info(param1:ItemTemplateInfo) : void{}
      
      override public function dragDrop(param1:DragEffect) : void{}
      
      private function showNumAlert(param1:InventoryItemInfo, param2:int) : void{}
      
      private function sellFunction(param1:int, param2:InventoryItemInfo, param3:int) : void{}
      
      private function notSellFunction() : void{}
      
      override protected function createChildren() : void{}
      
      override public function dispose() : void{}
   }
}
