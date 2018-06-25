package store.view.strength
{
   import bagAndInfo.cell.DragEffect;
   import baglocked.BaglockedManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.DragManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import store.StoneCell;
   
   public class StrengthStone extends StoneCell
   {
       
      
      private var _stoneType:String = "";
      
      private var _itemType:int = -1;
      
      private var _aler:StrengthSelectNumAlertFrame;
      
      public function StrengthStone(stoneType:Array, i:int)
      {
         super(stoneType,i);
      }
      
      public function set itemType(value:int) : void
      {
         _itemType = value;
      }
      
      public function get itemType() : int
      {
         return _itemType;
      }
      
      public function get stoneType() : String
      {
         return _stoneType;
      }
      
      public function set stoneType(value:String) : void
      {
         _stoneType = value;
      }
      
      override public function dragDrop(effect:DragEffect) : void
      {
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var sourceInfo:InventoryItemInfo = effect.data as InventoryItemInfo;
         if(sourceInfo.BagType == 12 && info != null)
         {
            return;
         }
         if(_types.indexOf(sourceInfo.Property1) == -1)
         {
            return;
         }
         if(sourceInfo && effect.action != "split")
         {
            effect.action = "none";
            if(_stoneType == "" || _stoneType == sourceInfo.Property1)
            {
               _stoneType = sourceInfo.Property1;
               SocketManager.Instance.out.sendMoveGoods(sourceInfo.BagType,sourceInfo.Place,12,index,sourceInfo.Count,true);
               DragManager.acceptDrag(this,"none");
               reset();
            }
            else
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("store.view.strength.typeUnpare"));
            }
         }
      }
      
      private function showNumAlert(info:InventoryItemInfo, index:int) : void
      {
         if(_stoneType == "35" || _stoneType == "2")
         {
            _aler = ComponentFactory.Instance.creat("ddtstore.StrengthSelectNumAlertFrame");
            _aler.addExeFunction(sellFunction,notSellFunction);
            _aler.goodsinfo = info;
            _aler.index = index;
            _aler.show(info.Count);
         }
         else if(_stoneType == "45")
         {
            _aler = ComponentFactory.Instance.creat("store.view.exalt.exaltSelectNumAlertFrame");
            _aler.addExeFunction(sellFunction,notSellFunction);
            _aler.goodsinfo = info;
            _aler.index = index;
            _aler.show(info.Count);
         }
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
      
      private function reset() : void
      {
         _stoneType = "";
         _itemType = -1;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         if(_aler)
         {
            ObjectUtils.disposeObject(_aler);
         }
         _aler = null;
      }
   }
}
