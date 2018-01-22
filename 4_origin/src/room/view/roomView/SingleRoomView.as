package room.view.roomView
{
   import bagAndInfo.info.PlayerInfoViewControl;
   import battleGroud.BattleGroudControl;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedCheckButton;
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
   import ddt.manager.CheckWeaponManager;
   import ddt.manager.GameInSocketOut;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.StateManager;
   import ddt.utils.PositionUtils;
   import ddt.view.academyCommon.academyIcon.AcademyIcon;
   import ddt.view.character.CharactoryFactory;
   import ddt.view.character.RoomCharacter;
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
   import room.RoomControl;
   import room.RoomManager;
   import room.model.RoomInfo;
   import room.view.SingleRoomRightPropView;
   import vip.VipController;
   
   public class SingleRoomView extends BaseAlerFrame
   {
      
      public static const ENCOUNTER:int = 1;
       
      
      protected var _roomInfo:RoomInfo;
      
      protected var _bg:Bitmap;
      
      protected var _singleRoomRightPropView:SingleRoomRightPropView;
      
      protected var _nameText:FilterFrameText;
      
      protected var _vipName:GradientText;
      
      protected var _guildTitle:FilterFrameText;
      
      protected var _guildName:FilterFrameText;
      
      protected var _player:RoomCharacter;
      
      protected var _selfInfo:SelfInfo;
      
      protected var _levelIcon:LevelIcon;
      
      protected var _vipIcon:VipLevelIcon;
      
      protected var _marriedIcon:MarriedIcon;
      
      protected var _academyIcon:AcademyIcon;
      
      protected var _iconContainer:VBox;
      
      protected var _badge:Badge;
      
      protected var _model:ScaleFrameImage;
      
      protected var _model2:ScaleFrameImage;
      
      protected var _battleRemainTimesText:FilterFrameText;
      
      protected var _battleRemainTimesLabel:Bitmap;
      
      protected var _explain:FilterFrameText;
      
      protected var _cancelBtn:SimpleBitmapButton;
      
      protected var _timerText:FilterFrameText;
      
      protected var _waiting:Bitmap;
      
      protected var _chatBtn:SimpleBitmapButton;
      
      protected var _timer:Timer;
      
      private var _singBattleState:int;
      
      private var _isCloseOrEscClick:Boolean = false;
      
      private var _type:int;
      
      private var _cancelBtnBg:Bitmap;
      
      private var _startBtn:SimpleBitmapButton;
      
      private var _cancelMatchBtn:SimpleBitmapButton;
      
      private var _1v1Btn:SelectedCheckButton;
      
      private var _1v1Txt:FilterFrameText;
      
      private var _2v2Btn:SelectedCheckButton;
      
      private var _2v2Txt:FilterFrameText;
      
      private var _3v3Btn:SelectedCheckButton;
      
      private var _3v3Txt:FilterFrameText;
      
      private var _4v4Btn:SelectedCheckButton;
      
      private var _4v4Txt:FilterFrameText;
      
      private var _BtnGroup:SelectedButtonGroup;
      
      private var _survival:Bitmap;
      
      protected var _isCancelWait:Boolean = true;
      
      public function SingleRoomView(param1:int = 6)
      {
         _type = param1;
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
         initTitle();
      }
      
      protected function createRightView() : void
      {
         _player = CharactoryFactory.createCharacter(_selfInfo,"room") as RoomCharacter;
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
      
      private function initTitle() : void
      {
         if(_type == 2)
         {
            info = new AlertInfo(LanguageMgr.GetTranslation("ddt.battleGroud"));
            _model = ComponentFactory.Instance.creatComponentByStylename("room.view.roomView.SingleRoomView.battleTitle");
            addToContent(_model);
            _battleRemainTimesLabel = ComponentFactory.Instance.creat("asset.room.view.roomView.BattleTimesRemain");
            addToContent(_battleRemainTimesLabel);
            _battleRemainTimesText = ComponentFactory.Instance.creat("room.view.roomView.SingleRoomView.BattleRemainTimesText");
            _battleRemainTimesText.text = BattleGroudControl.Instance.orderdata.prestigeTimes + "/20";
            addToContent(_battleRemainTimesText);
            _cancelBtn = ComponentFactory.Instance.creatComponentByStylename("room.view.roomView.SingleRoomView.cancelBtn2");
            addToContent(_cancelBtn);
            _explain.text = LanguageMgr.GetTranslation("room.view.roomView.SingleRoomView.explain2");
            _timer.start();
            _timerText.visible = true;
            _waiting.visible = true;
         }
         else if(_type == 21)
         {
            info = new AlertInfo(LanguageMgr.GetTranslation("tank.roomlist.RoomListIICreateRvpRoomView.Survivalmode"));
            _model = ComponentFactory.Instance.creatComponentByStylename("room.survival.infomation");
            addToContent(_model);
            _survival = ComponentFactory.Instance.creat("asset.ddtroom.survival.sixIcon");
            addToContent(_survival);
            _cancelBtnBg = ComponentFactory.Instance.creat("asset.ddtroom.cancelBtnBg");
            addToContent(_cancelBtnBg);
            _startBtn = ComponentFactory.Instance.creatComponentByStylename("room.view.roomView.SingleRoomView.startBtn");
            addToContent(_startBtn);
            _cancelMatchBtn = ComponentFactory.Instance.creatComponentByStylename("room.view.roomView.SingleRoomView.cancelBtn");
            addToContent(_cancelMatchBtn);
            _cancelMatchBtn.visible = false;
         }
         else
         {
            info = new AlertInfo(LanguageMgr.GetTranslation("room.view.roomView.SingleRoomView.title"));
            _model = ComponentFactory.Instance.creatComponentByStylename("room.view.roomView.SingleRoomView.modelTitle1");
            addToContent(_model);
            _model2 = ComponentFactory.Instance.creatComponentByStylename("room.view.roomView.SingleRoomView.modelTitle2");
            addToContent(_model2);
            _1v1Btn = ComponentFactory.Instance.creatComponentByStylename("singleroom.SelectBtn");
            addToContent(_1v1Btn);
            _1v1Txt = ComponentFactory.Instance.creatComponentByStylename("asset.ddtroomList.pvp.typeTxt");
            _1v1Txt.text = LanguageMgr.GetTranslation("ddt.roomlist.1v1");
            _1v1Txt.x = _1v1Btn.x + 28;
            _1v1Txt.y = _1v1Btn.y + 8;
            addToContent(_1v1Txt);
            _2v2Btn = ComponentFactory.Instance.creatComponentByStylename("singleroom.SelectBtn");
            addToContent(_2v2Btn);
            _2v2Btn.x = _1v1Btn.x + 108;
            _2v2Txt = ComponentFactory.Instance.creatComponentByStylename("asset.ddtroomList.pvp.typeTxt");
            _2v2Txt.x = _2v2Btn.x + 28;
            _2v2Txt.y = _2v2Btn.y + 8;
            _2v2Txt.text = LanguageMgr.GetTranslation("ddt.roomlist.2v2");
            addToContent(_2v2Txt);
            _3v3Btn = ComponentFactory.Instance.creatComponentByStylename("singleroom.SelectBtn");
            addToContent(_3v3Btn);
            _3v3Btn.y = _2v2Btn.y + 24;
            _3v3Txt = ComponentFactory.Instance.creatComponentByStylename("asset.ddtroomList.pvp.typeTxt");
            _3v3Txt.x = _3v3Btn.x + 28;
            _3v3Txt.y = _3v3Btn.y + 8;
            _3v3Txt.text = LanguageMgr.GetTranslation("ddt.roomlist.3v3");
            addToContent(_3v3Txt);
            _4v4Btn = ComponentFactory.Instance.creatComponentByStylename("singleroom.SelectBtn");
            addToContent(_4v4Btn);
            _4v4Btn.x = _3v3Btn.x + 108;
            _4v4Btn.y = _3v3Btn.y;
            _4v4Txt = ComponentFactory.Instance.creatComponentByStylename("asset.ddtroomList.pvp.typeTxt");
            _4v4Txt.x = _4v4Btn.x + 28;
            _4v4Txt.y = _4v4Btn.y + 8;
            _4v4Txt.text = LanguageMgr.GetTranslation("ddt.roomlist.4v4");
            addToContent(_4v4Txt);
            _BtnGroup = new SelectedButtonGroup();
            _BtnGroup.addSelectItem(_1v1Btn);
            _BtnGroup.addSelectItem(_2v2Btn);
            _BtnGroup.addSelectItem(_3v3Btn);
            _BtnGroup.addSelectItem(_4v4Btn);
            if(_selfInfo.Grade < 6)
            {
               var _loc1_:* = false;
               _4v4Btn.enable = _loc1_;
               _loc1_ = _loc1_;
               _3v3Btn.enable = _loc1_;
               _2v2Btn.enable = _loc1_;
            }
            _BtnGroup.selectIndex = RoomControl.instance.fightTypeLastSelected;
            _cancelBtnBg = ComponentFactory.Instance.creat("asset.ddtroom.cancelBtnBg");
            addToContent(_cancelBtnBg);
            _startBtn = ComponentFactory.Instance.creatComponentByStylename("room.view.roomView.SingleRoomView.startBtn");
            addToContent(_startBtn);
            _cancelMatchBtn = ComponentFactory.Instance.creatComponentByStylename("room.view.roomView.SingleRoomView.cancelBtn");
            addToContent(_cancelMatchBtn);
            _cancelMatchBtn.visible = false;
            _explain.text = LanguageMgr.GetTranslation("room.view.roomView.SingleRoomView.explainI");
            changeState(1);
         }
         initEvent();
      }
      
      protected function __BtnGroupChange(param1:Event) : void
      {
         SoundManager.instance.play("008");
         RoomControl.instance.fightTypeLastSelected = _BtnGroup.selectIndex;
      }
      
      protected function createLeftView() : void
      {
         if(_type == 2)
         {
            _singleRoomRightPropView = new SingleRoomRightPropView(true);
         }
         else
         {
            _singleRoomRightPropView = new SingleRoomRightPropView(false);
         }
         PositionUtils.setPos(_singleRoomRightPropView,"room.view.roomView.singleRoomView.SingleRoomRightPropViewPos");
         addToContent(_singleRoomRightPropView);
         _chatBtn = ComponentFactory.Instance.creatComponentByStylename("room.view.roomView.SingleRoomView.chatButton");
         _chatBtn.tipData = LanguageMgr.GetTranslation("tank.game.ToolStripView.chat");
         addToContent(_chatBtn);
         _timer = new Timer(1000);
         _timer.addEventListener("timer",__timer);
         _timerText = ComponentFactory.Instance.creatComponentByStylename("room.view.roomView.SingleRoomView.timeTxt");
         _timerText.text = "00";
         _timerText.visible = false;
         addToContent(_timerText);
         _waiting = ComponentFactory.Instance.creatBitmap("asset.ddtroom.bigMapInfo.matchingTxt");
         PositionUtils.setPos(_waiting,"room.view.roomView.singleRoomView.waitingPos");
         _waiting.visible = false;
         addToContent(_waiting);
      }
      
      protected function initEvent() : void
      {
         if(_type == 2)
         {
            _cancelBtn.addEventListener("click",__onCancel);
         }
         else
         {
            if(_type != 21)
            {
               _BtnGroup.addEventListener("change",__BtnGroupChange);
            }
            _startBtn.addEventListener("click",__onStart);
            _cancelMatchBtn.addEventListener("click",__onCancelMatch);
         }
         GameControl.Instance.addEventListener("StartLoading",__onStartLoad);
         GameControl.Instance.addEventListener("StartMatch",__onStartMatch);
         _chatBtn.addEventListener("click",__chatClick);
      }
      
      protected function __onStartMatch(param1:Event) : void
      {
         StateManager.setState("singleBattleMatching",GameControl.Instance.Current);
      }
      
      protected function __onStart(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         CheckWeaponManager.instance.setFunction(this,__onStart,[param1]);
         if(CheckWeaponManager.instance.isNoWeapon())
         {
            CheckWeaponManager.instance.showAlert();
            return;
         }
         if(_type == 21)
         {
            GameInSocketOut.sendSingleRoomBegin(21);
         }
         else
         {
            GameInSocketOut.sendSingleRoomBegin(_BtnGroup.selectIndex + 7);
         }
      }
      
      public function startTime() : void
      {
         changeState(2);
         _startBtn.visible = false;
         _cancelMatchBtn.visible = true;
      }
      
      private function changeState(param1:int) : void
      {
         _singBattleState = param1;
         if(param1 == 1)
         {
            if(_1v1Btn)
            {
               var _loc2_:* = true;
               _model2.visible = _loc2_;
               _loc2_ = _loc2_;
               _1v1Txt.visible = _loc2_;
               _1v1Btn.visible = _loc2_;
            }
            if(_2v2Btn)
            {
               _loc2_ = true;
               _2v2Txt.visible = _loc2_;
               _2v2Btn.visible = _loc2_;
            }
            if(_3v3Btn)
            {
               _loc2_ = true;
               _3v3Txt.visible = _loc2_;
               _3v3Btn.visible = _loc2_;
            }
            if(_4v4Btn)
            {
               _loc2_ = true;
               _4v4Txt.visible = _loc2_;
               _4v4Btn.visible = _loc2_;
            }
            if(_survival)
            {
               _survival.visible = true;
            }
            _timerText.text = "00";
            _timer.stop();
            _timer.reset();
            _loc2_ = false;
            _waiting.visible = _loc2_;
            _timerText.visible = _loc2_;
         }
         else
         {
            if(_1v1Btn)
            {
               _loc2_ = false;
               _model2.visible = _loc2_;
               _loc2_ = _loc2_;
               _1v1Txt.visible = _loc2_;
               _1v1Btn.visible = _loc2_;
            }
            if(_2v2Btn)
            {
               _loc2_ = false;
               _2v2Txt.visible = _loc2_;
               _2v2Btn.visible = _loc2_;
            }
            if(_3v3Btn)
            {
               _loc2_ = false;
               _3v3Txt.visible = _loc2_;
               _3v3Btn.visible = _loc2_;
            }
            if(_4v4Btn)
            {
               _loc2_ = false;
               _4v4Txt.visible = _loc2_;
               _4v4Btn.visible = _loc2_;
            }
            if(_survival)
            {
               _survival.visible = false;
            }
            _timerText.text = "00";
            _timer.start();
            _loc2_ = true;
            _waiting.visible = _loc2_;
            _timerText.visible = _loc2_;
         }
      }
      
      protected function __chatClick(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         LayerManager.Instance.addToLayer(ChatManager.Instance.view,3);
      }
      
      protected function removeEvent() : void
      {
         if(_type == 2)
         {
            _cancelBtn.removeEventListener("click",__onCancel);
         }
         else
         {
            if(_type != 21)
            {
               _BtnGroup.removeEventListener("change",__BtnGroupChange);
            }
            _startBtn.removeEventListener("click",__onStart);
            _cancelMatchBtn.removeEventListener("click",__onCancelMatch);
         }
         GameControl.Instance.removeEventListener("StartLoading",__onStartLoad);
         GameControl.Instance.removeEventListener("StartMatch",__onStartMatch);
         _chatBtn.removeEventListener("click",__chatClick);
      }
      
      protected function __onStartLoad(param1:Event) : void
      {
         _isCancelWait = false;
         var _loc2_:RoomInfo = RoomManager.Instance.current;
         if(GameControl.Instance.Current == null)
         {
            return;
         }
         StateManager.setState("roomLoading",GameControl.Instance.Current);
      }
      
      protected function __onCancel(param1:MouseEvent) : void
      {
         dispatchEvent(new FrameEvent(4));
      }
      
      protected function __onCancelMatch(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         _cancelMatchBtn.visible = false;
         _startBtn.visible = true;
         changeState(1);
         GameInSocketOut.sendCancelWait();
      }
      
      protected function __timer(param1:TimerEvent) : void
      {
         var _loc2_:uint = _timer.currentCount / 60;
         var _loc3_:uint = _timer.currentCount % 60;
         _timerText.text = _loc3_ > 9?_loc3_.toString():"0" + _loc3_;
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,2);
         SocketManager.Instance.out.battleGroundUpdata(1);
      }
      
      public function update() : void
      {
      }
      
      override public function dispose() : void
      {
         if(_type == 6)
         {
            if(_isCloseOrEscClick && _singBattleState == 2)
            {
               GameInSocketOut.sendCancelWait();
            }
         }
         else if(_isCancelWait && (_type == 2 || _type == 21))
         {
            GameInSocketOut.sendCancelWait();
         }
         if(PlayerInfoViewControl._isBattle)
         {
            PlayerInfoViewControl._isBattle = false;
         }
         removeEvent();
         if(_timer)
         {
            _timer.removeEventListener("timer",__timer);
            _timer.stop();
            _timer = null;
         }
         if(_timerText)
         {
            ObjectUtils.disposeObject(_timerText);
         }
         _timerText = null;
         if(_waiting)
         {
            ObjectUtils.disposeObject(_waiting);
         }
         _waiting = null;
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
         if(_model2)
         {
            ObjectUtils.disposeObject(_model2);
         }
         _model2 = null;
         if(_startBtn)
         {
            ObjectUtils.disposeObject(_startBtn);
         }
         _startBtn = null;
         if(_1v1Btn)
         {
            ObjectUtils.disposeObject(_1v1Btn);
         }
         _1v1Btn = null;
         if(_2v2Btn)
         {
            ObjectUtils.disposeObject(_2v2Btn);
         }
         _2v2Btn = null;
         if(_3v3Btn)
         {
            ObjectUtils.disposeObject(_3v3Btn);
         }
         _3v3Btn = null;
         if(_4v4Btn)
         {
            ObjectUtils.disposeObject(_4v4Btn);
         }
         _4v4Btn = null;
         if(_1v1Txt)
         {
            ObjectUtils.disposeObject(_1v1Txt);
         }
         _1v1Txt = null;
         if(_2v2Txt)
         {
            ObjectUtils.disposeObject(_2v2Txt);
         }
         _2v2Txt = null;
         if(_3v3Txt)
         {
            ObjectUtils.disposeObject(_3v3Txt);
         }
         _3v3Txt = null;
         if(_4v4Txt)
         {
            ObjectUtils.disposeObject(_4v4Txt);
         }
         _4v4Txt = null;
         if(_battleRemainTimesText)
         {
            ObjectUtils.disposeObject(_battleRemainTimesText);
         }
         _battleRemainTimesText = null;
         if(_battleRemainTimesLabel)
         {
            ObjectUtils.disposeObject(_battleRemainTimesLabel);
         }
         _battleRemainTimesLabel = null;
         if(_cancelBtnBg)
         {
            ObjectUtils.disposeObject(_cancelBtnBg);
         }
         _cancelBtnBg = null;
         if(_cancelMatchBtn)
         {
            ObjectUtils.disposeObject(_cancelMatchBtn);
         }
         _cancelMatchBtn = null;
         if(_survival)
         {
            ObjectUtils.disposeObject(_survival);
         }
         _survival = null;
         super.dispose();
      }
      
      public function set isCloseOrEscClick(param1:Boolean) : void
      {
         _isCloseOrEscClick = param1;
      }
   }
}
