package ddt.manager{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.core.Disposeable;   import ddt.display.BitmapObject;   import ddt.display.BitmapShape;   import flash.display.Bitmap;   import flash.display.BitmapData;   import flash.display.DisplayObject;   import flash.display.IBitmapDrawable;   import flash.geom.Matrix;   import flash.geom.Point;      public class BitmapManager implements Disposeable   {            public static const GameView:String = "GameView";            private static const destPoint:Point = new Point();            private static var _mgrPool:Object = {};                   private var _bitmapPool:Object;            private var _len:int;            public var name:String = "BitmapManager";            public var linkCount:int = 0;            public function BitmapManager() { super(); }
            public static function hasMgr(name:String) : Boolean { return false; }
            private static function registerMgr(name:String, mgr:BitmapManager) : void { }
            private static function removeMgr(name:String) : void { }
            public static function getBitmapMgr(name:String) : BitmapManager { return null; }
            public function dispose() : void { }
            private function destory() : void { }
            public function creatBitmapShape(name:String, matrix:Matrix = null, repeat:Boolean = true, smooth:Boolean = false) : BitmapShape { return null; }
            public function hasBitmap(name:String) : Boolean { return false; }
            public function getBitmap(name:String) : BitmapObject { return null; }
            private function createBitmap(name:String) : BitmapObject { return null; }
            private function addBitmap(bitmap:BitmapObject) : void { }
            private function removeBitmap(bitmap:BitmapObject) : void { }
   }}