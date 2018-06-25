package hall.player{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.image.ScaleFrameImage;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.ui.text.GradientText;   import com.pickgliss.utils.DisplayUtils;   import com.pickgliss.utils.ObjectUtils;   import consortion.view.selfConsortia.Badge;   import ddt.manager.PlayerManager;   import ddt.manager.SoundManager;   import ddt.view.common.VipLevelIcon;   import ddt.view.sceneCharacter.SceneCharacterDirection;   import ddt.view.scenePathSearcher.SceneScene;   import flash.display.Bitmap;   import flash.display.BitmapData;   import flash.display.Sprite;   import flash.events.MouseEvent;   import flash.events.TimerEvent;   import flash.geom.Point;   import flash.utils.Timer;   import hall.event.NewHallEvent;   import hall.player.vo.PlayerVO;   import newTitle.NewTitleManager;   import newTitle.model.NewTitleModel;   import road7th.DDTAssetManager;   import vip.VipController;      public class HallPlayer extends HallPlayerBase   {                   private var _playerVO:PlayerVO;            private var _currentWalkStartPoint:Point;            private var _spName:Sprite;            private var _lblName:FilterFrameText;            private var _vipName:GradientText;            private var _vipIcon:VipLevelIcon;            private var _sceneScene:SceneScene;            private var _badgeSprite:Sprite;            private var _badge:Badge;            private var _consortiaName:FilterFrameText;            private var _titleSprite:Sprite;            private var _title:Bitmap;            private var _walkSpeed:Number;            private var isHiedTitle:Boolean;            private var _attestBtn:ScaleFrameImage;            private var _posTimer:Timer;            private var _randomPathX:int;            private var _randomPathY:int;            private var _randomPathMap:Object;            public function HallPlayer(playerVO:PlayerVO, callBack:Function = null) { super(null,null); }
            private function setPlayerWalkSpeed() : void { }
            public function showPlayerInfo(petsDis:int) : void { }
            public function showVipName() : void { }
            private function creatAttestBtn() : void { }
            public function showPlayerTitle() : void { }
            private function loadIcon(pic:String) : void { }
            private function setTitleSprite(bitmapdata:BitmapData) : void { }
            public function removePlayerTitle() : void { }
            override protected function __onMouseClick(event:MouseEvent) : void { }
            private function characterDirectionChange(actionFlag:Boolean) : void { }
            public function updatePlayer() : void { }
            public function refreshCharacterState() : void { }
            private function characterMirror() : void { }
            private function playerWalkPath() : void { }
            override public function playerWalk(walkPath:Array) : void { }
            private function setPlayerDirection() : SceneCharacterDirection { return null; }
            public function set setSceneCharacterDirectionDefault(value:SceneCharacterDirection) : void { }
            private function fixPlayerPath() : void { }
            public function get currentWalkStartPoint() : Point { return null; }
            public function get playerVO() : PlayerVO { return null; }
            public function set playerVO(value:PlayerVO) : void { }
            public function get sceneScene() : SceneScene { return null; }
            public function set sceneScene(value:SceneScene) : void { }
            public function hideTitle(value:Boolean) : void { }
            public function startRandomWalk(randomPathX:int, randomPathY:int, randomPathMap:Object) : void { }
            private function onControlWalk(evt:TimerEvent) : void { }
            private function getRandomDelayTime() : int { return 0; }
            private function getEndPointIndex(startPointIndex:int) : int { return 0; }
            private function getPointPath(newStartPointIndex:int, newEndPointIndex:int) : Array { return null; }
            public function stopWalk() : void { }
            override public function dispose() : void { }
            public function set walkSpeed(value:Number) : void { }
            public function get walkSpeed() : Number { return 0; }
   }}