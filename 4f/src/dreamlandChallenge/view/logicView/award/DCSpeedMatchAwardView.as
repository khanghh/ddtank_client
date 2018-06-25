package dreamlandChallenge.view.logicView.award{   import com.pickgliss.ui.LayerManager;   import ddt.manager.LanguageMgr;   import ddt.manager.SoundManager;   import dreamlandChallenge.DreamlandChallengeControl;   import dreamlandChallenge.DreamlandChallengeManager;   import dreamlandChallenge.data.DCSpeedMatchRankMode;   import dreamlandChallenge.view.mornui.award.DCSpeedMatchAwardViewUI;   import morn.core.components.Component;   import morn.core.handlers.Handler;      public class DCSpeedMatchAwardView extends DCSpeedMatchAwardViewUI   {                   private var _curDiffculty:int = -1;            private var _control:DreamlandChallengeControl;            private var _selfRank:int = 0;            public function DCSpeedMatchAwardView(ctrl:DreamlandChallengeControl) { super(); }
            override protected function initialize() : void { }
            private function __tabChangeHandler(index:int) : void { }
            private function __speedMatchListRender(item:Component, index:int) : void { }
            public function get curDiffculty() : int { return 0; }
            public function set curDiffculty(value:int) : void { }
            private function initAwards() : void { }
            public function show() : void { }
            private function __closeView() : void { }
            override public function dispose() : void { }
   }}