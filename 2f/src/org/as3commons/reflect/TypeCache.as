package org.as3commons.reflect{   import flash.system.ApplicationDomain;   import flash.utils.Dictionary;   import org.as3commons.lang.Assert;      public class TypeCache   {                   protected var cache:Dictionary;            public function TypeCache() { super(); }
            public function clear(applicationDomain:ApplicationDomain = null) : void { }
            public function contains(key:String, applicationDomain:ApplicationDomain) : Boolean { return false; }
            public function getKeys(applicationDomain:ApplicationDomain) : Array { return null; }
            public function get(key:String, applicationDomain:ApplicationDomain) : Type { return null; }
            public function put(key:String, type:Type, applicationDomain:ApplicationDomain) : void { }
            public function size(applicationDomain:ApplicationDomain) : int { return 0; }
   }}