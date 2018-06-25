package com.pickgliss.loader{   import com.crypto.NewCrypto;   import flash.events.Event;   import flash.net.URLVariables;   import flash.utils.ByteArray;   import flash.utils.getTimer;      public class BonesLoader extends BaseLoader   {                   public function BonesLoader(id:int, url:String, args:URLVariables = null, requestMethod:String = "GET") { super(null,null,null,null); }
            override public function loadFromBytes(data:ByteArray) : void { }
            override protected function __onDataLoadComplete(event:Event) : void { }
   }}