package dreamlandChallenge.view.logicView{   import com.greensock.TweenLite;   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.AlertManager;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.alert.BaseAlerFrame;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.map.DungeonInfo;   import ddt.manager.LanguageMgr;   import ddt.manager.ServerConfigManager;   import ddt.manager.SoundManager;   import dreamlandChallenge.DreamlandChallengeControl;   import flash.display.Sprite;   import flash.events.MouseEvent;   import flash.geom.Point;      public class DCDuplicateChooseView extends Sprite implements Disposeable   {                   private var _preDupView:DCDuplicateChooseItem;            private var _nextDupView:DCDuplicateChooseItem;            private var _curDupView:DCDuplicateChooseItem;            private var _control:DreamlandChallengeControl;            private var _temView:DCDuplicateChooseItem;            private var _confirmFrame:BaseAlerFrame;            private var _prePos:Point;            private var _curPos:Point;            private var _nextPos:Point;            public function DCDuplicateChooseView(control:DreamlandChallengeControl) { super(); }
            private function initView() : void { }
            private function initDuplicateInfo() : void { }
            public function get curSelectedDuplicateInfo() : DungeonInfo { return null; }
            public function get curSelectedDupDifficulty() : int { return 0; }
            private function challengeCountBuyAlert() : void { }
            private function addEvent() : void { }
            private function __pageItemClick(evt:MouseEvent) : void { }
            private function moveItemToRigth(item:DCDuplicateChooseItem) : void { }
            private function resetItem() : void { }
            private function moveItemToLeft(item:DCDuplicateChooseItem) : void { }
            private function removeEvent() : void { }
            public function dispose() : void { }
   }}