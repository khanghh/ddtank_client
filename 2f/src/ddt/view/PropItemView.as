package ddt.view{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.ShowTipManager;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.core.ITipedDisplay;   import ddt.data.PropInfo;   import ddt.view.tips.ToolPropInfo;   import flash.display.Bitmap;   import flash.display.DisplayObject;   import flash.display.Sprite;   import flash.events.Event;   import flash.events.MouseEvent;   import flash.filters.ColorMatrixFilter;   import flash.utils.Dictionary;      public class PropItemView extends Sprite implements ITipedDisplay, Disposeable   {            public static const OVER:String = "over";            public static const OUT:String = "out";            public static var _prop:Dictionary;                   private var _info:PropInfo;            private var _asset:Bitmap;            private var _isExist:Boolean;            private var _tipStyle:String;            private var _tipData:Object;            private var _tipDirctions:String;            private var _tipGapV:int;            private var _tipGapH:int;            public function PropItemView(info:PropInfo, $isExist:Boolean = true, $showPrice:Boolean = true, $count:int = 1) { super(); }
            public static function createView(id:String, width:int = 62, height:int = 62, smoothing:Boolean = true) : Bitmap { return null; }
            public function get info() : PropInfo { return null; }
            public function set propPos(val:int) : void { }
            private function __out(event:MouseEvent) : void { }
            private function __over(event:MouseEvent) : void { }
            public function get isExist() : Boolean { return false; }
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