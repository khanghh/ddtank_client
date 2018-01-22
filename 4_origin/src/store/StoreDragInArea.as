package store
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
   
   public class StoreDragInArea extends Sprite implements IAcceptDrag
   {
      
      public static const RECTWIDTH:int = 340;
      
      public static const RECTHEIGHT:int = 360;
       
      
      protected var _cells:Array;
      
      public function StoreDragInArea(param1:Array)
      {
         super();
         _cells = param1;
         init();
      }
      
      private function init() : void
      {
         graphics.beginFill(255,0);
         graphics.drawRect(0,0,340,360);
         graphics.endFill();
      }
      
      public function dragDrop(param1:DragEffect) : void
      {
         var _loc2_:Boolean = false;
         var _loc3_:int = 0;
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var _loc4_:InventoryItemInfo = param1.data as InventoryItemInfo;
         if(_loc4_.BagType == 12)
         {
            param1.action = "none";
            DragManager.acceptDrag(this);
            return;
         }
         if(_loc4_ && param1.action != "split")
         {
            param1.action = "none";
            if(_loc4_.getRemainDate() <= 0)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("store.view.fusion.AccessoryDragInArea.overdue"));
               DragManager.acceptDrag(this);
            }
            else
            {
               _loc2_ = false;
               _loc3_ = 0;
               while(_loc3_ < _cells.length)
               {
                  if(_cells[_loc3_].info == null)
                  {
                     _cells[_loc3_].dragDrop(param1);
                     if(param1.target)
                     {
                        break;
                     }
                  }
                  else if(_cells[_loc3_].info == _loc4_)
                  {
                     _loc2_ = true;
                  }
                  _loc3_++;
               }
               if(param1.target == null)
               {
                  if(!_loc2_)
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
