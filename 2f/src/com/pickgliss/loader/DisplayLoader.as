package com.pickgliss.loader{   import com.crypto.NewCrypto;   import flash.display.Loader;   import flash.events.Event;   import flash.events.IOErrorEvent;   import flash.system.LoaderContext;   import flash.utils.ByteArray;      public class DisplayLoader extends BaseLoader   {            public static var Context:LoaderContext;            public static var isDebug:Boolean = false;                   protected var _displayLoader:Loader;            public function DisplayLoader(id:int, url:String) { super(null,null,null); }
            override public function loadFromBytes(data:ByteArray) : void { }
            protected function __onDisplayIoError(event:IOErrorEvent) : void { }
            protected function __onContentLoadComplete(event:Event) : void { }
            override protected function __onDataLoadComplete(event:Event) : void { }
            override public function get content() : * { return null; }
            override protected function getLoadDataFormat() : String { return null; }
            override public function get type() : int { return 0; }
   }}