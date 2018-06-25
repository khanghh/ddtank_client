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
      
      public function MagicBoxExtractionDragInArea($cell:MagicBoxExtractionCell)
      {
         super();
         _cell = $cell;
         init();
      }
      
      private function init() : void
      {
         graphics.beginFill(255,0);
         graphics.drawRect(0,0,460,360);
         graphics.endFill();
      }
      
      public function dragDrop(effect:DragEffect) : void
      {
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var info:InventoryItemInfo = effect.data as InventoryItemInfo;
         if(info.BagType == 12)
         {
            effect.action = "none";
            DragManager.acceptDrag(this);
            return;
         }
         if(info && effect.action != "split")
         {
            effect.action = "none";
         }
         _cell.dragDrop(effect);
      }
   }
}
