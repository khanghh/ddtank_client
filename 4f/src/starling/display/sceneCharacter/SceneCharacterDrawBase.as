package starling.display.sceneCharacter{   import ddt.utils.PositionUtils;   import flash.geom.Point;   import road7th.StarlingMain;   import road7th.data.DictionaryData;   import starling.display.Image;   import starling.display.Sprite;   import starling.textures.Texture;      public class SceneCharacterDrawBase extends Sprite   {            public static const S_HEAD:int = 0;            public static const S_BODY_BACK:int = 1;            public static const S_MOUNT:int = 2;            public static const S_MOUNT_S:int = 3;            public static const S_BODY:int = 4;                   protected var _synthesis:SceneCharacterSynthesisBase;            protected var _actionSet:SceneCharacterActionSet;            protected var _actionPointSet:SceneCharacterActionPointSet;            protected var _state:String;            protected var _frames:DictionaryData;            protected var _isUpdate:Boolean;            protected var _headImage:Image;            protected var _bodyImage:Image;            public function SceneCharacterDrawBase() { super(); }
            protected function initialize() : void { }
            public function setup(synthesis:SceneCharacterSynthesisBase, actionSet:SceneCharacterActionSet, actionPointSet:SceneCharacterActionPointSet) : void { }
            public function update() : void { }
            protected function drawCharacterItem(sortOrder:int, texture:Texture, w:Number, h:Number, $pos:Point = null) : void { }
            protected function getCharacterItem(sortOrder:int) : Image { return null; }
            protected function sortOn(a:Object, b:Object) : Number { return 0; }
            public function set state(value:String) : void { }
            public function reset() : void { }
            override public function dispose() : void { }
   }}