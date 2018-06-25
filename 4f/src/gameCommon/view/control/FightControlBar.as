package gameCommon.view.control{   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.utils.ObjectUtils;   import ddt.events.LivingEvent;   import flash.display.DisplayObjectContainer;   import flash.events.MouseEvent;   import gameCommon.model.LocalPlayer;      public class FightControlBar implements Disposeable   {            public static const LIVE:int = 0;            public static const SOUL:int = 1;                   private var _statePool:Object;            private var _self:LocalPlayer;            private var _state:int;            private var _container:DisplayObjectContainer;            private var _current:ControlState;            private var _next:ControlState;            public function FightControlBar(self:LocalPlayer, container:DisplayObjectContainer) { super(); }
            private static function getFightControlState(state:int, self:LocalPlayer) : ControlState { return null; }
            private function configUI() : void { }
            private function addEvent() : void { }
            private function __die(event:LivingEvent) : void { }
            private function removeEvent() : void { }
            public function setState(state:int) : ControlState { return null; }
            public function get curControlState() : ControlState { return null; }
            private function hasState(state:int) : Boolean { return false; }
            private function enterNext(next:ControlState) : void { }
            private function __stateClicked(event:MouseEvent) : void { }
            private function leavingComplete() : void { }
            private function enterComplete() : void { }
            public function dispose() : void { }
   }}