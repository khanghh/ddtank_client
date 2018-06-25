package gameCommon.view.propContainer{   import ddt.events.ItemEvent;   import ddt.events.LivingEvent;   import flash.display.Sprite;   import gameCommon.model.LocalPlayer;      public class BaseGamePropBarView extends Sprite   {                   protected var _notExistTip:Sprite;            protected var _itemContainer:ItemContainer;            private var _self:LocalPlayer;            public function BaseGamePropBarView(self:LocalPlayer, count:Number, column:Number, bgvisible:Boolean, ordinal:Boolean, clickable:Boolean, EffectType:String = "") { super(); }
            public function get itemContainer() : ItemContainer { return null; }
            public function get self() : LocalPlayer { return null; }
            public function setClickEnabled(clickAble:Boolean, isGray:Boolean) : void { }
            public function dispose() : void { }
            private function __changeAttack(event:LivingEvent) : void { }
            private function __die(event:LivingEvent) : void { }
            protected function __energyChange(event:LivingEvent) : void { }
            protected function __move(event:ItemEvent) : void { }
            public function setVisible(index:int, v:Boolean) : void { }
            protected function __over(event:ItemEvent) : void { }
            protected function __out(event:ItemEvent) : void { }
            protected function __click(event:ItemEvent) : void { }
            public function setLayerMode(mode:int) : void { }
   }}