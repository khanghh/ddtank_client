package ddt.manager
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import ddt.display.BitmapObject;
   import ddt.display.BitmapShape;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.IBitmapDrawable;
   import flash.geom.Matrix;
   import flash.geom.Point;
   
   public class BitmapManager implements Disposeable
   {
      
      public static const GameView:String = "GameView";
      
      private static const destPoint:Point = new Point();
      
      private static var _mgrPool:Object = {};
       
      
      private var _bitmapPool:Object;
      
      private var _len:int;
      
      public var name:String = "BitmapManager";
      
      public var linkCount:int = 0;
      
      public function BitmapManager(){super();}
      
      public static function hasMgr(param1:String) : Boolean{return false;}
      
      private static function registerMgr(param1:String, param2:BitmapManager) : void{}
      
      private static function removeMgr(param1:String) : void{}
      
      public static function getBitmapMgr(param1:String) : BitmapManager{return null;}
      
      public function dispose() : void{}
      
      private function destory() : void{}
      
      public function creatBitmapShape(param1:String, param2:Matrix = null, param3:Boolean = true, param4:Boolean = false) : BitmapShape{return null;}
      
      public function hasBitmap(param1:String) : Boolean{return false;}
      
      public function getBitmap(param1:String) : BitmapObject{return null;}
      
      private function createBitmap(param1:String) : BitmapObject{return null;}
      
      private function addBitmap(param1:BitmapObject) : void{}
      
      private function removeBitmap(param1:BitmapObject) : void{}
   }
}
