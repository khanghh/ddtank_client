package ddt.data{   import bones.BoneMovieFactory;   import bones.loader.BonesLoaderManager;   import com.pickgliss.loader.BaseLoader;   import com.pickgliss.loader.LoadResourceManager;   import com.pickgliss.loader.LoaderEvent;   import com.pickgliss.loader.ModuleLoader;   import ddt.manager.BallManager;   import ddt.manager.PathManager;   import flash.display.Bitmap;   import flash.geom.Point;      public class BallInfo   {            public static const BULLET:String = "bonesBullet";            public static const SHOOT_MOVIE:String = "bonesShootMovie";            public static const BLAST_OUT:String = "bonesBlastOut";                   private var _ID:int = 2;            public var Name:String;            public var Mass:Number = 1;            public var Power:Number;            public var Radii:Number;            public var SpinV:Number = 1000;            public var SpinVA:Number = 1;            public var Amount:Number = 1;            public var Wind:int;            public var Weight:int;            public var DragIndex:int;            public var Shake:Boolean;            public var ShootSound:String;            public var BombSound:String;            public var ActionType:int;            public var BombType:int;            public var blastOutID:int;            public var craterID:int;            public var FlyingPartical:int;            public function BallInfo() { super(); }
            public function get ID() : int { return 0; }
            public function set ID(value:int) : void { }
            public function getCarrayBall() : Point { return null; }
            public function loadBombAsset() : void { }
            public function loadCraterBitmap() : void { }
            private function __craterComplete(event:LoaderEvent) : void { }
            private function __craterBrinkComplete(event:LoaderEvent) : void { }
            public function isComplete() : Boolean { return false; }
            public function getHasDefinition(info:BallInfo) : Boolean { return false; }
            public function loadBombAsset3D() : void { }
            public function isComplete3D() : Boolean { return false; }
            public function getHasDefinition3D(info:BallInfo) : Boolean { return false; }
            public function get bulletName() : String { return null; }
            public function get shootMovieName() : String { return null; }
            public function get blastOutName() : String { return null; }
   }}