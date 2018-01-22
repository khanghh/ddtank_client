package ddt.data
{
   import bones.BoneMovieFactory;
   import bones.loader.BonesLoaderManager;
   import com.pickgliss.loader.BaseLoader;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.loader.LoaderEvent;
   import com.pickgliss.loader.ModuleLoader;
   import ddt.manager.BallManager;
   import ddt.manager.PathManager;
   import flash.display.Bitmap;
   import flash.geom.Point;
   
   public class BallInfo
   {
      
      public static const BULLET:String = "bonesBullet";
      
      public static const SHOOT_MOVIE:String = "bonesShootMovie";
      
      public static const BLAST_OUT:String = "bonesBlastOut";
       
      
      private var _ID:int = 2;
      
      public var Name:String;
      
      public var Mass:Number = 1;
      
      public var Power:Number;
      
      public var Radii:Number;
      
      public var SpinV:Number = 1000;
      
      public var SpinVA:Number = 1;
      
      public var Amount:Number = 1;
      
      public var Wind:int;
      
      public var Weight:int;
      
      public var DragIndex:int;
      
      public var Shake:Boolean;
      
      public var ShootSound:String;
      
      public var BombSound:String;
      
      public var ActionType:int;
      
      public var BombType:int;
      
      public var blastOutID:int;
      
      public var craterID:int;
      
      public var FlyingPartical:int;
      
      public function BallInfo()
      {
         super();
      }
      
      public function get ID() : int
      {
         return _ID;
      }
      
      public function set ID(param1:int) : void
      {
         _ID = param1;
      }
      
      public function getCarrayBall() : Point
      {
         return new Point(0,90);
      }
      
      public function loadBombAsset() : void
      {
         if(!ModuleLoader.hasDefinition(BallManager.solveBulletMovieName(ID)) && !ModuleLoader.hasDefinition(BallManager.instance.solveShootMovieMovieName(ID)))
         {
            LoadResourceManager.Instance.creatAndStartLoad(PathManager.solveBlastOut(ID),4);
         }
         if(!ModuleLoader.hasDefinition(BallManager.instance.solveBlastOutMovieName(blastOutID)))
         {
            LoadResourceManager.Instance.creatAndStartLoad(PathManager.solveBullet(blastOutID),4);
         }
      }
      
      public function loadCraterBitmap() : void
      {
         var _loc2_:* = null;
         var _loc1_:* = null;
         if(!BallManager.instance.hasBombAsset(craterID))
         {
            if(craterID != 0)
            {
               _loc2_ = LoadResourceManager.Instance.createLoader(PathManager.solveCrater(craterID),0);
               _loc2_.addEventListener("complete",__craterComplete);
               LoadResourceManager.Instance.startLoad(_loc2_);
               _loc1_ = LoadResourceManager.Instance.createLoader(PathManager.solveCraterBrink(craterID),0);
               _loc1_.addEventListener("complete",__craterBrinkComplete);
               LoadResourceManager.Instance.startLoad(_loc1_);
            }
         }
      }
      
      private function __craterComplete(param1:LoaderEvent) : void
      {
         (param1.currentTarget as BaseLoader).removeEventListener("complete",__craterComplete);
         BallManager.instance.addBombAsset(craterID,param1.loader.content as Bitmap,0);
      }
      
      private function __craterBrinkComplete(param1:LoaderEvent) : void
      {
         (param1.currentTarget as BaseLoader).removeEventListener("complete",__craterBrinkComplete);
         var _loc2_:Object = {};
         _loc2_["id"] = craterID;
         _loc2_["asset"] = param1.loader.content;
         _loc2_["type"] = 1;
         BallManager.instance.addBombAsset(craterID,param1.loader.content,1);
      }
      
      public function isComplete() : Boolean
      {
         if(craterID == 0 && blastOutID == 0)
         {
            return true;
         }
         if(BallManager.instance.hasBombAsset(craterID) && getHasDefinition(this))
         {
            return true;
         }
         if(craterID == 0 && getHasDefinition(this))
         {
            return true;
         }
         return false;
      }
      
      public function getHasDefinition(param1:BallInfo) : Boolean
      {
         if(!ModuleLoader.hasDefinition(BallManager.instance.solveBlastOutMovieName(param1.blastOutID)))
         {
            trace("炮弹ID" + ID + "找不到\t" + BallManager.instance.solveBlastOutMovieName(param1.blastOutID));
         }
         if(!ModuleLoader.hasDefinition(BallManager.solveBulletMovieName(param1.ID)))
         {
            trace("炮弹ID" + ID + "找不到\t" + BallManager.solveBulletMovieName(param1.ID));
         }
         if(!ModuleLoader.hasDefinition(BallManager.instance.solveShootMovieMovieName(param1.ID)))
         {
            trace("炮弹ID" + ID + "找不到\t" + BallManager.instance.solveShootMovieMovieName(param1.ID));
         }
         return ModuleLoader.hasDefinition(BallManager.instance.solveBlastOutMovieName(param1.blastOutID)) && ModuleLoader.hasDefinition(BallManager.solveBulletMovieName(param1.ID));
      }
      
      public function loadBombAsset3D() : void
      {
         if(!bulletName || !BoneMovieFactory.instance.hasBoneMovie(bulletName))
         {
            BonesLoaderManager.instance.startLoader(bulletName,0,"fighting3d");
         }
         if(blastOutID != 0 && !BoneMovieFactory.instance.hasBoneMovie(blastOutName))
         {
            BonesLoaderManager.instance.startLoader(blastOutName,0,"fighting3d");
         }
      }
      
      public function isComplete3D() : Boolean
      {
         if(craterID == 0 && blastOutID == 0)
         {
            return true;
         }
         if(craterID == 0 && getHasDefinition3D(this))
         {
            return true;
         }
         if(BallManager.instance.hasBombAsset(craterID) && getHasDefinition3D(this))
         {
            return true;
         }
         return false;
      }
      
      public function getHasDefinition3D(param1:BallInfo) : Boolean
      {
         var _loc2_:Boolean = true;
         if(!BoneMovieFactory.instance.hasBoneMovie(param1.bulletName))
         {
            _loc2_ = false;
            trace("炮弹动画 : ( " + param1.bulletName + " ) 未加载完成");
         }
         if(ID != 147 && ID != 130)
         {
            if(blastOutID != 0 && !BoneMovieFactory.instance.hasBoneMovie(param1.blastOutName))
            {
               _loc2_ = false;
               trace("爆炸动画 : ( " + param1.blastOutName + " ) 未加载完成");
            }
         }
         return _loc2_;
      }
      
      public function get bulletName() : String
      {
         return "bonesBullet" + ID;
      }
      
      public function get shootMovieName() : String
      {
         return "bonesShootMovie" + ID;
      }
      
      public function get blastOutName() : String
      {
         return "bonesBlastOut" + blastOutID;
      }
   }
}
