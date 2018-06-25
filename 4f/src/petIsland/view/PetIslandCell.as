package petIsland.view{   import com.greensock.TweenLite;   import com.pickgliss.ui.ComponentFactory;   import flash.display.MovieClip;   import flash.display.Sprite;   import flash.events.MouseEvent;   import petIsland.PetIslandManager;   import petIsland.event.PetIslandEvent;      public class PetIslandCell extends Sprite   {                   private var cell:MovieClip;            private var _type:int;            public var _row:int;            public var _col:int;            private var _isShine:Boolean;            public function PetIslandCell(type:int, row:int, col:int) { super(); }
            public function get type() : int { return 0; }
            public function set type(value:int) : void { }
            public function get isShine() : Boolean { return false; }
            public function set isShine(value:Boolean) : void { }
            private function init() : void { }
            public function destroy() : void { }
            private function tweenComplete() : void { }
            private function cellClickHandler(e:MouseEvent) : void { }
            public function clearShine() : void { }
   }}