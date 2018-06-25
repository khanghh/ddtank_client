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
      
      public function AssetManager(scaleFactor:Number = 1, useMipmaps:Boolean = false)
      {
         super();
         mDefaultTextureOptions = new TextureOptions(scaleFactor,useMipmaps);
         mTextures = new Dictionary();
         mAtlases = new Dictionary();
         mSounds = new Dictionary();
         mXmls = new Dictionary();
         mObjects = new Dictionary();
         mByteArrays = new Dictionary();
         mNumConnections = 3;
         mVerbose = true;
         mQueue = [];
      }
      
      public function dispose() : void
      {
         var _loc6_:int = 0;
         var _loc5_:* = mTextures;
         for each(var texture in mTextures)
         {
            texture.dispose();
         }
         var _loc8_:int = 0;
         var _loc7_:* = mAtlases;
         for each(var atlas in mAtlases)
         {
            atlas.dispose();
         }
         var _loc10_:int = 0;
         var _loc9_:* = mXmls;
         for each(var xml in mXmls)
         {
            System.disposeXML(xml);
         }
         var _loc12_:int = 0;
         var _loc11_:* = mByteArrays;
         for each(var byteArray in mByteArrays)
         {
            byteArray.clear();
         }
      }
      
      public function getTexture(name:String) : Texture
      {
         var texture:* = null;
         if(name in mTextures)
         {
            return mTextures[name];
         }
         var _loc5_:int = 0;
         var _loc4_:* = mAtlases;
         for each(var atlas in mAtlases)
         {
            texture = atlas.getTexture(name);
            if(texture)
            {
               return texture;
            }
         }
         return null;
      }
      
      public function getTextures(prefix:String = "", result:Vector.<Texture> = null) : Vector.<Texture>
      {
         if(result == null)
         {
            result = new Vector.<Texture>(0);
         }
         var _loc5_:int = 0;
         var _loc4_:* = getTextureNames(prefix,sNames);
         for each(var name in getTextureNames(prefix,sNames))
         {
            result[result.length] = getTexture(name);
         }
         sNames.length = 0;
         return result;
      }
      
      public function getTextureNames(prefix:String = "", result:Vector.<String> = null) : Vector.<String>
      {
         result = getDictionaryKeys(mTextures,prefix,result);
         var _loc5_:int = 0;
         var _loc4_:* = mAtlases;
         for each(var atlas in mAtlases)
         {
            atlas.getNames(prefix,result);
         }
         result.sort(1);
         return result;
      }
      
      public function getTextureAtlas(name:String) : TextureAtlas
      {
         return mAtlases[name] as TextureAtlas;
      }
      
      public function getSound(name:String) : Sound
      {
         return mSounds[name];
      }
      
      public function getSoundNames(prefix:String = "", result:Vector.<String> = null) : Vector.<String>
      {
         return getDictionaryKeys(mSounds,prefix,result);
      }
      
      public function playSound(name:String, startTime:Number = 0, loops:int = 0, transform:SoundTransform = null) : SoundChannel
      {
         if(name in mSounds)
         {
            return getSound(name).play(startTime,loops,transform);
         }
         return null;
      }
      
      public function getXml(name:String) : XML
      {
         return mXmls[name];
      }
      
      public function getXmlNames(prefix:String = "", result:Vector.<String> = null) : Vector.<String>
      {
         return getDictionaryKeys(mXmls,prefix,result);
      }
      
      public function getObject(name:String) : Object
      {
         return mObjects[name];
      }
      
      public function getObjectNames(prefix:String = "", result:Vector.<String> = null) : Vector.<String>
      {
         return getDictionaryKeys(mObjects,prefix,result);
      }
      
      public function getByteArray(name:String) : ByteArray
      {
         return mByteArrays[name];
      }
      
      public function getByteArrayNames(prefix:String = "", result:Vector.<String> = null) : Vector.<String>
      {
         return getDictionaryKeys(mByteArrays,prefix,result);
      }
      
      public function addTexture(name:String, texture:Texture) : void
      {
         log("Adding texture \'" + name + "\'");
         if(name in mTextures)
         {
            log("Warning: name was already in use; the previous texture will be replaced.");
            mTextures[name].dispose();
         }
         texture.textureName = name;
         mTextures[name] = texture;
      }
      
      public function addTextureAtlas(name:String, atlas:TextureAtlas) : void
      {
         log("Adding texture atlas \'" + name + "\'");
         if(name in mAtlases)
         {
            log("Warning: name was already in use; the previous atlas will be replaced.");
            mAtlases[name].dispose();
         }
         mAtlases[name] = atlas;
         atlas.texture.textureName = name;
      }
      
      public function addSound(name:String, sound:Sound) : void
      {
         log("Adding sound \'" + name + "\'");
         if(name in mSounds)
         {
            log("Warning: name was already in use; the previous sound will be replaced.");
         }
         mSounds[name] = sound;
      }
      
      public function addXml(name:String, xml:XML) : void
      {
         log("Adding XML \'" + name + "\'");
         if(name in mXmls)
         {
            log("Warning: name was already in use; the previous XML will be replaced.");
            System.disposeXML(mXmls[name]);
         }
         mXmls[name] = xml;
      }
      
      public function addObject(name:String, object:Object) : void
      {
         log("Adding object \'" + name + "\'");
         if(name in mObjects)
         {
            log("Warning: name was already in use; the previous object will be replaced.");
         }
         mObjects[name] = object;
      }
      
      public function addByteArray(name:String, byteArray:ByteArray) : void
      {
         log("Adding byte array \'" + name + "\'");
         if(name in mByteArrays)
         {
            log("Warning: name was already in use; the previous byte array will be replaced.");
            mByteArrays[name].clear();
         }
         mByteArrays[name] = byteArray;
      }
      
      public function removeTexture(name:String, dispose:Boolean = true) : void
      {
         log("Removing texture \'" + name + "\'");
         if(dispose && name in mTextures)
         {
            mTextures[name].dispose();
         }
      }
      
      public function removeTextureAtlas(name:String, dispose:Boolean = true) : void
      {
         log("Removing texture atlas \'" + name + "\'");
         if(dispose && name in mAtlases)
         {
            mAtlases[name].dispose();
         }
      }
      
      public function removeSound(name:String) : void
      {
         log("Removing sound \'" + name + "\'");
      }
      
      public function removeXml(name:String, dispose:Boolean = true) : void
      {
         log("Removing xml \'" + name + "\'");
         if(dispose && name in mXmls)
         {
            System.disposeXML(mXmls[name]);
         }
      }
      
      public function removeObject(name:String) : void
      {
         log("Removing object \'" + name + "\'");
      }
      
      public function removeByteArray(name:String, dispose:Boolean = true) : void
      {
         log("Removing byte array \'" + name + "\'");
         if(dispose && name in mByteArrays)
         {
            mByteArrays[name].clear();
         }
      }
      
      public function purgeQueue() : void
      {
         mQueue.length = 0;
         dispatchEventWith("cancel");
      }
      
      public function purge() : void
      {
         log("Purging all assets, emptying queue");
         purgeQueue();
         dispose();
         mTextures = new Dictionary();
         mAtlases = new Dictionary();
         mSounds = new Dictionary();
         mXmls = new Dictionary();
         mObjects = new Dictionary();
         mByteArrays = new Dictionary();
      }
      
      public function enqueue(... rawAssets) : void
      {
         var typeXml:* = null;
         var childNode:* = null;
         var _loc16_:int = 0;
         var _loc15_:* = rawAssets;
         for each(var rawAsset in rawAssets)
         {
            if(rawAsset is Array)
            {
               enqueue.apply(this,rawAsset);
            }
            else if(rawAsset is Class)
            {
               typeXml = describeType(rawAsset);
               if(mVerbose)
               {
                  log("Looking for static embedded assets in \'" + typeXml.@name.split("::").pop() + "\'");
               }
               var _loc10_:int = 0;
               var _loc5_:* = typeXml.constant;
               var _loc6_:int = 0;
               var _loc8_:* = new XMLList("");
               var _loc9_:* = typeXml.constant.(@type == "Class");
               for each(childNode in typeXml.constant.(@type == "Class"))
               {
                  enqueueWithName(rawAsset[childNode.@name],childNode.@name);
               }
               var _loc14_:int = 0;
               var _loc11_:* = typeXml.variable;
               var _loc12_:int = 0;
               _loc5_ = new XMLList("");
               var _loc13_:* = typeXml.variable.(@type == "Class");
               for each(childNode in typeXml.variable.(@type == "Class"))
               {
                  enqueueWithName(rawAsset[childNode.@name],childNode.@name);
               }
            }
            else if(getQualifiedClassName(rawAsset) == "flash.filesystem::File")
            {
               if(!rawAsset["exists"])
               {
                  log("File or directory not found: \'" + rawAsset["url"] + "\'");
               }
               else if(!rawAsset["isHidden"])
               {
                  if(rawAsset["isDirectory"])
                  {
                     enqueue.apply(this,rawAsset["getDirectoryListing"]());
                  }
                  else
                  {
                     enqueueWithName(rawAsset);
                  }
               }
            }
            else if(rawAsset is String || rawAsset is URLRequest)
            {
               enqueueWithName(rawAsset);
            }
            else
            {
               log("Ignoring unsupported asset type: " + getQualifiedClassName(rawAsset));
            }
         }
      }
      
      public function enqueueWithName(asset:Object, name:String = null, options:TextureOptions = null) : String
      {
         if(getQualifiedClassName(asset) == "flash.filesystem::File")
         {
            asset = decodeURI(asset["url"]);
         }
         if(name == null)
         {
            name = getName(asset);
         }
         if(options == null)
         {
            options = mDefaultTextureOptions.clone();
         }
         else
         {
            options = options.clone();
         }
         log("Enqueuing \'" + name + "\'");
         mQueue.push({
            "name":name,
            "asset":asset,
            "options":options
         });
         return name;
      }
      
      public function loadQueue(onProgress:Function) : void
      {
         onProgress = onProgress;
         loadNextQueueElement = function():void
         {
            var index:int = 0;
            if(assetIndex < assetInfos.length)
            {
               assetIndex = Number(assetIndex) + 1;
               index = Number(assetIndex);
               loadQueueElement(index,assetInfos[index]);
            }
         };
         loadQueueElement = function(index:int, assetInfo:Object):void
         {
            index = index;
            assetInfo = assetInfo;
            if(canceled)
            {
               return;
            }
            var onElementProgress:Function = function(progress:Number):void
            {
            };
            var onElementLoaded:Function = function():void
            {
               updateAssetProgress(index,1);
               assetCount = Number(assetCount) - 1;
               if(assetCount > 0)
               {
                  loadNextQueueElement();
               }
               else
               {
                  processXmls();
               }
            };
            processRawAsset(assetInfo.name,assetInfo.asset,assetInfo.options,xmls,onElementProgress,onElementLoaded);
         };
         updateAssetProgress = function(index:int, progress:Number):void
         {
            assetProgress[index] = progress;
            var sum:* = 0;
            var len:int = assetProgress.length;
            for(i = 0; i < len; )
            {
               sum = Number(sum + assetProgress[i]);
               i = i + 1;
            }
         };
         processXmls = function():void
         {
            xmls.sort(function(a:XML, b:XML):int
            {
               return a.localName() == "TextureAtlas"?-1:1;
            });
         };
         processXml = function(index:int):void
         {
            var name:* = null;
            var texture:* = null;
            if(canceled)
            {
               return;
            }
            if(index == xmls.length)
            {
               finish();
               return;
            }
            var xml:XML = xmls[index];
            var rootNode:String = xml.localName();
            var xmlProgress:Number = (index + 1) / (xmls.length + 1);
            if(rootNode == "TextureAtlas")
            {
               name = getName(xml.@imagePath.toString());
               texture = getTexture(name);
               if(texture)
               {
                  addTextureAtlas(name,new TextureAtlas(texture,xml));
                  removeTexture(name,false);
                  if(mKeepAtlasXmls)
                  {
                     addXml(name,xml);
                  }
                  else
                  {
                     System.disposeXML(xml);
                  }
               }
               else
               {
                  log("Cannot create atlas: texture \'" + name + "\' is missing.");
               }
            }
            else if(rootNode == "font")
            {
               name = getName(xml.pages.page.@file.toString());
               texture = getTexture(name);
               if(texture)
               {
                  log("Adding bitmap font \'" + name + "\'");
                  TextField.registerBitmapFont(new BitmapFont(texture,xml),name);
                  removeTexture(name,false);
                  if(mKeepFontXmls)
                  {
                     addXml(name,xml);
                  }
                  else
                  {
                     System.disposeXML(xml);
                  }
               }
               else
               {
                  log("Cannot create bitmap font: texture \'" + name + "\' is missing.");
               }
            }
            else
            {
               throw new Error("XML contents not recognized: " + rootNode);
            }
            onProgress(0.9 + 0.1 * xmlProgress);
            return;
            §§push(setTimeout(processXml,1,index + 1));
         };
         cancel = function():void
         {
            removeEventListener("cancel",cancel);
            mNumLoadingQueues = Number(mNumLoadingQueues) - 1;
            canceled = true;
         };
         finish = function():void
         {
            System.pauseForGCIfCollectionImminent(0);
            System.gc();
         };
         if(onProgress == null)
         {
            throw new ArgumentError("Argument \'onProgress\' must not be null");
         }
         if(mQueue.length == 0)
         {
            onProgress(1);
            return;
         }
         mStarling = Starling.current;
         if(mStarling == null || mStarling.context == null)
         {
            throw new Error("The Starling instance needs to be ready before assets can be loaded.");
         }
         var canceled:Boolean = false;
         var xmls:Vector.<XML> = new Vector.<XML>(0);
         var assetInfos:Array = mQueue.concat();
         var assetCount:int = mQueue.length;
         var assetProgress:Array = [];
         var assetIndex:int = 0;
         for(var i:int = 0; i < assetCount; )
         {
            assetProgress[i] = 0;
            i = i + 1;
         }
         for(i = 0; i < mNumConnections; )
         {
            loadNextQueueElement();
            i = i + 1;
         }
         mQueue.length = 0;
         mNumLoadingQueues = Number(mNumLoadingQueues) + 1;
         addEventListener("cancel",cancel);
      }
      
      private function processRawAsset(name:String, rawAsset:Object, options:TextureOptions, xmls:Vector.<XML>, onProgress:Function, onComplete:Function) : void
      {
         name = name;
         rawAsset = rawAsset;
         options = options;
         xmls = xmls;
         onProgress = onProgress;
         onComplete = onComplete;
         process = function(asset:Object):void
         {
            asset = asset;
            var object:Object = null;
            var xml:XML = null;
            mStarling.makeCurrent();
            if(!canceled)
            {
               if(asset == null)
               {
                  onComplete();
               }
               else if(asset is Sound)
               {
                  addSound(name,asset as Sound);
                  onComplete();
               }
               else if(asset is XML)
               {
                  xml = asset as XML;
                  if(xml.localName() == "TextureAtlas" || xml.localName() == "font")
                  {
                     xmls.push(xml);
                  }
                  else
                  {
                     addXml(name,xml);
                  }
                  onComplete();
               }
               else
               {
                  if(Starling.handleLostContext && mStarling.context.driverInfo == "Disposed")
                  {
                     log("Context lost while processing assets, retrying ...");
                     setTimeout(process,1,asset);
                     return;
                  }
                  if(asset is Bitmap)
                  {
                     var texture:Texture = Texture.fromData(asset,options);
                     texture.root.onRestore = function():void
                     {
                        mNumLostTextures = Number(mNumLostTextures) + 1;
                        loadRawAsset(rawAsset,null,function(asset:Object):void
                        {
                           try
                           {
                              if(asset == null)
                              {
                                 throw new Error("Reload failed");
                              }
                              texture.root.uploadBitmap(asset as Bitmap);
                              asset.bitmapData.dispose();
                           }
                           catch(e:Error)
                           {
                              log("Texture restoration failed for \'" + name + "\': " + e.message);
                           }
                           mNumRestoredTextures = Number(mNumRestoredTextures) + 1;
                           if(mNumLostTextures == mNumRestoredTextures)
                           {
                              dispatchEventWith("texturesRestored");
                           }
                        });
                     };
                     asset.bitmapData.dispose();
                     addTexture(name,texture);
                     onComplete();
                  }
                  else if(asset is ByteArray)
                  {
                     var bytes:ByteArray = asset as ByteArray;
                     if(AtfData.isAtfData(bytes))
                     {
                        options.onReady = prependCallback(options.onReady,function():void
                        {
                           addTexture(name,texture);
                        });
                        texture = Texture.fromData(bytes,options);
                        texture.root.onRestore = function():void
                        {
                           mNumLostTextures = Number(mNumLostTextures) + 1;
                           loadRawAsset(rawAsset,null,function(asset:Object):void
                           {
                              try
                              {
                                 if(asset == null)
                                 {
                                    throw new Error("Reload failed");
                                 }
                                 texture.root.uploadAtfData(asset as ByteArray,0,true);
                                 asset.clear();
                              }
                              catch(e:Error)
                              {
                                 log("Texture restoration failed for \'" + name + "\': " + e.message);
                              }
                              mNumRestoredTextures = Number(mNumRestoredTextures) + 1;
                              if(mNumLostTextures == mNumRestoredTextures)
                              {
                                 dispatchEventWith("texturesRestored");
                              }
                           });
                        };
                        bytes.clear();
                     }
                     else if(byteArrayStartsWith(bytes,"{") || byteArrayStartsWith(bytes,"["))
                     {
                        try
                        {
                           object = JSON.parse(bytes.readUTFBytes(bytes.length));
                        }
                        catch(e:Error)
                        {
                           log("Could not parse JSON: " + e.message);
                           dispatchEventWith("parseError",false,name);
                        }
                        if(object)
                        {
                           addObject(name,object);
                        }
                        bytes.clear();
                        onComplete();
                     }
                     else if(byteArrayStartsWith(bytes,"<"))
                     {
                        try
                        {
                           xml = new XML(bytes);
                        }
                        catch(e:Error)
                        {
                           log("Could not parse XML: " + e.message);
                           dispatchEventWith("parseError",false,name);
                        }
                        process(xml);
                        bytes.clear();
                     }
                     else
                     {
                        addByteArray(name,bytes);
                        onComplete();
                     }
                  }
                  else
                  {
                     addObject(name,asset);
                     onComplete();
                  }
               }
            }
            var asset:Object = null;
            bytes = null;
            removeEventListener("cancel",cancel);
         };
         progress = function(ratio:Number):void
         {
            if(!canceled)
            {
               onProgress(ratio);
            }
         };
         cancel = function():void
         {
            canceled = true;
         };
         var canceled:Boolean = false;
         addEventListener("cancel",cancel);
         loadRawAsset(rawAsset,progress,process);
      }
      
      protected function loadRawAsset(rawAsset:Object, onProgress:Function, onComplete:Function) : void
      {
         rawAsset = rawAsset;
         onProgress = onProgress;
         onComplete = onComplete;
         onIoError = function(event:IOErrorEvent):void
         {
            log("IO error: " + event.text);
            dispatchEventWith("ioError",false,url);
         };
         onSecurityError = function(event:SecurityErrorEvent):void
         {
            log("security error: " + event.text);
            dispatchEventWith("securityError",false,url);
         };
         onHttpResponseStatus = function(event:HTTPStatusEvent):void
         {
            var headers:* = null;
            var contentType:* = null;
            if(extension == null)
            {
               headers = event["responseHeaders"];
               contentType = getHttpHeader(headers,"Content-Type");
               if(contentType && /(audio|image)\//.exec(contentType))
               {
                  extension = contentType.split("/").pop();
               }
            }
         };
         onLoadProgress = function(event:ProgressEvent):void
         {
            if(onProgress != null && event.bytesTotal > 0)
            {
               onProgress(event.bytesLoaded / event.bytesTotal);
            }
         };
         onUrlLoaderComplete = function(event:Object):void
         {
            var sound:* = null;
            var loaderContext:* = null;
            var loader:* = null;
            var bytes:ByteArray = transformData(urlLoader.data as ByteArray,url);
            if(bytes == null)
            {
               complete(null);
               return;
            }
            if(extension)
            {
               extension = extension.toLowerCase();
            }
            var _loc6_:* = extension;
            if("mpeg" !== _loc6_)
            {
               if("mp3" !== _loc6_)
               {
                  if("jpg" !== _loc6_)
                  {
                     if("jpeg" !== _loc6_)
                     {
                        if("png" !== _loc6_)
                        {
                           if("gif" !== _loc6_)
                           {
                              complete(bytes);
                           }
                        }
                        addr75:
                        loaderContext = new LoaderContext(mCheckPolicyFile);
                        loader = new Loader();
                        loaderContext.imageDecodingPolicy = "onLoad";
                        loaderInfo = loader.contentLoaderInfo;
                        loaderInfo.addEventListener("ioError",onIoError);
                        loaderInfo.addEventListener("complete",onLoaderComplete);
                        loader.loadBytes(bytes,loaderContext);
                     }
                     addr74:
                     §§goto(addr75);
                  }
                  §§goto(addr74);
               }
               addr146:
               return;
            }
            sound = new Sound();
            sound.loadCompressedDataFromByteArray(bytes,bytes.length);
            bytes.clear();
            complete(sound);
            §§goto(addr146);
         };
         onLoaderComplete = function(event:Object):void
         {
            urlLoader.data.clear();
         };
         complete = function(asset:Object):void
         {
            if(urlLoader)
            {
               urlLoader.removeEventListener("ioError",onIoError);
               urlLoader.removeEventListener("securityError",onSecurityError);
               urlLoader.removeEventListener("httpResponseStatus",onHttpResponseStatus);
               urlLoader.removeEventListener("progress",onLoadProgress);
               urlLoader.removeEventListener("complete",onUrlLoaderComplete);
            }
            if(loaderInfo)
            {
               loaderInfo.removeEventListener("ioError",onIoError);
               loaderInfo.removeEventListener("complete",onLoaderComplete);
            }
            if(SystemUtil.isDesktop)
            {
               onComplete(asset);
            }
            else
            {
               SystemUtil.executeWhenApplicationIsActive(onComplete,asset);
            }
         };
         var extension:String = null;
         var loaderInfo:LoaderInfo = null;
         var urlLoader:URLLoader = null;
         var urlRequest:URLRequest = null;
         var url:String = null;
         if(rawAsset is Class)
         {
            setTimeout(complete,1,new rawAsset());
         }
         else if(rawAsset is String || rawAsset is URLRequest)
         {
            urlRequest = rawAsset as URLRequest || new URLRequest(rawAsset as String);
            url = urlRequest.url;
            extension = getExtensionFromUrl(url);
            urlLoader = new URLLoader();
            urlLoader.dataFormat = "binary";
            urlLoader.addEventListener("ioError",onIoError);
            urlLoader.addEventListener("securityError",onSecurityError);
            urlLoader.addEventListener("httpResponseStatus",onHttpResponseStatus);
            urlLoader.addEventListener("progress",onLoadProgress);
            urlLoader.addEventListener("complete",onUrlLoaderComplete);
            urlLoader.load(urlRequest);
         }
      }
      
      protected function getName(rawAsset:Object) : String
      {
         var name:* = null;
         if(rawAsset is String)
         {
            name = rawAsset as String;
         }
         else if(rawAsset is URLRequest)
         {
            name = (rawAsset as URLRequest).url;
         }
         else if(rawAsset is FileReference)
         {
            name = (rawAsset as FileReference).name;
         }
         if(name)
         {
            name = name.replace(/%20/g," ");
            name = getBasenameFromUrl(name);
            if(name)
            {
               return name;
            }
            throw new ArgumentError("Could not extract name from String \'" + rawAsset + "\'");
         }
         name = getQualifiedClassName(rawAsset);
         throw new ArgumentError("Cannot extract names for objects of type \'" + name + "\'");
      }
      
      protected function transformData(data:ByteArray, url:String) : ByteArray
      {
         return data;
      }
      
      protected function log(message:String) : void
      {
         if(mVerbose)
         {
            trace("[AssetManager]",message);
         }
      }
      
      private function byteArrayStartsWith(bytes:ByteArray, char:String) : Boolean
      {
         var i:* = 0;
         var byte:int = 0;
         var start:int = 0;
         var length:int = bytes.length;
         var wanted:int = char.charCodeAt(0);
         if(length >= 4 && (bytes[0] == 0 && bytes[1] == 0 && bytes[2] == 254 && bytes[3] == 255) || bytes[0] == 255 && bytes[1] == 254 && bytes[2] == 0 && bytes[3] == 0)
         {
            start = 4;
         }
         else if(length >= 3 && bytes[0] == 239 && bytes[1] == 187 && bytes[2] == 191)
         {
            start = 3;
         }
         else if(length >= 2 && (bytes[0] == 254 && bytes[1] == 255) || bytes[0] == 255 && bytes[1] == 254)
         {
            start = 2;
         }
         for(i = start; i < length; )
         {
            byte = bytes[i];
            if(!(byte == 0 || byte == 10 || byte == 13 || byte == 32))
            {
               return byte == wanted;
            }
            i++;
         }
         return false;
      }
      
      private function getDictionaryKeys(dictionary:Dictionary, prefix:String = "", result:Vector.<String> = null) : Vector.<String>
      {
         if(result == null)
         {
            result = new Vector.<String>(0);
         }
         var _loc6_:int = 0;
         var _loc5_:* = dictionary;
         for(var name in dictionary)
         {
            if(name.indexOf(prefix) == 0)
            {
               result[result.length] = name;
            }
         }
         result.sort(1);
         return result;
      }
      
      private function getHttpHeader(headers:Array, headerName:String) : String
      {
         if(headers)
         {
            var _loc5_:int = 0;
            var _loc4_:* = headers;
            for each(var header in headers)
            {
               if(header.name == headerName)
               {
                  return header.value;
               }
            }
         }
         return null;
      }
      
      protected function getBasenameFromUrl(url:String) : String
      {
         var matches:Array = NAME_REGEX.exec(url);
         if(matches && matches.length > 0)
         {
            return matches[1];
         }
         return null;
      }
      
      protected function getExtensionFromUrl(url:String) : String
      {
         var matches:Array = NAME_REGEX.exec(url);
         if(matches && matches.length > 1)
         {
            return matches[2];
         }
         return null;
      }
      
      private function prependCallback(oldCallback:Function, newCallback:Function) : Function
      {
         oldCallback = oldCallback;
         newCallback = newCallback;
         if(oldCallback == null)
         {
            return newCallback;
         }
         if(newCallback == null)
         {
            return oldCallback;
         }
         return function():void
         {
            newCallback();
         };
      }
      
      protected function get queue() : Array
      {
         return mQueue;
      }
      
      public function get numQueuedAssets() : int
      {
         return mQueue.length;
      }
      
      public function get verbose() : Boolean
      {
         return mVerbose;
      }
      
      public function set verbose(value:Boolean) : void
      {
         mVerbose = value;
      }
      
      public function get isLoading() : Boolean
      {
         return mNumLoadingQueues > 0;
      }
      
      public function get useMipMaps() : Boolean
      {
         return mDefaultTextureOptions.mipMapping;
      }
      
      public function set useMipMaps(value:Boolean) : void
      {
         mDefaultTextureOptions.mipMapping = value;
      }
      
      public function get textureRepeat() : Boolean
      {
         return mDefaultTextureOptions.repeat;
      }
      
      public function set textureRepeat(value:Boolean) : void
      {
         mDefaultTextureOptions.repeat = value;
      }
      
      public function get scaleFactor() : Number
      {
         return mDefaultTextureOptions.scale;
      }
      
      public function set scaleFactor(value:Number) : void
      {
         mDefaultTextureOptions.scale = value;
      }
      
      public function get textureFormat() : String
      {
         return mDefaultTextureOptions.format;
      }
      
      public function set textureFormat(value:String) : void
      {
         mDefaultTextureOptions.format = value;
      }
      
      public function get checkPolicyFile() : Boolean
      {
         return mCheckPolicyFile;
      }
      
      public function set checkPolicyFile(value:Boolean) : void
      {
         mCheckPolicyFile = value;
      }
      
      public function get keepAtlasXmls() : Boolean
      {
         return mKeepAtlasXmls;
      }
      
      public function set keepAtlasXmls(value:Boolean) : void
      {
         mKeepAtlasXmls = value;
      }
      
      public function get keepFontXmls() : Boolean
      {
         return mKeepFontXmls;
      }
      
      public function set keepFontXmls(value:Boolean) : void
      {
         mKeepFontXmls = value;
      }
      
      public function get numConnections() : int
      {
         return mNumConnections;
      }
      
      public function set numConnections(value:int) : void
      {
         mNumConnections = value;
      }
      
      public function get atlases() : Dictionary
      {
         return mAtlases;
      }
   }
}
