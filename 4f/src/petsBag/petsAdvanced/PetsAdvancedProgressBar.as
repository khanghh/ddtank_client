package petsBag.petsAdvanced{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.utils.PositionUtils;   import flash.display.Bitmap;   import flash.display.MovieClip;   import flash.display.Sprite;   import flash.events.Event;   import petsBag.petsAdvanced.event.PetsAdvancedEvent;      public class PetsAdvancedProgressBar extends Sprite implements Disposeable   {                   private var _progressBg:Bitmap;            private var _progressBar:Bitmap;            protected var _progressTxt:FilterFrameText;            private var _progressBarMask:Sprite;            protected var _progressMc:MovieClip;            protected var _currentExp:int;            protected var _max:int;            protected var _sumWidth:Number;            public function PetsAdvancedProgressBar() { super(); }
            private function addEvent() : void { }
            protected function __enterFrame(event:Event) : void { }
            private function initView() : void { }
            public function setProgress(exp:Number, success:Boolean = false) : void { }
            public function maxAdvancedGrade() : void { }
            private function removeEvent() : void { }
            public function dispose() : void { }
            public function get max() : Number { return 0; }
            public function set max(value:Number) : void { }
            public function get currentExp() : int { return 0; }
            public function set currentExp(value:int) : void { }
   }}