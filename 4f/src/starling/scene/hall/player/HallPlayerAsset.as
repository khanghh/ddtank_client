package starling.scene.hall.player{   import ddt.data.player.PlayerInfo;   import flash.display.Bitmap;   import flash.display.BitmapData;   import road7th.DDTAssetManager;   import starling.events.Event;   import starling.events.EventDispatcher;   import starling.textures.Texture;   import starling.textures.TextureAtlas;      public class HallPlayerAsset extends EventDispatcher   {                   private var _playerInfo:PlayerInfo;            private var _asset:DDTAssetManager;            private var _cellBack:Function;            private var _loadCount:int;            private var _isResetLoad:String;            private var _playerInfoStyle:Array;            private var _playerInfoColor:Array;            private var _playerInfoSex:Boolean;            private var _playerInfoMountsType:int;            private var _headLoader:HallPlayerBaseLoader;            private var _bodyLoader:HallPlayerBaseLoader;            private var _mountLoader:HallPlayerBaseLoader;            public function HallPlayerAsset(playerInfo:PlayerInfo) { super(); }
            public function load() : void { }
            public function resetLoader() : void { }
            public function loadHead() : void { }
            public function loadBody() : void { }
            public function loadMount() : void { }
            private function loaderComplete(loader:HallPlayerBaseLoader) : void { }
            private function checkLoadAllComplete() : Boolean { return false; }
            public function isResetByAssetName(value:String) : Boolean { return false; }
            public function isFirstLoad() : Boolean { return false; }
            private function updateLoadData() : void { }
            public function get headAssetName() : String { return null; }
            public function get bodyAssetName() : String { return null; }
            public function get mountsAssetName() : String { return null; }
            public function dispose() : void { }
   }}