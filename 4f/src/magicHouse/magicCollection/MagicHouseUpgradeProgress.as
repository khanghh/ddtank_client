package magicHouse.magicCollection{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.core.Component;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ClassUtils;   import com.pickgliss.utils.ObjectUtils;   import flash.display.Bitmap;   import flash.display.MovieClip;   import flash.display.Sprite;   import flash.events.Event;   import flash.utils.Dictionary;   import magicHouse.MagicHouseModel;      public class MagicHouseUpgradeProgress extends Component   {            private static const MAXLEVEL:int = 5;                   private var _background:Bitmap;            protected var _graphics_thuck:Bitmap;            protected var _progressLabel:FilterFrameText;            protected var _star:MovieClip;            private var _progressBarMask:Sprite;            private var _total:int = 50;            private var _scaleValue:Number;            protected var _max:Number = 0;            private var _exp:int;            protected var _currentFrame:int;            private var _taskFrames:Dictionary;            private var _level:int;            public function MagicHouseUpgradeProgress() { super(); }
            private function initView() : void { }
            private function initMask() : void { }
            private function startProgress() : void { }
            private function __startFrame(e:Event) : void { }
            public function resetProgress() : void { }
            public function setMask(value:Number) : void { }
            private function setStarVisible(value:Boolean) : void { }
            public function getStarVisible() : Boolean { return false; }
            public function initProgress($lv:int, $exp:int) : void { }
            public function setProgress($lv:int, $exp:int) : void { }
            public function setExpPercent() : void { }
            override public function dispose() : void { }
   }}