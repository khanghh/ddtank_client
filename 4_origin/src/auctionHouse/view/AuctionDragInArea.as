package auctionHouse.view
{
   import bagAndInfo.cell.DragEffect;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.interfaces.IAcceptDrag;
   import ddt.manager.DragManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import flash.display.Sprite;
   
   public class AuctionDragInArea extends Sprite implements IAcceptDrag
   {
       
      
      private var _cells:Vector.<AuctionCellView>;
      
      public function AuctionDragInArea(cells:Vector.<AuctionCellView>)
      {
         super();
         _cells = cells;
         graphics.beginFill(0,0);
         graphics.drawRect(-100,-10,1000,370);
         graphics.endFill();
      }
      
      public function dragDrop(effect:DragEffect) : void
      {
         var info:InventoryItemInfo = effect.data as InventoryItemInfo;
         if(info && effect.action != "split")
         {
            effect.action = "none";
            if(info.getRemainDate() <= 0)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.auctionHouse.view.AuctionDragInArea.this"));
               DragManager.acceptDrag(this);
            }
            else if(effect.target == null)
            {
               DragManager.acceptDrag(this);
            }
         }
      }
   }
}
