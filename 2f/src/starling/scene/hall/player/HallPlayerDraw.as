package starling.scene.hall.player{   import ddt.data.player.PlayerInfo;   import flash.geom.Point;   import road7th.StarlingMain;   import road7th.data.DictionaryData;   import starling.display.Image;   import starling.display.sceneCharacter.SceneCharacterActionItem;   import starling.display.sceneCharacter.SceneCharacterActionPointItem;   import starling.display.sceneCharacter.SceneCharacterDrawBase;   import starling.textures.Texture;      public class HallPlayerDraw extends SceneCharacterDrawBase   {                   private var _playerInfo:PlayerInfo;            protected var _bodyBackImage:Image;            protected var _mountImage:Image;            protected var _mountSImage:Image;            public function HallPlayerDraw(playerInfo:PlayerInfo) { super(); }
            override protected function initialize() : void { }
            override public function update() : void { }
            private function updateMounts() : void { }
            override protected function getCharacterItem(sortOrder:int) : Image { return null; }
            private function getImage(type:String) : Object { return null; }
            override public function dispose() : void { }
   }}