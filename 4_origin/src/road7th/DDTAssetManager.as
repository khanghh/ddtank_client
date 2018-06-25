package road7th
{
   import bones.loader.BonesLoaderManager;
   import dragonBones.objects.DragonBonesData;
   import dragonBones.textures.NativeTextureAtlas;
   import flash.display.BitmapData;
   import flash.utils.Dictionary;
   import flash.utils.NativeTextureAssetManager;
   import starling.textures.Texture;
   import starling.textures.TextureAtlas;
   import starling.utils.AssetManager;
   
   public class DDTAssetManager
   {
      
      private static var _instance:DDTAssetManager;
       
      
      private var _btmd:Dictionary;
      
      private var _btmdAtlas:Dictionary;
      
      private var _texture:Dictionary;
      
      private var _textureAtlas:Dictionary;
      
      private var _skeletonData:Dictionary;
      
      private var _starlingAsset:AssetManager;
      
      private var _nativeAsset:NativeTextureAssetManager;
      
      private var _dragonBonesDataDic:Dictionary;
      
      public function DDTAssetManager()
      {
         super();
         _starlingAsset = new AssetManager();
         _nativeAsset = new NativeTextureAssetManager();
         _dragonBonesDataDic = new Dictionary();
         _btmd = new Dictionary();
         _btmdAtlas = new Dictionary();
         _texture = new Dictionary();
         _textureAtlas = new Dictionary();
         _skeletonData = new Dictionary();
      }
      
      public static function get instance() : DDTAssetManager
      {
         if(!_instance)
         {
            _instance = new DDTAssetManager();
         }
         return _instance;
      }
      
      public function addSkeletonData(data:DragonBonesData, name:String = null, module:String = "") : void
      {
         if(!data)
         {
            throw new ArgumentError();
         }
         name = name || data.name;
         if(!name)
         {
            throw new ArgumentError("Unnamed data!");
         }
         if(_dragonBonesDataDic[name])
         {
            return;
         }
         if(!_skeletonData[module])
         {
            _skeletonData[module] = new Dictionary();
         }
         _skeletonData[module][name] = true;
         _dragonBonesDataDic[name] = data;
      }
      
      public function addBitmapData(name:String, btmd:BitmapData, module:String = "none") : void
      {
         if(!_btmd[module])
         {
            _btmd[module] = new Dictionary();
         }
         _btmd[module][name] = true;
         trace("DDTAssetManager :: add BTMD name: " + name + " to Module: " + module);
         _nativeAsset.addBitmapData(name,btmd);
      }
      
      public function addBitmapDataAtlas(name:String, atlas:NativeTextureAtlas, module:String = "none") : void
      {
         if(!_btmdAtlas[module])
         {
            _btmdAtlas[module] = new Dictionary();
         }
         _btmdAtlas[module][name] = true;
         trace("DDTAssetManager :: add BTMDAtlas name: " + name + " to Module: " + module);
         _nativeAsset.addBitmapDataAtlas(name,atlas);
      }
      
      public function addTexture(name:String, texture:Texture, module:String = "none") : void
      {
         if(!_texture[module])
         {
            _texture[module] = new Dictionary();
         }
         _texture[module][name] = true;
         trace("DDTAssetManager :: add Texture name: " + name + " to Module: " + module);
         _starlingAsset.addTexture(name,texture);
      }
      
      public function addTextureAtlas(name:String, atlas:TextureAtlas, module:String = "none") : void
      {
         if(!_textureAtlas[module])
         {
            _textureAtlas[module] = new Dictionary();
         }
         _textureAtlas[module][name] = true;
         trace("DDTAssetManager :: add TextureAtlas name: " + name + " to Module: " + module);
         _starlingAsset.addTextureAtlas(name,atlas);
      }
      
      public function removeSkeletonData(name:String) : void
      {
         var module:String = getModuleByName(name,_skeletonData);
         if(module)
         {
            delete _skeletonData[module][name];
         }
         trace("DDTAssetManager :: remove SkeletonData name: " + name + " to Module: " + module);
         (_dragonBonesDataDic[name] as DragonBonesData).dispose();
      }
      
      public function removeBitmapData(name:String, dispose:Boolean = true) : void
      {
         var module:String = getModuleByName(name,_btmd);
         if(module)
         {
            delete _btmd[module][name];
         }
         trace("DDTAssetManager :: remove BTMD name: " + name + " to Module: " + module);
         _nativeAsset.removeBitmapData(name,dispose);
      }
      
      public function removeBitmapDataAtlas(name:String, dispose:Boolean = true) : void
      {
         var module:String = getModuleByName(name,_btmdAtlas);
         if(module)
         {
            delete _btmdAtlas[module][name];
         }
         trace("DDTAssetManager :: remove BTMDAtlas name: " + name + " to Module: " + module);
         BonesLoaderManager.instance.clearBoneLoaderAtlas(name);
         _nativeAsset.removeBitmapDataAtlas(name,dispose);
      }
      
      public function removeTexture(name:String, dispose:Boolean = true) : void
      {
         var module:String = getModuleByName(name,_texture);
         if(module)
         {
            delete _texture[module][name];
         }
         trace("DDTAssetManager :: remove texture name: " + name + " to Module: " + module);
         _starlingAsset.removeTexture(name,dispose);
      }
      
      public function removeTextureAtlas(name:String, dispose:Boolean = true) : void
      {
         var module:String = getModuleByName(name,_textureAtlas);
         if(module)
         {
            delete _textureAtlas[module][name];
         }
         trace("DDTAssetManager :: remove textureAtlas name: " + name + " to Module: " + module);
         BonesLoaderManager.instance.clearBoneLoaderAtlas(name);
         _starlingAsset.removeTextureAtlas(name,dispose);
      }
      
      public function removeSkeletonDataByMoule(module:String) : void
      {
         if(checkModule(module))
         {
            var _loc4_:int = 0;
            var _loc3_:* = _skeletonData[module];
            for(var name in _skeletonData[module])
            {
               (_dragonBonesDataDic[name] as DragonBonesData).dispose();
               delete _dragonBonesDataDic[name];
            }
            _skeletonData[module] = null;
            delete _skeletonData[module];
         }
      }
      
      public function removeBitmapDataByMoule(module:String) : void
      {
         if(checkModule(module))
         {
            var _loc4_:int = 0;
            var _loc3_:* = _btmd[module];
            for(var name in _btmd[module])
            {
               _nativeAsset.removeBitmapData(name);
            }
            _btmd[module] = null;
            delete _btmd[module];
         }
      }
      
      public function removeBitmapDataAtlasByMoule(module:String) : void
      {
         if(checkModule(module))
         {
            var _loc4_:int = 0;
            var _loc3_:* = _btmdAtlas[module];
            for(var name in _btmdAtlas[module])
            {
               BonesLoaderManager.instance.clearBoneLoaderAtlas(name);
               _nativeAsset.removeBitmapDataAtlas(name);
            }
            _btmdAtlas[module] = null;
            delete _btmdAtlas[module];
         }
      }
      
      public function removeTextureByMoule(module:String) : void
      {
         if(checkModule(module))
         {
            var _loc4_:int = 0;
            var _loc3_:* = _texture[module];
            for(var name in _texture[module])
            {
               _starlingAsset.removeTexture(name);
            }
            _texture[module] = null;
            delete _texture[module];
         }
      }
      
      public function removeTextureAtlasByMoule(module:String) : void
      {
         if(checkModule(module))
         {
            var _loc4_:int = 0;
            var _loc3_:* = _textureAtlas[module];
            for(var name in _textureAtlas[module])
            {
               BonesLoaderManager.instance.clearBoneLoaderAtlas(name);
               _starlingAsset.removeTextureAtlas(name);
            }
            _textureAtlas[module] = null;
            delete _textureAtlas[module];
         }
      }
      
      private function getModuleByName(name:String, data:Dictionary) : String
      {
         var _loc8_:int = 0;
         var _loc7_:* = data;
         for(var moduleKey in data)
         {
            var _loc6_:int = 0;
            var _loc5_:* = data[moduleKey];
            for(var nameKey in data[moduleKey])
            {
               if(name == nameKey)
               {
                  return moduleKey;
               }
            }
         }
         return null;
      }
      
      public function getSkeletonData(name:String) : DragonBonesData
      {
         return _dragonBonesDataDic[name];
      }
      
      public function getBitmapData(name:String) : BitmapData
      {
         return _nativeAsset.getBitmapData(name);
      }
      
      public function getBitmapDataAtlas(name:String) : NativeTextureAtlas
      {
         return _nativeAsset.getBitmapDataAtlas(name);
      }
      
      public function getTexture(name:String) : Texture
      {
         return _starlingAsset.getTexture(name);
      }
      
      public function getTextureAtlas(name:String) : TextureAtlas
      {
         return _starlingAsset.getTextureAtlas(name);
      }
      
      public function get nativeAsset() : NativeTextureAssetManager
      {
         return _nativeAsset;
      }
      
      public function get starlingAsset() : AssetManager
      {
         return _starlingAsset;
      }
      
      public function get dragonBonesDataDic() : Dictionary
      {
         return _dragonBonesDataDic;
      }
      
      public function removeAllResByModule(module:String = "default") : void
      {
         trace("DDTAssetManager :: remove AllResModule: " + module);
         removeBitmapDataByMoule(module);
         removeBitmapDataAtlasByMoule(module);
         removeTextureByMoule(module);
         removeTextureAtlasByMoule(module);
         removeSkeletonDataByMoule(module);
      }
      
      public function changeModule(name:String, module:String, useType:int) : Boolean
      {
         var ischange:Boolean = false;
         var data:* = null;
         var i:int = 0;
         var oldModule:* = null;
         var list:Array = [_btmd,_btmdAtlas,_texture,_textureAtlas,_skeletonData];
         if(useType == 2)
         {
            if(!getBitmapDataAtlas(name) || !getTextureAtlas(name))
            {
               return ischange;
            }
         }
         else if(useType == 1)
         {
            if(!getBitmapData(name))
            {
               return ischange;
            }
         }
         else if(useType == 0)
         {
            if(!getTextureAtlas(name))
            {
               return ischange;
            }
         }
         i = 0;
         while(i < list.length)
         {
            data = list[i];
            oldModule = getModuleByName(name,data);
            if(oldModule && data[oldModule][name])
            {
               trace("DDTAssetManager :: changeModule name: " + name + " oldModule:" + oldModule + " to Module: " + module);
               ischange = true;
               if(oldModule != module)
               {
                  data[oldModule][name] = null;
                  delete data[oldModule][name];
                  if(!data[module])
                  {
                     data[module] = new Dictionary();
                  }
                  data[module][name] = true;
               }
            }
            i++;
         }
         return ischange;
      }
      
      private function checkModule(module:String) : Boolean
      {
         if(module == "none")
         {
            trace("remove asset module fail!!!!!!! DDTAssetManager checkModule()");
            return false;
         }
         return true;
      }
      
      public function purge() : void
      {
         _btmd = new Dictionary();
         _btmdAtlas = new Dictionary();
         _texture = new Dictionary();
         _textureAtlas = new Dictionary();
         _skeletonData = new Dictionary();
         _dragonBonesDataDic = new Dictionary();
         _starlingAsset.purge();
         _nativeAsset.purge();
      }
      
      public function dispose() : void
      {
         _starlingAsset.dispose();
         _nativeAsset.dispose();
         var _loc3_:int = 0;
         var _loc2_:* = _dragonBonesDataDic;
         for(var skeletonName in _dragonBonesDataDic)
         {
            (_dragonBonesDataDic[skeletonName] as DragonBonesData).dispose();
            delete _dragonBonesDataDic[skeletonName];
         }
         _dragonBonesDataDic = null;
         _btmd = null;
         _btmdAtlas = null;
         _texture = null;
         _textureAtlas = null;
         _skeletonData = null;
      }
   }
}
