package farm.player
{
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.DisplayUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.SceneCharacterEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import ddt.view.chat.chatBall.ChatBallPlayer;
   import ddt.view.common.VipLevelIcon;
   import ddt.view.sceneCharacter.SceneCharacterDirection;
   import ddt.view.scenePathSearcher.SceneScene;
   import farm.player.vo.GiftPacksTips;
   import farm.player.vo.PlayerVO;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.utils.Timer;
   import vip.VipController;
   
   public class FarmPlayer extends FarmPlayerBase
   {
       
      
      private var _playerVO:PlayerVO;
      
      private var _currentWalkStartPoint:Point;
      
      private var _isShowName:Boolean = true;
      
      private var _isChatBall:Boolean = false;
      
      private var _spName:Sprite;
      
      private var _lblName:FilterFrameText;
      
      private var _vipName:GradientText;
      
      private var _vipIcon:VipLevelIcon;
      
      private var _sceneScene:SceneScene;
      
      private var _chatBallView:ChatBallPlayer;
      
      private var _chatTimer:Timer;
      
      private var _giftPacks:GiftPacksTips;
      
      private var _clickFlag:Boolean;
      
      public function FarmPlayer(param1:PlayerVO, param2:Function = null){super(null,null);}
      
      private function initialize() : void{}
      
      public function set isChatBall(param1:Boolean) : void{}
      
      private function deleteChatTimer() : void{}
      
      public function get isChatBall() : Boolean{return false;}
      
      private function addGiftPacks() : void{}
      
      protected function __onTimerHandle(param1:TimerEvent) : void{}
      
      private function initEvent() : void{}
      
      protected function __onClick(param1:MouseEvent) : void{}
      
      protected function __clearGiftPacks(param1:MouseEvent) : void{}
      
      protected function __onGiftPacksClick(param1:MouseEvent) : void{}
      
      private function __onResponse(param1:FrameEvent) : void{}
      
      private function characterDirectionChange(param1:SceneCharacterEvent) : void{}
      
      public function updatePlayer() : void{}
      
      public function refreshCharacterState() : void{}
      
      private function characterMirror() : void{}
      
      private function playerWalkPath() : void{}
      
      override public function playerWalk(param1:Array) : void{}
      
      public function set setSceneCharacterDirectionDefault(param1:SceneCharacterDirection) : void{}
      
      private function fixPlayerPath() : void{}
      
      private function deleteChatBallView() : void{}
      
      private function deleteGiftPacks() : void{}
      
      private function removeEvent() : void{}
      
      public function get currentWalkStartPoint() : Point{return null;}
      
      public function get isShowName() : Boolean{return false;}
      
      public function set isShowName(param1:Boolean) : void{}
      
      public function get playerVO() : PlayerVO{return null;}
      
      public function set playerVO(param1:PlayerVO) : void{}
      
      public function get sceneScene() : SceneScene{return null;}
      
      public function set sceneScene(param1:SceneScene) : void{}
      
      override public function dispose() : void{}
      
      public function get giftPacks() : GiftPacksTips{return null;}
   }
}
