package labyrinth.view
{
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.UICreatShortcut;
   import com.pickgliss.ui.controls.ListPanel;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.ui.vo.AlertInfo;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.player.PlayerState;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.CheckMoneyUtils;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.text.TextFormat;
   import flash.utils.Timer;
   import kingBless.KingBlessManager;
   import labyrinth.LabyrinthManager;
   import labyrinth.data.CleanOutInfo;
   import road7th.data.DictionaryEvent;
   
   public class CleanOutFrame extends BaseAlerFrame
   {
       
      
      private var _bg:ScaleBitmapImage;
      
      private var _rightBG:Bitmap;
      
      private var _leftBG:Bitmap;
      
      private var _startCleanOutBtn:SimpleBitmapButton;
      
      private var _speededUpBtn:SimpleBitmapButton;
      
      private var _cancelBtn:SimpleBitmapButton;
      
      private var _rightLabel:GradientText;
      
      private var _rightLabelI:GradientText;
      
      private var _rightLabelII:GradientText;
      
      private var _rightValue:FilterFrameText;
      
      private var _rightValueI:FilterFrameText;
      
      private var _rightValueII:FilterFrameText;
      
      private var _tipContainer:Sprite;
      
      private var _tipTitle:FilterFrameText;
      
      private var _tipContent:FilterFrameText;
      
      private var _list:ListPanel;
      
      private var _textFormat:TextFormat;
      
      private var _timer:Timer;
      
      private var _remainTime:int;
      
      private var _currentRemainTime:int;
      
      private var _chatBtn:SimpleBitmapButton;
      
      private var _vipIcon:Bitmap;
      
      private var _freeAccTips:FilterFrameText;
      
      private var _currentFloor:int = 0;
      
      private var _btnState:int;
      
      public function CleanOutFrame()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         var alerInfo:AlertInfo = new AlertInfo(LanguageMgr.GetTranslation("ddt.labyrinth.CleanOutFrame.title"));
         alerInfo.moveEnable = false;
         info = alerInfo;
         _bg = ComponentFactory.Instance.creatComponentByStylename("ddt.view.CleanOutFrame.ScaleBG");
         addToContent(_bg);
         _rightBG = ComponentFactory.Instance.creatBitmap("ddt.labyrinth.CleanOutFrame.rightBG");
         addToContent(_rightBG);
         _leftBG = ComponentFactory.Instance.creatBitmap("ddt.labyrinth.CleanOutFrame.leftBG");
         addToContent(_leftBG);
         _startCleanOutBtn = ComponentFactory.Instance.creatComponentByStylename("ddt.view.CleanOutFrame.startCleanOutButton");
         addToContent(_startCleanOutBtn);
         _speededUpBtn = ComponentFactory.Instance.creatComponentByStylename("ddt.view.CleanOutFrame.speededUpButton");
         addToContent(_speededUpBtn);
         _cancelBtn = ComponentFactory.Instance.creatComponentByStylename("ddt.view.CleanOutFrame.cancelButton");
         addToContent(_cancelBtn);
         _rightLabel = ComponentFactory.Instance.creatComponentByStylename("ddt.labyrinth.CleanOutFrame.rightLabel");
         addToContent(_rightLabel);
         _rightLabelI = ComponentFactory.Instance.creatComponentByStylename("ddt.labyrinth.CleanOutFrame.rightLabelI");
         addToContent(_rightLabelI);
         _rightLabelII = ComponentFactory.Instance.creatComponentByStylename("ddt.labyrinth.CleanOutFrame.rightLabelII");
         addToContent(_rightLabelII);
         _rightValue = ComponentFactory.Instance.creatComponentByStylename("ddt.labyrinth.CleanOutFrame.rightValue");
         addToContent(_rightValue);
         _rightValueI = ComponentFactory.Instance.creatComponentByStylename("ddt.labyrinth.CleanOutFrame.rightValueI");
         addToContent(_rightValueI);
         _rightValueII = ComponentFactory.Instance.creatComponentByStylename("ddt.labyrinth.CleanOutFrame.rightValueII");
         addToContent(_rightValueII);
         _chatBtn = ComponentFactory.Instance.creatComponentByStylename("ddt.labyrinth.chatButton");
         _chatBtn.tipData = LanguageMgr.GetTranslation("tank.game.ToolStripView.chat");
         addToContent(_chatBtn);
         _vipIcon = ComponentFactory.Instance.creat("asset.seniorVipIcon.small_9");
         PositionUtils.setPos(_vipIcon,"ddt.labyrinth.vipIconPos");
         addToContent(_vipIcon);
         _freeAccTips = ComponentFactory.Instance.creatComponentByStylename("ddt.labyrinth.freeAccTips");
         addToContent(_freeAccTips);
         _freeAccTips.text = LanguageMgr.GetTranslation("ddt.labyrinth.CleanOutFrame.freeAccTips");
         _tipContainer = ComponentFactory.Instance.creatCustomObject("labyrinth.CleanOutFrame.tipContainer");
         addToContent(_tipContainer);
         _tipTitle = UICreatShortcut.creatTextAndAdd("ddt.labyrinth.CleanOutFrame.tipTitleText",LanguageMgr.GetTranslation("ddt.labyrinth.CleanOutFrame.leftTitle"),_tipContainer);
         _tipContent = UICreatShortcut.creatTextAndAdd("ddt.labyrinth.CleanOutFrame.tipContentText",LanguageMgr.GetTranslation("ddt.labyrinth.CleanOutFrame.leftTip"),_tipContainer);
         _textFormat = ComponentFactory.Instance.model.getSet("ddt.labyrinth.CleanOutFrame.rightValueIITF");
         _currentFloor = LabyrinthManager.Instance.model.currentFloor;
         _list = ComponentFactory.Instance.creatComponentByStylename("ddt.labyrinth.CleanOutFrame.List");
         addToContent(_list);
         btnState = 0;
         initEvent();
         PlayerManager.Instance.Self.playerState = new PlayerState(6,0);
         SocketManager.Instance.out.sendFriendState(PlayerManager.Instance.Self.playerState.StateID);
      }
      
      private function initEvent() : void
      {
         _startCleanOutBtn.addEventListener("click",__startCleanOut);
         _speededUpBtn.addEventListener("click",__speededUp);
         _cancelBtn.addEventListener("click",__cancel);
         _chatBtn.addEventListener("click",__chatClick);
         LabyrinthManager.Instance.model.cleanOutInfos.addEventListener("add",__addInfo);
         LabyrinthManager.Instance.addEventListener("updateRemainTime",__updateRemainTime);
         LabyrinthManager.Instance.addEventListener("updateInfo",__updateInfo);
      }
      
      protected function __chatClick(event:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         LabyrinthManager.Instance.chat();
      }
      
      protected function __updateInfo(event:Event) : void
      {
         updateTextVlaue();
         updateButton();
      }
      
      protected function __updateRemainTime(event:Event) : void
      {
         if(_timer)
         {
            _timer.stop();
            _timer.removeEventListener("timer",__updateTimer);
            _timer = null;
         }
         _remainTime = LabyrinthManager.Instance.model.remainTime;
         _currentRemainTime = LabyrinthManager.Instance.model.currentRemainTime;
         if(_remainTime > 0)
         {
            _timer = new Timer(1000,_remainTime);
            _timer.addEventListener("timer",__updateTimer);
            _timer.start();
         }
      }
      
      private function removeEvent() : void
      {
         _startCleanOutBtn.removeEventListener("click",__startCleanOut);
         _speededUpBtn.removeEventListener("click",__speededUp);
         _cancelBtn.removeEventListener("click",__cancel);
         LabyrinthManager.Instance.model.cleanOutInfos.removeEventListener("add",__addInfo);
         LabyrinthManager.Instance.removeEventListener("updateRemainTime",__updateRemainTime);
         LabyrinthManager.Instance.removeEventListener("updateInfo",__updateInfo);
      }
      
      private function updateRightValueI() : void
      {
         var remainTime:int = 0;
         if(_btnState == 0 || _btnState == 2)
         {
            remainTime = LabyrinthManager.Instance.model.cleanOutAllTime;
         }
         else
         {
            remainTime = _remainTime;
         }
         var minute:String = remainTime / 60 >= 10?String(Math.floor(remainTime / 60)):"0" + String(Math.floor(remainTime / 60));
         var second:String = remainTime % 60 >= 10?String(Math.floor(remainTime % 60)):"0" + String(Math.floor(remainTime % 60));
         _rightValueI.text = "00 : " + minute + " : " + second;
      }
      
      protected function __updateTimer(event:TimerEvent) : void
      {
         if(_remainTime != 0)
         {
            _remainTime = Number(_remainTime) - 1;
         }
         if(_currentRemainTime != 0)
         {
            _currentRemainTime = Number(_currentRemainTime) - 1;
         }
         updateRightValueI();
         if(_currentRemainTime == 0)
         {
            SocketManager.Instance.out.labyrinthCleanOutTimerComplete(LabyrinthManager.Instance.model.sType);
         }
      }
      
      protected function __addInfo(event:DictionaryEvent) : void
      {
         _list.vectorListModel.removeAt(_list.vectorListModel.elements.length - 1);
         _list.vectorListModel.append(event.data as CleanOutInfo);
         _currentFloor = Number(_currentFloor) + 1;
         if(_currentFloor != LabyrinthManager.Instance.model.myProgress + 1)
         {
            _list.vectorListModel.append(null);
         }
      }
      
      protected function __cancel(event:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         btnState = 0;
         SocketManager.Instance.out.labyrinthStopCleanOut(LabyrinthManager.Instance.model.sType);
         LabyrinthManager.Instance.model.cleanOutInfos.clear();
         _list.vectorListModel.clear();
         if(_timer)
         {
            _timer.stop();
            _timer.removeEventListener("timer",__updateTimer);
            _timer = null;
         }
         onResponse(0);
      }
      
      protected function __speededUp(event:MouseEvent) : void
      {
         var msg:* = null;
         var money:int = 0;
         SoundManager.instance.playButtonSound();
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var timeDeityCount:int = KingBlessManager.instance.getOneBuffData(7);
         if(timeDeityCount > 0)
         {
            msg = LanguageMgr.GetTranslation("ddt.labyrinth.CleanOutFrame.warning2");
         }
         else
         {
            money = Math.ceil(LabyrinthManager.Instance.model.remainTime / 60) * ServerConfigManager.instance.WarriorFamRaidPricePerMin;
            if(PlayerManager.Instance.Self.IsVIP && PlayerManager.Instance.Self.VIPLevel >= 6)
            {
               money = Math.ceil(money / 2);
               msg = LanguageMgr.GetTranslation("ddt.labyrinth.CleanOutFrame.warning",money);
            }
            else
            {
               msg = LanguageMgr.GetTranslation("ddt.labyrinth.CleanOutFrame.warning",money);
            }
         }
         var confirmFrame:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),msg,LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,true,1,null,"labyrinth.cleanOutConfirmView",30,true,1);
         confirmFrame.moveEnable = false;
         confirmFrame.addEventListener("response",__onFrameEvent);
      }
      
      protected function __onFrameEvent(event:FrameEvent) : void
      {
         var timeDeityCount:int = 0;
         SoundManager.instance.playButtonSound();
         var alert:BaseAlerFrame = BaseAlerFrame(event.currentTarget);
         ObjectUtils.disposeObject(event.target);
         var money:int = Math.ceil(LabyrinthManager.Instance.model.remainTime / 60) * ServerConfigManager.instance.WarriorFamRaidPricePerMin;
         if(event.responseCode == 2 || event.responseCode == 3)
         {
            timeDeityCount = KingBlessManager.instance.getOneBuffData(7);
            CheckMoneyUtils.instance.checkMoney(alert.isBand,timeDeityCount,onCheckComplete);
         }
         alert.removeEventListener("response",__onFrameEvent);
         alert = null;
      }
      
      private function onCheckComplete() : void
      {
         SocketManager.Instance.out.labyrinthSpeededUpCleanOut(LabyrinthManager.Instance.model.sType,CheckMoneyUtils.instance.isBind);
         btnState = 2;
         reset();
      }
      
      private function reset() : void
      {
         if(_timer)
         {
            _timer.stop();
            _timer.removeEventListener("timer",__updateTimer);
            _timer = null;
         }
         _rightValueI.text = "00 : 00 : 00";
      }
      
      protected function __startCleanOut(event:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         if(PlayerManager.Instance.Self.DDTMoney < LabyrinthManager.Instance.model.cleanOutGold)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("shop.view.noOrder"));
            return;
         }
         btnState = 1;
         _list.vectorListModel.append(null);
         if(LabyrinthManager.Instance.model.isDoubleAward == true)
         {
            SocketManager.Instance.out.labyrinthDouble(LabyrinthManager.Instance.model.sType,LabyrinthManager.Instance.model.isDoubleAward);
         }
         SocketManager.Instance.out.labyrinthCleanOut(LabyrinthManager.Instance.model.sType);
      }
      
      private function set btnState(value:int) : void
      {
         switch(int(value))
         {
            case 0:
               _btnState = 0;
               _startCleanOutBtn.visible = true;
               _tipContainer.visible = true;
               _speededUpBtn.visible = false;
               _cancelBtn.visible = false;
               _list.visible = false;
               break;
            case 1:
               _btnState = 1;
               _startCleanOutBtn.visible = false;
               _tipContainer.visible = false;
               _speededUpBtn.visible = true;
               _cancelBtn.visible = true;
               _list.visible = true;
               break;
            case 2:
               _btnState = 2;
               _startCleanOutBtn.visible = false;
               _tipContainer.visible = false;
               _speededUpBtn.visible = true;
               _cancelBtn.visible = true;
               _list.visible = true;
         }
         updateTextVlaue();
      }
      
      private function updateTextVlaue() : void
      {
         var myProgress:int = LabyrinthManager.Instance.model.myProgress;
         var currentFloor:int = LabyrinthManager.Instance.model.currentFloor - 1;
         var cleanOutGold:int = LabyrinthManager.Instance.model.cleanOutGold;
         _remainTime = LabyrinthManager.Instance.model.remainTime;
         if(_btnState == 0 || _btnState == 2)
         {
            _rightLabel.text = LanguageMgr.GetTranslation("ddt.labyrinth.CleanOutFrame.rightLabelText");
            _rightLabelI.text = LanguageMgr.GetTranslation("ddt.labyrinth.CleanOutFrame.rightLabelTextI");
            _rightLabelII.text = LanguageMgr.GetTranslation("ddt.labyrinth.CleanOutFrame.rightLabelTextII");
            _rightValue.text = LanguageMgr.GetTranslation("ddt.labyrinth.CleanOutFrame.rightValueTextII",myProgress);
            _rightValue.setTextFormat(_textFormat,11,_rightValue.text.length);
            _rightValueII.text = String(cleanOutGold);
            if(_btnState == 2)
            {
               _rightValue.text = LanguageMgr.GetTranslation("ddt.labyrinth.CleanOutFrame.rightValueText",myProgress);
               _rightValue.setTextFormat(_textFormat,11,_rightValue.text.length);
               _rightLabelII.text = LanguageMgr.GetTranslation("ddt.labyrinth.CleanOutFrame.rightLabelTextIIII");
               _rightValueII.text = LabyrinthManager.Instance.model.accumulateExp.toString();
            }
         }
         else
         {
            _rightLabel.text = LanguageMgr.GetTranslation("ddt.labyrinth.CleanOutFrame.rightLabelText");
            _rightLabelI.text = LanguageMgr.GetTranslation("ddt.labyrinth.CleanOutFrame.rightLabelTextIII");
            _rightLabelII.text = LanguageMgr.GetTranslation("ddt.labyrinth.CleanOutFrame.rightLabelTextIIII");
            _rightValue.text = LanguageMgr.GetTranslation("ddt.labyrinth.CleanOutFrame.rightValueText",currentFloor);
            _rightValue.setTextFormat(_textFormat,10,_rightValue.text.length);
            _rightValueII.text = LabyrinthManager.Instance.model.accumulateExp.toString();
         }
         updateRightValueI();
         updateButton();
      }
      
      private function updateButton() : void
      {
         var value:* = LabyrinthManager.Instance.model.currentFloor == LabyrinthManager.Instance.model.myProgress + 1;
         if(!LabyrinthManager.Instance.model.completeChallenge || value)
         {
            _startCleanOutBtn.enable = false;
            _speededUpBtn.enable = false;
            reset();
         }
      }
      
      public function continueCleanOut() : void
      {
         btnState = 1;
         _list.vectorListModel.append(null);
         SocketManager.Instance.out.labyrinthCleanOut(LabyrinthManager.Instance.model.sType);
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,2);
      }
      
      override public function dispose() : void
      {
         SocketManager.Instance.out.labyrinthStopCleanOut(LabyrinthManager.Instance.model.sType);
         PlayerManager.Instance.Self.playerState = new PlayerState(1,0);
         SocketManager.Instance.out.sendFriendState(PlayerManager.Instance.Self.playerState.StateID);
         removeEvent();
         if(_timer)
         {
            _timer.stop();
            _timer.removeEventListener("timer",__updateTimer);
            _timer = null;
         }
         super.dispose();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_rightBG);
         _rightBG = null;
         ObjectUtils.disposeObject(_leftBG);
         _leftBG = null;
         ObjectUtils.disposeObject(_startCleanOutBtn);
         _startCleanOutBtn = null;
         ObjectUtils.disposeObject(_speededUpBtn);
         _speededUpBtn = null;
         ObjectUtils.disposeObject(_cancelBtn);
         _cancelBtn = null;
         ObjectUtils.disposeObject(_rightLabel);
         _rightLabel = null;
         ObjectUtils.disposeObject(_rightLabelI);
         _rightLabelI = null;
         ObjectUtils.disposeObject(_rightLabelII);
         _rightLabelII = null;
         ObjectUtils.disposeObject(_rightValue);
         _rightValue = null;
         ObjectUtils.disposeObject(_rightValueI);
         _rightValueI = null;
         ObjectUtils.disposeObject(_rightValueII);
         _rightValueII = null;
         ObjectUtils.disposeObject(_vipIcon);
         _vipIcon = null;
         ObjectUtils.disposeObject(_freeAccTips);
         _freeAccTips = null;
         ObjectUtils.disposeObject(_tipContainer);
         _tipContainer = null;
         ObjectUtils.disposeObject(_tipTitle);
         _tipTitle = null;
         ObjectUtils.disposeObject(_tipContent);
         _tipContent = null;
         ObjectUtils.disposeObject(_list);
         _list = null;
         ObjectUtils.disposeObject(_chatBtn);
         _chatBtn = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
