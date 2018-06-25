package com.pickgliss.loader{   import cmodule.decry.CLibInit;   import com.crypto.NewCrypto;   import com.pickgliss.ui.ComponentSetting;   import flash.events.Event;   import flash.external.ExternalInterface;   import flash.system.ApplicationDomain;   import flash.system.LoaderContext;   import flash.utils.ByteArray;   import flash.utils.getDefinitionByName;   import flash.utils.getTimer;      public class ModuleLoader extends DisplayLoader   {            private static var loader:CLibInit = new CLibInit();                   private var _isEqual:Boolean;            private var _name:String;            private var _isSecondLoad:Boolean = false;            public function ModuleLoader(id:int, url:String, domain:ApplicationDomain) { super(null,null); }
            public static function decry(src:ByteArray) : ByteArray { return null; }
            public static function getDefinition(classname:String) : * { return null; }
            public static function hasDefinition(classname:String) : Boolean { return false; }
            override public function loadFromBytes(data:ByteArray) : void { }
            override protected function __onDataLoadComplete(event:Event) : void { }
            public function analyMd5(content:ByteArray) : void { }
            private function reload() : void { }
            private function getName() : String { return null; }
            private function compareMD5(temp:ByteArray, fileName:String) : Boolean { return false; }
            private function hasHead(temp:ByteArray) : Boolean { return false; }
            private function handleModule(temp:ByteArray) : void { }
            override public function get type() : int { return 0; }
   }}