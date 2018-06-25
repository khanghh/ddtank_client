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
      
      public function AccessoryDragInArea(cells:Array)
      {
         super();
         _cells = cells;
         graphics.beginFill(255,0);
         graphics.drawRect(-40,-40,280,230);
         graphics.endFill();
      }
      
      public function dragDrop(effect:DragEffect) : void
      {
         var hasEmpty:Boolean = false;
         var hasCell:Boolean = false;
         var i:int = 0;
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
            if(info.getRemainDate() <= 0)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("store.view.fusion.AccessoryDragInArea.overdue"));
               DragManager.acceptDrag(this);
            }
            else
            {
               hasEmpty = false;
               hasCell = false;
               for(i = 0; i < _cells.length; )
               {
                  if(_cells[i].info == null)
                  {
                     hasEmpty = true;
                     _cells[i].dragDrop(effect);
                     if(effect.target)
                     {
                        break;
                     }
                  }
                  else if(_cells[i].info == info)
                  {
                     hasCell = true;
                  }
                  i++;
               }
               if(effect.target == null)
               {
                  if(!hasCell)
                  {
                     if(hasEmpty)
                     {
                        MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("store.view.fusion.AccessoryDragInArea.type"));
                     }
                     else
                     {
                        MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("store.view.fusion.AccessoryDragInArea.more"));
                     }
                  }
                  DragManager.acceptDrag(this);
               }
            }
         }
      }
   }
}
