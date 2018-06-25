package worldboss.player{   import ddt.data.player.PlayerInfo;   import ddt.manager.ItemManager;   import ddt.view.character.ILayer;   import flash.display.BitmapData;      public class SceneCharacterLoaderBody   {                   private var _loaders:Vector.<WorldBossSceneCharacterLayer>;            private var _recordStyle:Array;            private var _recordColor:Array;            private var _content:BitmapData;            private var _completeCount:int;            private var _playerInfo:PlayerInfo;            private var _isAllLoadSucceed:Boolean = true;            private var _callBack:Function;            public function SceneCharacterLoaderBody(playerInfo:PlayerInfo) { super(); }
            public function load(callBack:Function = null) : void { }
            private function initLoaders() : void { }
            private function drawCharacter() : void { }
            private function layerComplete(layer:ILayer) : void { }
            private function loadComplete() : void { }
            public function getContent() : Array { return null; }
            public function dispose() : void { }
   }}