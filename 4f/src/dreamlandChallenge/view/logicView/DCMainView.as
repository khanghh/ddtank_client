package dreamlandChallenge.view.logicView{   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.controls.SimpleBitmapButton;   import com.pickgliss.ui.controls.alert.BaseAlerFrame;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.map.DungeonInfo;   import ddt.manager.LanguageMgr;   import ddt.manager.ServerConfigManager;   import ddt.manager.SoundManager;   import ddt.manager.TimeManager;   import ddt.utils.HelpFrameUtils;   import ddt.utils.PositionUtils;   import dreamlandChallenge.DreamlandChallengeControl;   import dreamlandChallenge.DreamlandChallengeManager;   import dreamlandChallenge.data.DreamLandModel;   import dreamlandChallenge.view.logicView.ranking.DCPointRankingView;   import dreamlandChallenge.view.logicView.ranking.DCSpeedMatchRankingView;   import dreamlandChallenge.view.mornui.DCMainViewUI;   import flash.events.Event;   import morn.core.handlers.Handler;   import road7th.utils.DateUtils;      public class DCMainView extends DCMainViewUI   {                   private var _control:DreamlandChallengeControl;            private var _dupView:DCDuplicateChooseView;            private var _confirmFrame:BaseAlerFrame;            private var _dcModel:DreamLandModel;            private var _helpBtn:SimpleBitmapButton;            public function DCMainView(control:DreamlandChallengeControl) { super(); }
            private function initActionSuplusDate() : void { }
            override protected function createChildren() : void { }
            override protected function initialize() : void { }
            private function __dupDesc() : void { }
            private function __storyDesc() : void { }
            public function set disableChallengeBtn(value:Boolean) : void { }
            private function __updateSuplusCount(evt:Event) : void { }
            private function updateChalengeBtnState(haveCount:Boolean) : void { }
            private function __buyCount() : void { }
            private function __onPointRanking() : void { }
            private function __onSpeedMatchRanking() : void { }
            private function __challenge() : void { }
            private function __closeView() : void { }
            public function show() : void { }
            override public function dispose() : void { }
   }}