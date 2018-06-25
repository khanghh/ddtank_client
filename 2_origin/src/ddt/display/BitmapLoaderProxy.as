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
      
      public function BitmapLoaderProxy(url:String, size:Rectangle = null, isSmoothing:Boolean = false)
      {
         super();
         _size = size;
         _isSmoothing = isSmoothing;
         _loader = LoadResourceManager.Instance.createLoader(url,0);
         _loader.addEventListener("complete",onComplete);
         LoadResourceManager.Instance.startLoad(_loader);
      }
      
      private function onComplete(event:LoaderEvent) : void
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
      
      private function __onEnterFrame(e:Event) : void
      {
         var armMaxFrame:int = _bitmap.width / 250 - 1;
         if(_frame >= armMaxFrame * 3)
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
      
      private function createRectList(row:int, line:int = 1) : void
      {
         var j:int = 0;
         var i:int = 0;
         var m:* = null;
         _rectList = [];
         for(j = 0; j < line; )
         {
            for(i = 0; i < row; )
            {
               m = new Rectangle(i * 250,j * 342,250,342);
               _rectList.push(m);
               i++;
            }
            j++;
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
