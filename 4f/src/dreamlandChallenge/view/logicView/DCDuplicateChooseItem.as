package dreamlandChallenge.view.logicView{   import com.greensock.TweenLite;   import com.pickgliss.loader.DisplayLoader;   import com.pickgliss.loader.LoadResourceManager;   import com.pickgliss.loader.LoaderEvent;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.map.DungeonInfo;   import ddt.manager.LanguageMgr;   import ddt.manager.MapManager;   import ddt.manager.PathManager;   import ddt.manager.ServerConfigManager;   import ddt.manager.SoundManager;   import dreamlandChallenge.DreamlandChallengeControl;   import dreamlandChallenge.view.mornui.DCDuplicateChooseItemUI;   import flash.display.Bitmap;   import flash.display.Sprite;   import flash.events.MouseEvent;   import morn.core.components.Button;   import morn.core.components.Component;   import morn.core.handlers.Handler;      public class DCDuplicateChooseItem extends DCDuplicateChooseItemUI   {            public static const PRE_PAGE:int = 0;            public static const CUR_PAGE:int = 2;            public static const NEXT_PAGE:int = 1;            public static const EASY:int = 1;            public static const GENERAL:int = 2;            public static const DIFFICULTY:int = 3;                   private var _info:DungeonInfo;            private var _loader:DisplayLoader;            protected var _mapShowContainer:Sprite;            private var _curType:int = -1;            private var _curDifficulty:int = -1;            private var _control:DreamlandChallengeControl;            public function DCDuplicateChooseItem(type:int, ctrl:DreamlandChallengeControl) { super(); }
            private function addEvent() : void { }
            private function removeEvent() : void { }
            private function __overHander(evt:MouseEvent) : void { }
            private function __outHandler(evt:MouseEvent) : void { }
            private function initDefaultSelectedDiff() : void { }
            override protected function initialize() : void { }
            private function __difficultySelectedHandler(paras:int) : void { }
            override protected function createChildren() : void { }
            private function updateView() : void { }
            private function clearMap() : void { }
            private function updateConten() : void { }
            protected function updateMap() : void { }
            private function __showMap(evt:LoaderEvent) : void { }
            private function __awarsListRender(item:Component, index:int) : void { }
            private function updateAwards() : void { }
            private function addDifficultyTips() : void { }
            private function solvePath() : String { return null; }
            public function get curDifficulty() : int { return 0; }
            public function set curDifficulty(value:int) : void { }
            public function get info() : DungeonInfo { return null; }
            public function set info(value:DungeonInfo) : void { }
            public function set type(value:int) : void { }
            public function get type() : int { return 0; }
            override public function dispose() : void { }
   }}