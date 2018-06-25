package starling.utils{   import flash.display.Bitmap;   import flash.display.Loader;   import flash.display.LoaderInfo;   import flash.events.HTTPStatusEvent;   import flash.events.IOErrorEvent;   import flash.events.ProgressEvent;   import flash.events.SecurityErrorEvent;   import flash.media.Sound;   import flash.media.SoundChannel;   import flash.media.SoundTransform;   import flash.net.FileReference;   import flash.net.URLLoader;   import flash.net.URLRequest;   import flash.system.LoaderContext;   import flash.system.System;   import flash.utils.ByteArray;   import flash.utils.Dictionary;   import flash.utils.describeType;   import flash.utils.getQualifiedClassName;   import flash.utils.setTimeout;   import starling.core.Starling;   import starling.events.EventDispatcher;   import starling.text.BitmapFont;   import starling.text.TextField;   import starling.textures.AtfData;   import starling.textures.Texture;   import starling.textures.TextureAtlas;   import starling.textures.TextureOptions;      [Event(name="texturesRestored",type="starling.events.Event")]   [Event(name="ioError",type="starling.events.Event")]   [Event(name="securityError",type="starling.events.Event")]   [Event(name="parseError",type="starling.events.Event")]   public class AssetManager extends EventDispatcher   {            private static const HTTP_RESPONSE_STATUS:String = "httpResponseStatus";            private static var sNames:Vector.<String> = new Vector.<String>(0);            private static const NAME_REGEX:RegExp = /([^\?\/\\]+?)(?:\.([\w\-]+))?(?:\?.*)?$/;                   private var mStarling:Starling;            private var mNumLostTextures:int;            private var mNumRestoredTextures:int;            private var mNumLoadingQueues:int;            private var mDefaultTextureOptions:TextureOptions;            private var mCheckPolicyFile:Boolean;            private var mKeepAtlasXmls:Boolean;            private var mKeepFontXmls:Boolean;            private var mNumConnections:int;            private var mVerbose:Boolean;            private var mQueue:Array;            private var mTextures:Dictionary;            private var mAtlases:Dictionary;            private var mSounds:Dictionary;            private var mXmls:Dictionary;            private var mObjects:Dictionary;            private var mByteArrays:Dictionary;            public function AssetManager(scaleFactor:Number = 1, useMipmaps:Boolean = false) { super(); }
            public function dispose() : void { }
            public function getTexture(name:String) : Texture { return null; }
            public function getTextures(prefix:String = "", result:Vector.<Texture> = null) : Vector.<Texture> { return null; }
            public function getTextureNames(prefix:String = "", result:Vector.<String> = null) : Vector.<String> { return null; }
            public function getTextureAtlas(name:String) : TextureAtlas { return null; }
            public function getSound(name:String) : Sound { return null; }
            public function getSoundNames(prefix:String = "", result:Vector.<String> = null) : Vector.<String> { return null; }
            public function playSound(name:String, startTime:Number = 0, loops:int = 0, transform:SoundTransform = null) : SoundChannel { return null; }
            public function getXml(name:String) : XML { return null; }
            public function getXmlNames(prefix:String = "", result:Vector.<String> = null) : Vector.<String> { return null; }
            public function getObject(name:String) : Object { return null; }
            public function getObjectNames(prefix:String = "", result:Vector.<String> = null) : Vector.<String> { return null; }
            public function getByteArray(name:String) : ByteArray { return null; }
            public function getByteArrayNames(prefix:String = "", result:Vector.<String> = null) : Vector.<String> { return null; }
            public function addTexture(name:String, texture:Texture) : void { }
            public function addTextureAtlas(name:String, atlas:TextureAtlas) : void { }
            public function addSound(name:String, sound:Sound) : void { }
            public function addXml(name:String, xml:XML) : void { }
            public function addObject(name:String, object:Object) : void { }
            public function addByteArray(name:String, byteArray:ByteArray) : void { }
            public function removeTexture(name:String, dispose:Boolean = true) : void { }
            public function removeTextureAtlas(name:String, dispose:Boolean = true) : void { }
            public function removeSound(name:String) : void { }
            public function removeXml(name:String, dispose:Boolean = true) : void { }
            public function removeObject(name:String) : void { }
            public function removeByteArray(name:String, dispose:Boolean = true) : void { }
            public function purgeQueue() : void { }
            public function purge() : void { }
            public function enqueue(... rawAssets) : void { }
            public function enqueueWithName(asset:Object, name:String = null, options:TextureOptions = null) : String { return null; }
            public function loadQueue(onProgress:Function) : void { }
            private function processRawAsset(name:String, rawAsset:Object, options:TextureOptions, xmls:Vector.<XML>, onProgress:Function, onComplete:Function) : void { }
            protected function loadRawAsset(rawAsset:Object, onProgress:Function, onComplete:Function) : void { }
            protected function getName(rawAsset:Object) : String { return null; }
            protected function transformData(data:ByteArray, url:String) : ByteArray { return null; }
            protected function log(message:String) : void { }
            private function byteArrayStartsWith(bytes:ByteArray, char:String) : Boolean { return false; }
            private function getDictionaryKeys(dictionary:Dictionary, prefix:String = "", result:Vector.<String> = null) : Vector.<String> { return null; }
            private function getHttpHeader(headers:Array, headerName:String) : String { return null; }
            protected function getBasenameFromUrl(url:String) : String { return null; }
            protected function getExtensionFromUrl(url:String) : String { return null; }
            private function prependCallback(oldCallback:Function, newCallback:Function) : Function { return null; }
            protected function get queue() : Array { return null; }
            public function get numQueuedAssets() : int { return 0; }
            public function get verbose() : Boolean { return false; }
            public function set verbose(value:Boolean) : void { }
            public function get isLoading() : Boolean { return false; }
            public function get useMipMaps() : Boolean { return false; }
            public function set useMipMaps(value:Boolean) : void { }
            public function get textureRepeat() : Boolean { return false; }
            public function set textureRepeat(value:Boolean) : void { }
            public function get scaleFactor() : Number { return 0; }
            public function set scaleFactor(value:Number) : void { }
            public function get textureFormat() : String { return null; }
            public function set textureFormat(value:String) : void { }
            public function get checkPolicyFile() : Boolean { return false; }
            public function set checkPolicyFile(value:Boolean) : void { }
            public function get keepAtlasXmls() : Boolean { return false; }
            public function set keepAtlasXmls(value:Boolean) : void { }
            public function get keepFontXmls() : Boolean { return false; }
            public function set keepFontXmls(value:Boolean) : void { }
            public function get numConnections() : int { return 0; }
            public function set numConnections(value:int) : void { }
            public function get atlases() : Dictionary { return null; }
   }}