package ddt.manager{   import bagAndInfo.cell.BagCell;   import com.pickgliss.action.FunctionAction;   import com.pickgliss.events.FrameEvent;   import com.pickgliss.events.UIModuleEvent;   import com.pickgliss.loader.UIModuleLoader;   import com.pickgliss.manager.CacheSysManager;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import ddt.command.QuickBuyFrame;   import ddt.data.box.BoxGoodsTempInfo;   import ddt.data.goods.InventoryItemInfo;   import ddt.data.goods.ItemTemplateInfo;   import ddt.events.BagEvent;   import ddt.events.CrazyTankSocketEvent;   import ddt.events.PkgEvent;   import ddt.view.UIModuleSmallLoading;   import ddt.view.caddyII.CaddyAwardListFrame;   import ddt.view.caddyII.CaddyEvent;   import ddt.view.caddyII.CaddyFrame;   import ddt.view.caddyII.CaddyModel;   import ddt.view.caddyII.card.CardFrame;   import ddt.view.caddyII.card.CardSoulBoxFrame;   import ddt.view.caddyII.vip.VipBoxFrame;   import ddt.view.roulette.RouletteBoxPanel;   import ddt.view.roulette.RouletteEvent;   import flash.events.Event;   import flash.events.EventDispatcher;   import flash.events.IEventDispatcher;   import road7th.comm.PackageIn;      public class RouletteManager extends EventDispatcher   {            private static var _instance:RouletteManager = null;            public static const SLEEP:int = 0;            public static const OPEN_ROULETTEBOX:int = 1;            public static const OPEN_CADDY:int = 2;            public static const NO_BOX:int = 0;            public static const ROULETTEBOX:int = 1;            public static const CADDY:int = 2;                   private var _rouletteBoxkeyCount:int = -1;            private var _caddyKeyCount:int = -1;            private var _templateIDList:Array;            private var _bagType:int;            private var _place:int;            private var _stateAfterBuyKey:int = 0;            private var _boxType:int = 0;            private var _numList:Array;            public var dataList:Vector.<Object>;            public var goodList:Vector.<InventoryItemInfo>;            private var _goodsInfo:ItemTemplateInfo;            private var limdataList:Vector.<Object>;            public function RouletteManager(target:IEventDispatcher = null) { super(null); }
            public static function get instance() : RouletteManager { return null; }
            public function setup() : void { }
            private function init() : void { }
            private function initEvent() : void { }
            protected function luckStoneRankLimit(event:PkgEvent) : void { }
            private function _showBox(evt:PkgEvent) : void { }
            private function _showRoultteView(evt:CrazyTankSocketEvent) : void { }
            public function useVipBox(cell:BagCell) : void { }
            public function useRouletteBox(cell:BagCell) : void { }
            private function updateState() : void { }
            public function showRouletteView() : void { }
            public function showBuyRouletteKey(needKeyCount:int) : void { }
            private function _response(evt:FrameEvent) : void { }
            private function _closeFun() : void { }
            private function _randomTemplateID() : void { }
            private function _bagUpdate(e:BagEvent) : void { }
            private function __getBadLuckHandler(e:PkgEvent) : void { }
            private function __showBadLuckEndFrame() : void { }
            private function getStateAble(type:String) : Boolean { return false; }
            public function useCaddy(cell:BagCell) : void { }
            private function _creatCaddy() : void { }
            public function useBless(cell:BagCell = null) : void { }
            private function _creatBless() : void { }
            public function useCelebrationBox() : void { }
            public function useBead(templateID:int) : void { }
            public function useOfferPack(cell:BagCell) : void { }
            public function useCard(cell:BagCell) : void { }
            private function _loadSWF() : void { }
            private function _loadUI() : void { }
            private function __onUIComplete(e:UIModuleEvent) : void { }
            private function __onUICompleteOne(e:UIModuleEvent) : void { }
            private function __onSmallLoadingClose(e:Event) : void { }
            private function __onUIProgress(e:UIModuleEvent) : void { }
   }}