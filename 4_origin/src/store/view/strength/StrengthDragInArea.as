package store.view.strength
{
   import bagAndInfo.cell.DragEffect;
   import baglocked.BaglockedManager;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.DragManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import store.StoreDragInArea;
   
   public class StrengthDragInArea extends StoreDragInArea
   {
       
      
      private var _hasStone:Boolean = false;
      
      private var _hasItem:Boolean = false;
      
      private var _stonePlace:int = -1;
      
      private var _effect:DragEffect;
      
      public function StrengthDragInArea(cells:Array)
      {
         super(cells);
      }
      
      override public function dragDrop(effect:DragEffect) : void
      {
         var i:int = 0;
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var info:InventoryItemInfo = effect.data as InventoryItemInfo;
         _effect = effect;
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
               i = 0;
               while(i < 5)
               {
                  if(i == 0 || i == 3 || i == 4)
                  {
                     if(_cells[i].itemInfo != null)
                     {
                        _hasStone = true;
                        _stonePlace = i;
                        break;
                     }
                  }
                  i++;
               }
               if(_cells[2].itemInfo != null)
               {
                  _hasItem = true;
               }
               if(info.CanEquip)
               {
                  if(!_hasStone)
                  {
                     _cells[2].dragDrop(effect);
                  }
                  else if(info.RefineryLevel > 0 && _cells[_stonePlace].itemInfo.Property1 == "35" || info.RefineryLevel == 0 && _cells[_stonePlace].itemInfo.Property1 == "2")
                  {
                     _cells[2].dragDrop(effect);
                     reset();
                  }
                  else
                  {
                     MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("store.view.strength.unpare"));
                  }
               }
               else if(_cells[2].itemInfo.RefineryLevel > 0 && info.Property1 == "35" || _cells[2].itemInfo.RefineryLevel == 0 && info.Property1 == "2")
               {
                  if(!_hasStone)
                  {
                     findCellAndDrop();
                     reset();
                  }
                  else if(_cells[_stonePlace].itemInfo.Property1 == info.Property1)
                  {
                     findCellAndDrop();
                     reset();
                  }
                  else
                  {
                     MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("store.view.strength.typeUnpare"));
                  }
               }
               else
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("store.view.strength.unpare"));
               }
            }
         }
      }
      
      private function findCellAndDrop() : void
      {
         var i:int = 0;
         for(i = 0; i < 5; )
         {
            if(i == 0 || i == 3 || i == 4)
            {
               if(_cells[i].itemInfo == null)
               {
                  _cells[i].dragDrop(_effect);
                  reset();
                  return;
               }
            }
            i++;
         }
         _cells[0].dragDrop(_effect);
         reset();
      }
      
      private function reset() : void
      {
         _hasStone = false;
         _hasItem = false;
         _stonePlace = -1;
         _effect = null;
      }
      
      override public function dispose() : void
      {
         reset();
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
