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
      
      public function BitmapManager()
      {
         super();
         _bitmapPool = {};
      }
      
      public static function hasMgr(name:String) : Boolean
      {
         return _mgrPool.hasOwnProperty(name);
      }
      
      private static function registerMgr(name:String, mgr:BitmapManager) : void
      {
         _mgrPool[name] = mgr;
      }
      
      private static function removeMgr(name:String) : void
      {
         if(hasMgr(name))
         {
            delete _mgrPool[name];
         }
      }
      
      public static function getBitmapMgr(name:String) : BitmapManager
      {
         var mgr:* = null;
         if(hasMgr(name))
         {
            mgr = _mgrPool[name];
            mgr.linkCount = Number(mgr.linkCount) + 1;
            return mgr;
         }
         mgr = new BitmapManager();
         mgr.name = name;
         mgr.linkCount = Number(mgr.linkCount) + 1;
         registerMgr(name,mgr);
         return mgr;
      }
      
      public function dispose() : void
      {
         linkCount = Number(linkCount) - 1;
         if(linkCount <= 0)
         {
            destory();
         }
      }
      
      private function destory() : void
      {
         var bitmap:* = null;
         removeMgr(name);
         var _loc4_:int = 0;
         var _loc3_:* = _bitmapPool;
         for(var key in _bitmapPool)
         {
            bitmap = _bitmapPool[key];
            bitmap.destory();
            delete _bitmapPool[key];
         }
         _bitmapPool = null;
      }
      
      public function creatBitmapShape(name:String, matrix:Matrix = null, repeat:Boolean = true, smooth:Boolean = false) : BitmapShape
      {
         return new BitmapShape(getBitmap(name),matrix,repeat,smooth);
      }
      
      public function hasBitmap(name:String) : Boolean
      {
         return _bitmapPool.hasOwnProperty(name);
      }
      
      public function getBitmap(name:String) : BitmapObject
      {
         var bitmap:* = null;
         if(hasBitmap(name))
         {
            bitmap = _bitmapPool[name];
            bitmap.linkCount = Number(bitmap.linkCount) + 1;
            return bitmap;
         }
         bitmap = createBitmap(name);
         bitmap.manager = this;
         bitmap.linkCount = Number(bitmap.linkCount) + 1;
         return bitmap;
      }
      
      private function createBitmap(name:String) : BitmapObject
      {
         var bitmap:* = null;
         var display:* = ComponentFactory.Instance.creat(name);
         if(display is BitmapData)
         {
            bitmap = new BitmapObject(display.width,display.height,true,0);
            bitmap.copyPixels(display,display.rect,destPoint);
            bitmap.linkName = name;
            addBitmap(bitmap);
            return bitmap;
         }
         if(display is Bitmap)
         {
            bitmap = new BitmapObject(display.bitmapData.width,display.bitmapData.height,true,0);
            bitmap.copyPixels(display.bitmapData,display.bitmapData.rect,destPoint);
            bitmap.linkName = name;
            addBitmap(bitmap);
            return bitmap;
         }
         if(display is DisplayObject)
         {
            bitmap = new BitmapObject(display.width,display.height,true,0);
            bitmap.draw(display as IBitmapDrawable);
            bitmap.linkName = name;
            addBitmap(bitmap);
            return bitmap;
         }
         return null;
      }
      
      private function addBitmap(bitmap:BitmapObject) : void
      {
         if(!hasBitmap(bitmap.linkName))
         {
            _len = Number(_len) + 1;
         }
         bitmap.linkCount = 0;
         bitmap.manager = this;
         _bitmapPool[bitmap.linkName] = bitmap;
      }
      
      private function removeBitmap(bitmap:BitmapObject) : void
      {
         if(hasBitmap(bitmap.linkName))
         {
            _len = Number(_len) - 1;
         }
      }
   }
}
