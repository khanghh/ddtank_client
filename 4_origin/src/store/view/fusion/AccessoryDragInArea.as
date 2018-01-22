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
      
      public function AccessoryDragInArea(param1:Array)
      {
         super();
         _cells = param1;
         graphics.beginFill(255,0);
         graphics.drawRect(-40,-40,280,230);
         graphics.endFill();
      }
      
      public function dragDrop(param1:DragEffect) : void
      {
         var _loc3_:Boolean = false;
         var _loc2_:Boolean = false;
         var _loc4_:int = 0;
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var _loc5_:InventoryItemInfo = param1.data as InventoryItemInfo;
         if(_loc5_.BagType == 12)
         {
            param1.action = "none";
            DragManager.acceptDrag(this);
            return;
         }
         if(_loc5_ && param1.action != "split")
         {
            param1.action = "none";
            if(_loc5_.getRemainDate() <= 0)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("store.view.fusion.AccessoryDragInArea.overdue"));
               DragManager.acceptDrag(this);
            }
            else
            {
               _loc3_ = false;
               _loc2_ = false;
               _loc4_ = 0;
               while(_loc4_ < _cells.length)
               {
                  if(_cells[_loc4_].info == null)
                  {
                     _loc3_ = true;
                     _cells[_loc4_].dragDrop(param1);
                     if(param1.target)
                     {
                        break;
                     }
                  }
                  else if(_cells[_loc4_].info == _loc5_)
                  {
                     _loc2_ = true;
                  }
                  _loc4_++;
               }
               if(param1.target == null)
               {
                  if(!_loc2_)
                  {
                     if(_loc3_)
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
