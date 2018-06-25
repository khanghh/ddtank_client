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
      
      public function ChallengeRoomView(info:RoomInfo)
      {
         super(info);
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
         var i:int = 0;
         var item:* = null;
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
         var sbInBlueTeam:Boolean = false;
         var sbInRedTeam:Boolean = false;
         for(i = 0; i < _playerItems.length; )
         {
            item = _playerItems[i] as RoomPlayerItem;
            if(item.info && item.info.team == 1)
            {
               sbInBlueTeam = true;
            }
            if(item.info && item.info.team == 2)
            {
               sbInRedTeam = true;
            }
            i++;
         }
         if(!sbInBlueTeam || !sbInRedTeam)
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
      
      private function __onMapChangedHandler(evt:RoomEvent) : void
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
      
      private function __switchProViewHandler(evt:Event) : void
      {
         var type:int = RoomManager.Instance.current.dungeonMode;
         var isSwitch:Boolean = false;
         isSwitch = type == _curSelectType?false:true;
         if(!isSwitch)
         {
            return;
         }
         _curSelectType = type;
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
      
      override protected function __prepareClick(evt:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(_info.gameMode != 121)
         {
            CheckWeaponManager.instance.setFunction(this,__prepareClick,[evt]);
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
         var result:Boolean = true;
         if(_info.selfRoomPlayer.isViewer || _info.gameMode == 121)
         {
            return result;
         }
         if(CheckWeaponManager.instance.isNoWeapon())
         {
            result = false;
            CheckWeaponManager.instance.showAlert();
         }
         return result;
      }
      
      override protected function initTileList() : void
      {
         var i:int = 0;
         var item1:* = null;
         var item2:* = null;
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
         for(i = 0; i < 8; )
         {
            item1 = new RoomPlayerItem(i);
            _playerItemContainers[1 - 1].addChild(item1);
            _playerItems.push(item1);
            item2 = new RoomPlayerItem(i + 1);
            _playerItemContainers[2 - 1].addChild(item2);
            _playerItems.push(item2);
            i = i + 2;
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
         var i:int = 0;
         var defyAfficheViewFrame:* = null;
         if(!_info || !_info.defyInfo)
         {
            return;
         }
         i = 0;
         while(i <= _info.defyInfo[0].length)
         {
            if(_self.NickName == _info.defyInfo[0][i])
            {
               if(_info.defyInfo[1].length != 0)
               {
                  defyAfficheViewFrame = ComponentFactory.Instance.creatComponentByStylename("game.view.defyAfficheViewFrame");
                  defyAfficheViewFrame.roomInfo = _info;
                  defyAfficheViewFrame.show();
               }
            }
            i++;
         }
      }
      
      override protected function __updatePlayerItems(evt:RoomEvent) : void
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
      
      private function __switchTeam(evt:MouseEvent) : void
      {
         SoundManager.instance.play("012");
         if(!_info.selfRoomPlayer.isReady || _info.selfRoomPlayer.isHost)
         {
            GameInSocketOut.sendGameTeam(int(_info.selfRoomPlayer.team == 1?2:uint(1)));
         }
      }
   }
}
