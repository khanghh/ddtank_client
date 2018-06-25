package petsBag.petsAdvanced{   import com.greensock.TweenMax;   import com.greensock.easing.Linear;   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.Frame;   import com.pickgliss.ui.controls.SimpleBitmapButton;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.SoundManager;   import flash.display.Bitmap;   import flash.events.Event;   import flash.utils.setTimeout;   import pet.data.PetInfo;   import petsBag.PetsBagManager;      public class PetsBreakAnimationFrame extends Frame   {                   private var _bg:Bitmap;            private var _barProgressBG:Bitmap;            private var _progressBar:Bitmap;            public var _btnBreak:SimpleBitmapButton;            private var _petsBasicInfoView:PetsBasicInfoView;            private var _maxProgressWidth:Number;            private var _flag:int = 0;            public function PetsBreakAnimationFrame() { super(); }
            override protected function init() : void { }
            private function addEvent() : void { }
            private function _response(evt:FrameEvent) : void { }
            public function show() : void { }
            public function hide() : void { }
            public function result(isSuccess:Boolean) : void { }
            private function remove() : void { }
            private function rmv() : void { }
            protected function onEF(e:Event) : void { }
            override public function dispose() : void { }
   }}