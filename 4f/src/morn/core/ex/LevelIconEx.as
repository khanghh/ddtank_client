package morn.core.ex{   import com.pickgliss.ui.ShowTipManager;   import com.pickgliss.utils.ObjectUtils;   import flash.display.Sprite;   import morn.core.components.Component;   import morn.core.components.FrameClip;   import morn.core.components.Image;      public class LevelIconEx extends Component   {            private static const BIG:String = "big";            private static const SMALL:String = "small";            private static const MAX:int = 70;            private static const MIN:int = 1;            private static const LEVEL_EFFECT_CLASSPATH:String = "asset.LevelIcon.LevelEffect_";            private static const LEVEL_ICON_CLASSPATH:String = "asset.LevelIcon.Level_";                   private var _level:int;            private var _size:String;            private var _levelTipInfo:Object;            private var _isBitmap:Boolean;            private var _bmContainer:Sprite;            private var _levelImage:Image;            private var _levelEffect:FrameClip;            public function LevelIconEx() { super(); }
            public function get level() : int { return 0; }
            public function set level(value:int) : void { }
            override protected function createChildren() : void { }
            override protected function initialize() : void { }
            public function setInfo(lev:int, ddtKingGraed:int, reputeCount:int, win:int, total:int, battle:int, exploit:int, enableTip:Boolean = true, isBitmap:Boolean = true, team:int = 1) : void { }
            private function updateView() : void { }
            private function addCurrentLevelBitmap() : void { }
            private function addCurrentLevelEffect() : void { }
            private function getValueInRange(value:Number, min:Number, max:Number) : Number { return 0; }
            private function isInRange(value:Number, min:Number, max:Number, equalMin:Boolean = false, equleMax:Boolean = true) : Boolean { return false; }
            override public function get tipData() : Object { return null; }
            public function set size(value:String) : void { }
            public function get size() : String { return null; }
            private function updateSize() : void { }
            override public function dispose() : void { }
   }}