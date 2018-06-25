package store.data{   import ddt.data.goods.InventoryItemInfo;   import ddt.manager.ItemManager;   import flash.utils.getTimer;      public class PreviewInfoII   {                   private var _info:InventoryItemInfo;            private var _rate:int;            public function PreviewInfoII() { super(); }
            public function data(id:int, beginDate:Number = 7) : void { }
            public function setComposeProperty(agilityCompose:int, attackCompose:int, defendCompose:int, luckCompose:int) : void { }
            public function get info() : InventoryItemInfo { return null; }
            public function set rate($rate:int) : void { }
            public function get rate() : int { return 0; }
   }}