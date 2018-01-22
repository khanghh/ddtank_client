package ddt.manager
{
   import bones.BoneMovieFactory;
   import bones.display.IBoneMovie;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.StarlingObjectUtils;
   import ddt.data.BallInfo;
   import ddt.data.analyze.BallInfoAnalyzer;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.utils.Dictionary;
   import game.objects.BombAsset;
   
   public class BallManager
   {
      
      public static const CRATER:int = 0;
      
      public static const CREATER_BRINK:int = 1;
      
      public static const ADDBALLASSET:String = "addBallAsset";
      
      private static var _list:Vector.<BallInfo>;
      
      private static var sceneEffectDic:Dictionary = new Dictionary();
      
      private static var _instance:BallManager;
       
      
      public var gameInBombAssets:Dictionary;
      
      public function BallManager(){super();}
      
      public static function solveBulletMovieName(param1:int) : String{return null;}
      
      public static function getSceneEffectMovie(param1:String) : MovieClip{return null;}
      
      public static function clearSceneEffectMovie() : void{}
      
      public static function createSceneEffectMovie(param1:int) : MovieClip{return null;}
      
      public static function getSceneEffectMovieBone(param1:String, param2:int = 0) : IBoneMovie{return null;}
      
      public static function clearSceneEffectMovieBone() : void{}
      
      public static function createSceneEffectMovieBone(param1:int, param2:int = 0) : IBoneMovie{return null;}
      
      public static function get instance() : BallManager{return null;}
      
      public function setup(param1:BallInfoAnalyzer) : void{}
      
      public function hasBombAsset(param1:int) : Boolean{return false;}
      
      public function findBall(param1:int) : BallInfo{return null;}
      
      public function solveBlastOutMovieName(param1:int) : String{return null;}
      
      public function solveShootMovieMovieName(param1:int) : String{return null;}
      
      public function createBlastOutMovie(param1:int) : MovieClip{return null;}
      
      public function createBulletMovie(param1:int) : MovieClip{return null;}
      
      public function createShootMovieMovie(param1:int) : MovieClip{return null;}
      
      public function addBombAsset(param1:int, param2:Bitmap, param3:int) : void{}
      
      public function clearAsset() : void{}
      
      public function createSceneEffectBullet(param1:int) : MovieClip{return null;}
      
      public function createSceneEffectBlastOut(param1:int) : MovieClip{return null;}
      
      public function createSceneEffectBulletBone(param1:int, param2:int = 0) : IBoneMovie{return null;}
      
      public function createSceneEffectBlastOutBone(param1:int, param2:int = 0) : IBoneMovie{return null;}
   }
}
