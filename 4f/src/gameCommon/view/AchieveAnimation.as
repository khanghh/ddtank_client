package gameCommon.view{   import com.greensock.TweenLite;   import com.greensock.easing.Bounce;   import com.pickgliss.toplevel.StageReferance;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.image.ScaleFrameImage;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.FightAchievModel;   import ddt.display.BitmapShape;   import ddt.manager.BitmapManager;   import flash.display.Sprite;   import flash.events.Event;   import flash.filters.GlowFilter;   import flash.geom.Point;   import flash.text.TextField;   import flash.utils.getTimer;      [Event(name="complete",type="flash.events.Event")]   public class AchieveAnimation extends Sprite implements Disposeable   {            public static const Show:int = 1;            public static const Hold:int = 2;            public static const Hide:int = -1;                   private var _startY:int;            private var _startX:int;            private var _flashTime:Number;            private var _holdTime:Number;            private var _fadeOutTime:Number;            private var _elapsed:int;            private var _lastTime:int;            private var _state:int = -1;            private var _currentAchiev:int;            private var _num:int = 0;            private var _achievImage:ScaleFrameImage;            private var _numShape:AchievNumShape;            private var _center:Point;            private var _holdTimeField:TextField;            private var _shine:AchievShineShape;            private var _shineTime:Number;            private var _interval:int = -1;            private var _show:Boolean = false;            private var _start:int = 0;            private var _achiev:int;            private var _bitmapMgr:BitmapManager;            private var _achievShape:BitmapShape;            public function AchieveAnimation(achiev:int, num:int, interval:int, start:int) { super(); }
            public function dispose() : void { }
            private function drawNum() : void { }
            public function flash() : void { }
            private function flashComplete() : void { }
            private function shineComplete() : void { }
            private function __holdFrame(event:Event) : void { }
            private function holdComplete() : void { }
            public function fadeOut() : void { }
            private function fadeOutComplete() : void { }
            public function kill() : void { }
            public function play() : void { }
            public function get state() : int { return 0; }
            public function set startY(val:int) : void { }
            public function set numCenter(val:String) : void { }
            public function set time(val:String) : void { }
            public function get interval() : int { return 0; }
            public function get show() : Boolean { return false; }
            public function get delay() : int { return 0; }
            public function get id() : int { return 0; }
            public function setNum(num:int) : void { }
            override public function get height() : Number { return 0; }
            override public function set y(value:Number) : void { }
   }}