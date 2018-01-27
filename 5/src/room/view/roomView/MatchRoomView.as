package room.view.roomView
{
import LimitAward.LimitAwardButton;
import com.pickgliss.events.FrameEvent;
import com.pickgliss.ui.AlertManager;
import com.pickgliss.ui.ComponentFactory;
import com.pickgliss.ui.controls.SelectedButton;
import com.pickgliss.ui.controls.alert.BaseAlerFrame;
import com.pickgliss.ui.controls.container.SimpleTileList;
import com.pickgliss.ui.text.FilterFrameText;
import com.pickgliss.ui.vo.AlertInfo;
import com.pickgliss.utils.ClassUtils;
import com.pickgliss.utils.ObjectUtils;
import ddt.events.PkgEvent;
import ddt.events.RoomEvent;
import ddt.manager.BossBoxManager;
import ddt.manager.ChatManager;
import ddt.manager.GameInSocketOut;
import ddt.manager.LanguageMgr;
import ddt.manager.MessageTipManager;
import ddt.manager.PlayerManager;
import ddt.manager.SocketManager;
import ddt.manager.SoundManager;
import ddt.manager.StateManager;
import ddt.utils.PositionUtils;
import ddt.view.bossbox.SmallBoxButton;
import ddt.view.chat.ChatData;
import flash.display.MovieClip;
import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.events.MouseEvent;
import flash.events.TimerEvent;
import flash.geom.Point;
import flash.utils.Timer;

import gameAuto.AutoGameManager;

import league.LeagueManager;

import org.aswing.KeyStroke;

import org.aswing.KeyboardManager;

import room.RoomManager;
import room.model.RoomInfo;
import room.model.RoomPlayer;
import room.view.RoomPlayerItem;
import room.view.bigMapInfoPanel.MatchRoomBigMapInfoPanel;
import room.view.smallMapInfoPanel.MatchRoomSmallMapInfoPanel;
import trainer.controller.WeakGuildManager;
import trainer.view.NewHandContainer;
import trainer.view.VaneTipView;

public class MatchRoomView extends BaseRoomView
{

    private static const MATCH_NPC:int = 40;

    private static const BOTH_MODE_ALERT_TIME:int = 60;

    private static const DISABLE_RETURN:int = 20;

    private static const MATCH_NPC_ENABLE:Boolean = false;


    private var _bg:MovieClip;

    private var _itemListBg:MovieClip;

    private var _bigMapInfoPanel:MatchRoomBigMapInfoPanel;

    private var _smallMapInfoPanel:MatchRoomSmallMapInfoPanel;

    private var _playerItemContainer:SimpleTileList;

    protected var _crossZoneBtn:SelectedButton;

    private var _boxButton:SmallBoxButton;

    private var _limitAwardButton:LimitAwardButton;

    private var _timerII:Timer;

    protected var _leagueTxt:FilterFrameText;

    private var _roomIdTxt:FilterFrameText;

    private var _roomDesbit:MovieClip;

    private var _alert1:BaseAlerFrame;

    private var _alert2:BaseAlerFrame;

    private function __loadWeakGuild(param1:Event) : void
    {
        var _loc2_:* = null;
        removeEventListener("addedToStage",__loadWeakGuild);
        if(!WeakGuildManager.Instance.switchUserGuide)
        {
            return;
        }
        showStart();
        if(!PlayerManager.Instance.Self.IsWeakGuildFinish(39) && PlayerManager.Instance.Self.IsWeakGuildFinish(9))
        {
            _loc2_ = ComponentFactory.Instance.creat("trainer.vane.mainFrame");
            _loc2_.show();
        }
        if(!PlayerManager.Instance.Self.IsWeakGuildFinish(89) && PlayerManager.Instance.Self.Grade >= 12)
        {
            userGuideAlert(89,"room.view.roomView.MatchRoomView.challengeTip");
        }
    }

    private function showStart() : void
    {
        if(!PlayerManager.Instance.Self.IsWeakGuildFinish(48))
        {
            NewHandContainer.Instance.clearArrowByID(-1);
            NewHandContainer.Instance.showArrow(9,-45,"trainer.startGameArrowPos","asset.trainer.startGameTipAsset","trainer.startGameTipPos",this);
        }
    }

    private function showWait() : void
    {
        if(!PlayerManager.Instance.Self.IsWeakGuildFinish(48))
        {
            NewHandContainer.Instance.clearArrowByID(-1);
            NewHandContainer.Instance.showArrow(8,-45,"trainer.startGameArrowPos","asset.trainer.txtWait","trainer.startGameTipPos",this);
        }
    }

    private function userGuideAlert(param1:int, param2:String) : void
    {
        var _loc3_:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation(param2),"","",false,false,false,2);
        _loc3_.addEventListener("response",__responseTip);
        SocketManager.Instance.out.syncWeakStep(param1);
    }

    private function __responseTip(param1:FrameEvent) : void
    {
        SoundManager.instance.play("008");
        var _loc2_:BaseAlerFrame = param1.currentTarget as BaseAlerFrame;
        _loc2_.removeEventListener("response",__responseTip);
        ObjectUtils.disposeObject(_loc2_);
    }

    private function __crossZoneChangeHandler(param1:RoomEvent) : void
    {
        _crossZoneBtn.selected = _info.isCrossZone;
        if(_info.isCrossZone)
        {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.room.RoomIIView.cross.kuaqu"));
        }
        else
        {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.room.RoomIIView.cross.benqu"));
        }
    }

    private function __onTweentySec(param1:RoomEvent) : void
    {
        if(RoomManager.Instance.current.selfRoomPlayer.isViewer)
        {
            return;
        }
        _cancelBtn.enable = true;
    }

    private function __onTimer(param1:TimerEvent) : void
    {
        if(false && _timerII.currentCount == 40 && _info.selfRoomPlayer.isHost)
        {
            showMatchNpc();
        }
        if((_info.gameMode == 1 || _info.gameMode == 13) && _timerII.currentCount == 60 && _info.selfRoomPlayer.isHost)
        {
            showBothMode();
        }
    }

    private function showMatchNpc() : void
    {
        var _loc1_:AlertInfo = new AlertInfo();
        _loc1_.title = LanguageMgr.GetTranslation("AlertDialog.Info");
        _loc1_.data = LanguageMgr.GetTranslation("tank.room.PickupPanel.ChangeStyle");
        _alert1 = AlertManager.Instance.alert("SimpleAlert",_loc1_,2);
        _alert1.addEventListener("response",__onResponse);
    }

    private function __onResponse(param1:FrameEvent) : void
    {
        var _loc2_:* = null;
        if(param1.responseCode == 2 || param1.responseCode == 3)
        {
            GameInSocketOut.sendGameStyle(2);
            _loc2_ = new ChatData();
            _loc2_.channel = 7;
            _loc2_.msg = LanguageMgr.GetTranslation("tank.room.UpdateGameStyle");
            if(!StateManager.currentStateType != "teamRoom")
            {
                ChatManager.Instance.chat(_loc2_);
            }
        }
        _alert1.removeEventListener("response",__onResponse);
        _alert1.dispose();
    }

    private function showBothMode() : void
    {
        _alert2 = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("tank.room.PickupPanel.ChangeStyle"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,true,2);
        _alert2.addEventListener("response",__onResponseII);
    }

    private function __onResponseII(param1:FrameEvent) : void
    {
        var _loc2_:* = null;
        SoundManager.instance.play("008");
        _alert2.removeEventListener("response",__onResponseII);
        _alert2.dispose();
        if(param1.responseCode == 2 || param1.responseCode == 3)
        {
            GameInSocketOut.sendGameStyle(2);
            _loc2_ = new ChatData();
            _loc2_.channel = 7;
            _loc2_.msg = LanguageMgr.GetTranslation("tank.room.UpdateGameStyle");
            if(!StateManager.currentStateType != "teamRoom")
            {
                ChatManager.Instance.chat(_loc2_);
            }
        }
    }

    private function __crossZoneClick(param1:MouseEvent) : void
    {
        SoundManager.instance.play("008");
        GameInSocketOut.sendGameRoomSetUp(_info.mapId,_info.type,false,_info.roomPass,_info.roomName,3,0,0,!_info.isCrossZone,0);
        _crossZoneBtn.selected = _info.isCrossZone;
    }

    private function __onFightNpc(param1:PkgEvent) : void
    {
        showMatchNpc();
    }

    override protected function updateButtons() : void
    {
        super.updateButtons();
        _crossZoneBtn.enable = _info.selfRoomPlayer.isHost && !_info.started;
        _smallMapInfoPanel._actionStatus = _info.selfRoomPlayer.isHost && !_info.started && _info.type != 13 && _info.type != 12;
        if(_info.type == 12 || _info.type == 13)
        {
            _inviteBtn.enable = false;
            _crossZoneBtn.enable = false;
        }
        if(_info.type == 13)
        {
            _startBtn.removeEventListener("click",__startClick);
            _startBtn.filters = [ComponentFactory.Instance.model.getSet("grayFilter")];
            _startBtn.gotoAndStop(1);
            _startBtn.buttonMode = false;
            _prepareBtn.enabled = false;
            _cancelBtn.enable = false;
        }
        if(_info.gameMode == 41 || _info.gameMode == 42)
        {
            _crossZoneBtn.selected = true;
            _crossZoneBtn.enable = false;
        }
    }

    override protected function initView() : void
    {
        _bg = ClassUtils.CreatInstance("asset.background.room.right") as MovieClip;
        PositionUtils.setPos(_bg,"asset.ddtmatchroom.bgPos");
        addChild(_bg);
        _itemListBg = ClassUtils.CreatInstance("asset.ddtroom.playerItemlist.bg") as MovieClip;
        PositionUtils.setPos(_itemListBg,"asset.ddtroom.playerItemlist.bgPos");
        addChild(_itemListBg);
        _bigMapInfoPanel = ComponentFactory.Instance.creatCustomObject("ddtroom.matchRoomBigMapInfoPanel");
        _bigMapInfoPanel.info = _info;
        addChild(_bigMapInfoPanel);
        _smallMapInfoPanel = ComponentFactory.Instance.creatCustomObject("ddtroom.matchRoomSmallMapInfoPanel");
        _smallMapInfoPanel.info = _info;
        addChild(_smallMapInfoPanel);
        _crossZoneBtn = ComponentFactory.Instance.creatComponentByStylename("asset.ddtroom.crossZoneButton");
        _crossZoneBtn.selected = _info.isCrossZone;
        addChild(_crossZoneBtn);
        super.initView();
        if(_info.gameMode == 41 || _info.gameMode == 42)
        {
            RoomManager.Instance.isEnterTainmentRoom = true;
            _roomPropView.visible = false;
            _roomDesbit = ClassUtils.CreatInstance("asset.Entertainment.mode.explain") as MovieClip;
            PositionUtils.setPos(_roomDesbit,"asset.ddtmatchroom.entertainmentBgPos");
            addChild(_roomDesbit);
            _roomIdTxt = ComponentFactory.Instance.creatComponentByStylename("room.roomID.text");
            PositionUtils.setPos(_roomIdTxt,"asset.ddtmatchroom.entertainmentNumPos");
            _roomIdTxt.text = RoomManager.Instance.current.ID.toString();
            addChild(_roomIdTxt);
        }
        if(BossBoxManager.instance.isShowBoxButton())
        {
            _boxButton = new SmallBoxButton(2);
            addChild(_boxButton);
        }
        if(LeagueManager.instance.maxCount != -1 && PlayerManager.Instance.Self.Grade >= 24 && _info.gameMode != 41 && _info.gameMode != 42 && _info.gameMode != 68 && StateManager.currentStateType != "teamRoom")
        {
            _leagueTxt = ComponentFactory.Instance.creatComponentByStylename("league.restCount.tipTxt");
            _leagueTxt.text = LanguageMgr.GetTranslation("ddt.league.restCountTipTxt",LeagueManager.instance.restCount.toString(),LeagueManager.instance.maxCount.toString());
            addChild(_leagueTxt);
        }
    }

    override protected function initTileList() : void
    {
        var _loc4_:int = 0;
        var _loc1_:* = null;
        super.initTileList();
        _playerItemContainer = new SimpleTileList(2);
        var _loc3_:Point = ComponentFactory.Instance.creatCustomObject("asset.ddtroom.matchRoom.listSpace");
        _playerItemContainer.hSpace = _loc3_.x;
        _playerItemContainer.vSpace = _loc3_.y;
        var _loc2_:Point = ComponentFactory.Instance.creatCustomObject("asset.ddtroom.playerListPos");
        _playerItemContainer.x = _bg.x + _loc2_.x;
        _playerItemContainer.y = _bg.y + _loc2_.y;
        _loc4_ = 0;
        while(_loc4_ < 4)
        {
            _loc1_ = new RoomPlayerItem(_loc4_);
            _playerItemContainer.addChild(_loc1_);
            _playerItems.push(_loc1_);
            _loc4_++;
        }
        addChild(_playerItemContainer);
        if(isViewerRoom)
        {
            PositionUtils.setPos(_viewerItems[0],"asset.ddtmatchroom.ViewerItemPos");
            addChild(_viewerItems[0]);
            if(_info.gameMode == 41 || _info.gameMode == 42)
            {
                _loc4_ = 0;
                while(_loc4_ < _viewerItems.length)
                {
                    _viewerItems[_loc4_].visible = false;
                    _loc4_++;
                }
            }
        }
    }

    override protected function __addPlayer(param1:RoomEvent) : void
    {
        var _loc2_:RoomPlayer = param1.params[0] as RoomPlayer;
        if(_loc2_.isFirstIn)
        {
            SoundManager.instance.play("158");
        }
        if(_loc2_.isViewer)
        {
            _viewerItems[_loc2_.place - 8].info = _loc2_;
        }
        else
        {
            _playerItems[_loc2_.place].info = _loc2_;
        }
        updateButtons();
    }

    override protected function __removePlayer(param1:RoomEvent) : void
    {
        var _loc2_:RoomPlayer = param1.params[0] as RoomPlayer;
        if(_loc2_.place >= 8)
        {
            _viewerItems[_loc2_.place - 8].info = null;
        }
        else
        {
            _playerItems[_loc2_.place].info = null;
        }
        _loc2_.dispose();
        updateButtons();
    }

    override public function dispose() : void
    {
        super.dispose();
        if(_bg)
        {
            removeChild(_bg);
        }
        _bg = null;
        if(_roomIdTxt)
        {
            removeChild(_roomIdTxt);
        }
        _roomIdTxt = null;
        if(_roomDesbit)
        {
            removeChild(_roomDesbit);
        }
        _roomDesbit = null;
        if(_boxButton)
        {
            BossBoxManager.instance.deleteBoxButton();
            ObjectUtils.disposeObject(_boxButton);
        }
        if(_limitAwardButton)
        {
            ObjectUtils.disposeObject(_limitAwardButton);
        }
        _limitAwardButton = null;
        _boxButton = null;
        _bigMapInfoPanel.dispose();
        _bigMapInfoPanel = null;
        _smallMapInfoPanel.dispose();
        _smallMapInfoPanel = null;
        _playerItemContainer.dispose();
        _playerItemContainer = null;
        _crossZoneBtn.dispose();
        _crossZoneBtn = null;
        if(_alert1)
        {
            _alert1.dispose();
        }
        _alert1 = null;
        if(_alert2)
        {
            _alert2.dispose();
        }
        _alert2 = null;
        if(_leagueTxt)
        {
            ObjectUtils.disposeObject(_leagueTxt);
        }
        _leagueTxt = null;
    }

    //======================================================================================================================

    private var _startGameTimer:Timer = null;

    private function get roomInfo() : RoomInfo
    {
        return RoomManager.Instance.current;
    }

    public function MatchRoomView(param1:RoomInfo)
    {
        _timerII = new Timer(1000);
        _startGameTimer = new Timer(2000);
        super(param1);
    }

    override protected function initEvents() : void
    {
        ChatManager.Instance.sysChatYellow("MatchRoom_initEvents");
        super.initEvents();
        SocketManager.Instance.removeEventListener(PkgEvent.format(50),__onFightNpc);
        _info.addEventListener("allowCrossChange",__crossZoneChangeHandler);
        _bigMapInfoPanel.addEventListener("tweentySec",__onTweentySec);
        _crossZoneBtn.addEventListener("click",__crossZoneClick);
        _timerII.addEventListener("timer",__onTimer);
        _startGameTimer.addEventListener("timer", __retryStartGame);
        KeyboardManager.getInstance().addEventListener("keyDown",__KeyDown);
        addEventListener("addedToStage",__loadWeakGuild);
        if (AutoGameManager.Instance.IsAutoMatchGame)
        {
            _startGameTimer.start();
        }
    }

    override protected function removeEvents() : void
    {
        super.removeEvents();
        SocketManager.Instance.removeEventListener(PkgEvent.format(50),__onFightNpc);
        _info.removeEventListener("allowCrossChange",__crossZoneChangeHandler);
        _bigMapInfoPanel.removeEventListener("tweentySec",__onTweentySec);
        _crossZoneBtn.removeEventListener("click",__crossZoneClick);
        _timerII.removeEventListener("timer",__onTimer);
        _startGameTimer.stop();
        _startGameTimer.removeEventListener("timer", __retryStartGame);
        KeyboardManager.getInstance().removeEventListener("keyDown",__KeyDown);
        removeEventListener("addedToStage",__loadWeakGuild);
        if(_alert1)
        {
            _alert1.removeEventListener("response",__onResponse);
        }
        if(_alert2)
        {
            _alert2.removeEventListener("response",__onResponseII);
        }
    }

    override protected function __startHandler(param1:RoomEvent) : void
    {
        super.__startHandler(param1);
        if(_info.started)
        {
            _timerII.start();
            if (AutoGameManager.Instance.IsAutoMatchGame)
            {
                _startGameTimer.stop();
                _startGameTimer.reset();
            }
            showWait();
        }
        else
        {
            _timerII.stop();
            _timerII.reset();
            if (AutoGameManager.Instance.IsAutoMatchGame)
            {
                _startGameTimer.start();
            }
            showStart();
        }
    }

    protected function __retryStartGame(event:TimerEvent):void
    {
        if (roomInfo.selfRoomPlayer.isHost && roomInfo.isAllReady())
        {
            if (!roomInfo.started)
            {
                roomInfo.started = true;
                startGame();
            }
        }
        else if (roomInfo.selfRoomPlayer.isFirstIn)
        {
            prepareGame();
        }
    }

    protected function __KeyDown(param1:KeyboardEvent) : void
    {
        if (param1.keyCode == KeyStroke.VK_K.getCode())
        {

            SoundManager.instance.play("008");
            if (roomInfo.selfRoomPlayer.isHost || roomInfo.selfRoomPlayer.isFirstIn)
            {
                AutoGameManager.Instance.toggleAutoMatchGame();
                if (AutoGameManager.Instance.IsAutoMatchGame)
                {
                    _startGameTimer.start();
                }
                else
                {
                    _startGameTimer.stop();
                    _startGameTimer.reset();
                }
                ChatManager.Instance.sysChatYellow("IsAutoMatchGame: " + AutoGameManager.Instance.IsAutoMatchGame.toString());
            }
        }
    }

//======================================================================================================================
}
}
