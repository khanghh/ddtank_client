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
      
      public static function solveBulletMovieName(id:int) : String
      {
         return "bullet" + id;
      }
      
      public static function getSceneEffectMovie(movieName:String) : MovieClip
      {
         var movies:* = null;
         var currentMovie:* = null;
         var i:int = 0;
         if(sceneEffectDic.hasOwnProperty(movieName))
         {
            movies = sceneEffectDic[movieName];
            for(i = 0; i < movies.length; )
            {
               if(movies[i].parent == null)
               {
                  currentMovie = movies[i];
                  break;
               }
               i++;
            }
            if(currentMovie == null)
            {
               if(ClassUtils.uiSourceDomain.hasDefinition(movieName))
               {
                  currentMovie = ClassUtils.CreatInstance(movieName) as MovieClip;
                  movies.push(currentMovie);
               }
            }
            return currentMovie;
         }
         if(ClassUtils.uiSourceDomain.hasDefinition(movieName))
         {
            movies = [];
            currentMovie = ClassUtils.CreatInstance(movieName) as MovieClip;
            movies.push(currentMovie);
            sceneEffectDic[movieName] = movies;
         }
         return currentMovie;
      }
      
      public static function clearSceneEffectMovie() : void
      {
         var movies:* = null;
         var i:int = 0;
         var _loc5_:int = 0;
         var _loc4_:* = sceneEffectDic;
         for(var movieName in sceneEffectDic)
         {
            movies = sceneEffectDic[movieName];
            for(i = 0; i < movies.length; )
            {
               ObjectUtils.disposeObject(movies[i]);
               i++;
            }
            delete sceneEffectDic[movieName];
         }
      }
      
      public static function createSceneEffectMovie(id:int) : MovieClip
      {
         var sceneEffectMovieName:String = "asset.gameBattle.sceneEffectMovie" + id;
         return getSceneEffectMovie(sceneEffectMovieName);
      }
      
      public static function getSceneEffectMovieBone(movieName:String, type:int = 0) : IBoneMovie
      {
         var movies:* = null;
         var currentMovie:* = null;
         var i:int = 0;
         if(sceneEffectDic.hasOwnProperty(movieName))
         {
            movies = sceneEffectDic[movieName];
            for(i = 0; i < movies.length; )
            {
               if(movies[i].parent == null)
               {
                  currentMovie = movies[i];
                  break;
               }
               i++;
            }
            if(currentMovie == null)
            {
               currentMovie = BoneMovieFactory.instance.creatBoneMovie(movieName,type,"fighting3d");
               movies.push(currentMovie);
            }
         }
         else
         {
            movies = [];
            currentMovie = BoneMovieFactory.instance.creatBoneMovie(movieName,type,"fighting3d");
            movies.push(currentMovie);
            sceneEffectDic[movieName] = movies;
         }
         return currentMovie;
      }
      
      public static function clearSceneEffectMovieBone() : void
      {
         var movies:* = null;
         var i:int = 0;
         var _loc5_:int = 0;
         var _loc4_:* = sceneEffectDic;
         for(var movieName in sceneEffectDic)
         {
            movies = sceneEffectDic[movieName];
            for(i = 0; i < movies.length; )
            {
               StarlingObjectUtils.disposeObject(movies[i]);
               i++;
            }
            delete sceneEffectDic[movieName];
         }
      }
      
      public static function createSceneEffectMovieBone(id:int, type:int = 0) : IBoneMovie
      {
         var sceneEffectMovieName:String = "bones.game.sceneEffectMovie" + id;
         return BoneMovieFactory.instance.creatBoneMovie(sceneEffectMovieName,type,"fighting3d");
      }
      
      public static function get instance() : BallManager
      {
         if(!_instance)
         {
            _instance = new BallManager();
         }
         return _instance;
      }
      
      public function setup(analyzer:BallInfoAnalyzer) : void
      {
         _list = analyzer.list;
      }
      
      public function hasBombAsset(id:int) : Boolean
      {
         return gameInBombAssets[id] != null;
      }
      
      public function findBall(id:int) : BallInfo
      {
         var result:* = null;
         var _loc5_:int = 0;
         var _loc4_:* = _list;
         for each(var info in _list)
         {
            if(info.ID == id)
            {
               result = info;
               break;
            }
         }
         return result;
      }
      
      public function solveBlastOutMovieName(id:int) : String
      {
         return "blastOutMovie" + id;
      }
      
      public function solveShootMovieMovieName(id:int) : String
      {
         return "shootMovie" + id;
      }
      
      public function createBlastOutMovie(id:int) : MovieClip
      {
         return ClassUtils.CreatInstance(solveBlastOutMovieName(id)) as MovieClip;
      }
      
      public function createBulletMovie(id:int) : MovieClip
      {
         return ClassUtils.CreatInstance(solveBulletMovieName(id)) as MovieClip;
      }
      
      public function createShootMovieMovie(id:int) : MovieClip
      {
         return ClassUtils.CreatInstance(solveShootMovieMovieName(id)) as MovieClip;
      }
      
      public function addBombAsset(id:int, asset:Bitmap, type:int) : void
      {
         if(gameInBombAssets[id] == null)
         {
            gameInBombAssets[id] = new BombAsset();
         }
         if(type == 0)
         {
            if(gameInBombAssets[id].crater == null)
            {
               gameInBombAssets[id].crater = asset;
            }
         }
         else if(type == 1)
         {
            if(gameInBombAssets[id].craterBrink == null)
            {
               gameInBombAssets[id].craterBrink = asset;
            }
         }
      }
      
      public function clearAsset() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = gameInBombAssets;
         for(var id in gameInBombAssets)
         {
            gameInBombAssets[id].dispose();
            delete gameInBombAssets[id];
         }
      }
      
      public function createSceneEffectBullet(id:int) : MovieClip
      {
         var sceneEffectBulletName:String = "asset.gameBattle.sceneEffectBullet" + id;
         return getSceneEffectMovie(sceneEffectBulletName);
      }
      
      public function createSceneEffectBlastOut(id:int) : MovieClip
      {
         var sceneEffectBlastOutName:String = "asset.gameBattle.sceneEffectBlastOut" + id;
         return getSceneEffectMovie(sceneEffectBlastOutName);
      }
      
      public function createSceneEffectBulletBone(id:int, type:int = 0) : IBoneMovie
      {
         var sceneEffectBulletName:String = "bones.game.sceneEffectBullet" + id;
         return BoneMovieFactory.instance.creatBoneMovie(sceneEffectBulletName,type,"fighting3d");
      }
      
      public function createSceneEffectBlastOutBone(id:int, type:int = 0) : IBoneMovie
      {
         var sceneEffectBlastOutName:String = "bones.game.sceneEffectBlastOut" + id;
         return BoneMovieFactory.instance.creatBoneMovie(sceneEffectBlastOutName,type,"fighting3d");
      }
   }
}
