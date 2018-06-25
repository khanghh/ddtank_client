package ddt.loader{   import bones.BoneMovieFactory;   import bones.loader.BonesLoaderEvent;   import bones.loader.BonesLoaderManager;   import ddt.manager.PathManager;   import ddt.view.UIModuleSmallLoading;   import road7th.DDTAssetManager;   import starling.loader.StarlingQueueLoader;      public class StateLoader   {            private static var _loadCall:Function;            private static var _starlingSceneLoader:StarlingQueueLoader;            private static var _lastStarlingSceneLoader:StarlingQueueLoader;            private static var _loadBonesList:Array;                   public function StateLoader() { super(); }
            private static function loadComplete() : void { }
            private static function getLoaderDataList(type:String) : Array { return null; }
            public static function startStarlingBonesLoad(last:String, next:String, complete:Function) : void { }
            private static function loadBones(next:String) : void { }
            private static function checkBonesAssetComplete(next:String) : Boolean { return false; }
            public static function getStarlingSceneResource($type:String) : Array { return null; }
            private static function getLoadBonesList(type:String) : Array { return null; }
   }}