package com.pickgliss.loader{   import flash.events.Event;   import flash.net.URLVariables;   import flash.utils.ByteArray;      public class CompressTextLoader extends BaseLoader   {                   private var _deComressedText:String;            public function CompressTextLoader(id:int, url:String, args:URLVariables = null, requestMethod:String = "GET") { super(null,null,null,null); }
            override protected function __onDataLoadComplete(event:Event) : void { }
            override public function get content() : * { return null; }
            override public function get type() : int { return 0; }
   }}