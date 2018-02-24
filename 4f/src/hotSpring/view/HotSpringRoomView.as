package hotSpring.view
{
   import com.greensock.TweenLite;
   import com.pickgliss.effect.IEffect;
   import com.pickgliss.manager.CacheSysManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.events.PkgEvent;
   import ddt.events.PlayerPropertyEvent;
   import ddt.events.SceneCharacterEvent;
   import ddt.manager.BossBoxManager;
   import ddt.manager.ChatManager;
   import ddt.manager.HotSpringManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.StateManager;
   import ddt.utils.PositionUtils;
   import ddt.view.MainToolBar;
   import ddt.view.bossbox.SmallBoxButton;
   import ddt.view.chat.ChatView;
   import ddt.view.common.GradeContainer;
   import ddt.view.sceneCharacter.SceneCharacterDirection;
   import ddt.view.scenePathSearcher.PathMapHitTester;
   import ddt.view.scenePathSearcher.SceneScene;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.filters.GlowFilter;
   import flash.geom.Point;
   import flash.utils.getTimer;
   import hotSpring.controller.HotSpringRoomManager;
   import hotSpring.event.HotSpringRoomEvent;
   import hotSpring.model.HotSpringRoomModel;
   import hotSpring.player.HotSpringPlayer;
   import hotSpring.vo.MapVO;
   import hotSpring.vo.PlayerVO;
   import road7th.comm.PackageIn;
   import road7th.data.DictionaryData;
   import uiModeManager.bombUI.HappyLittleGameManager;
   
   public class HotSpringRoomView extends Sprite
   {
      
      private static var _waterArea:MovieClip;
       
      
      private var _model:HotSpringRoomModel;
      
      private var _controller:HotSpringRoomManager;
      
      private var _hotSpringViewAsset:MovieClip;
      
      private var _mapVO:MapVO;
      
      private var _playerLayer:MovieClip;
      
      private var _defaultPoint:Point;
      
      private var _selfPlayer:HotSpringPlayer;
      
      private var _mouseMovie:MovieClip;
      
      private var _waterAreaPointPixel:uint = 0;
      
      private var _playerWalkPath:Array;
      
      private var _sceneScene:SceneScene;
      
      private var _lastClick:Number = 0;
      
      private var _clickInterval:Number = 200;
      
      private var _chatFrame:ChatView;
      
      private var _roomMenuView:RoomMenuView;
      
      private var _isShowName:Boolean = true;
      
      private var _isChatBall:Boolean = true;
      
      private var _isShowPalyer:Boolean = true;
      
      private var _sysDateTime:Date;
      
      private var _grade:GradeContainer;
      
      private var _sceneFront:MovieClip;
      
      private var _sceneFront2:MovieClip;
      
      private var _sceneBack:Bitmap;
      
      private var _sceneFrontNight:MovieClip;
      
      private var _sceneFrontNight2:MovieClip;
      
      private var _sceneBackNight:Bitmap;
      
      private var _sceneBackBox:Sprite;
      
      private var _playerList:DictionaryData;
      
      private var _playerListFailure:DictionaryData;
      
      private var _playerListCellLoadCount:DictionaryData;
      
      private var _isPlayerListLoading:Boolean = false;
      
      private var _boxButton:SmallBoxButton;
      
      private var _hotSpringPlayerList:DictionaryData;
      
      private var _expUpAsset:Bitmap;
      
      private var _expUpText:FilterFrameText;
      
      private var _expUpBox:Sprite;
      
      private var _currentLoadingPlayer:HotSpringPlayer;
      
      private var _SceneType:int = 0;
      
      private var _dayStart:Date;
      
      private var _dayEnd:Date;
      
      private var _nightStart:Date;
      
      private var _nightEnd:Date;
      
      private var _ShowNameBtn:ScaleFrameImage;
      
      private var _ShowPaoBtn:ScaleFrameImage;
      
      private var _ShowPlayerBtn:ScaleFrameImage;
      
      private var _countDown:ScaleFrameImage;
      
      private var _energy:ScaleFrameImage;
      
      private var _roomNum:Bitmap;
      
      private var _countDownTxt:FilterFrameText;
      
      private var _energyTxt:FilterFrameText;
      
      private var _roomNumTxt:FilterFrameText;
      
      private var _HpLittleGameNpc:MovieClip;
      
      private var _emailShine:IEffect;
      
      public function HotSpringRoomView(param1:HotSpringRoomManager, param2:HotSpringRoomModel){super();}
      
      public static function getCurrentAreaType(param1:int, param2:int) : int{return 0;}
      
      protected function initialize() : void{}
      
      private function __onStageAddInitMapPath(param1:Event) : void{}
      
      private function setEvent() : void{}
      
      private function __npcOutHandler(param1:MouseEvent) : void{}
      
      private function __npcOverHander(param1:MouseEvent) : void{}
      
      private function __npcClickHander(param1:MouseEvent) : void{}
      
      private function playerLoad() : void{}
      
      private function playerLoadEnter(param1:PlayerVO) : void{}
      
      private function addPlayerCallBack(param1:HotSpringPlayer, param2:Boolean, param3:int = 0) : void{}
      
      private function roomTimeUp(param1:int, param2:Boolean = false) : void{}
      
      private function playerPropChanged(param1:PlayerPropertyEvent) : void{}
      
      private function roomTimeUpdate(param1:CrazyTankSocketEvent) : void{}
      
      private function sysDateTimeScene(param1:Date) : void{}
      
      private function addSceneDay() : void{}
      
      private function removeSceneDay() : void{}
      
      private function addSceneNight() : void{}
      
      private function removeSceneNight() : void{}
      
      private function dayAndNight() : void{}
      
      private function roomToolMenu(param1:MouseEvent) : void{}
      
      private function setPlayerShowItem() : void{}
      
      private function addPlayer(param1:HotSpringRoomEvent) : void{}
      
      private function onEnterFrame(param1:Event) : void{}
      
      private function getPointDepth(param1:Number, param2:Number) : Number{return 0;}
      
      private function BuildEntityDepth() : void{}
      
      private function removePlayer(param1:HotSpringRoomEvent) : void{}
      
      private function onMouseClick(param1:MouseEvent) : void{}
      
      private function setCenter(param1:SceneCharacterEvent = null) : void{}
      
      private function playerActionChange(param1:SceneCharacterEvent) : void{}
      
      public function expUpPlayer(param1:int) : void{}
      
      private function expUpMoviePlayer() : void{}
      
      private function onOut() : void{}
      
      private function onOut1() : void{}
      
      private function removeExpUpMovie() : void{}
      
      public function show() : void{}
      
      public function hide() : void{}
      
      public function dispose() : void{}
   }
}
