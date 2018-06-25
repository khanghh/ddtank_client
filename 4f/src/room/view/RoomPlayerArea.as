package room.view{   import com.pickgliss.ui.ShowTipManager;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.core.ITipedDisplay;   import flash.display.DisplayObject;   import flash.display.Sprite;      public class RoomPlayerArea extends Sprite implements Disposeable, ITipedDisplay   {                   protected var _tipData:Object;            protected var _tipDirection:String;            protected var _tipGapH:int;            protected var _tipGapV:int;            protected var _tipStyle:String;            public function RoomPlayerArea() { super(); }
            private function addTip() : void { }
            public function get tipDirctions() : String { return null; }
            public function set tipDirctions(value:String) : void { }
            public function get tipGapH() : int { return 0; }
            public function set tipGapH(value:int) : void { }
            public function get tipGapV() : int { return 0; }
            public function set tipGapV(value:int) : void { }
            public function get tipData() : Object { return null; }
            public function set tipData(value:Object) : void { }
            public function get tipStyle() : String { return null; }
            public function set tipStyle(value:String) : void { }
            public function asDisplayObject() : DisplayObject { return null; }
            public function dispose() : void { }
   }}