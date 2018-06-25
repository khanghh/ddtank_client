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
      
      public function GypsyShopModel(single:inner)
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
      
      public function requestBuyItem(id:int) : void
      {
         GameInSocketOut.sendGypsyBuy(id,GypsyPurchaseModel.getInstance().getUseBind());
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
         var L1:int = 278;
         var type1:String = PkgEvent.format(L1,2);
         var type2:String = PkgEvent.format(L1,3);
         var type3:String = PkgEvent.format(L1,4);
         SocketManager.Instance.addEventListener(type1,onItemListUpdated);
         SocketManager.Instance.addEventListener(type2,onBuyResult);
         SocketManager.Instance.addEventListener(type3,onRareItemListUpdated);
      }
      
      protected function onRareItemListUpdated(e:PkgEvent) : void
      {
         var templeteID:int = 0;
         var bytes:ByteArray = e.pkg;
         var rareItemNum:int = bytes.readInt();
         _listRareItemTempleteIDs = new Vector.<int>();
         while(bytes.bytesAvailable)
         {
            templeteID = bytes.readInt();
            _listRareItemTempleteIDs.push(templeteID);
         }
         GypsyShopManager.getInstance().newRareItemsUpdate();
      }
      
      protected function onBuyResult(e:PkgEvent) : void
      {
         var _canBuy:int = 0;
         var bytes:ByteArray = e.pkg;
         var _id:int = bytes.readInt();
         var _isSucc:Boolean = bytes.readBoolean();
         _buyResult = null;
         if(_isSucc)
         {
            _canBuy = bytes.readInt();
            _buyResult = {
               "id":_id,
               "canBuy":_canBuy
            };
            GypsyShopManager.getInstance().updateBuyResult();
         }
      }
      
      protected function onItemListUpdated(e:PkgEvent) : void
      {
         var i:int = 0;
         var id:int = 0;
         var unit:int = 0;
         var price:int = 0;
         var num:int = 0;
         var type:int = 0;
         var templeteID:int = 0;
         var canBuy:int = 0;
         var quality:int = 0;
         var bytes:ByteArray = e.pkg;
         _curRefreshedTimes = bytes.readInt();
         _itemCount = bytes.readInt();
         _itemDataList = new Vector.<GypsyItemData>();
         for(i = 0; i < _itemCount; )
         {
            id = bytes.readInt();
            unit = bytes.readInt();
            price = bytes.readInt();
            num = bytes.readInt();
            type = bytes.readInt();
            templeteID = bytes.readInt();
            canBuy = bytes.readInt();
            quality = bytes.readInt();
            _itemDataList.push(new GypsyItemData(id,unit,price,type,templeteID,num,canBuy,quality));
            i++;
         }
         GypsyShopManager.getInstance().newItemListUpdate();
      }
      
      public function dispose() : void
      {
         var L1:int = 278;
         var type1:String = PkgEvent.format(L1,2);
         var type2:String = PkgEvent.format(L1,3);
         var type3:String = PkgEvent.format(L1,4);
         SocketManager.Instance.removeEventListener(type1,onItemListUpdated);
         SocketManager.Instance.removeEventListener(type2,onBuyResult);
         SocketManager.Instance.removeEventListener(type3,onRareItemListUpdated);
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
