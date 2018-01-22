package collectionTask.player
{
   import collectionTask.CollectionTaskManager;
   import collectionTask.event.CollectionTaskEvent;
   import collectionTask.vo.PlayerVO;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.SceneCharacterEvent;
   import ddt.manager.ChatManager;
   import ddt.utils.Helpers;
   import ddt.utils.PositionUtils;
   import ddt.view.FaceContainer;
   import ddt.view.chat.ChatData;
   import ddt.view.chat.ChatEvent;
   import ddt.view.chat.chatBall.ChatBallPlayer;
   import ddt.view.common.VipLevelIcon;
   import ddt.view.sceneCharacter.SceneCharacterDirection;
   import ddt.view.scenePathSearcher.SceneScene;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Point;
   import times.utils.timerManager.TimerJuggler;
   import times.utils.timerManager.TimerManager;
   import vip.VipController;
   
   public class CollectionTaskPlayer extends CollectionTaskPlayerBase
   {
       
      
      private var _playerVO:PlayerVO;
      
      private var _sceneScene:SceneScene;
      
      private var _spName:Sprite;
      
      private var _lblName:FilterFrameText;
      
      private var _vipName:GradientText;
      
      private var _isShowName:Boolean = true;
      
      private var _isChatBall:Boolean = true;
      
      private var _isShowPlayer:Boolean = true;
      
      private var _chatBallView:ChatBallPlayer;
      
      private var _face:FaceContainer;
      
      private var _vipIcon:VipLevelIcon;
      
      private var _walkOverHander:Function;
      
      private var _destinationPos:Point;
      
      private var _robertWalkVector:Vector.<Point>;
      
      private var _robertCollectTimer:TimerJuggler;
      
      private var _robertCollectCount:int;
      
      private var _currentWalkStartPoint:Point;
      
      public function CollectionTaskPlayer(param1:PlayerVO, param2:Function = null){super(null,null);}
      
      private function initialize() : void{}
      
      private function setEvent() : void{}
      
      public function walk(param1:Point, param2:Function = null) : void{}
      
      public function robertWalk(param1:Vector.<Point>) : void{}
      
      private function characterDirectionChange(param1:SceneCharacterEvent) : void{}
      
      protected function __robertCollectCompleteHandler(param1:Event) : void{}
      
      public function set setSceneCharacterDirectionDefault(param1:SceneCharacterDirection) : void{}
      
      public function updatePlayer() : void{}
      
      private function characterMirror() : void{}
      
      private function playerWalkPath() : void{}
      
      override public function playerWalk(param1:Array) : void{}
      
      private function fixPlayerPath() : void{}
      
      public function get currentWalkStartPoint() : Point{return null;}
      
      public function refreshCharacterState() : void{}
      
      private function __getChat(param1:ChatEvent) : void{}
      
      private function __getFace(param1:ChatEvent) : void{}
      
      public function get playerVO() : PlayerVO{return null;}
      
      public function set playerVO(param1:PlayerVO) : void{}
      
      public function get isShowName() : Boolean{return false;}
      
      public function set isShowName(param1:Boolean) : void{}
      
      public function get isChatBall() : Boolean{return false;}
      
      public function set isChatBall(param1:Boolean) : void{}
      
      public function get isShowPlayer() : Boolean{return false;}
      
      public function set isShowPlayer(param1:Boolean) : void{}
      
      public function get sceneScene() : SceneScene{return null;}
      
      public function set sceneScene(param1:SceneScene) : void{}
      
      public function get ID() : int{return 0;}
      
      override public function dispose() : void{}
   }
}
