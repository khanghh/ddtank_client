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
      
      public function StrengthDragInArea(param1:Array)
      {
         super(param1);
      }
      
      override public function dragDrop(param1:DragEffect) : void
      {
         var _loc2_:int = 0;
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var _loc3_:InventoryItemInfo = param1.data as InventoryItemInfo;
         _effect = param1;
         if(_loc3_ && param1.action != "split")
         {
            param1.action = "none";
            if(_loc3_.getRemainDate() <= 0)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("store.view.fusion.AccessoryDragInArea.overdue"));
               DragManager.acceptDrag(this);
            }
            else
            {
               _loc2_ = 0;
               while(_loc2_ < 5)
               {
                  if(_loc2_ == 0 || _loc2_ == 3 || _loc2_ == 4)
                  {
                     if(_cells[_loc2_].itemInfo != null)
                     {
                        _hasStone = true;
                        _stonePlace = _loc2_;
                        break;
                     }
                  }
                  _loc2_++;
               }
               if(_cells[2].itemInfo != null)
               {
                  _hasItem = true;
               }
               if(_loc3_.CanEquip)
               {
                  if(!_hasStone)
                  {
                     _cells[2].dragDrop(param1);
                  }
                  else if(_loc3_.RefineryLevel > 0 && _cells[_stonePlace].itemInfo.Property1 == "35" || _loc3_.RefineryLevel == 0 && _cells[_stonePlace].itemInfo.Property1 == "2")
                  {
                     _cells[2].dragDrop(param1);
                     reset();
                  }
                  else
                  {
                     MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("store.view.strength.unpare"));
                  }
               }
               else if(_cells[2].itemInfo.RefineryLevel > 0 && _loc3_.Property1 == "35" || _cells[2].itemInfo.RefineryLevel == 0 && _loc3_.Property1 == "2")
               {
                  if(!_hasStone)
                  {
                     findCellAndDrop();
                     reset();
                  }
                  else if(_cells[_stonePlace].itemInfo.Property1 == _loc3_.Property1)
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
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < 5)
         {
            if(_loc1_ == 0 || _loc1_ == 3 || _loc1_ == 4)
            {
               if(_cells[_loc1_].itemInfo == null)
               {
                  _cells[_loc1_].dragDrop(_effect);
                  reset();
                  return;
               }
            }
            _loc1_++;
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
