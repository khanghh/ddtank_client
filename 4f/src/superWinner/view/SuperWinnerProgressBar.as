package superWinner.view{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.utils.ObjectUtils;   import flash.display.MovieClip;   import flash.display.Sprite;   import flash.events.Event;   import superWinner.controller.SuperWinnerController;   import superWinner.event.SuperWinnerEvent;      public class SuperWinnerProgressBar extends Sprite implements Disposeable   {                   private var _movie:MovieClip;            private var _outLight:MovieClip;            private var _changeColor:MovieClip;            private var _light1:MovieClip;            private var _light2:MovieClip;            public function SuperWinnerProgressBar() { super(); }
            private function init() : void { }
            public function resetProgressBar() : void { }
            public function playBar() : void { }
            private function stopBar() : void { }
            private function frameBar(e:Event) : void { }
            public function dispose() : void { }
   }}