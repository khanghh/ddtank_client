package ddt.view.tips{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.image.ScaleBitmapImage;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.ui.tip.BaseTip;   import com.pickgliss.ui.tip.ITip;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.StateManager;   import ddt.utils.PositionUtils;   import flash.display.Bitmap;   import flash.display.Sprite;   import flash.geom.Point;   import flash.utils.getDefinitionByName;      public class SmallPlayerTip extends BaseTip implements ITip   {            private static var _instance:SmallPlayerTip;                   private var _bg:ScaleBitmapImage;            private var _lv:Bitmap;            private var _ddtKingGradeText:FilterFrameText;            private var _winRate:WinRate;            private var _battle:Battle;            private var _tipContainer:Sprite;            private var _nameField:FilterFrameText;            private var _level:int;            private var _reputeCount:int;            private var _win:int;            private var _total:int;            private var _enableTip:Boolean;            private var _tip:Sprite;            private var _tipInfo:Object;            private var _battleNum:int;            private var _exploitValue:int;            private var _bgH:int;            public function SmallPlayerTip() { super(); }
            public static function get instance() : SmallPlayerTip { return null; }
            override protected function init() : void { }
            override protected function addChildren() : void { }
            public function get txtPos() : Point { return null; }
            override public function get tipData() : Object { return null; }
            override public function set tipData(data:Object) : void { }
            private function updateWH() : void { }
            private function createLevelTip() : void { }
            private function makeTip(obj:Object) : void { }
            private function resetLevelTip(lv:int, ddtKingGraed:int, repute:int, win:int, total:int, battle:int, exploit:int, enableTip:Boolean = true, team:int = 1, name:String = "") : void { }
            private function setRepute(level:int, reputeCount:int) : void { }
            private function setRate($win:int, $total:int) : void { }
            private function setBattle(num:int) : void { }
            private function setExploit(value:int) : void { }
            private function updateTip() : void { }
            override public function dispose() : void { }
   }}