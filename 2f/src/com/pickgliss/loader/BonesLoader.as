package com.pickgliss.loader
{
   import com.crypto.NewCrypto;
   import flash.events.Event;
   import flash.net.URLVariables;
   import flash.utils.ByteArray;
   import flash.utils.getTimer;
   
   public class BonesLoader extends BaseLoader
   {
       
      
      public function BonesLoader(param1:int, param2:String, param3:URLVariables = null, param4:String = "GET"){super(null,null,null,null);}
      
      override public function loadFromBytes(param1:ByteArray) : void{}
      
      override protected function __onDataLoadComplete(param1:Event) : void{}
   }
}
