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
      
      public function MagicBoxExtractionCell(bg:Sprite, $index:int)
      {
         super(bg,$index);
      }
      
      override public function set info(value:ItemTemplateInfo) : void
      {
         .super.info = value;
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
      
      override public function dragDrop(effect:DragEffect) : void
      {
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var info:InventoryItemInfo = effect.data as InventoryItemInfo;
         if(info && effect.action != "split")
         {
            effect.action = "none";
            if(info.Count == 1)
            {
               SocketManager.Instance.out.sendMoveGoods(info.BagType,info.Place,12,1,1);
            }
            else
            {
               showNumAlert(info,1);
            }
            effect.action = "none";
            DragManager.acceptDrag(this);
         }
      }
      
      private function showNumAlert(info:InventoryItemInfo, index:int) : void
      {
         _aler = ComponentFactory.Instance.creatComponentByStylename("magicbox.selectNumAlertFrame");
         _aler.addExeFunction(sellFunction,notSellFunction);
         _aler.goodsinfo = info;
         _aler.index = index;
         _aler.show(info.Count);
      }
      
      private function sellFunction(_nowNum:int, goodsinfo:InventoryItemInfo, index:int) : void
      {
         SocketManager.Instance.out.sendMoveGoods(goodsinfo.BagType,goodsinfo.Place,12,index,_nowNum,true);
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
