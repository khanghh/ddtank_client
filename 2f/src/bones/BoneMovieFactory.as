package bones{   import bones.display.BoneMovieFastStarling;   import bones.display.BoneMovieFlash;   import bones.display.BoneMovieStarling;   import bones.display.IBoneMovie;   import bones.loader.BonesLoaderManager;   import bones.model.BoneVo;   import bones.model.BonesModel;   import dragonBones.Armature;   import dragonBones.animation.WorldClock;   import dragonBones.factories.BaseFactory;   import dragonBones.factories.NativeFactory;   import dragonBones.factories.StarlingFactory;   import dragonBones.fast.FastArmature;   import dragonBones.objects.AnimationData;   import dragonBones.objects.ArmatureData;   import dragonBones.objects.Frame;   import road7th.DDTAssetManager;   import road7th.data.DictionaryData;   import starling.core.Starling;      public class BoneMovieFactory   {            private static var _instance:BoneMovieFactory;                   private var _starlingFactory:StarlingFactory;            private var _flashFactory:NativeFactory;            private var _model:BonesModel;            public function BoneMovieFactory(enforcer:BoneMovieFactoryEnforcer) { super(); }
            public static function get instance() : BoneMovieFactory { return null; }
            public function setup() : void { }
            public function reset() : void { }
            public function creatBoneMovie(styleName:String, type:int = 0, module:String = "default") : * { return null; }
            public function analysisFrameArgs(movie:IBoneMovie) : DictionaryData { return null; }
            public function getArmature(styleName:String, factory:BaseFactory) : Armature { return null; }
            public function creatBoneMovieFast(styleName:String, module:String = "default") : BoneMovieFastStarling { return null; }
            public function getFastArmature(styleName:String, factory:BaseFactory) : FastArmature { return null; }
            public function checkTextureAtlas(name:String, useType:int) : Boolean { return false; }
            public function get flashFactory() : NativeFactory { return null; }
            public function get starlingFactory() : StarlingFactory { return null; }
            public function hasBoneMovie(styleName:String) : Boolean { return false; }
            public function get model() : BonesModel { return null; }
   }}class BoneMovieFactoryEnforcer{          function BoneMovieFactoryEnforcer() { super(); }
}