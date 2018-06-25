package gameCommon.view{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.ShowTipManager;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.core.ITipedDisplay;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.LanguageMgr;   import flash.display.Bitmap;   import flash.display.DisplayObject;   import flash.display.Sprite;   import flash.events.MouseEvent;      public class SkipButton extends Sprite implements Disposeable, ITipedDisplay   {                   private var _back:Bitmap;            private var _shine:Bitmap;            private var _tipData:String;            private var _enabled:Boolean = true;            public function SkipButton() { super(); }
            private function addEvent() : void { }
            private function removeEvent() : void { }
            public function set enabled(val:Boolean) : void { }
            public function get enabled() : Boolean { return false; }
            private function __mouseOut(evt:MouseEvent) : void { }
            private function __mouseOver(evt:MouseEvent) : void { }
            public function dispose() : void { }
            public function get tipData() : Object { return null; }
            public function set tipData(value:Object) : void { }
            public function get tipDirctions() : String { return null; }
            public function set tipDirctions(value:String) : void { }
            public function get tipGapH() : int { return 0; }
            public function set tipGapH(value:int) : void { }
            public function get tipGapV() : int { return 0; }
            public function set tipGapV(value:int) : void { }
            public function get tipStyle() : String { return null; }
            public function set tipStyle(value:String) : void { }
            public function asDisplayObject() : DisplayObject { return null; }
   }}