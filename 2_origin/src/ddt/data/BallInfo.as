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
      
      public function set ID(value:int) : void
      {
         _ID = value;
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
         var craterILoader:* = null;
         var craterBrinkLoader:* = null;
         if(!BallManager.instance.hasBombAsset(craterID))
         {
            if(craterID != 0)
            {
               craterILoader = LoadResourceManager.Instance.createLoader(PathManager.solveCrater(craterID),0);
               craterILoader.addEventListener("complete",__craterComplete);
               LoadResourceManager.Instance.startLoad(craterILoader);
               craterBrinkLoader = LoadResourceManager.Instance.createLoader(PathManager.solveCraterBrink(craterID),0);
               craterBrinkLoader.addEventListener("complete",__craterBrinkComplete);
               LoadResourceManager.Instance.startLoad(craterBrinkLoader);
            }
         }
      }
      
      private function __craterComplete(event:LoaderEvent) : void
      {
         (event.currentTarget as BaseLoader).removeEventListener("complete",__craterComplete);
         BallManager.instance.addBombAsset(craterID,event.loader.content as Bitmap,0);
      }
      
      private function __craterBrinkComplete(event:LoaderEvent) : void
      {
         (event.currentTarget as BaseLoader).removeEventListener("complete",__craterBrinkComplete);
         var data:Object = {};
         data["id"] = craterID;
         data["asset"] = event.loader.content;
         data["type"] = 1;
         BallManager.instance.addBombAsset(craterID,event.loader.content,1);
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
      
      public function getHasDefinition(info:BallInfo) : Boolean
      {
         if(!ModuleLoader.hasDefinition(BallManager.instance.solveBlastOutMovieName(info.blastOutID)))
         {
            trace("炮弹ID" + ID + "找不到\t" + BallManager.instance.solveBlastOutMovieName(info.blastOutID));
         }
         if(!ModuleLoader.hasDefinition(BallManager.solveBulletMovieName(info.ID)))
         {
            trace("炮弹ID" + ID + "找不到\t" + BallManager.solveBulletMovieName(info.ID));
         }
         if(!ModuleLoader.hasDefinition(BallManager.instance.solveShootMovieMovieName(info.ID)))
         {
            trace("炮弹ID" + ID + "找不到\t" + BallManager.instance.solveShootMovieMovieName(info.ID));
         }
         return ModuleLoader.hasDefinition(BallManager.instance.solveBlastOutMovieName(info.blastOutID)) && ModuleLoader.hasDefinition(BallManager.solveBulletMovieName(info.ID));
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
      
      public function getHasDefinition3D(info:BallInfo) : Boolean
      {
         var complete:Boolean = true;
         if(!BoneMovieFactory.instance.hasBoneMovie(info.bulletName))
         {
            complete = false;
            trace("炮弹动画 : ( " + info.bulletName + " ) 未加载完成");
         }
         if(ID != 147 && ID != 130)
         {
            if(blastOutID != 0 && !BoneMovieFactory.instance.hasBoneMovie(info.blastOutName))
            {
               complete = false;
               trace("爆炸动画 : ( " + info.blastOutName + " ) 未加载完成");
            }
         }
         return complete;
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
