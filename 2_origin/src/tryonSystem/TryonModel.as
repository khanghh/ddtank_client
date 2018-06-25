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
      
      public function TryonModel($items:Array)
      {
         super();
         _items = $items;
         var _self:PlayerInfo = PlayerManager.Instance.Self;
         _playerInfo = new PlayerInfo();
         _playerInfo.updateStyle(_self.Sex,_self.Hide,_self.getPrivateStyle(),_self.Colors,_self.getSkinColor());
         _bagItems = new DictionaryData();
         var _loc5_:int = 0;
         var _loc4_:* = _self.Bag.items;
         for each(var item in _self.Bag.items)
         {
            if(item.Place <= 30)
            {
               _bagItems.add(item.Place,item);
            }
         }
      }
      
      public function set selectedItem(item:InventoryItemInfo) : void
      {
         if(item == _selectedItem)
         {
            return;
         }
         _selectedItem = item;
         if(EquipType.isAvatar(item.CategoryID))
         {
            _playerInfo.setPartStyle(item.CategoryID,item.NeedSex,item.TemplateID);
            if(item.CategoryID == 6)
            {
               _playerInfo.setSkinColor(item.Skin);
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
