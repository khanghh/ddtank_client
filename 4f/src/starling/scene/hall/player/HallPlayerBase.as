package starling.scene.hall.player{   import ddt.data.player.PlayerInfo;   import ddt.events.PlayerPropertyEvent;   import ddt.view.sceneCharacter.SceneCharacterDirection;   import hall.player.vo.PlayerVO;   import horse.HorseManager;   import road7th.StarlingMain;   import starling.display.Image;   import starling.display.sceneCharacter.SceneCharacterActionPointSet;   import starling.display.sceneCharacter.SceneCharacterActionSet;   import starling.display.sceneCharacter.SceneCharacterActionType;   import starling.display.sceneCharacter.SceneCharacterPlayerBase;   import starling.display.sceneCharacter.SceneCharacterState;   import starling.display.sceneCharacter.SceneCharacterTextureItem;   import starling.display.sceneCharacter.SceneCharacterTextureSet;   import starling.display.sceneCharacter.event.SceneCharacterEvent;   import starling.events.Event;      public class HallPlayerBase extends SceneCharacterPlayerBase   {                   private var _playerInfo:PlayerInfo;            private var _playerVO:PlayerVO;            private var _playerAsset:HallPlayerAsset;            public function HallPlayerBase(playerVO:PlayerVO) { super(); }
            override protected function initialize() : void { }
            override protected function initEvent() : void { }
            override protected function removeEvent() : void { }
            private function showDefault() : void { }
            protected function __onStyleChange(evt:PlayerPropertyEvent) : void { }
            private function __onPlayerAssetComplete(e:Event) : void { }
            protected function resetPlayerAsset() : void { }
            protected function setCharacterData() : void { }
            protected function getSceneCharacterActionSet() : SceneCharacterActionSet { return null; }
            protected function getSceneCharacterActionPointSet() : SceneCharacterActionPointSet { return null; }
            protected function getSceneCharacterTextureSet() : SceneCharacterTextureSet { return null; }
            override public function set sceneCharacterActionState(value:String) : void { }
            private function setSceneCharacterActionPoint(state:String) : void { }
            private function setSceneCharacterAction(state:String) : void { }
            public function set setSceneCharacterDirectionDefault(value:SceneCharacterDirection) : void { }
            protected function characterDirectionChange(actionFlag:Boolean) : void { }
            override public function dispose() : void { }
   }}