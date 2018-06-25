package Indiana{   import Indiana.analyzer.IndianaGoodsItemAnalyzer;   import Indiana.analyzer.IndianaGoodsItemInfo;   import Indiana.analyzer.IndianaShopItemInfo;   import Indiana.analyzer.IndianaShopItemsAnalyzer;   import Indiana.event.IndianaEvent;   import Indiana.model.HistoryIndianaData;   import Indiana.model.IndianaData;   import Indiana.model.IndianaModel;   import Indiana.model.IndianaShowData;   import com.pickgliss.ui.ComponentFactory;   import ddt.data.goods.ItemTemplateInfo;   import ddt.events.PkgEvent;   import ddt.loader.LoaderCreate;   import ddt.manager.ItemManager;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.SocketManager;   import ddt.utils.AssetModuleLoader;   import flash.events.Event;   import flash.events.EventDispatcher;   import flash.events.IEventDispatcher;   import hall.IHallStateView;   import hallIcon.HallIconManager;   import times.utils.timerManager.TimerJuggler;      public class IndianaDataManager extends EventDispatcher   {            private static var _instance:IndianaDataManager;                   private var _model:IndianaModel;            public var currentShowData:IndianaShowData;            private var indianaDic:Vector.<IndianaData>;            private var historyIndiana:Vector.<HistoryIndianaData>;            private var beginCode:int;            public var totleCount:int;            private var joinCount:int;            private var currentShopInfo:IndianaShopItemInfo;            private var view;            public var _showBtn:Boolean = false;            private var _shopItems:Vector.<IndianaShowData>;            private var _hall:IHallStateView;            private var _icon:IndianaIcon;            public var updataRecode:Boolean = false;            private var _timer:TimerJuggler;            public function IndianaDataManager(target:IEventDispatcher = null) { super(null); }
            public static function get instance() : IndianaDataManager { return null; }
            public function get model() : IndianaModel { return null; }
            public function setup() : void { }
            public function __joinIndianaInfoHandler(pkg:PkgEvent) : void { }
            private function __historyIndianaInfoHandler(pkg:PkgEvent) : void { }
            public function get HistoryIndianaInfo() : Vector.<HistoryIndianaData> { return null; }
            private function __currentIndianaInfoHandler(pkg:PkgEvent) : void { }
            public function get currentIndianInfo() : Vector.<IndianaData> { return null; }
            private function __enterGameHandler(pkg:PkgEvent) : void { }
            private function sortShowData() : void { }
            private function sortState(x:IndianaShowData, y:IndianaShowData) : int { return 0; }
            private function getIndianaShowDataByPerId(id:int) : IndianaShowData { return null; }
            public function disposeView() : void { }
            public function goodsItemAnalyzer(analyzer:IndianaGoodsItemAnalyzer) : void { }
            public function shopItemAnalyzer(analyzer:IndianaShopItemsAnalyzer) : void { }
            public function tickTime() : void { }
            public function checkIcon() : void { }
            private function disposeTimer() : void { }
            private function __completeHander(evt:Event) : void { }
            public function getTemplatesByShopId(shopId:int) : ItemTemplateInfo { return null; }
            public function getIndianaGoodsItemInfoByshopId(shopId:int) : IndianaGoodsItemInfo { return null; }
            public function get getCurrentShopItem() : IndianaShopItemInfo { return null; }
            public function get leftShopItem() : IndianaShowData { return null; }
            public function get rightShopItem() : IndianaShowData { return null; }
            public function getShopItem() : Array { return null; }
            private function onComplete() : void { }
            public function show() : void { }
   }}