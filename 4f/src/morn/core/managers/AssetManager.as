package morn.core.managers{   import flash.display.BitmapData;   import flash.system.ApplicationDomain;   import morn.core.utils.BitmapUtils;      public class AssetManager   {                   private var _bmdMap:Object;            private var _clipsMap:Object;            private var _domain:ApplicationDomain;            public function AssetManager() { super(); }
            public function setDomain(domain:ApplicationDomain) : void { }
            public function hasClass(name:String) : Boolean { return false; }
            public function getClass(name:String) : Class { return null; }
            public function getAsset(name:String) : * { return null; }
            public function getBitmapData(name:String, cache:Boolean = false) : BitmapData { return null; }
            public function getClips(name:String, xNum:int, yNum:int, cache:Boolean = false, source:BitmapData = null) : Vector.<BitmapData> { return null; }
            public function cacheBitmapData(name:String, bmd:BitmapData) : void { }
            public function disposeBitmapData(name:String) : void { }
            public function cacheClips(name:String, clips:Vector.<BitmapData>) : void { }
            public function destroyClips(name:String) : void { }
   }}