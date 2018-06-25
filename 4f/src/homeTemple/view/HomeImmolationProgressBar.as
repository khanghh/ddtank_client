package homeTemple.view{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.core.Component;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.utils.PositionUtils;   import flash.display.Bitmap;   import flash.display.MovieClip;   import flash.display.Sprite;   import flash.events.Event;   import flash.utils.Dictionary;   import homeTemple.HomeTempleController;   import homeTemple.data.HomeTempleData;   import homeTemple.event.HomeTempleEvent;      public class HomeImmolationProgressBar extends Component   {                   protected var _thuck:Bitmap;            protected var _progressLabel:FilterFrameText;            protected var _currentFrame:int;            private var _strengthenLevel:int;            private var _strengthenExp:int;            private var _progressBarMask:Sprite;            private var _scaleValue:Number;            private var _taskFrames:Dictionary;            private var _total:int = 50;            private var _max:Number = 0;            private var _upgradeMovie:MovieClip;            public function HomeImmolationProgressBar() { super(); }
            protected function initView() : void { }
            private function startProgress() : void { }
            private function __startFrame(e:Event) : void { }
            private function initMask() : void { }
            public function initProgress() : void { }
            public function setProgress() : void { }
            private function playerUpgradeAnimation() : void { }
            private function setMask(value:Number) : void { }
            private function setExpPercent() : void { }
            public function resetProgress() : void { }
            override public function dispose() : void { }
   }}