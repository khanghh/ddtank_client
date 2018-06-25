package equipretrieve.view
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
   import store.StoreCell;
   
   public class RetrieveDragInArea extends Sprite implements IAcceptDrag
   {
      
      public static const RECTWIDTH:int = 376;
      
      public static const RECTHEIGHT:int = 440;
       
      
      protected var _cells:Vector.<StoreCell>;
      
      public function RetrieveDragInArea(cells:Vector.<StoreCell>)
      {
         super();
         _cells = cells;
         init();
      }
      
      private function init() : void
      {
         graphics.beginFill(255,0);
         graphics.drawRect(0,0,376,440);
         graphics.endFill();
      }
      
      public function dragDrop(effect:DragEffect) : void
      {
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
               DragManager.acceptDrag(this);
            }
            else
            {
               hasCell = false;
               for(i = 0; i < _cells.length; )
               {
                  if(_cells[i].info == null)
                  {
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
                     MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("store.view.fusion.AccessoryDragInArea.type"));
                  }
                  DragManager.acceptDrag(this);
               }
            }
         }
      }
      
      public function dispose() : void
      {
         _cells = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
