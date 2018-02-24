package com.pickgliss.loader
{
   import flash.display.Shape;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.NetStatusEvent;
   import flash.net.SharedObject;
   import flash.utils.ByteArray;
   import flash.utils.Timer;
   import flash.utils.getTimer;
   
   public class LoaderSavingManager extends EventDispatcher
   {
      
      private static const LOCAL_FILE:String = "7road/files";
      
      private static var _cacheFile:Boolean = false;
      
      private static var _version:int;
      
      private static var _files:Object;
      
      private static var _saveTimer:Timer;
      
      private static var _so:SharedObject;
      
      private static var _changed:Boolean;
      
      private static var _save:Array;
      
      private static const READ_ERROR_ID:int = 2030;
      
      public static var eventDispatcher:EventDispatcher = new EventDispatcher();
      
      public static var ReadShareError:Boolean = false;
      
      private static const _reg1:RegExp = /http:\/\/[\w|.|:]+\//i;
      
      private static const _reg2:RegExp = /[:|.|\/]/g;
      
      private static var _isSaving:Boolean = false;
      
      private static var _shape:Shape = new Shape();
      
      private static var _retryCount:int = 0;
       
      
      public function LoaderSavingManager(){super();}
      
      public static function get Version() : int{return 0;}
      
      public static function set Version(param1:int) : void{}
      
      public static function set cacheAble(param1:Boolean) : void{}
      
      public static function get cacheAble() : Boolean{return false;}
      
      public static function setup() : void{}
      
      public static function applyUpdate(param1:int, param2:int, param3:Array) : void{}
      
      public static function clearFiles(param1:String) : void{}
      
      public static function loadFilesInLocal() : void{}
      
      public static function resetErrorVersion() : void{}
      
      private static function getPath(param1:String) : String{return null;}
      
      public static function saveFilesToLocal() : void{}
      
      private static function save(param1:Event) : void{}
      
      private static function hasUpdate(param1:String, param2:Array) : Boolean{return false;}
      
      public static function loadCachedFile(param1:String, param2:Boolean) : ByteArray{return null;}
      
      private static function findInSave(param1:String) : ByteArray{return null;}
      
      public static function cacheFile(param1:String, param2:ByteArray, param3:Boolean) : void{}
      
      private static function __netStatus(param1:NetStatusEvent) : void{}
      
      public static function updateList(param1:XMLList) : void{}
      
      protected static function __deleteComplete(param1:Event) : void{}
      
      public static function parseUpdate(param1:XML) : void{}
      
      public static function get hasFileToSave() : Boolean{return false;}
      
      public static function clearAllCache() : void{}
   }
}
