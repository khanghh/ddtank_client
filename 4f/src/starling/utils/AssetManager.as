package starling.utils
{
   import flash.display.Bitmap;
   import flash.display.Loader;
   import flash.display.LoaderInfo;
   import flash.events.HTTPStatusEvent;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   import flash.events.SecurityErrorEvent;
   import flash.media.Sound;
   import flash.media.SoundChannel;
   import flash.media.SoundTransform;
   import flash.net.FileReference;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.system.LoaderContext;
   import flash.system.System;
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   import flash.utils.describeType;
   import flash.utils.getQualifiedClassName;
   import flash.utils.setTimeout;
   import starling.core.Starling;
   import starling.events.EventDispatcher;
   import starling.text.BitmapFont;
   import starling.text.TextField;
   import starling.textures.AtfData;
   import starling.textures.Texture;
   import starling.textures.TextureAtlas;
   import starling.textures.TextureOptions;
   
   [Event(name="texturesRestored",type="starling.events.Event")]
   [Event(name="ioError",type="starling.events.Event")]
   [Event(name="securityError",type="starling.events.Event")]
   [Event(name="parseError",type="starling.events.Event")]
   public class AssetManager extends EventDispatcher
   {
      
      private static const HTTP_RESPONSE_STATUS:String = "httpResponseStatus";
      
      private static var sNames:Vector.<String> = new Vector.<String>(0);
      
      private static const NAME_REGEX:RegExp = /([^\?\/\\]+?)(?:\.([\w\-]+))?(?:\?.*)?$/;
       
      
      private var mStarling:Starling;
      
      private var mNumLostTextures:int;
      
      private var mNumRestoredTextures:int;
      
      private var mNumLoadingQueues:int;
      
      private var mDefaultTextureOptions:TextureOptions;
      
      private var mCheckPolicyFile:Boolean;
      
      private var mKeepAtlasXmls:Boolean;
      
      private var mKeepFontXmls:Boolean;
      
      private var mNumConnections:int;
      
      private var mVerbose:Boolean;
      
      private var mQueue:Array;
      
      private var mTextures:Dictionary;
      
      private var mAtlases:Dictionary;
      
      private var mSounds:Dictionary;
      
      private var mXmls:Dictionary;
      
      private var mObjects:Dictionary;
      
      private var mByteArrays:Dictionary;
      
      public function AssetManager(param1:Number = 1, param2:Boolean = false){super();}
      
      public function dispose() : void{}
      
      public function getTexture(param1:String) : Texture{return null;}
      
      public function getTextures(param1:String = "", param2:Vector.<Texture> = null) : Vector.<Texture>{return null;}
      
      public function getTextureNames(param1:String = "", param2:Vector.<String> = null) : Vector.<String>{return null;}
      
      public function getTextureAtlas(param1:String) : TextureAtlas{return null;}
      
      public function getSound(param1:String) : Sound{return null;}
      
      public function getSoundNames(param1:String = "", param2:Vector.<String> = null) : Vector.<String>{return null;}
      
      public function playSound(param1:String, param2:Number = 0, param3:int = 0, param4:SoundTransform = null) : SoundChannel{return null;}
      
      public function getXml(param1:String) : XML{return null;}
      
      public function getXmlNames(param1:String = "", param2:Vector.<String> = null) : Vector.<String>{return null;}
      
      public function getObject(param1:String) : Object{return null;}
      
      public function getObjectNames(param1:String = "", param2:Vector.<String> = null) : Vector.<String>{return null;}
      
      public function getByteArray(param1:String) : ByteArray{return null;}
      
      public function getByteArrayNames(param1:String = "", param2:Vector.<String> = null) : Vector.<String>{return null;}
      
      public function addTexture(param1:String, param2:Texture) : void{}
      
      public function addTextureAtlas(param1:String, param2:TextureAtlas) : void{}
      
      public function addSound(param1:String, param2:Sound) : void{}
      
      public function addXml(param1:String, param2:XML) : void{}
      
      public function addObject(param1:String, param2:Object) : void{}
      
      public function addByteArray(param1:String, param2:ByteArray) : void{}
      
      public function removeTexture(param1:String, param2:Boolean = true) : void{}
      
      public function removeTextureAtlas(param1:String, param2:Boolean = true) : void{}
      
      public function removeSound(param1:String) : void{}
      
      public function removeXml(param1:String, param2:Boolean = true) : void{}
      
      public function removeObject(param1:String) : void{}
      
      public function removeByteArray(param1:String, param2:Boolean = true) : void{}
      
      public function purgeQueue() : void{}
      
      public function purge() : void{}
      
      public function enqueue(... rest) : void{}
      
      public function enqueueWithName(param1:Object, param2:String = null, param3:TextureOptions = null) : String{return null;}
      
      public function loadQueue(param1:Function) : void{}
      
      private function processRawAsset(param1:String, param2:Object, param3:TextureOptions, param4:Vector.<XML>, param5:Function, param6:Function) : void{}
      
      protected function loadRawAsset(param1:Object, param2:Function, param3:Function) : void{}
      
      protected function getName(param1:Object) : String{return null;}
      
      protected function transformData(param1:ByteArray, param2:String) : ByteArray{return null;}
      
      protected function log(param1:String) : void{}
      
      private function byteArrayStartsWith(param1:ByteArray, param2:String) : Boolean{return false;}
      
      private function getDictionaryKeys(param1:Dictionary, param2:String = "", param3:Vector.<String> = null) : Vector.<String>{return null;}
      
      private function getHttpHeader(param1:Array, param2:String) : String{return null;}
      
      protected function getBasenameFromUrl(param1:String) : String{return null;}
      
      protected function getExtensionFromUrl(param1:String) : String{return null;}
      
      private function prependCallback(param1:Function, param2:Function) : Function{return null;}
      
      protected function get queue() : Array{return null;}
      
      public function get numQueuedAssets() : int{return 0;}
      
      public function get verbose() : Boolean{return false;}
      
      public function set verbose(param1:Boolean) : void{}
      
      public function get isLoading() : Boolean{return false;}
      
      public function get useMipMaps() : Boolean{return false;}
      
      public function set useMipMaps(param1:Boolean) : void{}
      
      public function get textureRepeat() : Boolean{return false;}
      
      public function set textureRepeat(param1:Boolean) : void{}
      
      public function get scaleFactor() : Number{return 0;}
      
      public function set scaleFactor(param1:Number) : void{}
      
      public function get textureFormat() : String{return null;}
      
      public function set textureFormat(param1:String) : void{}
      
      public function get checkPolicyFile() : Boolean{return false;}
      
      public function set checkPolicyFile(param1:Boolean) : void{}
      
      public function get keepAtlasXmls() : Boolean{return false;}
      
      public function set keepAtlasXmls(param1:Boolean) : void{}
      
      public function get keepFontXmls() : Boolean{return false;}
      
      public function set keepFontXmls(param1:Boolean) : void{}
      
      public function get numConnections() : int{return 0;}
      
      public function set numConnections(param1:int) : void{}
      
      public function get atlases() : Dictionary{return null;}
   }
}
