package ddt.data.analyze{   import com.pickgliss.events.FrameEvent;   import com.pickgliss.loader.DataAnalyzer;   import com.pickgliss.ui.AlertManager;   import com.pickgliss.ui.controls.alert.BaseAlerFrame;   import ddt.data.goods.ShopItemInfo;   import ddt.manager.LanguageMgr;   import ddt.manager.ShopManager;   import flash.events.TimerEvent;   import flash.utils.Dictionary;   import flash.utils.Timer;      public class ShopItemSortAnalyzer extends DataAnalyzer   {                   private var _xml:XML;            private var _shoplist:XMLList;            public var shopSortedGoods:Dictionary;            private var index:int = -1;            private var _timer:Timer;            public function ShopItemSortAnalyzer(onCompleteCall:Function) { super(null); }
            override public function analyze(data:*) : void { }
            private function parseShop() : void { }
            private function __partexceute(evt:TimerEvent) : void { }
            private function __onResponse(event:FrameEvent) : void { }
            private function addToList(type:int, shopItem:ShopItemInfo) : void { }
   }}