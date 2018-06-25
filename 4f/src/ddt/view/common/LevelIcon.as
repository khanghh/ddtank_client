package ddt.view.common{   import bagAndInfo.ddtKingGrade.DDTKingGradeManager;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.ShowTipManager;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.core.ITipedDisplay;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.view.tips.LevelTipInfo;   import flash.display.Bitmap;   import flash.display.DisplayObject;   import flash.display.MovieClip;   import flash.display.Sprite;   import flash.events.MouseEvent;   import flash.utils.Dictionary;   import road7th.utils.MathUtils;   import trainer.view.NewHandContainer;      public class LevelIcon extends Sprite implements ITipedDisplay, Disposeable   {            public static const MAX_LEVEL:int = 70;            public static const MIN_LEVEL:int = 1;            public static const SIZE_BIG:int = 0;            public static const SIZE_SMALL:int = 1;            private static const LEVEL_EFFECT_CLASSPATH:String = "asset.LevelIcon.LevelEffect_";            private static const LEVEL_ICON_CLASSPATH:String = "asset.LevelIcon.Level_";                   private var _isBitmap:Boolean;            private var _level:int;            private var _levelBitmaps:Dictionary;            private var _levelEffects:Dictionary;            private var _levelTipInfo:LevelTipInfo;            private var _tipDirctions:String;            private var _tipGapH:int;            private var _tipGapV:int;            private var _tipStyle:String;            private var _size:int;            private var _bmContainer:Sprite;            public function LevelIcon() { super(); }
            private function __click(evt:MouseEvent) : void { }
            public function asDisplayObject() : DisplayObject { return null; }
            public function dispose() : void { }
            public function setInfo(level:int, ddtKingGraed:int, reputeCount:int, win:int, total:int, battle:int, exploit:int, enableTip:Boolean = true, isBitmap:Boolean = true, team:int = 1) : void { }
            public function setSize(size:int) : void { }
            public function get tipData() : Object { return null; }
            public function set tipData(value:Object) : void { }
            public function get tipDirctions() : String { return null; }
            public function set tipDirctions(value:String) : void { }
            public function get tipGapH() : int { return 0; }
            public function set tipGapH(value:int) : void { }
            public function get tipGapV() : int { return 0; }
            public function set tipGapV(value:int) : void { }
            public function get tipStyle() : String { return null; }
            public function set tipStyle(value:String) : void { }
            public function allowClick() : void { }
            private function addCurrentLevelBitmap() : void { }
            private function addCurrentLevelEffect() : void { }
            private function clearnDisplay() : void { }
            private function creatLevelBitmap(level:int) : Bitmap { return null; }
            private function creatLevelEffect(level:int) : MovieClip { return null; }
            private function updateView() : void { }
            private function updateSize() : void { }
   }}