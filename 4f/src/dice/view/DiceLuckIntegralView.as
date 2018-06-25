package dice.view{   import com.greensock.TweenLite;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.image.ScaleFrameImage;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.utils.PositionUtils;   import dice.controller.DiceController;   import dice.event.DiceEvent;   import dice.vo.DiceAwardInfo;   import flash.display.Bitmap;   import flash.display.MovieClip;   import flash.display.Shape;   import flash.display.Sprite;   import flash.events.MouseEvent;      public class DiceLuckIntegralView extends Sprite implements Disposeable   {                   private var _bg:ScaleFrameImage;            private var _level:ScaleFrameImage;            private var _luckBar:Bitmap;            private var _grayBar:Bitmap;            private var _caption:Bitmap;            private var _luckIntegral:FilterFrameText;            private var _shape:Shape;            private var _yellowIris:MovieClip;            private var _starlight:MovieClip;            private var _progressEffect:MovieClip;            private var _container:Sprite;            private var _maxIntegral:int;            private var _currentIntegral:int = 0;            private var _tip:DiceTreasureBoxTip;            public function DiceLuckIntegralView() { super(); }
            private function preInitialize() : void { }
            private function initialize() : void { }
            private function addEvent() : void { }
            private function removeEvent() : void { }
            private function __onLevelRollOver(event:MouseEvent) : void { }
            private function __onLevelRollOut(event:MouseEvent) : void { }
            private function __onLuckIntegralChanged(event:DiceEvent) : void { }
            private function __onLuckIntegralLevelChanged(event:DiceEvent) : void { }
            public function resetLuckBar(preIntegral:int, maxIntegral:int) : void { }
            public function set setIntegral(integral:int) : void { }
            private function onMoveEffect() : void { }
            public function set setIntegralLevel(level:int) : void { }
            public function dispose() : void { }
   }}