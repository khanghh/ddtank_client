package com.pickgliss.loader{   import flash.events.Event;   import flash.net.URLVariables;      public class TextLoader extends BaseLoader   {            public static var TextLoaderKey:String;                   public function TextLoader(id:int, url:String, args:URLVariables = null, requestMethod:String = "GET") { super(null,null,null,null); }
            override public function get content() : * { return null; }
            override protected function __onDataLoadComplete(event:Event) : void { }
            override protected function getLoadDataFormat() : String { return null; }
            override public function get type() : int { return 0; }
   }}