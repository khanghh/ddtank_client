package store.view.fusion
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
   
   public class AccessoryDragInArea extends Sprite implements IAcceptDrag
   {
       
      
      private var _cells:Array;
      
      public function AccessoryDragInArea(param1:Array){super();}
      
      public function dragDrop(param1:DragEffect) : void{}
   }
}
