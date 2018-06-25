package room.view.roomView
{
   import bagAndInfo.info.PlayerInfoViewControl;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.ui.vo.AlertInfo;
   import com.pickgliss.utils.ObjectUtils;
   import consortion.view.selfConsortia.Badge;
   import ddt.data.player.SelfInfo;
   import ddt.manager.ChatManager;
   import ddt.manager.GameInSocketOut;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import ddt.manager.StateManager;
   import ddt.utils.PositionUtils;
   import ddt.view.academyCommon.academyIcon.AcademyIcon;
   import ddt.view.character.CharactoryFactory;
   import ddt.view.character.ICharacter;
   import ddt.view.common.LevelIcon;
   import ddt.view.common.MarriedIcon;
   import ddt.view.common.VipLevelIcon;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import gameCommon.GameControl;
   import room.RoomManager;
   import room.model.RoomInfo;
   import room.view.SingleRoomRightPropView;
   import vip.VipController;
   
   public class SingleRoomViewForSeven extends BaseAlerFrame
   {
      
      public static const ENCOUNTER:int = 1;
       
      
      protected var _roomInfo:RoomInfo;
      
      protected var _bg:Bitmap;
      
      protected var _singleRoomRightPropView:SingleRoomRightPropView;
      
      protected var _nameText:FilterFrameText;
      
      protected var _vipName:GradientText;
      
      protected var _guildTitle:FilterFrameText;
      
      protected var _guildName:FilterFrameText;
      
      protected var _player:ICharacter;
      
      protected var _selfInfo:SelfInfo;
      
      protected var _levelIcon:LevelIcon;
      
      protected var _vipIcon:VipLevelIcon;
      
      protected var _marriedIcon:MarriedIcon;
      
      protected var _academyIcon:AcademyIcon;
      
      protected var _iconContainer:VBox;
      
      protected var _badge:Badge;
      
      protected var _model:ScaleFrameImage;
      
      protected var _explain:FilterFrameText;
      
      protected var _cancelBtn:SimpleBitmapButton;
      
      protected var _timerText:FilterFrameText;
      
      protected var _waiting:Bitmap;
      
      protected var _chatBtn:SimpleBitmapButton;
      
      protected var _timer:Timer;
      
      protected var _isCancelWait:Boolean = true;
      
      public function SingleRoomViewForSeven()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         _bg = ComponentFactory.Instance.creatBitmap("asset.room.view.roomView.SingleRoomView.BG");
         addToContent(_bg);
         _selfInfo = PlayerManager.Instance.Self;
         createRightView();
         createLeftView();
      }
      
      protected function createRightView() : void
      {
         _player = CharactoryFactory.createCharacter(_selfInfo,"room");
         _player.showGun = true;
         _player.show();
         _player.setShowLight(true);
         _player.scaleX = -1.3;
         _player.scaleY = 1.3;
         PositionUtils.setPos(_player,"room.view.roomView.singleRoomView.playerPos");
         addToContent(_player as DisplayObject);
         _nameText = ComponentFactory.Instance.creatComponentByStylename("room.view.roomView.SingleRoomView.nickNameText");
         _nameText.text = _selfInfo.NickName;
         addToContent(_nameText);
         if(_selfInfo.IsVIP)
         {
            _vipName = VipController.instance.getVipNameTxt(104,_selfInfo.typeVIP);
            _vipName.textSize = 16;
            _vipName.x = _nameText.x;
            _vipName.y = _nameText.y - 2;
            _vipName.text = _selfInfo.NickName;
            addToContent(_vipName);
         }
         PositionUtils.adaptNameStyle(_selfInfo,_nameText,_vipName);
         _guildTitle = ComponentFactory.Instance.creatComponentByStylename("room.view.roomView.SingleRoomView.guildTitle");
         _guildTitle.text = LanguageMgr.GetTranslation("tank.menu.ClubName");
         addToContent(_guildTitle);
         _guildName = ComponentFactory.Instance.creatComponentByStylename("room.view.roomView.SingleRoomView.guildName");
         _guildName.text = _selfInfo.ConsortiaName;
         addToContent(_guildName);
         _explain = ComponentFactory.Instance.creatComponentByStylename("room.view.roomView.SingleRoomView.explainText");
         addToContent(_explain);
         _iconContainer = ComponentFactory.Instance.creatComponentByStylename("room.view.roomView.SingleRoomView.iconContainer");
         addToContent(_iconContainer);
         _levelIcon = ComponentFactory.Instance.creat("room.view.roomView.singleRoomView.levelIcon");
         _levelIcon.setInfo(_selfInfo.Grade,_selfInfo.ddtKingGrade,_selfInfo.Repute,_selfInfo.WinCount,_selfInfo.TotalCount,_selfInfo.FightPower,_selfInfo.Offer,true,false);
         addToContent(_levelIcon);
         _vipIcon = ComponentFactory.Instance.creatCustomObject("room.view.roomView.singleRoomView.VipIcon");
         _vipIcon.setInfo(_selfInfo);
         _iconContainer.addChild(_vipIcon);
         if(!_selfInfo.IsVIP)
         {
            _vipIcon.filters = ComponentFactory.Instance.creatFilters("grayFilter");
         }
         if(_selfInfo.SpouseID > 0 && !_marriedIcon)
         {
            _marriedIcon = ComponentFactory.Instance.creatCustomObject("room.view.roomView.singleRoomView.MarriedIcon");
            _marriedIcon.tipData = {
               "nickName":_selfInfo.SpouseName,
               "gender":_selfInfo.Sex
            };
            _iconContainer.addChild(_marriedIcon);
         }
         if(_selfInfo.shouldShowAcademyIcon())
         {
            _academyIcon = ComponentFactory.Instance.creatCustomObject("room.view.roomView.singleRoomView.AcademyIcon");
            _academyIcon.tipData = _selfInfo;
            _iconContainer.addChild(_academyIcon);
         }
         if(_selfInfo.ConsortiaID > 0 && _selfInfo.badgeID)
         {
            _badge = new Badge();
            _badge.badgeID = _selfInfo.badgeID;
            _badge.showTip = true;
            _badge.tipData = _selfInfo.ConsortiaName;
            _iconContainer.addChild(_badge);
         }
      }
      
      public function initTitle(type:int = 1) : void
      {
         if(type == 2)
         {
            info = new AlertInfo(LanguageMgr.GetTranslation("ddt.battleGroud"));
            _model = ComponentFactory.Instance.creatComponentByStylename("room.view.roomView.SingleRoomView.modelTitle2");
            addToContent(_model);
            _cancelBtn = ComponentFactory.Instance.creatComponentByStylename("room.view.roomView.SingleRoomView.cancelBtn2");
            addToContent(_cancelBtn);
            _explain.text = LanguageMgr.GetTranslation("room.view.roomView.SingleRoomView.explain2");
         }
         else
         {
            info = new AlertInfo(LanguageMgr.GetTranslation("room.view.roomView.SingleRoomView.title"));
            _model = ComponentFactory.Instance.creatComponentByStylename("room.view.roomView.SingleRoomView.modelTitle1");
            addToContent(_model);
            _cancelBtn = ComponentFactory.Instance.creatComponentByStylename("room.view.roomView.SingleRoomView.cancelBtn");
            addToContent(_cancelBtn);
            _explain.text = LanguageMgr.GetTranslation("room.view.roomView.SingleRoomView.explainI");
         }
         initEvent();
      }
      
      protected function createLeftView() : void
      {
         _singleRoomRightPropView = new SingleRoomRightPropView();
         PositionUtils.setPos(_singleRoomRightPropView,"room.view.roomView.singleRoomView.SingleRoomRightPropViewPos");
         addToContent(_singleRoomRightPropView);
         _timerText = ComponentFactory.Instance.creatComponentByStylename("room.view.roomView.SingleRoomView.timeTxt");
         _timerText.text = "00";
         addToContent(_timerText);
         _waiting = ComponentFactory.Instance.creatBitmap("asset.ddtroom.bigMapInfo.matchingTxt");
         PositionUtils.setPos(_waiting,"room.view.roomView.singleRoomView.waitingPos");
         addToContent(_waiting);
         _chatBtn = ComponentFactory.Instance.creatComponentByStylename("room.view.roomView.SingleRoomView.chatButton");
         _chatBtn.tipData = LanguageMgr.GetTranslation("tank.game.ToolStripView.chat");
         addToContent(_chatBtn);
         _timer = new Timer(1000);
         _timer.addEventListener("timer",__timer);
         _timer.start();
      }
      
      protected function initEvent() : void
      {
         _cancelBtn.addEventListener("click",__onCancel);
         GameControl.Instance.addEventListener("StartLoading",__onStartLoad);
         _chatBtn.addEventListener("click",__chatClick);
      }
      
      protected function __chatClick(event:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         LayerManager.Instance.addToLayer(ChatManager.Instance.view,3);
      }
      
      protected function removeEvent() : void
      {
         _cancelBtn.removeEventListener("click",__onCancel);
         GameControl.Instance.removeEventListener("StartLoading",__onStartLoad);
         _chatBtn.removeEventListener("click",__chatClick);
      }
      
      protected function __onStartLoad(event:Event) : void
      {
         _isCancelWait = false;
         var roomInfo:RoomInfo = RoomManager.Instance.current;
         if(GameControl.Instance.Current == null)
         {
            return;
         }
         if(roomInfo.type == 16)
         {
            StateManager.setState("encounterLoading",GameControl.Instance.Current);
         }
         else
         {
            StateManager.setState("roomLoading",GameControl.Instance.Current);
         }
      }
      
      protected function __onCancel(event:MouseEvent) : void
      {
         dispatchEvent(new FrameEvent(4));
      }
      
      protected function __timer(evt:TimerEvent) : void
      {
         var min:uint = _timer.currentCount / 60;
         var sec:uint = _timer.currentCount % 60;
         _timerText.text = sec > 9?sec.toString():"0" + sec;
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,2);
      }
      
      override public function dispose() : void
      {
         if(_isCancelWait)
         {
            GameInSocketOut.sendCancelWait();
         }
         if(PlayerInfoViewControl._isBattle)
         {
            PlayerInfoViewControl._isBattle = false;
         }
         removeEvent();
         _timer.removeEventListener("timer",__timer);
         _timer.stop();
         _timer = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_singleRoomRightPropView);
         _singleRoomRightPropView = null;
         ObjectUtils.disposeObject(_nameText);
         _nameText = null;
         ObjectUtils.disposeObject(_vipName);
         _vipName = null;
         ObjectUtils.disposeObject(_guildTitle);
         _guildTitle = null;
         ObjectUtils.disposeObject(_guildName);
         _guildName = null;
         ObjectUtils.disposeObject(_player);
         _player = null;
         ObjectUtils.disposeObject(_levelIcon);
         _levelIcon = null;
         ObjectUtils.disposeObject(_vipIcon);
         _vipIcon = null;
         ObjectUtils.disposeObject(_marriedIcon);
         _marriedIcon = null;
         ObjectUtils.disposeObject(_academyIcon);
         _academyIcon = null;
         ObjectUtils.disposeObject(_badge);
         _badge = null;
         ObjectUtils.disposeObject(_iconContainer);
         _iconContainer = null;
         ObjectUtils.disposeObject(_model);
         _model = null;
         ObjectUtils.disposeObject(_explain);
         _explain = null;
         ObjectUtils.disposeObject(_cancelBtn);
         _cancelBtn = null;
         ObjectUtils.disposeObject(_timerText);
         _timerText = null;
         ObjectUtils.disposeObject(_waiting);
         _waiting = null;
         super.dispose();
      }
   }
}
