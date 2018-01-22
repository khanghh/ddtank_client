package magicHouse
{
   import bagAndInfo.cell.DragEffect;
   import baglocked.BaglockedManager;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.interfaces.IAcceptDrag;
   import ddt.manager.DragManager;
   import ddt.manager.PlayerManager;
   import flash.display.Sprite;
   import magicHouse.magicBox.MagicBoxExtractionCell;
   
   public class MagicBoxExtractionDragInArea extends Sprite implements IAcceptDrag
   {
      
      public static const RECTWIDTH:int = 460;
      
      public static const RECTHEIGHT:int = 360;
       
      
      private var _cell:MagicBoxExtractionCell;
      
      public function MagicBoxExtractionDragInArea(param1:MagicBoxExtractionCell)
      {
         super();
         _cell = param1;
         init();
      }
      
      private function init() : void
      {
         graphics.beginFill(255,0);
         graphics.drawRect(0,0,460,360);
         graphics.endFill();
      }
      
      public function dragDrop(param1:DragEffect) : void
      {
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var _loc2_:InventoryItemInfo = param1.data as InventoryItemInfo;
         if(_loc2_.BagType == 12)
         {
            param1.action = "none";
            DragManager.acceptDrag(this);
            return;
         }
         if(_loc2_ && param1.action != "split")
         {
            param1.action = "none";
         }
         _cell.dragDrop(param1);
      }
   }
}
