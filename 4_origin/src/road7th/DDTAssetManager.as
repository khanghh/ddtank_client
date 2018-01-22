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
      
      public function addSkeletonData(param1:DragonBonesData, param2:String = null, param3:String = "") : void
      {
         if(!param1)
         {
            throw new ArgumentError();
         }
         param2 = param2 || param1.name;
         if(!param2)
         {
            throw new ArgumentError("Unnamed data!");
         }
         if(_dragonBonesDataDic[param2])
         {
            return;
         }
         if(!_skeletonData[param3])
         {
            _skeletonData[param3] = new Dictionary();
         }
         _skeletonData[param3][param2] = true;
         _dragonBonesDataDic[param2] = param1;
      }
      
      public function addBitmapData(param1:String, param2:BitmapData, param3:String = "none") : void
      {
         if(!_btmd[param3])
         {
            _btmd[param3] = new Dictionary();
         }
         _btmd[param3][param1] = true;
         trace("DDTAssetManager :: add BTMD name: " + param1 + " to Module: " + param3);
         _nativeAsset.addBitmapData(param1,param2);
      }
      
      public function addBitmapDataAtlas(param1:String, param2:NativeTextureAtlas, param3:String = "none") : void
      {
         if(!_btmdAtlas[param3])
         {
            _btmdAtlas[param3] = new Dictionary();
         }
         _btmdAtlas[param3][param1] = true;
         trace("DDTAssetManager :: add BTMDAtlas name: " + param1 + " to Module: " + param3);
         _nativeAsset.addBitmapDataAtlas(param1,param2);
      }
      
      public function addTexture(param1:String, param2:Texture, param3:String = "none") : void
      {
         if(!_texture[param3])
         {
            _texture[param3] = new Dictionary();
         }
         _texture[param3][param1] = true;
         trace("DDTAssetManager :: add Texture name: " + param1 + " to Module: " + param3);
         _starlingAsset.addTexture(param1,param2);
      }
      
      public function addTextureAtlas(param1:String, param2:TextureAtlas, param3:String = "none") : void
      {
         if(!_textureAtlas[param3])
         {
            _textureAtlas[param3] = new Dictionary();
         }
         _textureAtlas[param3][param1] = true;
         trace("DDTAssetManager :: add TextureAtlas name: " + param1 + " to Module: " + param3);
         _starlingAsset.addTextureAtlas(param1,param2);
      }
      
      public function removeSkeletonData(param1:String) : void
      {
         var _loc2_:String = getModuleByName(param1,_skeletonData);
         if(_loc2_)
         {
            delete _skeletonData[_loc2_][param1];
         }
         trace("DDTAssetManager :: remove SkeletonData name: " + param1 + " to Module: " + _loc2_);
         (_dragonBonesDataDic[param1] as DragonBonesData).dispose();
      }
      
      public function removeBitmapData(param1:String, param2:Boolean = true) : void
      {
         var _loc3_:String = getModuleByName(param1,_btmd);
         if(_loc3_)
         {
            delete _btmd[_loc3_][param1];
         }
         trace("DDTAssetManager :: remove BTMD name: " + param1 + " to Module: " + _loc3_);
         _nativeAsset.removeBitmapData(param1,param2);
      }
      
      public function removeBitmapDataAtlas(param1:String, param2:Boolean = true) : void
      {
         var _loc3_:String = getModuleByName(param1,_btmdAtlas);
         if(_loc3_)
         {
            delete _btmdAtlas[_loc3_][param1];
         }
         trace("DDTAssetManager :: remove BTMDAtlas name: " + param1 + " to Module: " + _loc3_);
         BonesLoaderManager.instance.clearBoneLoaderAtlas(param1);
         _nativeAsset.removeBitmapDataAtlas(param1,param2);
      }
      
      public function removeTexture(param1:String, param2:Boolean = true) : void
      {
         var _loc3_:String = getModuleByName(param1,_texture);
         if(_loc3_)
         {
            delete _texture[_loc3_][param1];
         }
         trace("DDTAssetManager :: remove texture name: " + param1 + " to Module: " + _loc3_);
         _starlingAsset.removeTexture(param1,param2);
      }
      
      public function removeTextureAtlas(param1:String, param2:Boolean = true) : void
      {
         var _loc3_:String = getModuleByName(param1,_textureAtlas);
         if(_loc3_)
         {
            delete _textureAtlas[_loc3_][param1];
         }
         trace("DDTAssetManager :: remove textureAtlas name: " + param1 + " to Module: " + _loc3_);
         BonesLoaderManager.instance.clearBoneLoaderAtlas(param1);
         _starlingAsset.removeTextureAtlas(param1,param2);
      }
      
      public function removeSkeletonDataByMoule(param1:String) : void
      {
         if(checkModule(param1))
         {
            var _loc4_:int = 0;
            var _loc3_:* = _skeletonData[param1];
            for(var _loc2_ in _skeletonData[param1])
            {
               (_dragonBonesDataDic[_loc2_] as DragonBonesData).dispose();
               delete _dragonBonesDataDic[_loc2_];
            }
            _skeletonData[param1] = null;
            delete _skeletonData[param1];
         }
      }
      
      public function removeBitmapDataByMoule(param1:String) : void
      {
         if(checkModule(param1))
         {
            var _loc4_:int = 0;
            var _loc3_:* = _btmd[param1];
            for(var _loc2_ in _btmd[param1])
            {
               _nativeAsset.removeBitmapData(_loc2_);
            }
            _btmd[param1] = null;
            delete _btmd[param1];
         }
      }
      
      public function removeBitmapDataAtlasByMoule(param1:String) : void
      {
         if(checkModule(param1))
         {
            var _loc4_:int = 0;
            var _loc3_:* = _btmdAtlas[param1];
            for(var _loc2_ in _btmdAtlas[param1])
            {
               BonesLoaderManager.instance.clearBoneLoaderAtlas(_loc2_);
               _nativeAsset.removeBitmapDataAtlas(_loc2_);
            }
            _btmdAtlas[param1] = null;
            delete _btmdAtlas[param1];
         }
      }
      
      public function removeTextureByMoule(param1:String) : void
      {
         if(checkModule(param1))
         {
            var _loc4_:int = 0;
            var _loc3_:* = _texture[param1];
            for(var _loc2_ in _texture[param1])
            {
               _starlingAsset.removeTexture(_loc2_);
            }
            _texture[param1] = null;
            delete _texture[param1];
         }
      }
      
      public function removeTextureAtlasByMoule(param1:String) : void
      {
         if(checkModule(param1))
         {
            var _loc4_:int = 0;
            var _loc3_:* = _textureAtlas[param1];
            for(var _loc2_ in _textureAtlas[param1])
            {
               BonesLoaderManager.instance.clearBoneLoaderAtlas(_loc2_);
               _starlingAsset.removeTextureAtlas(_loc2_);
            }
            _textureAtlas[param1] = null;
            delete _textureAtlas[param1];
         }
      }
      
      private function getModuleByName(param1:String, param2:Dictionary) : String
      {
         var _loc8_:int = 0;
         var _loc7_:* = param2;
         for(var _loc4_ in param2)
         {
            var _loc6_:int = 0;
            var _loc5_:* = param2[_loc4_];
            for(var _loc3_ in param2[_loc4_])
            {
               if(param1 == _loc3_)
               {
                  return _loc4_;
               }
            }
         }
         return null;
      }
      
      public function getSkeletonData(param1:String) : DragonBonesData
      {
         return _dragonBonesDataDic[param1];
      }
      
      public function getBitmapData(param1:String) : BitmapData
      {
         return _nativeAsset.getBitmapData(param1);
      }
      
      public function getBitmapDataAtlas(param1:String) : NativeTextureAtlas
      {
         return _nativeAsset.getBitmapDataAtlas(param1);
      }
      
      public function getTexture(param1:String) : Texture
      {
         return _starlingAsset.getTexture(param1);
      }
      
      public function getTextureAtlas(param1:String) : TextureAtlas
      {
         return _starlingAsset.getTextureAtlas(param1);
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
      
      public function removeAllResByModule(param1:String = "default") : void
      {
         trace("DDTAssetManager :: remove AllResModule: " + param1);
         removeBitmapDataByMoule(param1);
         removeBitmapDataAtlasByMoule(param1);
         removeTextureByMoule(param1);
         removeTextureAtlasByMoule(param1);
         removeSkeletonDataByMoule(param1);
      }
      
      public function changeModule(param1:String, param2:String, param3:int) : Boolean
      {
         var _loc4_:Boolean = false;
         var _loc5_:* = null;
         var _loc8_:int = 0;
         var _loc7_:* = null;
         var _loc6_:Array = [_btmd,_btmdAtlas,_texture,_textureAtlas,_skeletonData];
         if(param3 == 2)
         {
            if(!getBitmapDataAtlas(param1) || !getTextureAtlas(param1))
            {
               return _loc4_;
            }
         }
         else if(param3 == 1)
         {
            if(!getBitmapData(param1))
            {
               return _loc4_;
            }
         }
         else if(param3 == 0)
         {
            if(!getTextureAtlas(param1))
            {
               return _loc4_;
            }
         }
         _loc8_ = 0;
         while(_loc8_ < _loc6_.length)
         {
            _loc5_ = _loc6_[_loc8_];
            _loc7_ = getModuleByName(param1,_loc5_);
            if(_loc7_ && _loc5_[_loc7_][param1])
            {
               trace("DDTAssetManager :: changeModule name: " + param1 + " oldModule:" + _loc7_ + " to Module: " + param2);
               _loc4_ = true;
               if(_loc7_ != param2)
               {
                  _loc5_[_loc7_][param1] = null;
                  delete _loc5_[_loc7_][param1];
                  if(!_loc5_[param2])
                  {
                     _loc5_[param2] = new Dictionary();
                  }
                  _loc5_[param2][param1] = true;
               }
            }
            _loc8_++;
         }
         return _loc4_;
      }
      
      private function checkModule(param1:String) : Boolean
      {
         if(param1 == "none")
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
         for(var _loc1_ in _dragonBonesDataDic)
         {
            (_dragonBonesDataDic[_loc1_] as DragonBonesData).dispose();
            delete _dragonBonesDataDic[_loc1_];
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
