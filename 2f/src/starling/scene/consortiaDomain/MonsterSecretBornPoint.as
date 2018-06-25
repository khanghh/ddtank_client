package starling.scene.consortiaDomain{   import bones.BoneMovieFactory;   import bones.display.BoneMovieStarling;   import com.pickgliss.utils.StarlingObjectUtils;   import consortiaDomain.ConsortiaDomainManager;   import flash.events.Event;   import road7th.StarlingMain;   import starling.core.Starling;   import starling.display.Image;   import starling.display.Sprite;      public class MonsterSecretBornPoint extends Sprite   {                   public var id:int;            private var _monsterBornBuildState:int = -1;            private var _build:Image;            private var _monsterOutEff:BoneMovieStarling;            private var _closeDoorImage:Image;            private var _buildImageScale:Number;            public function MonsterSecretBornPoint(id:int, textureName:String, buildImageScale:Number) { super(); }
            public function setXY(posX:int, posY:int) : void { }
            private function onMonsterBorn(evt:Event) : void { }
            private function buildStateClose() : void { }
            public function get monsterBornBuildState() : int { return 0; }
            public function set monsterBornBuildState(value:int) : void { }
            override public function dispose() : void { }
   }}