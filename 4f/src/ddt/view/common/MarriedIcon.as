package ddt.view.common{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.ShowTipManager;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.core.ITipedDisplay;   import flash.display.Bitmap;   import flash.display.DisplayObject;   import flash.display.Sprite;      public class MarriedIcon extends Sprite implements ITipedDisplay, Disposeable   {                   private var _icon:Bitmap;            private var _tipStyle:String;            private var _tipDirctions:String;            private var _tipData:Object;            private var _tipGapH:int;            private var _tipGapV:int;            private var _gender:Boolean;            public function MarriedIcon() { super(); }
            public function dispose() : void { }
            public function get tipStyle() : String { return null; }
            public function get tipData() : Object { return null; }
            public function get tipDirctions() : String { return null; }
            public function get tipGapV() : int { return 0; }
            public function get tipGapH() : int { return 0; }
            public function set tipStyle(value:String) : void { }
            public function set tipData(value:Object) : void { }
            public function set tipDirctions(value:String) : void { }
            public function set tipGapV(value:int) : void { }
            public function set tipGapH(value:int) : void { }
            public function asDisplayObject() : DisplayObject { return null; }
   }}