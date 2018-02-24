package starling.scene.consortiaDomain
{
   import bones.BoneMovieFactory;
   import bones.display.BoneMovieFastStarling;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.StarlingObjectUtils;
   import consortiaDomain.ConsortiaDomainManager;
   import consortiaDomain.ConsortiaDomainPlayerVo;
   import consortiaDomain.EachMonsterInfo;
   import ddt.data.player.PlayerInfo;
   import ddt.events.CEvent;
   import ddt.events.PkgEvent;
   import ddt.manager.CheckWeaponManager;
   import ddt.manager.GameInSocketOut;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.view.chat.ChatView;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.text.TextField;
   import flash.utils.Dictionary;
   import flash.utils.Timer;
   import flash.utils.getTimer;
   import hall.event.NewHallEvent;
   import hall.player.vo.PlayerVO;
   import newTitle.NewTitleManager;
   import road7th.comm.PackageIn;
   import starling.core.Starling;
   import starling.display.DisplayObject;
   import starling.display.Sprite;
   import starling.display.sceneCharacter.event.SceneCharacterEvent;
   import starling.events.Touch;
   import starling.events.TouchEvent;
   import starling.scene.common.DisplayObjectSortView;
   import starling.scene.common.NativeStageClickFilter;
   import starling.scene.consortiaDomain.buildView.BuildView;
   import starling.scene.hall.event.NewHallEventStarling;
   
   public class PlayerView extends Sprite
   {
       
      
      private var _selfPlayer:ConsortiaDomainHallPlayer;
      
      private var _friendPlayerDic:Dictionary;
      
      private var _disObjSortView:DisplayObjectSortView;
      
      private var _hidFlag:Boolean;
      
      private var _loadPlayerDic:Dictionary;
      
      private var _unLoadPlayerDic:Dictionary;
      
      private var _loadPkg:PackageIn;
      
      private var _loadTimer:Timer;
      
      private var _lastClick:Number = 0;
      
      private var _mouseMovie:BoneMovieFastStarling;
      
      private var _staticLayer:StaticLayer;
      
      private var _nativeStageClickFilter:NativeStageClickFilter;
      
      private const buildImageScale:Number = 1.06667;
      
      private const monsterSecretBornBuildPos:Array = [1529,461,1110,1321,2160,1300];
      
      private const monsterNormalBornBuildPos:Array = [700,543,480,969,645,1618,1589,1775,2504,440,2774,995,2499,1558];
      
      private const MAX_PLAYER_NUM:int = 10;
      
      public function PlayerView(){super();}
      
      private function initEvent() : void{}
      
      private function removeEvent() : void{}
      
      private function onActiveStateChange(param1:flash.events.Event) : void{}
      
      private function onOtherEnter(param1:PkgEvent) : void{}
      
      private function getPlayerNum() : int{return 0;}
      
      private function onOtherLeave(param1:CEvent) : void{}
      
      private function onFightState(param1:PkgEvent) : void{}
      
      private function onPlayerRepairChange(param1:PkgEvent) : void{}
      
      private function onPlayerRepair(param1:PkgEvent) : void{}
      
      private function onPlayerMove(param1:PkgEvent) : void{}
      
      private function onMonsterStateChange(param1:flash.events.Event) : void{}
      
      private function onMonsterInfoSingle(param1:CEvent) : void{}
      
      private function updateMonsterInfoSingle(param1:EachMonsterInfo) : void{}
      
      private function onRemoveChildMonster(param1:CEvent) : void{}
      
      protected function __onFriendPlayerInfo(param1:PkgEvent) : void{}
      
      private function startLoadOtherPlayer(param1:Boolean = true) : void{}
      
      protected function __onloadPlayerRes(param1:TimerEvent) : void{}
      
      private function addSelfPlayer(param1:PlayerVO) : void{}
      
      private function readPlayerInfoPkg(param1:PackageIn) : ConsortiaDomainPlayerVo{return null;}
      
      private function indexOfConsortiaDomainHallPlayerByID(param1:int) : int{return 0;}
      
      private function indexOfMonsterByLivingID(param1:int) : int{return 0;}
      
      private function setPlayerInfo(param1:ConsortiaDomainPlayerVo) : void{}
      
      public function set type(param1:String) : void{}
      
      protected function __updateFrame(param1:starling.events.Event) : void{}
      
      protected function __onPlayerClick(param1:TouchEvent) : void{}
      
      protected function __onSetSelfPlayerPos(param1:NewHallEvent) : void{}
      
      private function setSelfPlayerPos(param1:Point, param2:Boolean = true) : Boolean{return false;}
      
      public function checkAndWalkToPoint(param1:Point) : void{}
      
      protected function onFinishWalk(param1:NewHallEventStarling) : void{}
      
      private function startGame() : void{}
      
      private function checkCanStartGame() : Boolean{return false;}
      
      protected function ajustScreen() : void{}
      
      public function setCenter(param1:SceneCharacterEvent = null) : void{}
      
      public function get selfPlayer() : ConsortiaDomainHallPlayer{return null;}
      
      private function addBuildsAndEffs() : void{}
      
      override public function dispose() : void{}
   }
}
