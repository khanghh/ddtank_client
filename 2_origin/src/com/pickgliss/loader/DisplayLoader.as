package com.pickgliss.loader
{
   import com.crypto.NewCrypto;
   import flash.display.Loader;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.system.LoaderContext;
   import flash.utils.ByteArray;
   
   public class DisplayLoader extends BaseLoader
   {
      
      public static var Context:LoaderContext;
      
      public static var isDebug:Boolean = false;
       
      
      protected var _displayLoader:Loader;
      
      public function DisplayLoader(id:int, url:String)
      {
         _displayLoader = new Loader();
         super(id,url,null);
      }
      
      override public function loadFromBytes(data:ByteArray) : void
      {
         var temp:ByteArray = NewCrypto.decry(data);
         super.loadFromBytes(temp);
         if(!_displayLoader)
         {
            return;
         }
         _displayLoader.contentLoaderInfo.addEventListener("complete",__onContentLoadComplete);
         _displayLoader.contentLoaderInfo.addEventListener("ioError",__onDisplayIoError);
         if(type == 4 || type == 8)
         {
            _displayLoader.loadBytes(temp,Context);
         }
         else
         {
            _displayLoader.loadBytes(temp);
         }
      }
      
      protected function __onDisplayIoError(event:IOErrorEvent) : void
      {
         _displayLoader.contentLoaderInfo.removeEventListener("ioError",__onDisplayIoError);
         throw new Error(event.text + " url: " + _url);
      }
      
      protected function __onContentLoadComplete(event:Event) : void
      {
         _displayLoader.contentLoaderInfo.removeEventListener("complete",__onContentLoadComplete);
         _displayLoader.contentLoaderInfo.removeEventListener("ioError",__onDisplayIoError);
         fireCompleteEvent();
         _displayLoader.unload();
         _displayLoader = null;
      }
      
      override protected function __onDataLoadComplete(event:Event) : void
      {
         removeEvent();
         unload();
         if(_loader.data.length == 0)
         {
            return;
         }
         var temp:ByteArray = _loader.data;
         LoaderSavingManager.cacheFile(_url,temp,true);
         loadFromBytes(temp);
      }
      
      override public function get content() : *
      {
         return _displayLoader.content;
      }
      
      override protected function getLoadDataFormat() : String
      {
         return "binary";
      }
      
      override public function get type() : int
      {
         return 1;
      }
   }
}
