package ddt.command{   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.SoundManager;   import flash.display.MovieClip;   import flash.display.Sprite;   import flash.events.Event;      public class ShineObject extends Sprite   {                   private var _shiner:MovieClip;            private var _addToBottom:Boolean;            public function ShineObject(shiner:MovieClip, addToBottom:Boolean = true) { super(); }
            private function init() : void { }
            private function initEvents() : void { }
            private function removeEvents() : void { }
            private function __addToStage(evt:Event) : void { }
            public function shine(playSound:Boolean = false) : void { }
            public function stopShine() : void { }
            public function dispose() : void { }
   }}