package ddt.display
{
   import com.pickgliss.loader.BitmapLoader;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.loader.LoaderEvent;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class BitmapLoaderProxy extends Sprite implements Disposeable
   {
      
      public static const LOADING_FINISH:String = "loadingFinish";
       
      
      private var _loader:BitmapLoader;
      
      private var _bitmap:Bitmap;
      
      private var _showBitmap:Bitmap;
      
      private var _size:Rectangle;
      
      private var _isSmoothing:Boolean;
      
      private var _rectList:Array;
      
      private var _rect:Rectangle;
      
      private var _frame:int = 0;
      
      public function BitmapLoaderProxy(param1:String, param2:Rectangle = null, param3:Boolean = false)
      {
         super();
         _size = param2;
         _isSmoothing = param3;
         _loader = LoadResourceManager.Instance.createLoader(param1,0);
         _loader.addEventListener("complete",onComplete);
         LoadResourceManager.Instance.startLoad(_loader);
      }
      
      private function onComplete(param1:LoaderEvent) : void
      {
         if(_loader.isSuccess)
         {
            _bitmap = _loader.content;
            if(_bitmap.width > 250)
            {
               _showBitmap = new Bitmap(new BitmapData(250,342,true,0),"never",true);
               _rect = new Rectangle(0,0,250,342);
               addChild(_showBitmap);
               if(_size)
               {
                  _showBitmap.x = _size.y;
                  _showBitmap.y = _size.y;
                  _showBitmap.width = _size.width;
                  _showBitmap.height = _size.height;
               }
               createRectList(_bitmap.width / 250);
               addEventListener("enterFrame",__onEnterFrame);
            }
            else
            {
               if(_size)
               {
                  _bitmap.x = _size.x;
                  _bitmap.y = _size.y;
                  _bitmap.width = _size.width;
                  _bitmap.height = _size.height;
               }
               addChild(_bitmap);
               _bitmap.smoothing = _isSmoothing;
            }
            dispatchEvent(new Event("loadingFinish"));
         }
      }
      
      private function __onEnterFrame(param1:Event) : void
      {
         var _loc2_:int = _bitmap.width / 250 - 1;
         if(_frame >= _loc2_ * 3)
         {
            _frame = 0;
         }
         else
         {
            _frame = Number(_frame) + 1;
         }
         _showBitmap.bitmapData.fillRect(_rect,0);
         _showBitmap.bitmapData.copyPixels(_bitmap.bitmapData,_rectList[int(_frame / 3)],new Point(0,0),null,null,true);
      }
      
      private function createRectList(param1:int, param2:int = 1) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc3_:* = null;
         _rectList = [];
         _loc4_ = 0;
         while(_loc4_ < param2)
         {
            _loc5_ = 0;
            while(_loc5_ < param1)
            {
               _loc3_ = new Rectangle(_loc5_ * 250,_loc4_ * 342,250,342);
               _rectList.push(_loc3_);
               _loc5_++;
            }
            _loc4_++;
         }
      }
      
      public function dispose() : void
      {
         removeEventListener("enterFrame",__onEnterFrame);
         _loader.removeEventListener("complete",onComplete);
         _loader = null;
         ObjectUtils.disposeObject(_bitmap);
         _bitmap = null;
         ObjectUtils.disposeObject(_showBitmap);
         _showBitmap = null;
         if(_rectList)
         {
            _rectList.splice(0,_rectList.length);
         }
         _rectList = null;
         _rect = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
