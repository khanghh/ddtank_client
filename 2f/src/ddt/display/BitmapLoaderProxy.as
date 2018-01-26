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
      
      public function BitmapLoaderProxy(param1:String, param2:Rectangle = null, param3:Boolean = false){super();}
      
      private function onComplete(param1:LoaderEvent) : void{}
      
      private function __onEnterFrame(param1:Event) : void{}
      
      private function createRectList(param1:int, param2:int = 1) : void{}
      
      public function dispose() : void{}
   }
}
