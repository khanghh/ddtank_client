package starling.loader
{
   import com.pickgliss.loader.BaseLoader;
   import com.pickgliss.loader.BitmapLoader;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.loader.LoaderEvent;
   import com.pickgliss.loader.QueueLoader;
   import com.pickgliss.loader.TextLoader;
   import dragonBones.textures.NativeTextureAtlas;
   import flash.display.BitmapData;
   import flash.events.Event;
   import flash.system.System;
   import road7th.DDTAssetManager;
   import starling.core.Starling;
   import starling.textures.Texture;
   import starling.textures.TextureAtlas;
   
   public class StarlingQueueLoader
   {
      
      public static const NAME_REGEX:RegExp = /([^\?\/\\]+?)(?:\.([\w\-]+))?(?:\?.*)?$/;
       
      
      private var _assetArr:Array;
      
      private var _module:String;
      
      private var _queueLoader:QueueLoader;
      
      private var _onComplete:Function;
      
      public function StarlingQueueLoader()
      {
         super();
      }
      
      public function load(assetArr:Array, onComplete:Function, module:String = "none") : void
      {
         var matches:* = null;
         var extension:* = null;
         var loaderType:int = 0;
         var loader:* = null;
         _assetArr = assetArr.concat();
         _onComplete = onComplete;
         _module = module;
         _queueLoader = new QueueLoader();
         var _loc10_:int = 0;
         var _loc9_:* = _assetArr;
         for each(var assetInfo in _assetArr)
         {
            matches = NAME_REGEX.exec(assetInfo.url);
            if(matches.length < 3)
            {
               throw new Error("scene asset url error:" + assetInfo.url);
            }
            assetInfo.name = matches[1];
            extension = matches[2];
            assetInfo.extension = extension;
            if(extension == "png")
            {
               loaderType = 0;
            }
            else if(extension == "json" || extension == "xml")
            {
               loaderType = 2;
            }
            else if(extension == "swf")
            {
               loaderType = 3;
            }
            assetInfo.loaderType = loaderType;
            loader = LoadResourceManager.Instance.createLoader(assetInfo.url,loaderType);
            assetInfo.loader = loader;
            _queueLoader.addLoader(loader);
         }
         _queueLoader.addEventListener("complete",onQueueLoaderComplete);
         _queueLoader.start();
      }
      
      private function onQueueLoaderComplete(evt:Event) : void
      {
         var assetInfo:* = null;
         var extension:* = null;
         var texture:* = null;
         var module:* = null;
         var bitmapLoader:* = null;
         var bytesLoader:* = null;
         var xmlLoader:* = null;
         var xml:* = null;
         var xmlName:* = null;
         var btmd:* = null;
         var _loc13_:int = 0;
         var _loc12_:* = _assetArr;
         for each(assetInfo in _assetArr)
         {
            extension = assetInfo.extension;
            if(assetInfo.hasOwnProperty("loader"))
            {
               if(extension == "png")
               {
                  bitmapLoader = BitmapLoader(assetInfo.loader);
                  module = !!assetInfo.hasOwnProperty("module")?assetInfo.module:_module;
                  if(!DDTAssetManager.instance.getTexture(assetInfo.name))
                  {
                     texture = Texture.fromBitmapData(bitmapLoader.bitmapData,false);
                     addTexture(assetInfo,texture);
                     DDTAssetManager.instance.addTexture(assetInfo.name,texture,module);
                  }
                  if(assetInfo.hasOwnProperty("useType") && !DDTAssetManager.instance.getBitmapData(assetInfo.name))
                  {
                     DDTAssetManager.instance.addBitmapData(assetInfo.name,bitmapLoader.bitmapData.clone(),module);
                  }
                  bitmapLoader.bitmapData.dispose();
               }
               else if(extension == "swf")
               {
                  bytesLoader = BaseLoader(assetInfo.loader);
                  module = !!assetInfo.hasOwnProperty("module")?assetInfo.module:_module;
                  if(!DDTAssetManager.instance.getTexture(assetInfo.name))
                  {
                     texture = Texture.fromData(bytesLoader.content);
                     addAtfTexture(assetInfo,texture);
                     DDTAssetManager.instance.addTexture(assetInfo.name,texture,module);
                  }
               }
            }
         }
         var _loc15_:int = 0;
         var _loc14_:* = _assetArr;
         for each(assetInfo in _assetArr)
         {
            extension = assetInfo.extension;
            module = !!assetInfo.hasOwnProperty("module")?assetInfo.module:_module;
            if(assetInfo.hasOwnProperty("loader") && extension == "xml")
            {
               xmlLoader = TextLoader(assetInfo.loader);
               xml = new XML(xmlLoader.content);
               if(xml.localName() == "TextureAtlas")
               {
                  xmlName = assetInfo.name;
                  texture = DDTAssetManager.instance.getTexture(xmlName);
                  if(texture)
                  {
                     DDTAssetManager.instance.addTextureAtlas(xmlName,new TextureAtlas(texture,xml),module);
                     DDTAssetManager.instance.removeTexture(xmlName,false);
                  }
                  if(assetInfo.hasOwnProperty("useType"))
                  {
                     btmd = DDTAssetManager.instance.getBitmapData(assetInfo.name);
                     if(btmd)
                     {
                        DDTAssetManager.instance.addBitmapDataAtlas(xmlName,new NativeTextureAtlas(btmd,xml),module);
                        DDTAssetManager.instance.removeBitmapData(xmlName);
                     }
                  }
                  System.disposeXML(xml);
               }
            }
         }
      }
      
      private function addTexture(assetInfo:Object, texture:Texture) : void
      {
         assetInfo = assetInfo;
         texture = texture;
         if(Starling.handleLostContext)
         {
            texture.root.onRestore = function():void
            {
               onLoadComplete = function(evt:LoaderEvent):void
               {
                  loader.removeEventListener("complete",onLoadComplete);
                  var bitmapData:BitmapData = loader.bitmapData;
                  texture.root.uploadBitmapData(bitmapData);
                  bitmapData.dispose();
               };
               var loader:BitmapLoader = LoadResourceManager.Instance.createLoader(assetInfo.url,0);
               loader.isComplete = false;
               loader.addEventListener("complete",onLoadComplete);
               LoadResourceManager.Instance.startLoad(loader);
            };
         }
      }
      
      private function addAtfTexture(assetInfo:Object, texture:Texture) : void
      {
         assetInfo = assetInfo;
         texture = texture;
         if(Starling.handleLostContext)
         {
            texture.root.onRestore = function():void
            {
               onLoadComplete = function(evt:LoaderEvent):void
               {
                  loader.removeEventListener("complete",onLoadComplete);
                  texture.root.uploadAtfData(loader.content);
                  loader.content.clear();
               };
               var loader:BaseLoader = LoadResourceManager.Instance.createLoader(assetInfo.url,3);
               loader.isComplete = false;
               loader.addEventListener("complete",onLoadComplete);
               LoadResourceManager.Instance.startLoad(loader);
            };
         }
      }
      
      public function getCompletePrecent() : Number
      {
         if(!_queueLoader)
         {
            return 0;
         }
         return _queueLoader.completeCount / _queueLoader.length;
      }
      
      public function dispose() : void
      {
         _assetArr = null;
         _queueLoader.removeEventListener("complete",onQueueLoaderComplete);
         _queueLoader.dispose();
         _queueLoader = null;
         _onComplete = null;
      }
   }
}
