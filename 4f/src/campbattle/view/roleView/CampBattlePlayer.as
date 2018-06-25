package campbattle.view.roleView{   import campbattle.data.RoleData;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.events.SceneCharacterEvent;   import ddt.view.sceneCharacter.SceneCharacterDirection;   import ddt.view.scenePathSearcher.SceneScene;   import flash.display.Bitmap;   import flash.display.MovieClip;   import flash.events.Event;   import flash.geom.Point;      public class CampBattlePlayer extends CampBaseRole   {                   public var scene:SceneScene;            protected var tombstone:MovieClip;            protected var fighting:MovieClip;            protected var capture:Bitmap;            private var _walkOverHander:Function;            private var _targetID:int;            private var _targetZoneID:int;            private var _nameTxt:FilterFrameText;            private var _resurrectCartoon:MovieClip;            private var _currentWalkStartPoint:Point;            private var _walkSpeed:Number;            public function CampBattlePlayer(playerInfo:RoleData = null, callBack:Function = null) { super(null,null); }
            private function setPlayerWalkSpeed() : void { }
            public function setPlayerInfo(playerInfo:RoleData = null) : void { }
            private function initStatus() : void { }
            public function setCaptureVisible(bool:Boolean) : void { }
            private function cartoonCompleteHandler(e:Event) : void { }
            public function setStateType(type:int) : void { }
            override public function dispose() : void { }
            protected function enterFrameHander(e:Event) : void { }
            public function walk(p:Point, fun:Function = null, id:int = 0, zoneID:int = 0) : void { }
            protected function characterMirror() : void { }
            protected function playerWalkPath() : void { }
            override public function playerWalk(walkPath:Array) : void { }
            private function setPlayerDirection() : SceneCharacterDirection { return null; }
            public function IsShowPlayer(bool:Boolean) : void { }
            private function characterDirectionChange(e:SceneCharacterEvent) : void { }
            public function get playerInfo() : RoleData { return null; }
   }}