package dreamlandChallenge.view.logicView.ranking{   import com.pickgliss.ui.LayerManager;   import ddt.manager.LanguageMgr;   import ddt.manager.SoundManager;   import dreamlandChallenge.DreamlandChallengeControl;   import dreamlandChallenge.data.DCSpeedMatchRankMode;   import dreamlandChallenge.data.DreamLandModel;   import dreamlandChallenge.view.logicView.award.DCSpeedMatchAwardView;   import dreamlandChallenge.view.mornui.ranking.DCSpeedMatchRankingViewUI;   import flash.events.Event;   import morn.core.components.Component;   import morn.core.handlers.Handler;      public class DCSpeedMatchRankingView extends DCSpeedMatchRankingViewUI   {            private static const PAGE_SIZE:int = 5;                   private var _curSelectedIndex:int;            private var _curPageNum:int = -1;            private var _rankModel:DreamLandModel;            private var _control:DreamlandChallengeControl;            private var _selfRank:int = 0;            public function DCSpeedMatchRankingView(mode:DreamLandModel) { super(); }
            override protected function initialize() : void { }
            private function __refreshRankingHandler(evt:Event) : void { }
            private function __openAward() : void { }
            private function __changePageHandler(index:int) : void { }
            private function __listRankRender(item:Component, index:int) : void { }
            private function __changeTableHandler(index:int) : void { }
            private function requestData() : void { }
            private function __closeView() : void { }
            public function show() : void { }
            public function set control(ctrl:DreamlandChallengeControl) : void { }
            override public function dispose() : void { }
   }}