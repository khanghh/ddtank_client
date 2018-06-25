package dreamlandChallenge.view.logicView.ranking{   import com.pickgliss.ui.LayerManager;   import ddt.manager.LanguageMgr;   import ddt.manager.SoundManager;   import dreamlandChallenge.DreamlandChallengeControl;   import dreamlandChallenge.data.DCSpeedMatchRankMode;   import dreamlandChallenge.data.DreamLandModel;   import dreamlandChallenge.view.logicView.award.DCPointAwardView;   import dreamlandChallenge.view.logicView.shop.DCPointShopView;   import dreamlandChallenge.view.mornui.ranking.DCPointRankingViewUI;   import flash.events.Event;   import morn.core.components.Component;   import morn.core.handlers.Handler;      public class DCPointRankingView extends DCPointRankingViewUI   {                   private var _rankModel:DreamLandModel;            private var _curPageNum:int = -1;            private var _control:DreamlandChallengeControl;            public function DCPointRankingView(mode:DreamLandModel) { super(); }
            override protected function initialize() : void { }
            private function __refreshRankingHandler(evt:Event) : void { }
            private function __listRankRender(item:Component, index:int) : void { }
            private function __changePageHandler(index:int) : void { }
            private function requestData() : void { }
            public function set control(ctrl:DreamlandChallengeControl) : void { }
            private function __closeView() : void { }
            private function __openAward() : void { }
            private function __openShop() : void { }
            public function show() : void { }
            override public function dispose() : void { }
   }}