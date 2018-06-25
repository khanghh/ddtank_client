package christmas.player{   import christmas.event.ChristmasRoomEvent;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.ui.text.GradientText;   import com.pickgliss.utils.DisplayUtils;   import com.pickgliss.utils.ObjectUtils;   import ddt.events.SceneCharacterEvent;   import ddt.manager.ChatManager;   import ddt.utils.Helpers;   import ddt.view.FaceContainer;   import ddt.view.chat.ChatData;   import ddt.view.chat.ChatEvent;   import ddt.view.chat.chatBall.ChatBallPlayer;   import ddt.view.common.VipLevelIcon;   import ddt.view.sceneCharacter.SceneCharacterDirection;   import ddt.view.scenePathSearcher.SceneScene;   import flash.display.MovieClip;   import flash.display.Sprite;   import flash.events.Event;   import flash.geom.Point;   import vip.VipController;      public class ChristmasRoomPlayer extends ChristmasRoomPlayerBase   {                   private var _playerVO:PlayerVO;            private var _sceneScene:SceneScene;            private var _spName:Sprite;            private var _lblName:FilterFrameText;            private var _vipName:GradientText;            private var _isShowName:Boolean = true;            private var _isChatBall:Boolean = true;            private var _isShowPlayer:Boolean = true;            private var _chatBallView:ChatBallPlayer;            private var _face:FaceContainer;            private var _vipIcon:VipLevelIcon;            private var _fightIcon:MovieClip;            private var _tombstone:MovieClip;            private var _isReadyFight:Boolean;            private var _currentWalkStartPoint:Point;            public function ChristmasRoomPlayer(playerVO:PlayerVO, callBack:Function = null) { super(null,null); }
            private function initialize() : void { }
            public function setStatus() : void { }
            public function revive() : void { }
            private function __reviveComplete(e:Event) : void { }
            private function setEvent() : void { }
            private function __onplayerPosChangeImp(event:ChristmasRoomEvent) : void { }
            private function characterDirectionChange(evt:SceneCharacterEvent) : void { }
            public function set setSceneCharacterDirectionDefault(value:SceneCharacterDirection) : void { }
            public function updatePlayer() : void { }
            private function characterMirror() : void { }
            private function playerWalkPath() : void { }
            override public function playerWalk(walkPath:Array) : void { }
            private function fixPlayerPath() : void { }
            public function get currentWalkStartPoint() : Point { return null; }
            private function playChangeStateMovie() : void { }
            public function refreshCharacterState() : void { }
            private function __getChat(evt:ChatEvent) : void { }
            private function __getFace(evt:ChatEvent) : void { }
            public function get playerVO() : PlayerVO { return null; }
            public function set playerVO(value:PlayerVO) : void { }
            public function get isShowName() : Boolean { return false; }
            public function set isShowName(value:Boolean) : void { }
            public function get isChatBall() : Boolean { return false; }
            public function set isChatBall(value:Boolean) : void { }
            public function get isShowPlayer() : Boolean { return false; }
            public function set isShowPlayer(value:Boolean) : void { }
            public function get sceneScene() : SceneScene { return null; }
            public function set sceneScene(value:SceneScene) : void { }
            public function get ID() : int { return 0; }
            public function get isReadyFight() : Boolean { return false; }
            public function set isReadyFight(value:Boolean) : void { }
            public function getCanAction() : Boolean { return false; }
            override public function dispose() : void { }
   }}