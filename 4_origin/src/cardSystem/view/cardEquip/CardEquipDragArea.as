package cardSystem.view.cardEquip
{
   import bagAndInfo.cell.DragEffect;
   import cardSystem.data.CardInfo;
   import ddt.interfaces.IAcceptDrag;
   import ddt.manager.DragManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import flash.display.Sprite;
   import road7th.data.DictionaryData;
   
   public class CardEquipDragArea extends Sprite implements IAcceptDrag
   {
       
      
      private var _view:CardEquipView;
      
      public function CardEquipDragArea(param1:CardEquipView)
      {
         super();
         _view = param1;
         init();
      }
      
      private function init() : void
      {
         graphics.beginFill(65280,0);
         graphics.drawRect(-9,6,397,257);
         graphics.endFill();
      }
      
      public function dragDrop(param1:DragEffect) : void
      {
         var _loc3_:* = null;
         var _loc4_:int = 0;
         if(PlayerManager.Instance.Self.bagLocked)
         {
            return;
         }
         var _loc2_:CardInfo = param1.data as CardInfo;
         if(_loc2_)
         {
            if(_loc2_.templateInfo.Property8 == "1")
            {
               SocketManager.Instance.out.sendMoveCards(_loc2_.Place,0);
               param1.action = "none";
            }
            else
            {
               _loc3_ = PlayerManager.Instance.Self.cardEquipDic;
               _loc4_ = 1;
               while(_loc4_ < 5)
               {
                  if((_loc3_[_loc4_] == null || _loc3_[_loc4_].Count < 0) && _view._equipCells[_loc4_].open)
                  {
                     SocketManager.Instance.out.sendMoveCards(_loc2_.Place,_loc4_);
                     param1.action = "none";
                     break;
                  }
                  if(_loc4_ == 4)
                  {
                     SocketManager.Instance.out.sendMoveCards(_loc2_.Place,1);
                     param1.action = "none";
                  }
                  _loc4_++;
               }
               DragManager.acceptDrag(this);
            }
         }
      }
      
      public function dispose() : void
      {
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
