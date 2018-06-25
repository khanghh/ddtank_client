package dreamlandChallenge.view.logicView.shop{   import com.pickgliss.ui.LayerManager;   import ddt.manager.LanguageMgr;   import ddt.manager.ShopManager;   import ddt.manager.SoundManager;   import dreamlandChallenge.data.DreamLandModel;   import dreamlandChallenge.view.mornui.shop.DCPointShopViewUI;   import flash.events.Event;   import morn.core.components.Component;   import morn.core.handlers.Handler;      public class DCPointShopView extends DCPointShopViewUI   {                   private var _goodsInfoList:Array;            private var _model:DreamLandModel;            public function DCPointShopView(mode:DreamLandModel) { super(); }
            public function show() : void { }
            override protected function initialize() : void { }
            private function __pageChangeHandler(index:int) : void { }
            private function initShops() : void { }
            private function __updatePointHandler(evt:Event) : void { }
            private function __listRender(item:Component, index:int) : void { }
            private function __closeView() : void { }
            override public function dispose() : void { }
   }}