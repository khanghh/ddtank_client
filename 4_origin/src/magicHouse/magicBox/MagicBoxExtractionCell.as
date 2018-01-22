package magicHouse.magicBox
{
   import bagAndInfo.cell.DragEffect;
   import baglocked.BaglockedManager;
   import com.pickgliss.ui.ComponentFactory;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.DragManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import flash.display.Sprite;
   import store.StoreCell;
   
   public class MagicBoxExtractionCell extends StoreCell
   {
       
      
      private var _aler:MagicBoxExtractionSelectedNumAlertFrame;
      
      public function MagicBoxExtractionCell(param1:Sprite, param2:int)
      {
         super(param1,param2);
      }
      
      override public function set info(param1:ItemTemplateInfo) : void
      {
         .super.info = param1;
         if(_enchantMc)
         {
            var _loc2_:int = 66;
            _enchantMc.height = _loc2_;
            _enchantMc.width = _loc2_;
            _loc2_ = -1;
            _enchantMc.y = _loc2_;
            _enchantMc.x = _loc2_;
         }
         if(_bgOverDate && _bgOverDate.visible)
         {
            _bgOverDate.x = 30;
            _bgOverDate.y = 35;
         }
      }
      
      override public function dragDrop(param1:DragEffect) : void
      {
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var _loc2_:InventoryItemInfo = param1.data as InventoryItemInfo;
         if(_loc2_ && param1.action != "split")
         {
            param1.action = "none";
            if(_loc2_.Count == 1)
            {
               SocketManager.Instance.out.sendMoveGoods(_loc2_.BagType,_loc2_.Place,12,1,1);
            }
            else
            {
               showNumAlert(_loc2_,1);
            }
            param1.action = "none";
            DragManager.acceptDrag(this);
         }
      }
      
      private function showNumAlert(param1:InventoryItemInfo, param2:int) : void
      {
         _aler = ComponentFactory.Instance.creatComponentByStylename("magicbox.selectNumAlertFrame");
         _aler.addExeFunction(sellFunction,notSellFunction);
         _aler.goodsinfo = param1;
         _aler.index = param2;
         _aler.show(param1.Count);
      }
      
      private function sellFunction(param1:int, param2:InventoryItemInfo, param3:int) : void
      {
         SocketManager.Instance.out.sendMoveGoods(param2.BagType,param2.Place,12,param3,param1,true);
         if(_aler)
         {
            _aler.dispose();
         }
         if(_aler && _aler.parent)
         {
            removeChild(_aler);
         }
         _aler = null;
      }
      
      private function notSellFunction() : void
      {
         if(_aler)
         {
            _aler.dispose();
         }
         if(_aler && _aler.parent)
         {
            removeChild(_aler);
         }
         _aler = null;
      }
      
      override protected function createChildren() : void
      {
         super.createChildren();
         _tbxCount.x = 18;
         _tbxCount.y = 49;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
