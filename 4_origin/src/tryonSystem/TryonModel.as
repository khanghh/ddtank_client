package tryonSystem
{
   import ddt.data.EquipType;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.player.PlayerInfo;
   import ddt.manager.PlayerManager;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import road7th.data.DictionaryData;
   
   public class TryonModel extends EventDispatcher
   {
       
      
      private var _playerInfo:PlayerInfo;
      
      private var _selectedItem:InventoryItemInfo;
      
      private var _items:Array;
      
      private var _bagItems:DictionaryData;
      
      public function TryonModel(param1:Array)
      {
         super();
         _items = param1;
         var _loc3_:PlayerInfo = PlayerManager.Instance.Self;
         _playerInfo = new PlayerInfo();
         _playerInfo.updateStyle(_loc3_.Sex,_loc3_.Hide,_loc3_.getPrivateStyle(),_loc3_.Colors,_loc3_.getSkinColor());
         _bagItems = new DictionaryData();
         var _loc5_:int = 0;
         var _loc4_:* = _loc3_.Bag.items;
         for each(var _loc2_ in _loc3_.Bag.items)
         {
            if(_loc2_.Place <= 30)
            {
               _bagItems.add(_loc2_.Place,_loc2_);
            }
         }
      }
      
      public function set selectedItem(param1:InventoryItemInfo) : void
      {
         if(param1 == _selectedItem)
         {
            return;
         }
         _selectedItem = param1;
         if(EquipType.isAvatar(param1.CategoryID))
         {
            _playerInfo.setPartStyle(param1.CategoryID,param1.NeedSex,param1.TemplateID);
            if(param1.CategoryID == 6)
            {
               _playerInfo.setSkinColor(param1.Skin);
            }
            _bagItems.add(EquipType.CategeryIdToPlace(_selectedItem.CategoryID)[0],_selectedItem);
         }
         dispatchEvent(new Event("change"));
      }
      
      public function get bagItems() : DictionaryData
      {
         return _bagItems;
      }
      
      public function get items() : Array
      {
         return _items;
      }
      
      public function get playerInfo() : PlayerInfo
      {
         return _playerInfo;
      }
      
      public function get selectedItem() : InventoryItemInfo
      {
         return _selectedItem;
      }
      
      public function dispose() : void
      {
         _selectedItem = null;
         _items = null;
         _playerInfo = null;
         _bagItems = null;
      }
   }
}
