package dreamlandChallenge.view.logicView.award{   import com.pickgliss.ui.LayerManager;   import ddt.manager.LanguageMgr;   import ddt.manager.SoundManager;   import dreamlandChallenge.DreamlandChallengeControl;   import dreamlandChallenge.DreamlandChallengeManager;   import dreamlandChallenge.data.DCSpeedMatchRankMode;   import dreamlandChallenge.view.mornui.award.DCPointAwardViewUI;   import morn.core.components.Component;   import morn.core.handlers.Handler;      public class DCPointAwardView extends DCPointAwardViewUI   {                   private var _control:DreamlandChallengeControl;            private var _selfRank:int = 0;            public function DCPointAwardView(ctrl:DreamlandChallengeControl) { super(); }
            override protected function initialize() : void { }
            private function initAwards() : void { }
            private function __pointAwardListRender(item:Component, index:int) : void { }
            private function __closeView() : void { }
            public function show() : void { }
            override public function dispose() : void { }
   }}