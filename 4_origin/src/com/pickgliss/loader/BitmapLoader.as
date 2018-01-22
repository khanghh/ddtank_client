package com.pickgliss.loader
{
   import com.crypto.NewCrypto;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.events.Event;
   import flash.system.LoaderContext;
   import flash.utils.ByteArray;
   
   public class BitmapLoader extends DisplayLoader
   {
      
      private static const InvalidateBitmapDataID:int = 2015;
       
      
      private var _sourceBitmap:Bitmap;
      
      public function BitmapLoader(param1:int, param2:String)
      {
         super(param1,param2);
      }
      
      override public function get content() : *
      {
         if(_sourceBitmap == null)
         {
            return null;
         }
         return _sourceBitmap;
      }
      
      public function get bitmapData() : BitmapData
      {
         if(_sourceBitmap)
         {
            return _sourceBitmap.bitmapData;
         }
         return null;
      }
      
      override protected function __onContentLoadComplete(param1:Event) : void
      {
         _sourceBitmap = _displayLoader.content as Bitmap;
         super.__onContentLoadComplete(param1);
      }
      
      override public function loadFromBytes(param1:ByteArray) : void
      {
         var _loc2_:* = null;
         if(NewCrypto.isEncryed(param1))
         {
            _displayLoader.contentLoaderInfo.addEventListener("complete",__onContentLoadComplete);
            _displayLoader.contentLoaderInfo.addEventListener("ioError",__onDisplayIoError);
            _loc2_ = NewCrypto.decry(param1);
            if(domain != null)
            {
               _displayLoader.loadBytes(_loc2_,new LoaderContext(false,domain));
            }
            else
            {
               _displayLoader.loadBytes(_loc2_,Context);
            }
         }
         else
         {
            super.loadFromBytes(param1);
         }
      }
      
      override public function get type() : int
      {
         return 0;
      }
   }
}
