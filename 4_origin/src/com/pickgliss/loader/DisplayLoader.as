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
      
      public function DisplayLoader(param1:int, param2:String)
      {
         _displayLoader = new Loader();
         super(param1,param2,null);
      }
      
      override public function loadFromBytes(param1:ByteArray) : void
      {
         var _loc2_:ByteArray = NewCrypto.decry(param1);
         super.loadFromBytes(_loc2_);
         if(!_displayLoader)
         {
            return;
         }
         _displayLoader.contentLoaderInfo.addEventListener("complete",__onContentLoadComplete);
         _displayLoader.contentLoaderInfo.addEventListener("ioError",__onDisplayIoError);
         if(type == 4 || type == 8)
         {
            _displayLoader.loadBytes(_loc2_,Context);
         }
         else
         {
            _displayLoader.loadBytes(_loc2_);
         }
      }
      
      protected function __onDisplayIoError(param1:IOErrorEvent) : void
      {
         _displayLoader.contentLoaderInfo.removeEventListener("ioError",__onDisplayIoError);
         throw new Error(param1.text + " url: " + _url);
      }
      
      protected function __onContentLoadComplete(param1:Event) : void
      {
         _displayLoader.contentLoaderInfo.removeEventListener("complete",__onContentLoadComplete);
         _displayLoader.contentLoaderInfo.removeEventListener("ioError",__onDisplayIoError);
         fireCompleteEvent();
         _displayLoader.unload();
         _displayLoader = null;
      }
      
      override protected function __onDataLoadComplete(param1:Event) : void
      {
         removeEvent();
         unload();
         if(_loader.data.length == 0)
         {
            return;
         }
         var _loc2_:ByteArray = _loader.data;
         LoaderSavingManager.cacheFile(_url,_loc2_,true);
         loadFromBytes(_loc2_);
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
