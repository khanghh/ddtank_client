package com.pickgliss.loader
{
   import com.crypto.NewCrypto;
   import flash.events.Event;
   import flash.net.URLVariables;
   import flash.utils.ByteArray;
   import flash.utils.getTimer;
   
   public class BonesLoader extends BaseLoader
   {
       
      
      public function BonesLoader(param1:int, param2:String, param3:URLVariables = null, param4:String = "GET")
      {
         super(param1,param2,param3,param4);
      }
      
      override public function loadFromBytes(param1:ByteArray) : void
      {
         _starTime = getTimer();
         _loader.data = NewCrypto.decry(param1);
         fireCompleteEvent();
         unload();
      }
      
      override protected function __onDataLoadComplete(param1:Event) : void
      {
         super.__onDataLoadComplete(param1);
         if(_loader.data.length > 0)
         {
            LoaderSavingManager.cacheFile(_url,_loader.data,true);
         }
      }
   }
}
