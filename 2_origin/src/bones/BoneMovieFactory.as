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
      
      public function BoneMovieFactory(enforcer:BoneMovieFactoryEnforcer)
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
      
      public function creatBoneMovie(styleName:String, type:int = 0, module:String = "default") : *
      {
         var movie:* = null;
         var error:* = null;
         var factory:* = null;
         var armature:* = null;
         if(styleName == null || styleName == "" || !_model.getBonesStyle(styleName))
         {
            error = new Error("未找到\'" + styleName + "\'的配置，请检查!");
            throw error;
         }
         if(type == 0)
         {
            movie = new BoneMovieStarling(styleName);
            (movie as BoneMovieStarling).touchable = false;
            factory = _starlingFactory;
         }
         else if(type == 1)
         {
            movie = new BoneMovieFlash(styleName);
            (movie as BoneMovieFlash).mouseEnabled = false;
            (movie as BoneMovieFlash).mouseChildren = false;
            factory = _flashFactory;
         }
         else
         {
            throw new Error("骨骼动画创建失败.指定类型异常");
         }
         if(factory.getTextureAtlas(styleName) == null)
         {
            movie.loadWait();
            BonesLoaderManager.instance.startLoader(styleName,type,module);
         }
         else
         {
            armature = getArmature(styleName,factory);
            movie.setArmature(armature,armature.armatureData);
         }
         return movie;
      }
      
      public function analysisFrameArgs(movie:IBoneMovie) : DictionaryData
      {
         var len:int = 0;
         var event:* = null;
         var args:* = null;
         var i:int = 0;
         var object:* = null;
         var listData:DictionaryData = new DictionaryData();
         var data:ArmatureData = movie.armature.armatureData;
         if(data.animationDataList && data.animationDataList.length > 0)
         {
            var _loc14_:int = 0;
            var _loc13_:* = data.animationDataList;
            for each(var aData in data.animationDataList)
            {
               var _loc12_:int = 0;
               var _loc11_:* = aData.frameList;
               for each(var frame in aData.frameList)
               {
                  if(frame.event)
                  {
                     len = frame.event.indexOf("_");
                     if(len > 0)
                     {
                        event = frame.event.slice(0,len);
                        if(event == "args")
                        {
                           args = frame.event.slice(len + 1,frame.event.length).split("|");
                           for(i = 0; i < args.length; )
                           {
                              object = args[i].split(":");
                              listData.add(object[0],object[1]);
                              i++;
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
         return listData;
      }
      
      public function getArmature(styleName:String, factory:BaseFactory) : Armature
      {
         var vo:BoneVo = _model.getBonesStyle(styleName);
         var armature:Armature = factory.buildArmature(styleName,styleName,vo.atlasName);
         return armature;
      }
      
      public function creatBoneMovieFast(styleName:String, module:String = "default") : BoneMovieFastStarling
      {
         var error:* = null;
         var armature:* = null;
         if(styleName == null || styleName == "" || !_model.getBonesStyle(styleName))
         {
            error = new Error("未找到\'" + styleName + "\'的配置，请检查!");
            throw error;
         }
         var movie:BoneMovieFastStarling = new BoneMovieFastStarling(styleName);
         movie.touchable = false;
         if(_starlingFactory.getTextureAtlas(styleName) == null)
         {
            movie.loadWait();
            BonesLoaderManager.instance.startLoader(styleName,0,module);
         }
         else
         {
            armature = getFastArmature(styleName,_starlingFactory);
            movie.setArmature(armature,armature.armatureData);
         }
         return movie;
      }
      
      public function getFastArmature(styleName:String, factory:BaseFactory) : FastArmature
      {
         var vo:BoneVo = _model.getBonesStyle(styleName);
         var armature:FastArmature = factory.buildFastArmature(styleName,styleName,vo.atlasName);
         armature.enableAnimationCache(25);
         return armature;
      }
      
      public function checkTextureAtlas(name:String, useType:int) : Boolean
      {
         if(useType == 0)
         {
            return DDTAssetManager.instance.getTextureAtlas(name);
         }
         if(useType == 1)
         {
            return DDTAssetManager.instance.getBitmapDataAtlas(name);
         }
         return DDTAssetManager.instance.getTextureAtlas(name) && DDTAssetManager.instance.getBitmapDataAtlas(name);
      }
      
      public function get flashFactory() : NativeFactory
      {
         return _flashFactory;
      }
      
      public function get starlingFactory() : StarlingFactory
      {
         return _starlingFactory;
      }
      
      public function hasBoneMovie(styleName:String) : Boolean
      {
         var error:* = null;
         var vo:BoneVo = _model.getBonesStyle(styleName);
         if(styleName == null || styleName == "" || vo == null)
         {
            error = new Error("未找到\'" + styleName + "\'的配置，请检查!");
            throw error;
         }
         if(checkTextureAtlas(vo.atlasName,vo.useType) == false)
         {
            return false;
         }
         if(DDTAssetManager.instance.getSkeletonData(vo.styleName) == null)
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
