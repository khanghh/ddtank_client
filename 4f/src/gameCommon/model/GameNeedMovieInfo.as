package gameCommon.model{   import bones.BoneMovieFactory;   import bones.loader.BonesLoaderEvent;   import bones.loader.BonesLoaderManager;   import com.pickgliss.loader.BaseLoader;   import com.pickgliss.loader.LoadResourceManager;   import com.pickgliss.loader.LoaderEvent;   import com.pickgliss.utils.StringUtils;   import ddt.manager.PathManager;   import flash.events.EventDispatcher;   import gameCommon.LoadBombManager;      public class GameNeedMovieInfo extends EventDispatcher   {                   private var _type:int;            public var path:String;            private var _classPath:String;            private var _loader:BaseLoader;            public var bombId:int;            public function GameNeedMovieInfo() { super(); }
            public function get classPath() : String { return null; }
            public function set classPath(value:String) : void { }
            public function get filePath() : String { return null; }
            public function startLoad() : void { }
            private function __onLoaderBonesComplete(e:BonesLoaderEvent) : void { }
            private function __onLoaderNativeComplete(event:LoaderEvent) : void { }
            public function get loader() : BaseLoader { return null; }
            public function get type() : int { return 0; }
            public function set type(value:int) : void { }
   }}