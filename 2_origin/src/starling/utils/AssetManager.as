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
      
      public function AssetManager(param1:Number = 1, param2:Boolean = false)
      {
         super();
         mDefaultTextureOptions = new TextureOptions(param1,param2);
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
         for each(var _loc1_ in mTextures)
         {
            _loc1_.dispose();
         }
         var _loc8_:int = 0;
         var _loc7_:* = mAtlases;
         for each(var _loc4_ in mAtlases)
         {
            _loc4_.dispose();
         }
         var _loc10_:int = 0;
         var _loc9_:* = mXmls;
         for each(var _loc3_ in mXmls)
         {
            System.disposeXML(_loc3_);
         }
         var _loc12_:int = 0;
         var _loc11_:* = mByteArrays;
         for each(var _loc2_ in mByteArrays)
         {
            _loc2_.clear();
         }
      }
      
      public function getTexture(param1:String) : Texture
      {
         var _loc2_:* = null;
         if(param1 in mTextures)
         {
            return mTextures[param1];
         }
         var _loc5_:int = 0;
         var _loc4_:* = mAtlases;
         for each(var _loc3_ in mAtlases)
         {
            _loc2_ = _loc3_.getTexture(param1);
            if(_loc2_)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function getTextures(param1:String = "", param2:Vector.<Texture> = null) : Vector.<Texture>
      {
         if(param2 == null)
         {
            param2 = new Vector.<Texture>(0);
         }
         var _loc5_:int = 0;
         var _loc4_:* = getTextureNames(param1,sNames);
         for each(var _loc3_ in getTextureNames(param1,sNames))
         {
            param2[param2.length] = getTexture(_loc3_);
         }
         sNames.length = 0;
         return param2;
      }
      
      public function getTextureNames(param1:String = "", param2:Vector.<String> = null) : Vector.<String>
      {
         param2 = getDictionaryKeys(mTextures,param1,param2);
         var _loc5_:int = 0;
         var _loc4_:* = mAtlases;
         for each(var _loc3_ in mAtlases)
         {
            _loc3_.getNames(param1,param2);
         }
         param2.sort(1);
         return param2;
      }
      
      public function getTextureAtlas(param1:String) : TextureAtlas
      {
         return mAtlases[param1] as TextureAtlas;
      }
      
      public function getSound(param1:String) : Sound
      {
         return mSounds[param1];
      }
      
      public function getSoundNames(param1:String = "", param2:Vector.<String> = null) : Vector.<String>
      {
         return getDictionaryKeys(mSounds,param1,param2);
      }
      
      public function playSound(param1:String, param2:Number = 0, param3:int = 0, param4:SoundTransform = null) : SoundChannel
      {
         if(param1 in mSounds)
         {
            return getSound(param1).play(param2,param3,param4);
         }
         return null;
      }
      
      public function getXml(param1:String) : XML
      {
         return mXmls[param1];
      }
      
      public function getXmlNames(param1:String = "", param2:Vector.<String> = null) : Vector.<String>
      {
         return getDictionaryKeys(mXmls,param1,param2);
      }
      
      public function getObject(param1:String) : Object
      {
         return mObjects[param1];
      }
      
      public function getObjectNames(param1:String = "", param2:Vector.<String> = null) : Vector.<String>
      {
         return getDictionaryKeys(mObjects,param1,param2);
      }
      
      public function getByteArray(param1:String) : ByteArray
      {
         return mByteArrays[param1];
      }
      
      public function getByteArrayNames(param1:String = "", param2:Vector.<String> = null) : Vector.<String>
      {
         return getDictionaryKeys(mByteArrays,param1,param2);
      }
      
      public function addTexture(param1:String, param2:Texture) : void
      {
         log("Adding texture \'" + param1 + "\'");
         if(param1 in mTextures)
         {
            log("Warning: name was already in use; the previous texture will be replaced.");
            mTextures[param1].dispose();
         }
         param2.textureName = param1;
         mTextures[param1] = param2;
      }
      
      public function addTextureAtlas(param1:String, param2:TextureAtlas) : void
      {
         log("Adding texture atlas \'" + param1 + "\'");
         if(param1 in mAtlases)
         {
            log("Warning: name was already in use; the previous atlas will be replaced.");
            mAtlases[param1].dispose();
         }
         mAtlases[param1] = param2;
         param2.texture.textureName = param1;
      }
      
      public function addSound(param1:String, param2:Sound) : void
      {
         log("Adding sound \'" + param1 + "\'");
         if(param1 in mSounds)
         {
            log("Warning: name was already in use; the previous sound will be replaced.");
         }
         mSounds[param1] = param2;
      }
      
      public function addXml(param1:String, param2:XML) : void
      {
         log("Adding XML \'" + param1 + "\'");
         if(param1 in mXmls)
         {
            log("Warning: name was already in use; the previous XML will be replaced.");
            System.disposeXML(mXmls[param1]);
         }
         mXmls[param1] = param2;
      }
      
      public function addObject(param1:String, param2:Object) : void
      {
         log("Adding object \'" + param1 + "\'");
         if(param1 in mObjects)
         {
            log("Warning: name was already in use; the previous object will be replaced.");
         }
         mObjects[param1] = param2;
      }
      
      public function addByteArray(param1:String, param2:ByteArray) : void
      {
         log("Adding byte array \'" + param1 + "\'");
         if(param1 in mByteArrays)
         {
            log("Warning: name was already in use; the previous byte array will be replaced.");
            mByteArrays[param1].clear();
         }
         mByteArrays[param1] = param2;
      }
      
      public function removeTexture(param1:String, param2:Boolean = true) : void
      {
         log("Removing texture \'" + param1 + "\'");
         if(param2 && param1 in mTextures)
         {
            mTextures[param1].dispose();
         }
      }
      
      public function removeTextureAtlas(param1:String, param2:Boolean = true) : void
      {
         log("Removing texture atlas \'" + param1 + "\'");
         if(param2 && param1 in mAtlases)
         {
            mAtlases[param1].dispose();
         }
      }
      
      public function removeSound(param1:String) : void
      {
         log("Removing sound \'" + param1 + "\'");
      }
      
      public function removeXml(param1:String, param2:Boolean = true) : void
      {
         log("Removing xml \'" + param1 + "\'");
         if(param2 && param1 in mXmls)
         {
            System.disposeXML(mXmls[param1]);
         }
      }
      
      public function removeObject(param1:String) : void
      {
         log("Removing object \'" + param1 + "\'");
      }
      
      public function removeByteArray(param1:String, param2:Boolean = true) : void
      {
         log("Removing byte array \'" + param1 + "\'");
         if(param2 && param1 in mByteArrays)
         {
            mByteArrays[param1].clear();
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
      
      public function enqueue(... rest) : void
      {
         var _loc4_:* = null;
         var _loc2_:* = null;
         var _loc16_:int = 0;
         var _loc15_:* = rest;
         for each(var _loc3_ in rest)
         {
            if(_loc3_ is Array)
            {
               enqueue.apply(this,_loc3_);
            }
            else if(_loc3_ is Class)
            {
               _loc4_ = describeType(_loc3_);
               if(mVerbose)
               {
                  log("Looking for static embedded assets in \'" + _loc4_.@name.split("::").pop() + "\'");
               }
               var _loc10_:int = 0;
               var _loc5_:* = _loc4_.constant;
               var _loc6_:int = 0;
               var _loc8_:* = new XMLList("");
               var _loc9_:* = _loc4_.constant.(@type == "Class");
               for each(_loc2_ in _loc4_.constant.(@type == "Class"))
               {
                  enqueueWithName(_loc3_[_loc2_.@name],_loc2_.@name);
               }
               var _loc14_:int = 0;
               var _loc11_:* = _loc4_.variable;
               var _loc12_:int = 0;
               _loc5_ = new XMLList("");
               var _loc13_:* = _loc4_.variable.(@type == "Class");
               for each(_loc2_ in _loc4_.variable.(@type == "Class"))
               {
                  enqueueWithName(_loc3_[_loc2_.@name],_loc2_.@name);
               }
            }
            else if(getQualifiedClassName(_loc3_) == "flash.filesystem::File")
            {
               if(!_loc3_["exists"])
               {
                  log("File or directory not found: \'" + _loc3_["url"] + "\'");
               }
               else if(!_loc3_["isHidden"])
               {
                  if(_loc3_["isDirectory"])
                  {
                     enqueue.apply(this,_loc3_["getDirectoryListing"]());
                  }
                  else
                  {
                     enqueueWithName(_loc3_);
                  }
               }
            }
            else if(_loc3_ is String || _loc3_ is URLRequest)
            {
               enqueueWithName(_loc3_);
            }
            else
            {
               log("Ignoring unsupported asset type: " + getQualifiedClassName(_loc3_));
            }
         }
      }
      
      public function enqueueWithName(param1:Object, param2:String = null, param3:TextureOptions = null) : String
      {
         if(getQualifiedClassName(param1) == "flash.filesystem::File")
         {
            param1 = decodeURI(param1["url"]);
         }
         if(param2 == null)
         {
            param2 = getName(param1);
         }
         if(param3 == null)
         {
            param3 = mDefaultTextureOptions.clone();
         }
         else
         {
            param3 = param3.clone();
         }
         log("Enqueuing \'" + param2 + "\'");
         mQueue.push({
            "name":param2,
            "asset":param1,
            "options":param3
         });
         return param2;
      }
      
      public function loadQueue(param1:Function) : void
      {
         onProgress = param1;
         loadNextQueueElement = function():void
         {
            var _loc1_:int = 0;
            if(assetIndex < assetInfos.length)
            {
               assetIndex = Number(assetIndex) + 1;
               _loc1_ = Number(assetIndex);
               loadQueueElement(_loc1_,assetInfos[_loc1_]);
            }
         };
         loadQueueElement = function(param1:int, param2:Object):void
         {
            index = param1;
            assetInfo = param2;
            if(canceled)
            {
               return;
            }
            var onElementProgress:Function = function(param1:Number):void
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
         updateAssetProgress = function(param1:int, param2:Number):void
         {
            assetProgress[param1] = param2;
            var _loc3_:* = 0;
            var _loc4_:int = assetProgress.length;
            i = 0;
            while(i < _loc4_)
            {
               _loc3_ = Number(_loc3_ + assetProgress[i]);
               i = i + 1;
            }
         };
         processXmls = function():void
         {
            xmls.sort(function(param1:XML, param2:XML):int
            {
               return param1.localName() == "TextureAtlas"?-1:1;
            });
         };
         processXml = function(param1:int):void
         {
            var _loc4_:* = null;
            var _loc3_:* = null;
            if(canceled)
            {
               return;
            }
            if(param1 == xmls.length)
            {
               return;
               §§push(finish());
            }
            else
            {
               var _loc5_:XML = xmls[param1];
               var _loc2_:String = _loc5_.localName();
               var _loc6_:Number = (param1 + 1) / (xmls.length + 1);
               if(_loc2_ == "TextureAtlas")
               {
                  _loc4_ = getName(_loc5_.@imagePath.toString());
                  _loc3_ = getTexture(_loc4_);
                  if(_loc3_)
                  {
                     addTextureAtlas(_loc4_,new TextureAtlas(_loc3_,_loc5_));
                     removeTexture(_loc4_,false);
                     if(mKeepAtlasXmls)
                     {
                        addXml(_loc4_,_loc5_);
                     }
                     else
                     {
                        System.disposeXML(_loc5_);
                     }
                  }
                  else
                  {
                     log("Cannot create atlas: texture \'" + _loc4_ + "\' is missing.");
                  }
               }
               else if(_loc2_ == "font")
               {
                  _loc4_ = getName(_loc5_.pages.page.@file.toString());
                  _loc3_ = getTexture(_loc4_);
                  if(_loc3_)
                  {
                     log("Adding bitmap font \'" + _loc4_ + "\'");
                     TextField.registerBitmapFont(new BitmapFont(_loc3_,_loc5_),_loc4_);
                     removeTexture(_loc4_,false);
                     if(mKeepFontXmls)
                     {
                        addXml(_loc4_,_loc5_);
                     }
                     else
                     {
                        System.disposeXML(_loc5_);
                     }
                  }
                  else
                  {
                     log("Cannot create bitmap font: texture \'" + _loc4_ + "\' is missing.");
                  }
               }
               else
               {
                  throw new Error("XML contents not recognized: " + _loc2_);
               }
               onProgress(0.9 + 0.1 * _loc6_);
               return;
               §§push(setTimeout(processXml,1,param1 + 1));
            }
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
            return;
            §§push(onProgress(1));
         }
         else
         {
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
            var i:int = 0;
            while(i < assetCount)
            {
               assetProgress[i] = 0;
               i = i + 1;
            }
            i = 0;
            while(i < mNumConnections)
            {
               loadNextQueueElement();
               i = i + 1;
            }
            mQueue.length = 0;
            mNumLoadingQueues = Number(mNumLoadingQueues) + 1;
            addEventListener("cancel",cancel);
            return;
         }
      }
      
      private function processRawAsset(param1:String, param2:Object, param3:TextureOptions, param4:Vector.<XML>, param5:Function, param6:Function) : void
      {
         name = param1;
         rawAsset = param2;
         options = param3;
         xmls = param4;
         onProgress = param5;
         onComplete = param6;
         process = function(param1:Object):void
         {
            asset = param1;
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
               else if(Starling.handleLostContext && mStarling.context.driverInfo == "Disposed")
               {
                  log("Context lost while processing assets, retrying ...");
                  return;
                  §§push(setTimeout(process,1,asset));
               }
               else if(asset is Bitmap)
               {
                  var texture:Texture = Texture.fromData(asset,options);
                  texture.root.onRestore = function():void
                  {
                     mNumLostTextures = Number(mNumLostTextures) + 1;
                     loadRawAsset(rawAsset,null,function(param1:Object):void
                     {
                        try
                        {
                           if(param1 == null)
                           {
                              throw new Error("Reload failed");
                           }
                           texture.root.uploadBitmap(param1 as Bitmap);
                           param1.bitmapData.dispose();
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
                        loadRawAsset(rawAsset,null,function(param1:Object):void
                        {
                           try
                           {
                              if(param1 == null)
                              {
                                 throw new Error("Reload failed");
                              }
                              texture.root.uploadAtfData(param1 as ByteArray,0,true);
                              param1.clear();
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
            var asset:Object = null;
            bytes = null;
            removeEventListener("cancel",cancel);
         };
         progress = function(param1:Number):void
         {
            if(!canceled)
            {
               onProgress(param1);
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
      
      protected function loadRawAsset(param1:Object, param2:Function, param3:Function) : void
      {
         rawAsset = param1;
         onProgress = param2;
         onComplete = param3;
         onIoError = function(param1:IOErrorEvent):void
         {
            log("IO error: " + param1.text);
            dispatchEventWith("ioError",false,url);
         };
         onSecurityError = function(param1:SecurityErrorEvent):void
         {
            log("security error: " + param1.text);
            dispatchEventWith("securityError",false,url);
         };
         onHttpResponseStatus = function(param1:HTTPStatusEvent):void
         {
            var _loc2_:* = null;
            var _loc3_:* = null;
            if(extension == null)
            {
               _loc2_ = param1["responseHeaders"];
               _loc3_ = getHttpHeader(_loc2_,"Content-Type");
               if(_loc3_ && /(audio|image)\//.exec(_loc3_))
               {
                  extension = _loc3_.split("/").pop();
               }
            }
         };
         onLoadProgress = function(param1:ProgressEvent):void
         {
            if(onProgress != null && param1.bytesTotal > 0)
            {
               onProgress(param1.bytesLoaded / param1.bytesTotal);
            }
         };
         onUrlLoaderComplete = function(param1:Object):void
         {
            var _loc5_:* = null;
            var _loc4_:* = null;
            var _loc3_:* = null;
            var _loc2_:ByteArray = transformData(urlLoader.data as ByteArray,url);
            if(_loc2_ == null)
            {
               return;
               §§push(complete(null));
            }
            else
            {
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
                                 complete(_loc2_);
                              }
                           }
                           addr55:
                           _loc4_ = new LoaderContext(mCheckPolicyFile);
                           _loc3_ = new Loader();
                           _loc4_.imageDecodingPolicy = "onLoad";
                           loaderInfo = _loc3_.contentLoaderInfo;
                           loaderInfo.addEventListener("ioError",onIoError);
                           loaderInfo.addEventListener("complete",onLoaderComplete);
                           _loc3_.loadBytes(_loc2_,_loc4_);
                        }
                        addr54:
                        §§goto(addr55);
                     }
                     §§goto(addr54);
                  }
                  addr112:
                  return;
               }
               _loc5_ = new Sound();
               _loc5_.loadCompressedDataFromByteArray(_loc2_,_loc2_.length);
               _loc2_.clear();
               complete(_loc5_);
               §§goto(addr112);
            }
         };
         onLoaderComplete = function(param1:Object):void
         {
            urlLoader.data.clear();
         };
         complete = function(param1:Object):void
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
               onComplete(param1);
            }
            else
            {
               SystemUtil.executeWhenApplicationIsActive(onComplete,param1);
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
      
      protected function getName(param1:Object) : String
      {
         var _loc2_:* = null;
         if(param1 is String)
         {
            _loc2_ = param1 as String;
         }
         else if(param1 is URLRequest)
         {
            _loc2_ = (param1 as URLRequest).url;
         }
         else if(param1 is FileReference)
         {
            _loc2_ = (param1 as FileReference).name;
         }
         if(_loc2_)
         {
            _loc2_ = _loc2_.replace(/%20/g," ");
            _loc2_ = getBasenameFromUrl(_loc2_);
            if(_loc2_)
            {
               return _loc2_;
            }
            throw new ArgumentError("Could not extract name from String \'" + param1 + "\'");
         }
         _loc2_ = getQualifiedClassName(param1);
         throw new ArgumentError("Cannot extract names for objects of type \'" + _loc2_ + "\'");
      }
      
      protected function transformData(param1:ByteArray, param2:String) : ByteArray
      {
         return param1;
      }
      
      protected function log(param1:String) : void
      {
         if(mVerbose)
         {
            trace("[AssetManager]",param1);
         }
      }
      
      private function byteArrayStartsWith(param1:ByteArray, param2:String) : Boolean
      {
         var _loc7_:* = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = param1.length;
         var _loc6_:int = param2.charCodeAt(0);
         if(_loc5_ >= 4 && (param1[0] == 0 && param1[1] == 0 && param1[2] == 254 && param1[3] == 255) || param1[0] == 255 && param1[1] == 254 && param1[2] == 0 && param1[3] == 0)
         {
            _loc4_ = 4;
         }
         else if(_loc5_ >= 3 && param1[0] == 239 && param1[1] == 187 && param1[2] == 191)
         {
            _loc4_ = 3;
         }
         else if(_loc5_ >= 2 && (param1[0] == 254 && param1[1] == 255) || param1[0] == 255 && param1[1] == 254)
         {
            _loc4_ = 2;
         }
         _loc7_ = _loc4_;
         while(_loc7_ < _loc5_)
         {
            _loc3_ = param1[_loc7_];
            if(!(_loc3_ == 0 || _loc3_ == 10 || _loc3_ == 13 || _loc3_ == 32))
            {
               return _loc3_ == _loc6_;
            }
            _loc7_++;
         }
         return false;
      }
      
      private function getDictionaryKeys(param1:Dictionary, param2:String = "", param3:Vector.<String> = null) : Vector.<String>
      {
         if(param3 == null)
         {
            param3 = new Vector.<String>(0);
         }
         var _loc6_:int = 0;
         var _loc5_:* = param1;
         for(var _loc4_ in param1)
         {
            if(_loc4_.indexOf(param2) == 0)
            {
               param3[param3.length] = _loc4_;
            }
         }
         param3.sort(1);
         return param3;
      }
      
      private function getHttpHeader(param1:Array, param2:String) : String
      {
         if(param1)
         {
            var _loc5_:int = 0;
            var _loc4_:* = param1;
            for each(var _loc3_ in param1)
            {
               if(_loc3_.name == param2)
               {
                  return _loc3_.value;
               }
            }
         }
         return null;
      }
      
      protected function getBasenameFromUrl(param1:String) : String
      {
         var _loc2_:Array = NAME_REGEX.exec(param1);
         if(_loc2_ && _loc2_.length > 0)
         {
            return _loc2_[1];
         }
         return null;
      }
      
      protected function getExtensionFromUrl(param1:String) : String
      {
         var _loc2_:Array = NAME_REGEX.exec(param1);
         if(_loc2_ && _loc2_.length > 1)
         {
            return _loc2_[2];
         }
         return null;
      }
      
      private function prependCallback(param1:Function, param2:Function) : Function
      {
         oldCallback = param1;
         newCallback = param2;
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
      
      public function set verbose(param1:Boolean) : void
      {
         mVerbose = param1;
      }
      
      public function get isLoading() : Boolean
      {
         return mNumLoadingQueues > 0;
      }
      
      public function get useMipMaps() : Boolean
      {
         return mDefaultTextureOptions.mipMapping;
      }
      
      public function set useMipMaps(param1:Boolean) : void
      {
         mDefaultTextureOptions.mipMapping = param1;
      }
      
      public function get textureRepeat() : Boolean
      {
         return mDefaultTextureOptions.repeat;
      }
      
      public function set textureRepeat(param1:Boolean) : void
      {
         mDefaultTextureOptions.repeat = param1;
      }
      
      public function get scaleFactor() : Number
      {
         return mDefaultTextureOptions.scale;
      }
      
      public function set scaleFactor(param1:Number) : void
      {
         mDefaultTextureOptions.scale = param1;
      }
      
      public function get textureFormat() : String
      {
         return mDefaultTextureOptions.format;
      }
      
      public function set textureFormat(param1:String) : void
      {
         mDefaultTextureOptions.format = param1;
      }
      
      public function get checkPolicyFile() : Boolean
      {
         return mCheckPolicyFile;
      }
      
      public function set checkPolicyFile(param1:Boolean) : void
      {
         mCheckPolicyFile = param1;
      }
      
      public function get keepAtlasXmls() : Boolean
      {
         return mKeepAtlasXmls;
      }
      
      public function set keepAtlasXmls(param1:Boolean) : void
      {
         mKeepAtlasXmls = param1;
      }
      
      public function get keepFontXmls() : Boolean
      {
         return mKeepFontXmls;
      }
      
      public function set keepFontXmls(param1:Boolean) : void
      {
         mKeepFontXmls = param1;
      }
      
      public function get numConnections() : int
      {
         return mNumConnections;
      }
      
      public function set numConnections(param1:int) : void
      {
         mNumConnections = param1;
      }
      
      public function get atlases() : Dictionary
      {
         return mAtlases;
      }
   }
}
