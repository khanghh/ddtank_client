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
      
      public function load(param1:Array, param2:Function, param3:String = "none") : void
      {
         var _loc6_:* = null;
         var _loc4_:* = null;
         var _loc5_:int = 0;
         var _loc8_:* = null;
         _assetArr = param1.concat();
         _onComplete = param2;
         _module = param3;
         _queueLoader = new QueueLoader();
         var _loc10_:int = 0;
         var _loc9_:* = _assetArr;
         for each(var _loc7_ in _assetArr)
         {
            _loc6_ = NAME_REGEX.exec(_loc7_.url);
            if(_loc6_.length < 3)
            {
               throw new Error("scene asset url error:" + _loc7_.url);
            }
            _loc7_.name = _loc6_[1];
            _loc4_ = _loc6_[2];
            _loc7_.extension = _loc4_;
            if(_loc4_ == "png")
            {
               _loc5_ = 0;
            }
            else if(_loc4_ == "json" || _loc4_ == "xml")
            {
               _loc5_ = 2;
            }
            else if(_loc4_ == "swf")
            {
               _loc5_ = 3;
            }
            _loc7_.loaderType = _loc5_;
            _loc8_ = LoadResourceManager.Instance.createLoader(_loc7_.url,_loc5_);
            _loc7_.loader = _loc8_;
            _queueLoader.addLoader(_loc8_);
         }
         _queueLoader.addEventListener("complete",onQueueLoaderComplete);
         _queueLoader.start();
      }
      
      private function onQueueLoaderComplete(param1:Event) : void
      {
         var _loc6_:* = null;
         var _loc2_:* = null;
         var _loc7_:* = null;
         var _loc5_:* = null;
         var _loc3_:* = null;
         var _loc10_:* = null;
         var _loc11_:* = null;
         var _loc9_:* = null;
         var _loc4_:* = null;
         var _loc8_:* = null;
         var _loc13_:int = 0;
         var _loc12_:* = _assetArr;
         for each(_loc6_ in _assetArr)
         {
            _loc2_ = _loc6_.extension;
            if(_loc6_.hasOwnProperty("loader"))
            {
               if(_loc2_ == "png")
               {
                  _loc3_ = BitmapLoader(_loc6_.loader);
                  _loc5_ = !!_loc6_.hasOwnProperty("module")?_loc6_.module:_module;
                  if(!DDTAssetManager.instance.getTexture(_loc6_.name))
                  {
                     _loc7_ = Texture.fromBitmapData(_loc3_.bitmapData,false);
                     addTexture(_loc6_,_loc7_);
                     DDTAssetManager.instance.addTexture(_loc6_.name,_loc7_,_loc5_);
                  }
                  if(_loc6_.hasOwnProperty("useType") && !DDTAssetManager.instance.getBitmapData(_loc6_.name))
                  {
                     DDTAssetManager.instance.addBitmapData(_loc6_.name,_loc3_.bitmapData.clone(),_loc5_);
                  }
                  _loc3_.bitmapData.dispose();
               }
               else if(_loc2_ == "swf")
               {
                  _loc10_ = BaseLoader(_loc6_.loader);
                  _loc5_ = !!_loc6_.hasOwnProperty("module")?_loc6_.module:_module;
                  if(!DDTAssetManager.instance.getTexture(_loc6_.name))
                  {
                     _loc7_ = Texture.fromData(_loc10_.content);
                     addAtfTexture(_loc6_,_loc7_);
                     DDTAssetManager.instance.addTexture(_loc6_.name,_loc7_,_loc5_);
                  }
               }
            }
         }
         var _loc15_:int = 0;
         var _loc14_:* = _assetArr;
         for each(_loc6_ in _assetArr)
         {
            _loc2_ = _loc6_.extension;
            _loc5_ = !!_loc6_.hasOwnProperty("module")?_loc6_.module:_module;
            if(_loc6_.hasOwnProperty("loader") && _loc2_ == "xml")
            {
               _loc11_ = TextLoader(_loc6_.loader);
               _loc9_ = new XML(_loc11_.content);
               if(_loc9_.localName() == "TextureAtlas")
               {
                  _loc4_ = _loc6_.name;
                  _loc7_ = DDTAssetManager.instance.getTexture(_loc4_);
                  if(_loc7_)
                  {
                     DDTAssetManager.instance.addTextureAtlas(_loc4_,new TextureAtlas(_loc7_,_loc9_),_loc5_);
                     DDTAssetManager.instance.removeTexture(_loc4_,false);
                  }
                  if(_loc6_.hasOwnProperty("useType"))
                  {
                     _loc8_ = DDTAssetManager.instance.getBitmapData(_loc6_.name);
                     if(_loc8_)
                     {
                        DDTAssetManager.instance.addBitmapDataAtlas(_loc4_,new NativeTextureAtlas(_loc8_,_loc9_),_loc5_);
                        DDTAssetManager.instance.removeBitmapData(_loc4_);
                     }
                  }
                  System.disposeXML(_loc9_);
               }
            }
         }
      }
      
      private function addTexture(param1:Object, param2:Texture) : void
      {
         assetInfo = param1;
         texture = param2;
         if(Starling.handleLostContext)
         {
            texture.root.onRestore = function():void
            {
               onLoadComplete = function(param1:LoaderEvent):void
               {
                  loader.removeEventListener("complete",onLoadComplete);
                  var _loc2_:BitmapData = loader.bitmapData;
                  texture.root.uploadBitmapData(_loc2_);
                  _loc2_.dispose();
               };
               var loader:BitmapLoader = LoadResourceManager.Instance.createLoader(assetInfo.url,0);
               loader.isComplete = false;
               loader.addEventListener("complete",onLoadComplete);
               LoadResourceManager.Instance.startLoad(loader);
            };
         }
      }
      
      private function addAtfTexture(param1:Object, param2:Texture) : void
      {
         assetInfo = param1;
         texture = param2;
         if(Starling.handleLostContext)
         {
            texture.root.onRestore = function():void
            {
               onLoadComplete = function(param1:LoaderEvent):void
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
