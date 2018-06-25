package game.view.heroAuto{   import com.pickgliss.ui.UICreatShortcut;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.utils.ObjectUtils;   import flash.display.MovieClip;   import flash.display.Sprite;   import flash.events.Event;   import gameCommon.GameControl;   import gameCommon.HeroAutoControl;      public class HeroAutoView extends Sprite implements Disposeable   {                   private var _heroAutoMovie:MovieClip;            private var _heroAutoState:Boolean;            private var _autoControl:HeroAutoControl;            public function HeroAutoView() { super(); }
            private function init() : void { }
            public function updateWind(value:int) : void { }
            private function disableOperation() : void { }
            private function initEvent() : void { }
            private function removeEvent() : void { }
            protected function __die(event:Event) : void { }
            public function set autoState(value:Boolean) : void { }
            public function get autoState() : Boolean { return false; }
            private function update() : void { }
            public function dispose() : void { }
   }}