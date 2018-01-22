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
      
      public static function hasMgr(param1:String) : Boolean
      {
         return _mgrPool.hasOwnProperty(param1);
      }
      
      private static function registerMgr(param1:String, param2:BitmapManager) : void
      {
         _mgrPool[param1] = param2;
      }
      
      private static function removeMgr(param1:String) : void
      {
         if(hasMgr(param1))
         {
            delete _mgrPool[param1];
         }
      }
      
      public static function getBitmapMgr(param1:String) : BitmapManager
      {
         var _loc2_:* = null;
         if(hasMgr(param1))
         {
            _loc2_ = _mgrPool[param1];
            _loc2_.linkCount = Number(_loc2_.linkCount) + 1;
            return _loc2_;
         }
         _loc2_ = new BitmapManager();
         _loc2_.name = param1;
         _loc2_.linkCount = Number(_loc2_.linkCount) + 1;
         registerMgr(param1,_loc2_);
         return _loc2_;
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
         var _loc1_:* = null;
         removeMgr(name);
         var _loc4_:int = 0;
         var _loc3_:* = _bitmapPool;
         for(var _loc2_ in _bitmapPool)
         {
            _loc1_ = _bitmapPool[_loc2_];
            _loc1_.destory();
            delete _bitmapPool[_loc2_];
         }
         _bitmapPool = null;
      }
      
      public function creatBitmapShape(param1:String, param2:Matrix = null, param3:Boolean = true, param4:Boolean = false) : BitmapShape
      {
         return new BitmapShape(getBitmap(param1),param2,param3,param4);
      }
      
      public function hasBitmap(param1:String) : Boolean
      {
         return _bitmapPool.hasOwnProperty(param1);
      }
      
      public function getBitmap(param1:String) : BitmapObject
      {
         var _loc2_:* = null;
         if(hasBitmap(param1))
         {
            _loc2_ = _bitmapPool[param1];
            _loc2_.linkCount = Number(_loc2_.linkCount) + 1;
            return _loc2_;
         }
         _loc2_ = createBitmap(param1);
         _loc2_.manager = this;
         _loc2_.linkCount = Number(_loc2_.linkCount) + 1;
         return _loc2_;
      }
      
      private function createBitmap(param1:String) : BitmapObject
      {
         var _loc2_:* = null;
         var _loc3_:* = ComponentFactory.Instance.creat(param1);
         if(_loc3_ is BitmapData)
         {
            _loc2_ = new BitmapObject(_loc3_.width,_loc3_.height,true,0);
            _loc2_.copyPixels(_loc3_,_loc3_.rect,destPoint);
            _loc2_.linkName = param1;
            addBitmap(_loc2_);
            return _loc2_;
         }
         if(_loc3_ is Bitmap)
         {
            _loc2_ = new BitmapObject(_loc3_.bitmapData.width,_loc3_.bitmapData.height,true,0);
            _loc2_.copyPixels(_loc3_.bitmapData,_loc3_.bitmapData.rect,destPoint);
            _loc2_.linkName = param1;
            addBitmap(_loc2_);
            return _loc2_;
         }
         if(_loc3_ is DisplayObject)
         {
            _loc2_ = new BitmapObject(_loc3_.width,_loc3_.height,true,0);
            _loc2_.draw(_loc3_ as IBitmapDrawable);
            _loc2_.linkName = param1;
            addBitmap(_loc2_);
            return _loc2_;
         }
         return null;
      }
      
      private function addBitmap(param1:BitmapObject) : void
      {
         if(!hasBitmap(param1.linkName))
         {
            _len = Number(_len) + 1;
         }
         param1.linkCount = 0;
         param1.manager = this;
         _bitmapPool[param1.linkName] = param1;
      }
      
      private function removeBitmap(param1:BitmapObject) : void
      {
         if(hasBitmap(param1.linkName))
         {
            _len = Number(_len) - 1;
         }
      }
   }
}
