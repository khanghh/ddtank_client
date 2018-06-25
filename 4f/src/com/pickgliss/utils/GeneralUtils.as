package com.pickgliss.utils{   import org.as3commons.reflect.Accessor;   import org.as3commons.reflect.Field;   import org.as3commons.reflect.Type;   import org.as3commons.reflect.Variable;      public class GeneralUtils   {                   public function GeneralUtils() { super(); }
            public static function cloneObject(_obj:*) : * { return null; }
            public static function serializeObject(_obj:*) : Object { return null; }
            public static function deserializeObject(_obj:Object) : * { return null; }
            private static function doDeserializeObject(_transportLayerData:Object) : * { return null; }
            private static function doDeserializeProperty(_sourceProperty:*, _currentField:Field) : * { return null; }
            private static function doSerializeObject(_normalObj:*, _isClone:Boolean, _objType:Type = null) : Object { return null; }
            private static function doSerializeProperty(_sourceProperty:*, _isClone:Boolean, _currentField:Field) : * { return null; }
   }}