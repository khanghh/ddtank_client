package bagAndInfo.info{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.utils.ObjectUtils;   import flash.display.DisplayObject;   import flash.events.MouseEvent;   import flash.geom.Point;      public class GlowPropButton extends PropButton   {                   private var _overGraphics:DisplayObject;            private var _showOverGraphics:Boolean = true;            public function GlowPropButton() { super(); }
            public function get showOverGraphics() : Boolean { return false; }
            public function set showOverGraphics(value:Boolean) : void { }
            override protected function addChildren() : void { }
            public function setOverGraphicsPosition(p:Point) : void { }
            private function addEvent() : void { }
            private function __onMouseRollover(evt:MouseEvent) : void { }
            private function __onMouseRollout(evt:MouseEvent) : void { }
            private function removeEvent() : void { }
            override public function dispose() : void { }
   }}