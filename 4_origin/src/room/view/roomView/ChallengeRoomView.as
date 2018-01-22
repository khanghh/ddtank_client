package room.view.roomView
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.player.SelfInfo;
   import ddt.events.RoomEvent;
   import ddt.manager.CheckWeaponManager;
   import ddt.manager.GameInSocketOut;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import gameCommon.view.DefyAfficheViewFrame;
   import room.RoomManager;
   import room.model.RoomInfo;
   import room.view.PVPBattleRoomRightPropView;
   import room.view.RoomPlayerItem;
   import room.view.smallMapInfoPanel.ChallengeRoomSmallMapInfoPanel;
   
   public class ChallengeRoomView extends BaseRoomView implements Disposeable
   {
      
      public static const PLAYER_POS_CHANGE:String = "playerposchange";
       
      
      private var _curSelectType:int = -1;
      
      private var _bg:MovieClip;
      
      private var _btnSwitchTeam:BaseButton;
      
      private var _playerItemContainers:Vector.<SimpleTileList>;
      
      private var _smallMapInfoPanel:ChallengeRoomSmallMapInfoPanel;
      
      private var _blueTeam:Bitmap;
      
      private var _redTeam:Bitmap;
      
      private var _blueTeamBitmap:MovieClip;
      
      private var _redTeamBitmap:MovieClip;
      
      private var _self:SelfInfo;
      
      public function ChallengeRoomView(param1:RoomInfo)
      {
         super(param1);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         _btnSwitchTeam.dispose();
         _smallMapInfoPanel.dispose();
         _curSelectType = -1;
         removeChild(_bg);
         _bg = null;
         _btnSwitchTeam = null;
         _playerItemContainers = null;
         _smallMapInfoPanel = null;
      }
      
      override protected function updateButtons() : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = null;
         super.updateButtons();
         if(_info.selfRoomPlayer.isViewer)
         {
            _btnSwitchTeam.enable = false;
            return;
         }
         if(RoomManager.Instance.current.selfRoomPlayer.isHost)
         {
            _btnSwitchTeam.enable = _startBtn.visible;
            _cancelBtn.visible = !_startBtn.visible;
         }
         else
         {
            _btnSwitchTeam.enable = _prepareBtn.visible;
            _cancelBtn.visible = !_prepareBtn.visible;
         }
         var _loc1_:Boolean = false;
         var _loc2_:Boolean = false;
         _loc4_ = 0;
         while(_loc4_ < _playerItems.length)
         {
            _loc3_ = _playerItems[_loc4_] as RoomPlayerItem;
            if(_loc3_.info && _loc3_.info.team == 1)
            {
               _loc1_ = true;
            }
            if(_loc3_.info && _loc3_.info.team == 2)
            {
               _loc2_ = true;
            }
            _loc4_++;
         }
         if(!_loc1_ || !_loc2_)
         {
            _startBtn.removeEventListener("click",__startClick);
            _startBtn.filters = [ComponentFactory.Instance.model.getSet("grayFilter")];
            if(_startBtn && _startBtn.hasOwnProperty("startA"))
            {
               _startBtn["startA"].gotoAndStop(1);
            }
            _startBtn.buttonMode = false;
         }
      }
      
      override protected function initEvents() : void
      {
         super.initEvents();
         _smallMapInfoPanel.addEventListener("change_proView",__switchProViewHandler);
         _btnSwitchTeam.addEventListener("click",__switchTeam);
         if(_info)
         {
            _info.addEventListener("mapChanged",__onMapChangedHandler);
         }
      }
      
      private function __onMapChangedHandler(param1:RoomEvent) : void
      {
         __switchProViewHandler(null);
      }
      
      private function initMapView() : void
      {
         __switchProViewHandler(null);
      }
      
      private function clearRoomProView() : void
      {
         ObjectUtils.disposeObject(_roomPropView);
         _roomPropView = null;
      }
      
      private function createPVPBattleProView() : void
      {
         _roomPropView = ComponentFactory.Instance.creatCustomObject("ddtroom.roomPropView.pvpBattleProView");
         PositionUtils.setPos(_viewerItems[0],"asset.ddtchallengeroom.testModeViewerItemPos_0");
         PositionUtils.setPos(_viewerItems[1],"asset.ddtchallengeroom.testModeViewerItemPos_1");
      }
      
      private function createRoomProView() : void
      {
         _roomPropView = ComponentFactory.Instance.creatCustomObject("asset.ddtroom.roomPropView");
         PositionUtils.setPos(_viewerItems[0],"asset.ddtchallengeroom.ViewerItemPos_0");
         PositionUtils.setPos(_viewerItems[1],"asset.ddtchallengeroom.ViewerItemPos_1");
      }
      
      private function __switchProViewHandler(param1:Event) : void
      {
         var _loc3_:int = RoomManager.Instance.current.dungeonMode;
         var _loc2_:Boolean = false;
         _loc2_ = _loc3_ == _curSelectType?false:true;
         if(!_loc2_)
         {
            return;
         }
         _curSelectType = _loc3_;
         if(_curSelectType == 120 && !(_roomPropView is PVPBattleRoomRightPropView))
         {
            clearRoomProView();
            createPVPBattleProView();
         }
         else if(_curSelectType != 120 && _roomPropView is PVPBattleRoomRightPropView)
         {
            clearRoomProView();
            createRoomProView();
         }
         addChild(_roomPropView);
         if(_viewerItems[0])
         {
            setChildIndex(_roomPropView,getChildIndex(_viewerItems[0]) - 1);
         }
      }
      
      override protected function __prepareClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(_info.gameMode != 121)
         {
            CheckWeaponManager.instance.setFunction(this,__prepareClick,[param1]);
            if(CheckWeaponManager.instance.isNoWeapon())
            {
               CheckWeaponManager.instance.showAlert();
               return;
            }
         }
         prepareGame();
      }
      
      override protected function checkCanStartGame() : Boolean
      {
         var _loc1_:Boolean = true;
         if(_info.selfRoomPlayer.isViewer || _info.gameMode == 121)
         {
            return _loc1_;
         }
         if(CheckWeaponManager.instance.isNoWeapon())
         {
            _loc1_ = false;
            CheckWeaponManager.instance.showAlert();
         }
         return _loc1_;
      }
      
      override protected function initTileList() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = null;
         var _loc1_:* = null;
         super.initTileList();
         _playerItemContainers = new Vector.<SimpleTileList>();
         _playerItemContainers[1 - 1] = new SimpleTileList(2);
         _playerItemContainers[2 - 1] = new SimpleTileList(2);
         var _loc4_:int = 2;
         _playerItemContainers[2 - 1].hSpace = _loc4_;
         _playerItemContainers[1 - 1].hSpace = _loc4_;
         _loc4_ = 4;
         _playerItemContainers[2 - 1].vSpace = _loc4_;
         _playerItemContainers[1 - 1].vSpace = _loc4_;
         PositionUtils.setPos(_playerItemContainers[1 - 1],"asset.ddtchallengeRoom.BlueTeamPos");
         PositionUtils.setPos(_playerItemContainers[2 - 1],"asset.ddtchallengeRoom.RedTeamPos");
         _loc3_ = 0;
         while(_loc3_ < 8)
         {
            _loc2_ = new RoomPlayerItem(_loc3_);
            _playerItemContainers[1 - 1].addChild(_loc2_);
            _playerItems.push(_loc2_);
            _loc1_ = new RoomPlayerItem(_loc3_ + 1);
            _playerItemContainers[2 - 1].addChild(_loc1_);
            _playerItems.push(_loc1_);
            _loc3_ = _loc3_ + 2;
         }
         addChild(_playerItemContainers[1 - 1]);
         addChild(_playerItemContainers[2 - 1]);
         PositionUtils.setPos(_viewerItems[0],"asset.ddtchallengeroom.ViewerItemPos_0");
         PositionUtils.setPos(_viewerItems[1],"asset.ddtchallengeroom.ViewerItemPos_1");
         addChild(_viewerItems[0]);
         addChild(_viewerItems[1]);
         addChild(_blueTeam);
         addChild(_redTeam);
      }
      
      override protected function initView() : void
      {
         _bg = ClassUtils.CreatInstance("asset.background.room.right") as MovieClip;
         PositionUtils.setPos(_bg,"asset.ddtmatchroom.bgPos");
         _smallMapInfoPanel = ComponentFactory.Instance.creatCustomObject("asset.ddtchallengeRoom.smallMapInfoPanel");
         _btnSwitchTeam = ComponentFactory.Instance.creatComponentByStylename("asset.ddtChallengeRoom.switchTeamBtn");
         _blueTeamBitmap = ClassUtils.CreatInstance("asset.ddtChallengeRoom.blueBg") as MovieClip;
         PositionUtils.setPos(_blueTeamBitmap,"asset.ddtchallengeroom.blueBgpos");
         _redTeamBitmap = ClassUtils.CreatInstance("asset.ddtChallengeRoom.redBg") as MovieClip;
         PositionUtils.setPos(_redTeamBitmap,"asset.ddtchallengeroom.redBgpos");
         _blueTeam = ComponentFactory.Instance.creatBitmap("asset.ddtChallengeRoom.blueTeam");
         _redTeam = ComponentFactory.Instance.creatBitmap("asset.ddtChallengeRoom.readTeam");
         _smallMapInfoPanel.info = _info;
         _self = PlayerManager.Instance.Self;
         addChild(_bg);
         addChild(_blueTeamBitmap);
         addChild(_redTeamBitmap);
         addChild(_btnSwitchTeam);
         addChild(_smallMapInfoPanel);
         super.initView();
         if(!_info.selfRoomPlayer.isViewer)
         {
            openDefyAffiche();
         }
         PVPBattleRoomRightPropView;
         initMapView();
      }
      
      private function openDefyAffiche() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         if(!_info || !_info.defyInfo)
         {
            return;
         }
         _loc2_ = 0;
         while(_loc2_ <= _info.defyInfo[0].length)
         {
            if(_self.NickName == _info.defyInfo[0][_loc2_])
            {
               if(_info.defyInfo[1].length != 0)
               {
                  _loc1_ = ComponentFactory.Instance.creatComponentByStylename("game.view.defyAfficheViewFrame");
                  _loc1_.roomInfo = _info;
                  _loc1_.show();
               }
            }
            _loc2_++;
         }
      }
      
      override protected function __updatePlayerItems(param1:RoomEvent) : void
      {
         initPlayerItems();
         updateButtons();
      }
      
      override protected function removeEvents() : void
      {
         super.removeEvents();
         _btnSwitchTeam.removeEventListener("click",__switchTeam);
         if(_info)
         {
            _info.removeEventListener("mapChanged",__onMapChangedHandler);
         }
         _smallMapInfoPanel.removeEventListener("change_proView",__switchProViewHandler);
      }
      
      private function __switchTeam(param1:MouseEvent) : void
      {
         SoundManager.instance.play("012");
         if(!_info.selfRoomPlayer.isReady || _info.selfRoomPlayer.isHost)
         {
            GameInSocketOut.sendGameTeam(int(_info.selfRoomPlayer.team == 1?2:uint(1)));
         }
      }
   }
}
