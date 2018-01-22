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
      
      public function StrengthStone(param1:Array, param2:int)
      {
         super(param1,param2);
      }
      
      public function set itemType(param1:int) : void
      {
         _itemType = param1;
      }
      
      public function get itemType() : int
      {
         return _itemType;
      }
      
      public function get stoneType() : String
      {
         return _stoneType;
      }
      
      public function set stoneType(param1:String) : void
      {
         _stoneType = param1;
      }
      
      override public function dragDrop(param1:DragEffect) : void
      {
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var _loc2_:InventoryItemInfo = param1.data as InventoryItemInfo;
         if(_loc2_.BagType == 12 && info != null)
         {
            return;
         }
         if(_types.indexOf(_loc2_.Property1) == -1)
         {
            return;
         }
         if(_loc2_ && param1.action != "split")
         {
            param1.action = "none";
            if(_stoneType == "" || _stoneType == _loc2_.Property1)
            {
               _stoneType = _loc2_.Property1;
               SocketManager.Instance.out.sendMoveGoods(_loc2_.BagType,_loc2_.Place,12,index,_loc2_.Count,true);
               DragManager.acceptDrag(this,"none");
               reset();
            }
            else
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("store.view.strength.typeUnpare"));
            }
         }
      }
      
      private function showNumAlert(param1:InventoryItemInfo, param2:int) : void
      {
         if(_stoneType == "35" || _stoneType == "2")
         {
            _aler = ComponentFactory.Instance.creat("ddtstore.StrengthSelectNumAlertFrame");
            _aler.addExeFunction(sellFunction,notSellFunction);
            _aler.goodsinfo = param1;
            _aler.index = param2;
            _aler.show(param1.Count);
         }
         else if(_stoneType == "45")
         {
            _aler = ComponentFactory.Instance.creat("store.view.exalt.exaltSelectNumAlertFrame");
            _aler.addExeFunction(sellFunction,notSellFunction);
            _aler.goodsinfo = param1;
            _aler.index = param2;
            _aler.show(param1.Count);
         }
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
