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
         var _loc1_:AlertInfo = new AlertInfo(LanguageMgr.GetTranslation("ddt.labyrinth.CleanOutFrame.title"));
         _loc1_.moveEnable = false;
         info = _loc1_;
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
      
      protected function __chatClick(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         LabyrinthManager.Instance.chat();
      }
      
      protected function __updateInfo(param1:Event) : void
      {
         updateTextVlaue();
         updateButton();
      }
      
      protected function __updateRemainTime(param1:Event) : void
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
         var _loc3_:int = 0;
         if(_btnState == 0 || _btnState == 2)
         {
            _loc3_ = LabyrinthManager.Instance.model.cleanOutAllTime;
         }
         else
         {
            _loc3_ = _remainTime;
         }
         var _loc1_:String = _loc3_ / 60 >= 10?String(Math.floor(_loc3_ / 60)):"0" + String(Math.floor(_loc3_ / 60));
         var _loc2_:String = _loc3_ % 60 >= 10?String(Math.floor(_loc3_ % 60)):"0" + String(Math.floor(_loc3_ % 60));
         _rightValueI.text = "00 : " + _loc1_ + " : " + _loc2_;
      }
      
      protected function __updateTimer(param1:TimerEvent) : void
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
      
      protected function __addInfo(param1:DictionaryEvent) : void
      {
         _list.vectorListModel.removeAt(_list.vectorListModel.elements.length - 1);
         _list.vectorListModel.append(param1.data as CleanOutInfo);
         _currentFloor = Number(_currentFloor) + 1;
         if(_currentFloor != LabyrinthManager.Instance.model.myProgress + 1)
         {
            _list.vectorListModel.append(null);
         }
      }
      
      protected function __cancel(param1:MouseEvent) : void
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
      
      protected function __speededUp(param1:MouseEvent) : void
      {
         var _loc5_:* = null;
         var _loc3_:int = 0;
         SoundManager.instance.playButtonSound();
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var _loc2_:int = KingBlessManager.instance.getOneBuffData(7);
         if(_loc2_ > 0)
         {
            _loc5_ = LanguageMgr.GetTranslation("ddt.labyrinth.CleanOutFrame.warning2");
         }
         else
         {
            _loc3_ = Math.ceil(LabyrinthManager.Instance.model.remainTime / 60) * ServerConfigManager.instance.WarriorFamRaidPricePerMin;
            if(PlayerManager.Instance.Self.IsVIP && PlayerManager.Instance.Self.VIPLevel >= 6)
            {
               _loc3_ = Math.ceil(_loc3_ / 2);
               _loc5_ = LanguageMgr.GetTranslation("ddt.labyrinth.CleanOutFrame.warning",_loc3_);
            }
            else
            {
               _loc5_ = LanguageMgr.GetTranslation("ddt.labyrinth.CleanOutFrame.warning",_loc3_);
            }
         }
         var _loc4_:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),_loc5_,LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,true,1,null,"labyrinth.cleanOutConfirmView",30,true,1);
         _loc4_.moveEnable = false;
         _loc4_.addEventListener("response",__onFrameEvent);
      }
      
      protected function __onFrameEvent(param1:FrameEvent) : void
      {
         var _loc2_:int = 0;
         SoundManager.instance.playButtonSound();
         var _loc3_:BaseAlerFrame = BaseAlerFrame(param1.currentTarget);
         ObjectUtils.disposeObject(param1.target);
         var _loc4_:int = Math.ceil(LabyrinthManager.Instance.model.remainTime / 60) * ServerConfigManager.instance.WarriorFamRaidPricePerMin;
         if(param1.responseCode == 2 || param1.responseCode == 3)
         {
            _loc2_ = KingBlessManager.instance.getOneBuffData(7);
            CheckMoneyUtils.instance.checkMoney(_loc3_.isBand,_loc2_,onCheckComplete);
         }
         _loc3_.removeEventListener("response",__onFrameEvent);
         _loc3_ = null;
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
      
      protected function __startCleanOut(param1:MouseEvent) : void
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
      
      private function set btnState(param1:int) : void
      {
         switch(int(param1))
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
         var _loc2_:int = LabyrinthManager.Instance.model.myProgress;
         var _loc3_:int = LabyrinthManager.Instance.model.currentFloor - 1;
         var _loc1_:int = LabyrinthManager.Instance.model.cleanOutGold;
         _remainTime = LabyrinthManager.Instance.model.remainTime;
         if(_btnState == 0 || _btnState == 2)
         {
            _rightLabel.text = LanguageMgr.GetTranslation("ddt.labyrinth.CleanOutFrame.rightLabelText");
            _rightLabelI.text = LanguageMgr.GetTranslation("ddt.labyrinth.CleanOutFrame.rightLabelTextI");
            _rightLabelII.text = LanguageMgr.GetTranslation("ddt.labyrinth.CleanOutFrame.rightLabelTextII");
            _rightValue.text = LanguageMgr.GetTranslation("ddt.labyrinth.CleanOutFrame.rightValueTextII",_loc2_);
            _rightValue.setTextFormat(_textFormat,11,_rightValue.text.length);
            _rightValueII.text = String(_loc1_);
            if(_btnState == 2)
            {
               _rightValue.text = LanguageMgr.GetTranslation("ddt.labyrinth.CleanOutFrame.rightValueText",_loc2_);
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
            _rightValue.text = LanguageMgr.GetTranslation("ddt.labyrinth.CleanOutFrame.rightValueText",_loc3_);
            _rightValue.setTextFormat(_textFormat,10,_rightValue.text.length);
            _rightValueII.text = LabyrinthManager.Instance.model.accumulateExp.toString();
         }
         updateRightValueI();
         updateButton();
      }
      
      private function updateButton() : void
      {
         var _loc1_:* = LabyrinthManager.Instance.model.currentFloor == LabyrinthManager.Instance.model.myProgress + 1;
         if(!LabyrinthManager.Instance.model.completeChallenge || _loc1_)
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
