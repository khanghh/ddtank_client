package com.pickgliss.utils{   import com.pickgliss.ui.core.Disposeable;   import flash.display.Bitmap;   import flash.display.BitmapData;   import flash.display.DisplayObject;   import flash.display.DisplayObjectContainer;   import flash.geom.Rectangle;   import flash.utils.ByteArray;   import flash.utils.Dictionary;   import flash.utils.describeType;   import flash.utils.getQualifiedClassName;      public final class ObjectUtils   {            private static var _copyAbleTypes:Vector.<String>;            private static var _descriptOjbXMLs:Dictionary;                   public function ObjectUtils() { super(); }
            public static function cloneSimpleObject(obj:Object) : Object { return null; }
            public static function copyPorpertiesByXML(object:Object, data:XML) : void { }
            public static function copyProperties(dest:Object, orig:Object) : void { }
            public static function disposeAllChildren(container:DisplayObjectContainer) : void { }
            public static function removeChildAllChildren(container:DisplayObjectContainer) : void { }
            public static function disposeObject(target:Object) : void { }
            private static function getCopyAbleType() : Vector.<String> { return null; }
            public static function describeTypeSave(obj:Object) : XML { return null; }
            public static function encode(node:String, object:Object) : XML { return null; }
            private static function encodingProperty(name:String, value:Object) : String { return null; }
            private static function escapeString(str:String) : String { return null; }
            public static function modifyVisibility(value:Boolean, ... args) : void { }
            public static function copyPropertyByRectangle(source:DisplayObject, rt:Rectangle) : void { }
            public static function combineXML(result:XML, data:XML) : void { }
            public static function getDisplayObjectSuperParent(dis:*, containterClazz:Class, stage:*) : * { return null; }
            public static function getDisplayObjectSuperParentByName(dis:*, qualifiedClassName:String, stage:*) : * { return null; }
   }}