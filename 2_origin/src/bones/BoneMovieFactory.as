package bones
{
   import bones.display.BoneMovieFastStarling;
   import bones.display.BoneMovieFlash;
   import bones.display.BoneMovieStarling;
   import bones.display.IBoneMovie;
   import bones.loader.BonesLoaderManager;
   import bones.model.BoneVo;
   import bones.model.BonesModel;
   import dragonBones.Armature;
   import dragonBones.animation.WorldClock;
   import dragonBones.factories.BaseFactory;
   import dragonBones.factories.NativeFactory;
   import dragonBones.factories.StarlingFactory;
   import dragonBones.fast.FastArmature;
   import dragonBones.objects.AnimationData;
   import dragonBones.objects.ArmatureData;
   import dragonBones.objects.Frame;
   import road7th.DDTAssetManager;
   import road7th.data.DictionaryData;
   import starling.core.Starling;
   
   public class BoneMovieFactory
   {
      
      private static var _instance:BoneMovieFactory;
       
      
      private var _starlingFactory:StarlingFactory;
      
      private var _flashFactory:NativeFactory;
      
      private var _model:BonesModel;
      
      public function BoneMovieFactory(param1:BoneMovieFactoryEnforcer)
      {
         super();
         _model = new BonesModel();
      }
      
      public static function get instance() : BoneMovieFactory
      {
         if(_instance == null)
         {
            _instance = new BoneMovieFactory(new BoneMovieFactoryEnforcer());
         }
         return _instance;
      }
      
      public function setup() : void
      {
         _starlingFactory = new StarlingFactory();
         _flashFactory = new NativeFactory();
         _flashFactory.fillBitmapSmooth = true;
         Starling.juggler.add(WorldClock.clock);
      }
      
      public function reset() : void
      {
         Starling.juggler.remove(WorldClock.clock);
         if(_starlingFactory)
         {
            _starlingFactory.dispose(true);
         }
         if(_flashFactory)
         {
            _flashFactory.dispose(true);
         }
         BonesLoaderManager.instance.clear();
         setup();
      }
      
      public function creatBoneMovie(param1:String, param2:int = 0, param3:String = "default") : *
      {
         var _loc6_:* = null;
         var _loc5_:* = null;
         var _loc7_:* = null;
         var _loc4_:* = null;
         if(param1 == null || param1 == "" || !_model.getBonesStyle(param1))
         {
            _loc5_ = new Error("未找到\'" + param1 + "\'的配置，请检查!");
            throw _loc5_;
         }
         if(param2 == 0)
         {
            _loc6_ = new BoneMovieStarling(param1);
            (_loc6_ as BoneMovieStarling).touchable = false;
            _loc7_ = _starlingFactory;
         }
         else if(param2 == 1)
         {
            _loc6_ = new BoneMovieFlash(param1);
            (_loc6_ as BoneMovieFlash).mouseEnabled = false;
            (_loc6_ as BoneMovieFlash).mouseChildren = false;
            _loc7_ = _flashFactory;
         }
         else
         {
            throw new Error("骨骼动画创建失败.指定类型异常");
         }
         if(_loc7_.getTextureAtlas(param1) == null)
         {
            _loc6_.loadWait();
            BonesLoaderManager.instance.startLoader(param1,param2,param3);
         }
         else
         {
            _loc4_ = getArmature(param1,_loc7_);
            _loc6_.setArmature(_loc4_,_loc4_.armatureData);
         }
         return _loc6_;
      }
      
      public function analysisFrameArgs(param1:IBoneMovie) : DictionaryData
      {
         var _loc8_:int = 0;
         var _loc4_:* = null;
         var _loc3_:* = null;
         var _loc10_:int = 0;
         var _loc7_:* = null;
         var _loc9_:DictionaryData = new DictionaryData();
         var _loc5_:ArmatureData = param1.armature.armatureData;
         if(_loc5_.animationDataList && _loc5_.animationDataList.length > 0)
         {
            var _loc14_:int = 0;
            var _loc13_:* = _loc5_.animationDataList;
            for each(var _loc6_ in _loc5_.animationDataList)
            {
               var _loc12_:int = 0;
               var _loc11_:* = _loc6_.frameList;
               for each(var _loc2_ in _loc6_.frameList)
               {
                  if(_loc2_.event)
                  {
                     _loc8_ = _loc2_.event.indexOf("_");
                     if(_loc8_ > 0)
                     {
                        _loc4_ = _loc2_.event.slice(0,_loc8_);
                        if(_loc4_ == "args")
                        {
                           _loc3_ = _loc2_.event.slice(_loc8_ + 1,_loc2_.event.length).split("|");
                           _loc10_ = 0;
                           while(_loc10_ < _loc3_.length)
                           {
                              _loc7_ = _loc3_[_loc10_].split(":");
                              _loc9_.add(_loc7_[0],_loc7_[1]);
                              _loc10_++;
                           }
                           continue;
                        }
                        continue;
                     }
                     continue;
                  }
               }
            }
         }
         return _loc9_;
      }
      
      public function getArmature(param1:String, param2:BaseFactory) : Armature
      {
         var _loc4_:BoneVo = _model.getBonesStyle(param1);
         var _loc3_:Armature = param2.buildArmature(param1,param1,_loc4_.atlasName);
         return _loc3_;
      }
      
      public function creatBoneMovieFast(param1:String, param2:String = "default") : BoneMovieFastStarling
      {
         var _loc4_:* = null;
         var _loc3_:* = null;
         if(param1 == null || param1 == "" || !_model.getBonesStyle(param1))
         {
            _loc4_ = new Error("未找到\'" + param1 + "\'的配置，请检查!");
            throw _loc4_;
         }
         var _loc5_:BoneMovieFastStarling = new BoneMovieFastStarling(param1);
         _loc5_.touchable = false;
         if(_starlingFactory.getTextureAtlas(param1) == null)
         {
            _loc5_.loadWait();
            BonesLoaderManager.instance.startLoader(param1,0,param2);
         }
         else
         {
            _loc3_ = getFastArmature(param1,_starlingFactory);
            _loc5_.setArmature(_loc3_,_loc3_.armatureData);
         }
         return _loc5_;
      }
      
      public function getFastArmature(param1:String, param2:BaseFactory) : FastArmature
      {
         var _loc4_:BoneVo = _model.getBonesStyle(param1);
         var _loc3_:FastArmature = param2.buildFastArmature(param1,param1,_loc4_.atlasName);
         _loc3_.enableAnimationCache(25);
         return _loc3_;
      }
      
      public function checkTextureAtlas(param1:String, param2:int) : Boolean
      {
         if(param2 == 0)
         {
            return DDTAssetManager.instance.getTextureAtlas(param1);
         }
         if(param2 == 1)
         {
            return DDTAssetManager.instance.getBitmapDataAtlas(param1);
         }
         return DDTAssetManager.instance.getTextureAtlas(param1) && DDTAssetManager.instance.getBitmapDataAtlas(param1);
      }
      
      public function get flashFactory() : NativeFactory
      {
         return _flashFactory;
      }
      
      public function get starlingFactory() : StarlingFactory
      {
         return _starlingFactory;
      }
      
      public function hasBoneMovie(param1:String) : Boolean
      {
         var _loc2_:* = null;
         var _loc3_:BoneVo = _model.getBonesStyle(param1);
         if(param1 == null || param1 == "" || _loc3_ == null)
         {
            _loc2_ = new Error("未找到\'" + param1 + "\'的配置，请检查!");
            throw _loc2_;
         }
         if(checkTextureAtlas(_loc3_.atlasName,_loc3_.useType) == false)
         {
            return false;
         }
         if(DDTAssetManager.instance.getSkeletonData(_loc3_.styleName) == null)
         {
            return false;
         }
         return true;
      }
      
      public function get model() : BonesModel
      {
         return _model;
      }
   }
}

class BoneMovieFactoryEnforcer
{
    
   
   function BoneMovieFactoryEnforcer()
   {
      super();
   }
}
