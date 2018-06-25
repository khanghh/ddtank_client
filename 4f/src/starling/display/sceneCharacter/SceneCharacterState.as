package starling.display.sceneCharacter{   import ddt.view.sceneCharacter.SceneCharacterDirection;      public class SceneCharacterState   {                   protected var _sceneCharacterSet:SceneCharacterTextureSet;            protected var _sceneCharacterActionSet:SceneCharacterActionSet;            protected var _sceneCharacterActionPointSet:SceneCharacterActionPointSet;            protected var _sceneCharacterSynthesis:SceneCharacterSynthesisBase;            protected var _sceneCharacterDraw:SceneCharacterDrawBase;            protected var _sceneCharacterDirection:SceneCharacterDirection;            protected var _currentType:String;            public function SceneCharacterState(textureSet:SceneCharacterTextureSet, actionSet:SceneCharacterActionSet, actionPointSet:SceneCharacterActionPointSet, draw:SceneCharacterDrawBase = null) { super(); }
            public function updateSynthesis() : void { }
            protected function sceneCharacterSynthesisCallBack(synthesis:SceneCharacterSynthesisBase) : void { }
            public function updateTexture(textureItem:SceneCharacterTextureItem) : void { }
            public function removeTexture(type:String) : void { }
            public function set setSceneCharacterActionState(state:String) : void { }
            public function resetSceneCharacterDraw() : void { }
            public function get setSceneCharacterActionState() : String { return null; }
            public function set sceneCharacterDirection(value:SceneCharacterDirection) : void { }
            public function get sceneCharacterSet() : SceneCharacterTextureSet { return null; }
            public function set sceneCharacterSet(value:SceneCharacterTextureSet) : void { }
            public function set sceneCharacterBase(value:SceneCharacterDrawBase) : void { }
            public function get sceneCharacterBase() : SceneCharacterDrawBase { return null; }
            public function get defaultActionState() : String { return null; }
            public function get sceneCharacterActionPointSet() : SceneCharacterActionPointSet { return null; }
            public function get sceneCharacterActionSet() : SceneCharacterActionSet { return null; }
            public function dispose() : void { }
   }}