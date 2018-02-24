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
      
      public function BoneMovieFactory(param1:BoneMovieFactoryEnforcer){super();}
      
      public static function get instance() : BoneMovieFactory{return null;}
      
      public function setup() : void{}
      
      public function reset() : void{}
      
      public function creatBoneMovie(param1:String, param2:int = 0, param3:String = "default") : *{return null;}
      
      public function analysisFrameArgs(param1:IBoneMovie) : DictionaryData{return null;}
      
      public function getArmature(param1:String, param2:BaseFactory) : Armature{return null;}
      
      public function creatBoneMovieFast(param1:String, param2:String = "default") : BoneMovieFastStarling{return null;}
      
      public function getFastArmature(param1:String, param2:BaseFactory) : FastArmature{return null;}
      
      public function checkTextureAtlas(param1:String, param2:int) : Boolean{return false;}
      
      public function get flashFactory() : NativeFactory{return null;}
      
      public function get starlingFactory() : StarlingFactory{return null;}
      
      public function hasBoneMovie(param1:String) : Boolean{return false;}
      
      public function get model() : BonesModel{return null;}
   }
}

class BoneMovieFactoryEnforcer
{
    
   
   function BoneMovieFactoryEnforcer(){super();}
}
