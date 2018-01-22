package gypsyShop.model
{
   import ddt.data.goods.InventoryItemInfo;
   import ddt.events.PkgEvent;
   import ddt.manager.GameInSocketOut;
   import ddt.manager.SocketManager;
   import flash.events.EventDispatcher;
   import flash.utils.ByteArray;
   import gypsyShop.I.IGypsyShopViewModel;
   import gypsyShop.ctrl.GypsyShopManager;
   
   public class GypsyShopModel extends EventDispatcher implements IGypsyShopViewModel
   {
      
      private static var instance:GypsyShopModel;
       
      
      public var isBind:Boolean = true;
      
      private var _curRefreshedTimes:int;
      
      private var _itemCount:int;
      
      private var _itemDataList:Vector.<GypsyItemData>;
      
      private var _buyResult:Object;
      
      private var _listRareItemTempleteIDs:Vector.<int>;
      
      public function GypsyShopModel(param1:inner)
      {
         super();
      }
      
      public static function getInstance() : GypsyShopModel
      {
         if(!instance)
         {
            instance = new GypsyShopModel(new inner());
         }
         return instance;
      }
      
      public function requestManualRefreshList() : void
      {
         GameInSocketOut.sendGypsyManualRefreshItemList();
      }
      
      public function requestManualRefreshListWithRMB() : void
      {
         GameInSocketOut.sendGypsyManualRefreshItemListWithRMB(isBind);
      }
      
      public function requestBuyItem(param1:int) : void
      {
         GameInSocketOut.sendGypsyBuy(param1,GypsyPurchaseModel.getInstance().getUseBind());
      }
      
      public function requestRareList() : void
      {
         GameInSocketOut.sendGypsyRefreshRareList();
      }
      
      public function requestRefreshList() : void
      {
         GameInSocketOut.sendGypsyRefreshItemList();
      }
      
      public function init() : void
      {
         var _loc1_:int = 278;
         var _loc2_:String = PkgEvent.format(_loc1_,2);
         var _loc4_:String = PkgEvent.format(_loc1_,3);
         var _loc3_:String = PkgEvent.format(_loc1_,4);
         SocketManager.Instance.addEventListener(_loc2_,onItemListUpdated);
         SocketManager.Instance.addEventListener(_loc4_,onBuyResult);
         SocketManager.Instance.addEventListener(_loc3_,onRareItemListUpdated);
      }
      
      protected function onRareItemListUpdated(param1:PkgEvent) : void
      {
         var _loc4_:int = 0;
         var _loc2_:ByteArray = param1.pkg;
         var _loc3_:int = _loc2_.readInt();
         _listRareItemTempleteIDs = new Vector.<int>();
         while(_loc2_.bytesAvailable)
         {
            _loc4_ = _loc2_.readInt();
            _listRareItemTempleteIDs.push(_loc4_);
         }
         GypsyShopManager.getInstance().newRareItemsUpdate();
      }
      
      protected function onBuyResult(param1:PkgEvent) : void
      {
         var _loc5_:int = 0;
         var _loc3_:ByteArray = param1.pkg;
         var _loc4_:int = _loc3_.readInt();
         var _loc2_:Boolean = _loc3_.readBoolean();
         _buyResult = null;
         if(_loc2_)
         {
            _loc5_ = _loc3_.readInt();
            _buyResult = {
               "id":_loc4_,
               "canBuy":_loc5_
            };
            GypsyShopManager.getInstance().updateBuyResult();
         }
      }
      
      protected function onItemListUpdated(param1:PkgEvent) : void
      {
         var _loc11_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc5_:int = 0;
         var _loc4_:int = 0;
         var _loc10_:int = 0;
         var _loc9_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc6_:ByteArray = param1.pkg;
         _curRefreshedTimes = _loc6_.readInt();
         _itemCount = _loc6_.readInt();
         _itemDataList = new Vector.<GypsyItemData>();
         _loc11_ = 0;
         while(_loc11_ < _itemCount)
         {
            _loc2_ = _loc6_.readInt();
            _loc3_ = _loc6_.readInt();
            _loc5_ = _loc6_.readInt();
            _loc4_ = _loc6_.readInt();
            _loc10_ = _loc6_.readInt();
            _loc9_ = _loc6_.readInt();
            _loc7_ = _loc6_.readInt();
            _loc8_ = _loc6_.readInt();
            _itemDataList.push(new GypsyItemData(_loc2_,_loc3_,_loc5_,_loc10_,_loc9_,_loc4_,_loc7_,_loc8_));
            _loc11_++;
         }
         GypsyShopManager.getInstance().newItemListUpdate();
      }
      
      public function dispose() : void
      {
         var _loc1_:int = 278;
         var _loc2_:String = PkgEvent.format(_loc1_,2);
         var _loc4_:String = PkgEvent.format(_loc1_,3);
         var _loc3_:String = PkgEvent.format(_loc1_,4);
         SocketManager.Instance.removeEventListener(_loc2_,onItemListUpdated);
         SocketManager.Instance.removeEventListener(_loc4_,onBuyResult);
         SocketManager.Instance.removeEventListener(_loc3_,onRareItemListUpdated);
      }
      
      public function getNeedMoneyTotal() : int
      {
         return _curRefreshedTimes * _curRefreshedTimes * 30 + 500;
      }
      
      public function getUpdateTime() : String
      {
         return null;
      }
      
      public function getRareItemsList() : Vector.<InventoryItemInfo>
      {
         return null;
      }
      
      public function getHonour() : int
      {
         return 0;
      }
      
      public function get itemCount() : int
      {
         return _itemCount;
      }
      
      public function get curRefreshedTimes() : int
      {
         return _curRefreshedTimes;
      }
      
      public function get itemDataList() : Vector.<GypsyItemData>
      {
         return _itemDataList;
      }
      
      public function get buyResult() : Object
      {
         return _buyResult;
      }
      
      public function get listRareItemTempleteIDs() : Vector.<int>
      {
         return _listRareItemTempleteIDs;
      }
   }
}

class inner
{
    
   
   function inner()
   {
      super();
   }
}
