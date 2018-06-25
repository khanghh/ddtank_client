package ddt.data.analyze{   import com.pickgliss.loader.DataAnalyzer;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.goods.ShopItemInfo;   import ddt.manager.ShopManager;   import flash.events.TimerEvent;   import flash.utils.Dictionary;   import flash.utils.Timer;   import road7th.data.DictionaryData;      public class ShopItemDisCountAnalyzer extends DataAnalyzer   {                   private var _xml:XML;            private var _shoplist:XMLList;            public var shopDisCountGoods:Dictionary;            private var index:int = -1;            private var _timer:Timer;            public function ShopItemDisCountAnalyzer(onCompleteCall:Function) { super(null); }
            override public function analyze(data:*) : void { }
            private function parseShop() : void { }
            private function __partexceute(evt:TimerEvent) : void { }
            private function converMoneyType(info:ShopItemInfo) : void { }
            private function addList(type:int, itemInfo:ShopItemInfo) : void { }
   }}