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
      
      public function BitmapLoader(id:int, url:String)
      {
         super(id,url);
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
      
      override protected function __onContentLoadComplete(event:Event) : void
      {
         _sourceBitmap = _displayLoader.content as Bitmap;
         super.__onContentLoadComplete(event);
      }
      
      override public function loadFromBytes(data:ByteArray) : void
      {
         var temp:* = null;
         if(NewCrypto.isEncryed(data))
         {
            _displayLoader.contentLoaderInfo.addEventListener("complete",__onContentLoadComplete);
            _displayLoader.contentLoaderInfo.addEventListener("ioError",__onDisplayIoError);
            temp = NewCrypto.decry(data);
            if(domain != null)
            {
               _displayLoader.loadBytes(temp,new LoaderContext(false,domain));
            }
            else
            {
               _displayLoader.loadBytes(temp,Context);
            }
         }
         else
         {
            super.loadFromBytes(data);
         }
      }
      
      override public function get type() : int
      {
         return 0;
      }
   }
}
