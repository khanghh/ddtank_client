package ddt.manager{   import bones.BoneMovieFactory;   import bones.display.IBoneMovie;   import com.pickgliss.utils.ClassUtils;   import com.pickgliss.utils.ObjectUtils;   import com.pickgliss.utils.StarlingObjectUtils;   import ddt.data.BallInfo;   import ddt.data.analyze.BallInfoAnalyzer;   import flash.display.Bitmap;   import flash.display.MovieClip;   import flash.utils.Dictionary;   import game.objects.BombAsset;      public class BallManager   {            public static const CRATER:int = 0;            public static const CREATER_BRINK:int = 1;            public static const ADDBALLASSET:String = "addBallAsset";            private static var _list:Vector.<BallInfo>;            private static var sceneEffectDic:Dictionary = new Dictionary();            private static var _instance:BallManager;                   public var gameInBombAssets:Dictionary;            public function BallManager() { super(); }
            public static function solveBulletMovieName(id:int) : String { return null; }
            public static function getSceneEffectMovie(movieName:String) : MovieClip { return null; }
            public static function clearSceneEffectMovie() : void { }
            public static function createSceneEffectMovie(id:int) : MovieClip { return null; }
            public static function getSceneEffectMovieBone(movieName:String, type:int = 0) : IBoneMovie { return null; }
            public static function clearSceneEffectMovieBone() : void { }
            public static function createSceneEffectMovieBone(id:int, type:int = 0) : IBoneMovie { return null; }
            public static function get instance() : BallManager { return null; }
            public function setup(analyzer:BallInfoAnalyzer) : void { }
            public function hasBombAsset(id:int) : Boolean { return false; }
            public function findBall(id:int) : BallInfo { return null; }
            public function solveBlastOutMovieName(id:int) : String { return null; }
            public function solveShootMovieMovieName(id:int) : String { return null; }
            public function createBlastOutMovie(id:int) : MovieClip { return null; }
            public function createBulletMovie(id:int) : MovieClip { return null; }
            public function createShootMovieMovie(id:int) : MovieClip { return null; }
            public function addBombAsset(id:int, asset:Bitmap, type:int) : void { }
            public function clearAsset() : void { }
            public function createSceneEffectBullet(id:int) : MovieClip { return null; }
            public function createSceneEffectBlastOut(id:int) : MovieClip { return null; }
            public function createSceneEffectBulletBone(id:int, type:int = 0) : IBoneMovie { return null; }
            public function createSceneEffectBlastOutBone(id:int, type:int = 0) : IBoneMovie { return null; }
   }}