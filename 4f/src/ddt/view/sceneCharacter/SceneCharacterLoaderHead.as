package ddt.view.sceneCharacter{   import ddt.data.player.PlayerInfo;   import ddt.manager.ItemManager;   import ddt.view.character.ILayer;   import flash.display.BitmapData;   import flash.display.DisplayObject;      public class SceneCharacterLoaderHead   {                   private var _loaders:Vector.<SceneCharacterLayer>;            private var _recordStyle:Array;            private var _recordColor:Array;            private var _content:BitmapData;            private var _completeCount:int;            private var _playerInfo:PlayerInfo;            private var _isAllLoadSucceed:Boolean = true;            private var _callBack:Function;            private var _needLoadGirlHead:Boolean;            private var _girlHeadPicLoader:GirlHeadPicLoader;            public function SceneCharacterLoaderHead(playerInfo:PlayerInfo, loadGirlHead:Boolean = false) { super(); }
            public function load(callBack:Function = null) : void { }
            private function girlHeadPicLoaded(headPic:DisplayObject) : void { }
            private function initLoaders() : void { }
            private function drawCharacter() : void { }
            private function layerComplete(layer:ILayer) : void { }
            private function loadComplete() : void { }
            public function getContent() : Array { return null; }
            public function dispose() : void { }
   }}