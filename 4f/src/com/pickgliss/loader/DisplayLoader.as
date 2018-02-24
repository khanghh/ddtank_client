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
      
      public function DisplayLoader(param1:int, param2:String){super(null,null,null);}
      
      override public function loadFromBytes(param1:ByteArray) : void{}
      
      protected function __onDisplayIoError(param1:IOErrorEvent) : void{}
      
      protected function __onContentLoadComplete(param1:Event) : void{}
      
      override protected function __onDataLoadComplete(param1:Event) : void{}
      
      override public function get content() : *{return null;}
      
      override protected function getLoadDataFormat() : String{return null;}
      
      override public function get type() : int{return 0;}
   }
}
