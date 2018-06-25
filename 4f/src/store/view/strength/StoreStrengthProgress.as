package store.view.strength{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.core.Component;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ClassUtils;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.goods.InventoryItemInfo;   import ddt.utils.PositionUtils;   import flash.display.Bitmap;   import flash.display.MovieClip;   import flash.display.Sprite;   import flash.events.Event;   import flash.utils.Dictionary;   import store.data.StoreEquipExperience;      public class StoreStrengthProgress extends Component   {                   protected var _background:Bitmap;            protected var _thuck:Component;            protected var _graphics_thuck:Bitmap;            protected var _progressLabel:FilterFrameText;            protected var _star:MovieClip;            protected var _max:Number = 0;            protected var _currentFrame:int;            private var _strengthenLevel:int;            private var _strengthenExp:int;            private var _progressBarMask:Sprite;            private var _scaleValue:Number;            private var _taskFrames:Dictionary;            private var _total:int = 50;            public function StoreStrengthProgress() { super(); }
            protected function initView() : void { }
            private function startProgress() : void { }
            private function __startFrame(e:Event) : void { }
            private function initMask() : void { }
            private function setStarVisible(value:Boolean) : void { }
            public function getStarVisible() : Boolean { return false; }
            public function setMask(value:Number) : void { }
            public function initProgress(info:InventoryItemInfo) : void { }
            public function setProgress(info:InventoryItemInfo) : void { }
            public function setExpPercent() : void { }
            public function resetProgress() : void { }
            override public function dispose() : void { }
   }}