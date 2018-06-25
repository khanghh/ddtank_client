package starling.scene.consortiaDomain{   import bones.BoneMovieFactory;   import bones.display.BoneMovieFastStarling;   import bones.display.BoneMovieStarling;   import com.pickgliss.utils.StarlingObjectUtils;   import consortiaDomain.ConsortiaDomainManager;   import consortiaDomain.EachMonsterInfo;   import ddt.events.CEvent;   import starling.core.Starling;   import starling.display.Sprite;   import starling.events.Event;   import starling.scene.common.WalkPlugin;   import starling.text.TextField;      public class MonsterBone extends Sprite   {                   private var _moveEntityState:int = -1;            private var _walkPlugin:WalkPlugin;            private var _fight:BoneMovieFastStarling;            private var _eachMonsterInfo:EachMonsterInfo;            private var _bone:BoneMovieStarling;            private var _direction:int;            private var _debugBuildNameTf:TextField;            public function MonsterBone(eachInfo:EachMonsterInfo) { super(); }
            private function onBoneComplete(evt:Event) : void { }
            private function setTouchEnable() : void { }
            public function set moveEntityState(value:int) : void { }
            private function onMonsterDieComplete() : void { }
            private function showFightState(isFight:Boolean) : void { }
            public function get pathArr() : Array { return null; }
            public function set pathArr(value:Array) : void { }
            public function get moveEntityState() : int { return 0; }
            public function get eachMonsterInfo() : EachMonsterInfo { return null; }
            public function set eachMonsterInfo(value:EachMonsterInfo) : void { }
            public function get direction() : int { return 0; }
            public function set direction(value:int) : void { }
            override public function dispose() : void { }
   }}