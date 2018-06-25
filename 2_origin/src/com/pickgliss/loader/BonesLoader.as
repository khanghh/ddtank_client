package com.pickgliss.loader
{
   import com.crypto.NewCrypto;
   import flash.events.Event;
   import flash.net.URLVariables;
   import flash.utils.ByteArray;
   import flash.utils.getTimer;
   
   public class BonesLoader extends BaseLoader
   {
       
      
      public function BonesLoader(id:int, url:String, args:URLVariables = null, requestMethod:String = "GET")
      {
         super(id,url,args,requestMethod);
      }
      
      override public function loadFromBytes(data:ByteArray) : void
      {
         _starTime = getTimer();
         _loader.data = NewCrypto.decry(data);
         fireCompleteEvent();
         unload();
      }
      
      override protected function __onDataLoadComplete(event:Event) : void
      {
         super.__onDataLoadComplete(event);
         if(_loader.data.length > 0)
         {
            LoaderSavingManager.cacheFile(_url,_loader.data,true);
         }
      }
   }
}
