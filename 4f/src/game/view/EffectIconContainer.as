package game.view{   import flash.display.DisplayObject;   import flash.display.Sprite;   import flash.events.Event;   import gameCommon.view.effects.BaseMirariEffectIcon;   import road7th.data.DictionaryData;   import road7th.data.DictionaryEvent;      [Event(name="change",type="flash.events.Event")]   public class EffectIconContainer extends Sprite   {                   private var _data:DictionaryData;            private var _spList:Array;            private var _list:Vector.<BaseMirariEffectIcon>;            public function EffectIconContainer() { super(); }
            private function initialize() : void { }
            private function release() : void { }
            private function clearIcons() : void { }
            private function drawIcons(iconArr:Array) : void { }
            private function initEvent() : void { }
            private function removeEvent() : void { }
            private function __changeEffectHandler(e:DictionaryEvent) : void { }
            private function _updateList() : void { }
            override public function get width() : Number { return 0; }
            override public function get height() : Number { return 0; }
            public function handleEffect(type:int, view:DisplayObject) : void { }
            public function removeEffect(type:int) : void { }
            public function clearEffectIcon() : void { }
            public function dispose() : void { }
   }}