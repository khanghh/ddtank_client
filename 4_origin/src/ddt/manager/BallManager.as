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
      
      public function BallManager()
      {
         super();
         gameInBombAssets = new Dictionary();
      }
      
      public static function solveBulletMovieName(param1:int) : String
      {
         return "bullet" + param1;
      }
      
      public static function getSceneEffectMovie(param1:String) : MovieClip
      {
         var _loc3_:* = null;
         var _loc2_:* = null;
         var _loc4_:int = 0;
         if(sceneEffectDic.hasOwnProperty(param1))
         {
            _loc3_ = sceneEffectDic[param1];
            _loc4_ = 0;
            while(_loc4_ < _loc3_.length)
            {
               if(_loc3_[_loc4_].parent == null)
               {
                  _loc2_ = _loc3_[_loc4_];
                  break;
               }
               _loc4_++;
            }
            if(_loc2_ == null)
            {
               if(ClassUtils.uiSourceDomain.hasDefinition(param1))
               {
                  _loc2_ = ClassUtils.CreatInstance(param1) as MovieClip;
                  _loc3_.push(_loc2_);
               }
            }
            return _loc2_;
         }
         if(ClassUtils.uiSourceDomain.hasDefinition(param1))
         {
            _loc3_ = [];
            _loc2_ = ClassUtils.CreatInstance(param1) as MovieClip;
            _loc3_.push(_loc2_);
            sceneEffectDic[param1] = _loc3_;
         }
         return _loc2_;
      }
      
      public static function clearSceneEffectMovie() : void
      {
         var _loc2_:* = null;
         var _loc3_:int = 0;
         var _loc5_:int = 0;
         var _loc4_:* = sceneEffectDic;
         for(var _loc1_ in sceneEffectDic)
         {
            _loc2_ = sceneEffectDic[_loc1_];
            _loc3_ = 0;
            while(_loc3_ < _loc2_.length)
            {
               ObjectUtils.disposeObject(_loc2_[_loc3_]);
               _loc3_++;
            }
            delete sceneEffectDic[_loc1_];
         }
      }
      
      public static function createSceneEffectMovie(param1:int) : MovieClip
      {
         var _loc2_:String = "asset.gameBattle.sceneEffectMovie" + param1;
         return getSceneEffectMovie(_loc2_);
      }
      
      public static function getSceneEffectMovieBone(param1:String, param2:int = 0) : IBoneMovie
      {
         var _loc4_:* = null;
         var _loc3_:* = null;
         var _loc5_:int = 0;
         if(sceneEffectDic.hasOwnProperty(param1))
         {
            _loc4_ = sceneEffectDic[param1];
            _loc5_ = 0;
            while(_loc5_ < _loc4_.length)
            {
               if(_loc4_[_loc5_].parent == null)
               {
                  _loc3_ = _loc4_[_loc5_];
                  break;
               }
               _loc5_++;
            }
            if(_loc3_ == null)
            {
               _loc3_ = BoneMovieFactory.instance.creatBoneMovie(param1,param2,"fighting3d");
               _loc4_.push(_loc3_);
            }
         }
         else
         {
            _loc4_ = [];
            _loc3_ = BoneMovieFactory.instance.creatBoneMovie(param1,param2,"fighting3d");
            _loc4_.push(_loc3_);
            sceneEffectDic[param1] = _loc4_;
         }
         return _loc3_;
      }
      
      public static function clearSceneEffectMovieBone() : void
      {
         var _loc2_:* = null;
         var _loc3_:int = 0;
         var _loc5_:int = 0;
         var _loc4_:* = sceneEffectDic;
         for(var _loc1_ in sceneEffectDic)
         {
            _loc2_ = sceneEffectDic[_loc1_];
            _loc3_ = 0;
            while(_loc3_ < _loc2_.length)
            {
               StarlingObjectUtils.disposeObject(_loc2_[_loc3_]);
               _loc3_++;
            }
            delete sceneEffectDic[_loc1_];
         }
      }
      
      public static function createSceneEffectMovieBone(param1:int, param2:int = 0) : IBoneMovie
      {
         var _loc3_:String = "bones.game.sceneEffectMovie" + param1;
         return BoneMovieFactory.instance.creatBoneMovie(_loc3_,param2,"fighting3d");
      }
      
      public static function get instance() : BallManager
      {
         if(!_instance)
         {
            _instance = new BallManager();
         }
         return _instance;
      }
      
      public function setup(param1:BallInfoAnalyzer) : void
      {
         _list = param1.list;
      }
      
      public function hasBombAsset(param1:int) : Boolean
      {
         return gameInBombAssets[param1] != null;
      }
      
      public function findBall(param1:int) : BallInfo
      {
         var _loc2_:* = null;
         var _loc5_:int = 0;
         var _loc4_:* = _list;
         for each(var _loc3_ in _list)
         {
            if(_loc3_.ID == param1)
            {
               _loc2_ = _loc3_;
               break;
            }
         }
         return _loc2_;
      }
      
      public function solveBlastOutMovieName(param1:int) : String
      {
         return "blastOutMovie" + param1;
      }
      
      public function solveShootMovieMovieName(param1:int) : String
      {
         return "shootMovie" + param1;
      }
      
      public function createBlastOutMovie(param1:int) : MovieClip
      {
         return ClassUtils.CreatInstance(solveBlastOutMovieName(param1)) as MovieClip;
      }
      
      public function createBulletMovie(param1:int) : MovieClip
      {
         return ClassUtils.CreatInstance(solveBulletMovieName(param1)) as MovieClip;
      }
      
      public function createShootMovieMovie(param1:int) : MovieClip
      {
         return ClassUtils.CreatInstance(solveShootMovieMovieName(param1)) as MovieClip;
      }
      
      public function addBombAsset(param1:int, param2:Bitmap, param3:int) : void
      {
         if(gameInBombAssets[param1] == null)
         {
            gameInBombAssets[param1] = new BombAsset();
         }
         if(param3 == 0)
         {
            if(gameInBombAssets[param1].crater == null)
            {
               gameInBombAssets[param1].crater = param2;
            }
         }
         else if(param3 == 1)
         {
            if(gameInBombAssets[param1].craterBrink == null)
            {
               gameInBombAssets[param1].craterBrink = param2;
            }
         }
      }
      
      public function clearAsset() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = gameInBombAssets;
         for(var _loc1_ in gameInBombAssets)
         {
            gameInBombAssets[_loc1_].dispose();
            delete gameInBombAssets[_loc1_];
         }
      }
      
      public function createSceneEffectBullet(param1:int) : MovieClip
      {
         var _loc2_:String = "asset.gameBattle.sceneEffectBullet" + param1;
         return getSceneEffectMovie(_loc2_);
      }
      
      public function createSceneEffectBlastOut(param1:int) : MovieClip
      {
         var _loc2_:String = "asset.gameBattle.sceneEffectBlastOut" + param1;
         return getSceneEffectMovie(_loc2_);
      }
      
      public function createSceneEffectBulletBone(param1:int, param2:int = 0) : IBoneMovie
      {
         var _loc3_:String = "bones.game.sceneEffectBullet" + param1;
         return BoneMovieFactory.instance.creatBoneMovie(_loc3_,param2,"fighting3d");
      }
      
      public function createSceneEffectBlastOutBone(param1:int, param2:int = 0) : IBoneMovie
      {
         var _loc3_:String = "bones.game.sceneEffectBlastOut" + param1;
         return BoneMovieFactory.instance.creatBoneMovie(_loc3_,param2,"fighting3d");
      }
   }
}
