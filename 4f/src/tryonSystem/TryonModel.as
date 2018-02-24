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
      
      public function TryonModel(param1:Array){super();}
      
      public function set selectedItem(param1:InventoryItemInfo) : void{}
      
      public function get bagItems() : DictionaryData{return null;}
      
      public function get items() : Array{return null;}
      
      public function get playerInfo() : PlayerInfo{return null;}
      
      public function get selectedItem() : InventoryItemInfo{return null;}
      
      public function dispose() : void{}
   }
}
