package com.pickgliss.utils
{
   import com.pickgliss.ui.core.Disposeable;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.geom.Rectangle;
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   import flash.utils.describeType;
   import flash.utils.getQualifiedClassName;
   
   public final class ObjectUtils
   {
      
      private static var _copyAbleTypes:Vector.<String>;
      
      private static var _descriptOjbXMLs:Dictionary;
       
      
      public function ObjectUtils(){super();}
      
      public static function cloneSimpleObject(param1:Object) : Object{return null;}
      
      public static function copyPorpertiesByXML(param1:Object, param2:XML) : void{}
      
      public static function copyProperties(param1:Object, param2:Object) : void{}
      
      public static function disposeAllChildren(param1:DisplayObjectContainer) : void{}
      
      public static function removeChildAllChildren(param1:DisplayObjectContainer) : void{}
      
      public static function disposeObject(param1:Object) : void{}
      
      private static function getCopyAbleType() : Vector.<String>{return null;}
      
      public static function describeTypeSave(param1:Object) : XML{return null;}
      
      public static function encode(param1:String, param2:Object) : XML{return null;}
      
      private static function encodingProperty(param1:String, param2:Object) : String{return null;}
      
      private static function escapeString(param1:String) : String{return null;}
      
      public static function modifyVisibility(param1:Boolean, ... rest) : void{}
      
      public static function copyPropertyByRectangle(param1:DisplayObject, param2:Rectangle) : void{}
      
      public static function combineXML(param1:XML, param2:XML) : void{}
      
      public static function getDisplayObjectSuperParent(param1:*, param2:Class, param3:*) : *{return null;}
      
      public static function getDisplayObjectSuperParentByName(param1:*, param2:String, param3:*) : *{return null;}
   }
}
