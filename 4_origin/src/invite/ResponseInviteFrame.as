package invite
{
   import bombKing.BombKingManager;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.DisplayUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.InviteInfo;
   import ddt.manager.IMManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MapManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.StateManager;
   import ddt.utils.AssetModuleLoader;
   import ddt.utils.PositionUtils;
   import ddt.view.common.LevelIcon;
   import ddtBuried.BuriedManager;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.FocusEvent;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.Timer;
   import road7th.data.DictionaryData;
   import vip.VipController;
   import wonderfulActivity.WonderfulActivityManager;
   
   public class ResponseInviteFrame extends Frame
   {
      
      private static const InvitePool:DictionaryData = new DictionaryData(true);
       
      
      private var _levelIcon:LevelIcon;
      
      private var _name:FilterFrameText;
      
      private var _vipName:GradientText;
      
      private var _powerTitle:Bitmap;
      
      private var _powerValue:FilterFrameText;
      
      private var _titleBmp:Bitmap;
      
      private var _bg:Bitmap;
      
      private var _modeLabel:FilterFrameText;
      
      private var _mode:ScaleFrameImage;
      
      private var _leftLabel:FilterFrameText;
      
      private var _leftField:FilterFrameText;
      
      private var _rightLabel:FilterFrameText;
      
      private var _rightField:FilterFrameText;
      
      private var _levelField:FilterFrameText;
      
      private var _levelLabel:FilterFrameText;
      
      private var _tipField:FilterFrameText;
      
      private var _doButton:TextButton;
      
      private var _cancelButton:TextButton;
      
      private var _startTime:int = 0;
      
      private var _elapsed:int = 0;
      
      private var _titleString:String;
      
      private var _timeUnit:String;
      
      private var _prohibitSelectBtn:SelectedCheckButton;
      
      private var _prohibitText:FilterFrameText;
      
      private var _startupMark:Boolean = false;
      
      private var _markTime:int = 15;
      
      private var _visible:Boolean = true;
      
      private var _inviteInfo:InviteInfo;
      
      private var _resState:String;
      
      private var _timer:Timer;
      
      private var _uiReady:Boolean = false;
      
      private var _attestBtn:ScaleFrameImage;
      
      public function ResponseInviteFrame()
      {
         _titleString = LanguageMgr.GetTranslation("FPSView.as.InviteAlertPanel.yaoqingni");
         _timeUnit = LanguageMgr.GetTranslation("FPSView.as.InviteAlertPanel.second");
         super();
         configUi();
         addEvent();
         if(_inviteInfo)
         {
            onUpdateData();
         }
         _timer = new Timer(1000,_markTime);
      }
      
      private static function removeInvite(inviteFrame:ResponseInviteFrame) : void
      {
         InvitePool.remove(String(inviteFrame.inviteInfo.playerid));
      }
      
      public static function clearInviteFrame() : void
      {
         var resp:* = null;
         var responseArr:Array = InvitePool.list;
         while(responseArr.length > 0)
         {
            resp = responseArr[0];
            if(resp)
            {
               ObjectUtils.disposeObject(resp);
            }
         }
      }
      
      public static function newInvite(info:InviteInfo) : ResponseInviteFrame
      {
         var response:* = null;
         if(InvitePool[info.playerid] != null)
         {
            response = InvitePool[info.playerid];
            response.inviteInfo = info;
         }
         else
         {
            response = ComponentFactory.Instance.creatComponentByStylename("ResponseInviteFrame");
            InvitePool.add(String(info.playerid),response);
            response.inviteInfo = info;
         }
         return response;
      }
      
      private function configUi() : void
      {
         titleText = LanguageMgr.GetTranslation("tank.invite.InviteView.request");
         _bg = ComponentFactory.Instance.creatBitmap("ast.invite.bg");
         addToContent(_bg);
         _powerTitle = ComponentFactory.Instance.creatBitmap("ast.invite.power");
         _powerTitle.x = 240;
         _powerTitle.y = 71;
         addToContent(_powerTitle);
         _powerValue = ComponentFactory.Instance.creat("invite.response.powerValueLabel");
         addToContent(_powerValue);
         _titleBmp = ComponentFactory.Instance.creatBitmap("ast.invite.title");
         _titleBmp.x = 134;
         _titleBmp.y = 103;
         _name = ComponentFactory.Instance.creatComponentByStylename("asset.ddtinvite.cell.IniterName");
         addToContent(_name);
         _levelIcon = ComponentFactory.Instance.creatCustomObject("asset.ddtinvite.cell.LevelIcon2");
         _levelIcon.x = 62;
         _levelIcon.y = 68;
         _levelIcon.mouseEnabled = false;
         _levelIcon.mouseChildren = false;
         _levelIcon.setSize(1);
         addToContent(_levelIcon);
         _modeLabel = ComponentFactory.Instance.creatComponentByStylename("invite.response.ModeLabel");
         _modeLabel.text = LanguageMgr.GetTranslation("FPSView.as.InviteAlertPanel.ModeLabel");
         addToContent(_modeLabel);
         _mode = ComponentFactory.Instance.creatComponentByStylename("invite.response.GameMode");
         DisplayUtils.setFrame(_mode,1);
         addToContent(_mode);
         _leftLabel = ComponentFactory.Instance.creatComponentByStylename("invite.response.MapLabel");
         _leftLabel.text = LanguageMgr.GetTranslation("FPSView.as.InviteAlertPanel.map");
         addToContent(_leftLabel);
         _leftField = ComponentFactory.Instance.creatComponentByStylename("invite.response.MapField");
         addToContent(_leftField);
         _rightLabel = ComponentFactory.Instance.creatComponentByStylename("invite.response.TimeLabel");
         _rightLabel.text = LanguageMgr.GetTranslation("FPSView.as.InviteAlertPanel.huihetime");
         addToContent(_rightLabel);
         _rightField = ComponentFactory.Instance.creatComponentByStylename("invite.response.TimeField");
         addToContent(_rightField);
         _levelLabel = ComponentFactory.Instance.creatComponentByStylename("invite.response.LevelLabel");
         addToContent(_levelLabel);
         _levelField = ComponentFactory.Instance.creatComponentByStylename("invite.response.LevelField");
         addToContent(_levelField);
         _tipField = ComponentFactory.Instance.creatComponentByStylename("invite.response.TipField");
         _tipField.text = LanguageMgr.GetTranslation("FPSView.as.InviteAlertPanel.meifanying");
         addToContent(_tipField);
         _doButton = ComponentFactory.Instance.creatComponentByStylename("invite.response.DoButton");
         _doButton.text = LanguageMgr.GetTranslation("tank.room.RoomIIView2.affirm");
         addToContent(_doButton);
         _cancelButton = ComponentFactory.Instance.creatComponentByStylename("invite.response.CancelButton");
         _cancelButton.text = LanguageMgr.GetTranslation("tank.view.DefyAfficheView.cancel");
         addToContent(_cancelButton);
         _prohibitSelectBtn = ComponentFactory.Instance.creatComponentByStylename("ddt.responseInviteFrame.SelectedCheckButton");
         addToContent(_prohibitSelectBtn);
         _prohibitText = ComponentFactory.Instance.creat("ddt.responseInviteFrame.neverViewAgainTxt");
         _prohibitText.text = LanguageMgr.GetTranslation("ddt.inviteFrame.noReceivePlayerInvite");
         addToContent(_prohibitText);
         _attestBtn = ComponentFactory.Instance.creatComponentByStylename("hall.playerInfo.attest");
         addToContent(_attestBtn);
         _attestBtn.visible = false;
         _uiReady = true;
      }
      
      private function setAttestBtnInfo() : void
      {
         if(_inviteInfo.isAttest)
         {
            _attestBtn.visible = true;
            _attestBtn.x = _name.x + _name.width;
            _attestBtn.y = _name.y;
         }
         else
         {
            _attestBtn.visible = false;
         }
      }
      
      private function addEvent() : void
      {
         _doButton.addEventListener("click",__onInviteAccept);
         _cancelButton.addEventListener("click",__onCloseClick);
         addEventListener("addedToStage",__toStage);
         addEventListener("focusIn",__focusIn);
         addEventListener("focusOut",__focusOut);
         _prohibitSelectBtn.addEventListener("click",__onClickSelectedBtn);
      }
      
      private function removeEvent() : void
      {
         _doButton.removeEventListener("click",__onInviteAccept);
         _cancelButton.removeEventListener("click",__onCloseClick);
         removeEventListener("addedToStage",__toStage);
         removeEventListener("focusIn",__focusIn);
         removeEventListener("focusOut",__focusOut);
         removeEventListener("click",__bodyClick,true);
         _prohibitSelectBtn.removeEventListener("click",__onClickSelectedBtn);
      }
      
      public function show() : void
      {
         if(!stage)
         {
            if(!WonderfulActivityManager.Instance.frameFlag && !BuriedManager.Instance.isOpening && !BombKingManager.instance.ShowFlag)
            {
               LayerManager.Instance.addToLayer(this,2,false);
            }
         }
      }
      
      private function __focusOut(evt:FocusEvent) : void
      {
         addEventListener("click",__bodyClick,true);
      }
      
      private function __bodyClick(evt:MouseEvent) : void
      {
         StageReferance.stage.focus = this;
      }
      
      private function __toStage(evt:Event) : void
      {
         var lastFrame:* = null;
         var displayRect:* = null;
         var bounds:* = null;
         var leftTop:* = null;
         var offset:* = null;
         var rightBottom:* = null;
         if(InvitePool.length > 1)
         {
            lastFrame = InvitePool.list[InvitePool.length - 2];
            bounds = lastFrame.getBounds(stage);
            displayRect = ComponentFactory.Instance.creatCustomObject("invite.response.DispalyRect");
            offset = ComponentFactory.Instance.creatCustomObject("invite.response.FrameOffset");
            if(bounds.right + offset.x >= displayRect.right || bounds.bottom + offset.y >= displayRect.bottom)
            {
               x = displayRect.x;
               y = displayRect.y;
            }
            else
            {
               x = bounds.x + offset.x;
               y = bounds.y + offset.y;
            }
         }
         else
         {
            bounds = getBounds(this);
            x = StageReferance.stageWidth - bounds.width >> 1;
            y = StageReferance.stageHeight - bounds.height >> 1;
         }
      }
      
      private function __focusIn(evt:FocusEvent) : void
      {
         removeEventListener("click",__bodyClick,true);
         bringToTop();
      }
      
      private function bringToTop() : void
      {
         if(parent)
         {
            parent.setChildIndex(this,parent.numChildren - 1);
         }
      }
      
      private function enterRoom() : void
      {
         SoundManager.instance.play("008");
         if(_inviteInfo.gameMode == 41 || _inviteInfo.gameMode == 42)
         {
            SocketManager.Instance.out.sendGameLogin(8,-1,_inviteInfo.roomid,_inviteInfo.password,true);
         }
         else
         {
            if(StateManager.currentStateType == "roomlist")
            {
               SocketManager.Instance.out.sendGameLogin(1,-1,_inviteInfo.roomid,_inviteInfo.password,true);
            }
            if(StateManager.currentStateType == "battleRoom")
            {
               SocketManager.Instance.out.sendGameLogin(1,-1,_inviteInfo.roomid,_inviteInfo.password,true);
            }
            else if(StateManager.currentStateType == "dungeon")
            {
               SocketManager.Instance.out.sendGameLogin(2,-1,_inviteInfo.roomid,_inviteInfo.password,true);
            }
            else if(StateManager.currentStateType == "braveDoorRoom")
            {
               SocketManager.Instance.out.sendGameLogin(7,-1,_inviteInfo.roomid,_inviteInfo.password,true);
            }
            else
            {
               SocketManager.Instance.out.sendGameLogin(4,-1,_inviteInfo.roomid,_inviteInfo.password,true);
            }
         }
         close();
         clearInviteFrame();
      }
      
      private function __onInviteAccept(evt:MouseEvent) : void
      {
         AssetModuleLoader.startCodeLoader(enterRoom);
      }
      
      private function onUpdateData() : void
      {
         var data:InviteInfo = _inviteInfo;
         _levelIcon.setInfo(data.level,0,0,0,0,0,0,true,false);
         _name.text = data.nickname;
         if(data.IsVip)
         {
            ObjectUtils.disposeObject(_vipName);
            _vipName = VipController.instance.getVipNameTxt(121,data.typeVIP);
            _vipName.x = _name.x;
            _vipName.y = _name.y;
            _vipName.text = _name.text;
            addToContent(_vipName);
            DisplayUtils.removeDisplay(_name);
         }
         addToContent(_name);
         PositionUtils.adaptNameStyleByType(data.playerType,_name,_vipName);
         _powerValue.text = data.power.toString();
         var time:int = 1;
         if(data.secondType == 1)
         {
            time = 5;
         }
         if(data.secondType == 2)
         {
            time = 7;
         }
         if(data.secondType == 3)
         {
            time = 10;
         }
         if(data.secondType == 4)
         {
            time = 15;
         }
         titleText = LanguageMgr.GetTranslation("tank.invite.response.title",data.nickname);
         if(data.isOpenBoss)
         {
            _titleString = LanguageMgr.GetTranslation("FPSView.as.InviteAlertPanel.yaoqingniboss");
         }
         _modeLabel.visible = true;
         if(data.gameMode < 2 || data.gameMode == 45 || data.gameMode == 120)
         {
            DisplayUtils.setFrame(_mode,data.gameMode + 1);
            if(data.gameMode == 45)
            {
               DisplayUtils.setFrame(_mode,1);
            }
            if(data.gameMode == 120)
            {
               DisplayUtils.setFrame(_mode,7);
            }
            _rightLabel.text = LanguageMgr.GetTranslation("FPSView.as.InviteAlertPanel.huihetime");
            _rightField.text = time + LanguageMgr.GetTranslation("FPSView.as.InviteAlertPanel.second");
            _leftLabel.text = LanguageMgr.GetTranslation("FPSView.as.InviteAlertPanel.map");
            _leftField.text = String(MapManager.getMapName(data.mapid));
         }
         else if(data.gameMode == 58)
         {
            DisplayUtils.setFrame(_mode,9);
            _rightLabel.text = LanguageMgr.GetTranslation("FPSView.as.InviteAlertPanel.huihetime");
            _rightField.text = time + LanguageMgr.GetTranslation("FPSView.as.InviteAlertPanel.second");
            _leftLabel.text = LanguageMgr.GetTranslation("FPSView.as.InviteAlertPanel.map");
            _leftField.text = String(MapManager.getMapName(data.mapid));
         }
         else if(data.gameMode == 2)
         {
            DisplayUtils.setFrame(_mode,data.gameMode + 1);
            _rightLabel.text = LanguageMgr.GetTranslation("tank.view.common.levelRange");
            _rightField.text = getLevelLimits(data.levelLimits);
            _leftLabel.text = LanguageMgr.GetTranslation("tank.view.common.roomLevel");
            _leftField.text = getRoomHardLevel(data.hardLevel);
         }
         else if(data.gameMode > 2 && data.gameMode != 45 && data.gameMode != 120 && data.gameMode != 58)
         {
            DisplayUtils.setFrame(_mode,data.gameMode + 1);
            if(data.gameMode == 11 || data.gameMode == 21 || data.gameMode == 23 || data.gameMode == 47 || data.gameMode == 48 || data.gameMode == 55 || data.gameMode == 123)
            {
               DisplayUtils.setFrame(_mode,5);
            }
            if(data.gameMode == 41)
            {
               DisplayUtils.setFrame(_mode,1);
            }
            if(data.gameMode == 68)
            {
               DisplayUtils.setFrame(_mode,6);
            }
            if(data.gameMode == 49)
            {
               _mode.y = _mode.y + 3;
               DisplayUtils.setFrame(_mode,8);
            }
            else if(data.gameMode == 70)
            {
               DisplayUtils.setFrame(_mode,10);
            }
            _leftLabel.text = LanguageMgr.GetTranslation("tank.view.common.duplicateName");
            PositionUtils.setPos(_leftLabel,"duplicatePos");
            _leftField.text = String(MapManager.getMapName(data.mapid));
            _leftField.x = PositionUtils.creatPoint("duplicateNamePos").x;
            _leftField.y = PositionUtils.creatPoint("duplicateNamePos").y;
            _rightLabel.text = LanguageMgr.GetTranslation("tank.view.common.gameLevel");
            _rightLabel.x = PositionUtils.creatPoint("TimeLabelPos").x;
            _rightLabel.y = PositionUtils.creatPoint("TimeLabelPos").y;
            _rightField.text = getRoomHardLevel(data.hardLevel);
            _rightField.x = PositionUtils.creatPoint("TimeFieldPos").x;
            _rightField.y = PositionUtils.creatPoint("TimeFieldPos").y;
            if(_leftField.text.length > 15)
            {
               _leftField.text = _leftField.text.substring(0,12) + "...";
            }
         }
         if(data.barrierNum == -1 || data.gameMode < 2)
         {
            var _loc3_:* = false;
            _levelField.visible = _loc3_;
            _levelLabel.visible = _loc3_;
         }
         else
         {
            _loc3_ = true;
            _levelField.visible = _loc3_;
            _levelLabel.visible = _loc3_;
            _levelLabel.text = LanguageMgr.GetTranslation("tank.view.common.InviteAlertPanel.pass");
            _levelField.text = String(data.barrierNum <= 0?1:data.barrierNum);
         }
         if(data.gameMode > 2 && data.gameMode != 45 && data.gameMode != 47 && (data.mapid <= 0 || data.mapid >= 10000))
         {
            if(data.mapid != 70001 && data.mapid != 12016 && data.mapid != 70020)
            {
               _leftField.text = LanguageMgr.GetTranslation("FPSView.as.InviteAlertPanel.nochoice");
               _rightField.text = LanguageMgr.GetTranslation("FPSView.as.InviteAlertPanel.nochoice");
               _levelField.text = LanguageMgr.GetTranslation("FPSView.as.InviteAlertPanel.nochoice");
            }
         }
         if(data.gameMode == 28 && data.mapid == 70002)
         {
            _modeLabel.visible = false;
            _loc3_ = "";
            _levelField.text = _loc3_;
            _loc3_ = _loc3_;
            _levelLabel.text = _loc3_;
            _loc3_ = _loc3_;
            _rightField.text = _loc3_;
            _rightLabel.text = _loc3_;
            _leftField.text = String(MapManager.getMapName(data.mapid));
            PositionUtils.setPos(_leftLabel,"duplicatePos1");
            PositionUtils.setPos(_leftField,"duplicateNamePos1");
         }
         restartMark();
         setAttestBtnInfo();
      }
      
      private function __onMark(evt:TimerEvent) : void
      {
         _tipField.text = LanguageMgr.GetTranslation("FPSView.as.InviteAlertPanel.ruguo",_markTime - _timer.currentCount);
      }
      
      private function __onMarkComplete(evt:TimerEvent) : void
      {
         markComplete();
      }
      
      override protected function __onCloseClick(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         close();
      }
      
      private function getLevelLimits(levelLimits:int) : String
      {
         var result:String = "";
         switch(int(levelLimits) - 1)
         {
            case 0:
               result = "1-10";
               break;
            case 1:
               result = "11-20";
               break;
            case 2:
               result = "20-30";
               break;
            case 3:
               result = "30-40";
         }
         return result + LanguageMgr.GetTranslation("grade");
      }
      
      private function getRoomHardLevel(HardLevel:int) : String
      {
         switch(int(HardLevel))
         {
            case 0:
               return LanguageMgr.GetTranslation("tank.room.difficulty.simple");
            case 1:
               return LanguageMgr.GetTranslation("tank.room.difficulty.normal");
            case 2:
               return LanguageMgr.GetTranslation("tank.room.difficulty.hard");
            case 3:
               return LanguageMgr.GetTranslation("tank.room.difficulty.hero");
            default:
               return "";
            case 5:
               return LanguageMgr.GetTranslation("ddt.dungeonRoom.level5");
         }
      }
      
      private function restartMark() : void
      {
         if(_startupMark)
         {
            _timer.removeEventListener("timer",__onMark);
            _timer.removeEventListener("timerComplete",__onMarkComplete);
            _timer.stop();
         }
         _startupMark = true;
         _timer.addEventListener("timer",__onMark);
         _timer.addEventListener("timerComplete",__onMarkComplete);
         _timer.reset();
         _timer.start();
      }
      
      private function markComplete() : void
      {
         _startupMark = false;
         _timer.removeEventListener("timer",__onMark);
         _timer.removeEventListener("timerComplete",__onMarkComplete);
         close();
      }
      
      private function __onClickSelectedBtn(e:MouseEvent) : void
      {
         if(_prohibitSelectBtn.selected)
         {
            IMManager.Instance.prohibitInviteList[inviteInfo.nickname] = true;
         }
         else
         {
            IMManager.Instance.prohibitInviteList[inviteInfo.nickname] = false;
         }
      }
      
      public function close() : void
      {
         ObjectUtils.disposeObject(this);
      }
      
      public function get inviteInfo() : InviteInfo
      {
         return _inviteInfo;
      }
      
      public function set inviteInfo(val:InviteInfo) : void
      {
         _inviteInfo = val;
         if(_uiReady)
         {
            onUpdateData();
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         _timer.removeEventListener("timer",__onMark);
         _timer.removeEventListener("timerComplete",__onMarkComplete);
         _timer = null;
         if(_levelIcon)
         {
            ObjectUtils.disposeObject(_levelIcon);
            _levelIcon = null;
         }
         if(_name)
         {
            ObjectUtils.disposeObject(_name);
            _name = null;
         }
         if(_vipName)
         {
            ObjectUtils.disposeObject(_vipName);
            _vipName = null;
         }
         if(_powerTitle)
         {
            ObjectUtils.disposeObject(_powerTitle);
            _powerTitle = null;
         }
         if(_powerValue)
         {
            ObjectUtils.disposeObject(_powerValue);
            _powerValue = null;
         }
         if(_titleBmp)
         {
            ObjectUtils.disposeObject(_titleBmp);
            _titleBmp = null;
         }
         if(_modeLabel)
         {
            ObjectUtils.disposeObject(_modeLabel);
            _modeLabel = null;
         }
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
            _bg = null;
         }
         if(_mode)
         {
            ObjectUtils.disposeObject(_mode);
            _mode = null;
         }
         if(_prohibitText)
         {
            ObjectUtils.disposeObject(_prohibitText);
            _prohibitText = null;
         }
         if(_leftLabel)
         {
            ObjectUtils.disposeObject(_leftLabel);
            _leftLabel = null;
         }
         if(_leftField)
         {
            ObjectUtils.disposeObject(_leftField);
            _leftField = null;
         }
         if(_rightLabel)
         {
            ObjectUtils.disposeObject(_rightLabel);
            _rightLabel = null;
         }
         if(_rightField)
         {
            ObjectUtils.disposeObject(_rightField);
            _rightField = null;
         }
         if(_tipField)
         {
            ObjectUtils.disposeObject(_tipField);
            _tipField = null;
         }
         if(_doButton)
         {
            ObjectUtils.disposeObject(_doButton);
            _doButton = null;
         }
         if(_cancelButton)
         {
            ObjectUtils.disposeObject(_cancelButton);
            _cancelButton = null;
         }
         if(_levelLabel)
         {
            ObjectUtils.disposeObject(_levelLabel);
            _levelLabel = null;
         }
         if(_levelField)
         {
            ObjectUtils.disposeObject(_levelLabel);
            _levelField = null;
         }
         if(_attestBtn)
         {
            ObjectUtils.disposeObject(_attestBtn);
            _attestBtn = null;
         }
         ObjectUtils.disposeObject(_prohibitSelectBtn);
         _prohibitSelectBtn = null;
         removeInvite(this);
         super.dispose();
      }
   }
}
