package consortionBattle.player{   import ddt.manager.ItemManager;   import ddt.view.character.ILayer;   import flash.display.BitmapData;      public class ConsBatLoaderHeadOrBody   {                   private var _loaders:Vector.<ConsBattSceneCharacterLayer>;            private var _content:BitmapData;            private var _completeCount:int;            private var _isAllLoadSucceed:Boolean = true;            private var _callBack:Function;            private var _consBatPlayerData:ConsortiaBattlePlayerInfo;            private var _equipType:int;            public function ConsBatLoaderHeadOrBody(playerData:ConsortiaBattlePlayerInfo, equipType:int) { super(); }
            public function load(callBack:Function = null) : void { }
            private function initLoaders() : void { }
            private function drawCharacter() : void { }
            private function layerComplete(layer:ILayer) : void { }
            private function loadComplete() : void { }
            public function getContent() : Array { return null; }
            public function dispose() : void { }
   }}