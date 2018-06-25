package ddt.data.goods{   import flash.events.Event;      public class ShopCarItemInfo extends ShopItemInfo   {                   private var _currentBuyType:int = 1;            private var _color:String = "";            public var dressing:Boolean;            public var ModelSex:Boolean;            public var colorValue:String = "";            public var place:int;            public var skin:String = "";            public function ShopCarItemInfo(goodsID:int, templateID:int, CategoryID:int = 0) { super(null,null); }
            public function set Property8(value:String) : void { }
            public function get Property8() : String { return null; }
            public function get CategoryID() : int { return 0; }
            public function get Color() : String { return null; }
            public function set Color(value:String) : void { }
            public function set currentBuyType(value:int) : void { }
            public function get currentBuyType() : int { return 0; }
            public function getCurrentPrice() : ItemPrice { return null; }
   }}