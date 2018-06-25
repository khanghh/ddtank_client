package rewardTask.view
{
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.image.NumberImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.PkgEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.CheckMoneyUtils;
   import ddt.utils.HelpFrameUtils;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import flash.utils.getTimer;
   import magicStone.components.MagicStoneConfirmView;
   import rewardTask.RewardTaskControl;
   
   public class RewardTaskMainView extends Frame
   {
       
      
      private var _bg:Bitmap;
      
      private var _btnHelp:BaseButton;
      
      private var _questView:RewardTaskItem;
      
      private var _multiplemax:Bitmap;
      
      private var _multipleX:Bitmap;
      
      private var _number:NumberImage;
      
      private var _refreshRewardBtn:SimpleBitmapButton;
      
      private var _refreshTaskBtn:SimpleBitmapButton;
      
      private var _taskNumberText:FilterFrameText;
      
      private var _addTaskNumberBtn:SimpleBitmapButton;
      
      private var _vipBuyNumText:FilterFrameText;
      
      private var _multipleStatus:Boolean;
      
      private var _addNumberStatus:Boolean;
      
      private var _taskStatus:Boolean;
      
      private var _clickTime:Number;
      
      public function RewardTaskMainView()
      {
         super();
         initEvent();
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,1);
      }
      
      override protected function init() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.rewardTask.bg");
         _multipleX = ComponentFactory.Instance.creatBitmap("asset.rewardTask.multiplex");
         _number = ComponentFactory.Instance.creatComponentByStylename("rewardTask.multiple");
         _multiplemax = ComponentFactory.Instance.creatBitmap("asset.rewardTask.multiplemax");
         _refreshRewardBtn = ComponentFactory.Instance.creatComponentByStylename("rewardTask.refreshReward");
         _refreshTaskBtn = ComponentFactory.Instance.creatComponentByStylename("rewardTask.refreshTask");
         _taskNumberText = ComponentFactory.Instance.creatComponentByStylename("rewardTask.taskNumberText");
         _vipBuyNumText = ComponentFactory.Instance.creatComponentByStylename("rewardTask.vipBuyNumText");
         _addTaskNumberBtn = ComponentFactory.Instance.creatComponentByStylename("rawardTask.addRewardTaskNum");
         _addTaskNumberBtn.tipData = LanguageMgr.GetTranslation("tank.view.energy.addtip");
         _questView = new RewardTaskItem();
         super.init();
         titleText = LanguageMgr.GetTranslation("rewardTask.title");
         _btnHelp = HelpFrameUtils.Instance.simpleHelpButton(this,"core.helpButtonSmall",{
            "x":510,
            "y":5
         },LanguageMgr.GetTranslation("store.view.HelpButtonText"),"asset.rewardTask.view.help",450,350);
         SocketManager.Instance.out.sendRewardTaskQuestOfferInfo();
      }
      
      override protected function addChildren() : void
      {
         super.addChildren();
         if(_bg)
         {
            addToContent(_bg);
         }
         if(_refreshRewardBtn)
         {
            addToContent(_refreshRewardBtn);
         }
         if(_refreshTaskBtn)
         {
            addToContent(_refreshTaskBtn);
         }
         if(_multipleX)
         {
            addToContent(_multipleX);
         }
         if(_number)
         {
            addToContent(_number);
         }
         if(_multiplemax)
         {
            addToContent(_multiplemax);
         }
         if(_taskNumberText)
         {
            addToContent(_taskNumberText);
         }
         if(_addTaskNumberBtn)
         {
            addToContent(_addTaskNumberBtn);
         }
         if(_vipBuyNumText)
         {
            addToContent(_vipBuyNumText);
         }
         if(_questView)
         {
            addToContent(_questView);
         }
      }
      
      private function __addTaskNumberClick(e:MouseEvent) : void
      {
         var vipLevel:int = 0;
         var frame:* = null;
         SoundManager.instance.playButtonSound();
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         if(PlayerManager.Instance.Self.IsVIP)
         {
            vipLevel = PlayerManager.Instance.Self.VIPLevel;
            if(vipLevel >= RewardTaskControl.instance.model.buyTimes)
            {
               frame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),LanguageMgr.GetTranslation("rewardTask.addTaskNumAlter",ServerConfigManager.instance.rewardMultiplePrice + RewardTaskControl.instance.model.buyTimes * ServerConfigManager.instance.addTaskNumPrice),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,true,2,null,"SimpleAlert",60,false,1);
               frame.addEventListener("response",__onAddTaskNumber);
            }
            else
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("rewardTask.taskNumber.vipnot"));
            }
         }
         else
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("rewardTask.taskNumber.notvip"));
         }
      }
      
      private function __onAddTaskNumber(e:FrameEvent) : void
      {
         e = e;
         var frame:BaseAlerFrame = e.currentTarget as BaseAlerFrame;
         frame.removeEventListener("response",__onRefreshRewardResponse);
         if(e.responseCode == 3 || e.responseCode == 2)
         {
            CheckMoneyUtils.instance.checkMoney(frame.isBand,ServerConfigManager.instance.rewardMultiplePrice + RewardTaskControl.instance.model.buyTimes * ServerConfigManager.instance.addTaskNumPrice,function():void
            {
               _addNumberStatus = true;
               SocketManager.Instance.out.sendRewardTaskAddTimes(CheckMoneyUtils.instance.isBind);
            });
         }
         frame.dispose();
      }
      
      private function __onClickrefreshReward(e:MouseEvent) : void
      {
         e = e;
         SoundManager.instance.playButtonSound();
         if(getTimer() - _clickTime < 1000)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("carnival.clickTip"));
            return;
         }
         _clickTime = getTimer();
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         if(RewardTaskControl.instance.model.times > 0)
         {
            if(RewardTaskControl.instance.model.refreshRewardAlertAgain == false)
            {
               CheckMoneyUtils.instance.checkMoney(RewardTaskControl.instance.model.rewardisBind,ServerConfigManager.instance.rewardMultiplePrice,function():void
               {
                  _multipleStatus = true;
                  RewardTaskControl.instance.model.rewardisBind = CheckMoneyUtils.instance.isBind;
                  SocketManager.Instance.out.sendRewardTaskRefreshReward(CheckMoneyUtils.instance.isBind);
               });
               return;
            }
            var frame:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("rewardTask.refreshRewardAlter",ServerConfigManager.instance.rewardMultiplePrice),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,true,1,null,"reardTask.reward.confirmView",30,true,1);
            frame.moveEnable = false;
            frame.addEventListener("response",__onRefreshRewardResponse);
         }
         else
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("rewardTask.notTask"));
         }
      }
      
      private function __onRefreshRewardResponse(e:FrameEvent) : void
      {
         e = e;
         var frame:BaseAlerFrame = e.currentTarget as BaseAlerFrame;
         frame.removeEventListener("response",__onRefreshRewardResponse);
         if(e.responseCode == 3 || e.responseCode == 2)
         {
            CheckMoneyUtils.instance.checkMoney(frame.isBand,ServerConfigManager.instance.rewardMultiplePrice,function():void
            {
               _multipleStatus = true;
               SocketManager.Instance.out.sendRewardTaskRefreshReward(CheckMoneyUtils.instance.isBind);
            });
            if((frame as MagicStoneConfirmView).isNoPrompt)
            {
               RewardTaskControl.instance.model.refreshRewardAlertAgain = false;
            }
            RewardTaskControl.instance.model.rewardisBind = (frame as MagicStoneConfirmView).isBand;
         }
         frame.dispose();
      }
      
      private function __onClickRefreshTask(e:MouseEvent) : void
      {
         e = e;
         SoundManager.instance.playButtonSound();
         if(getTimer() - _clickTime < 1000)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("carnival.clickTip"));
            return;
         }
         _clickTime = getTimer();
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         if(RewardTaskControl.instance.model.times > 0)
         {
            if(RewardTaskControl.instance.model.refreshTaskAlertAgain == false)
            {
               CheckMoneyUtils.instance.checkMoney(RewardTaskControl.instance.model.taskisBind,ServerConfigManager.instance.rewardTaskPrice,function():void
               {
                  _taskStatus = true;
                  SocketManager.Instance.out.sendRewardTaskRefreshQuest(CheckMoneyUtils.instance.isBind);
               });
               return;
            }
            var frame:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("rewardTask.refreshTaskAlter",ServerConfigManager.instance.rewardTaskPrice),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,true,2,null,"reardTask.reward.confirmView",30,true,1);
            frame.moveEnable = false;
            frame.addEventListener("response",__onRefreshTaskResponse);
         }
         else
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("rewardTask.notTask"));
         }
      }
      
      private function __onRefreshTaskResponse(e:FrameEvent) : void
      {
         e = e;
         var frame:BaseAlerFrame = e.currentTarget as BaseAlerFrame;
         frame.removeEventListener("response",__onRefreshTaskResponse);
         var money:int = PlayerManager.Instance.Self.Money;
         if(e.responseCode == 3 || e.responseCode == 2)
         {
            CheckMoneyUtils.instance.checkMoney(frame.isBand,ServerConfigManager.instance.rewardTaskPrice,function():void
            {
               _taskStatus = true;
               SocketManager.Instance.out.sendRewardTaskRefreshQuest(CheckMoneyUtils.instance.isBind);
            });
            if((frame as MagicStoneConfirmView).isNoPrompt)
            {
               RewardTaskControl.instance.model.refreshTaskAlertAgain = false;
            }
            RewardTaskControl.instance.model.taskisBind = (frame as MagicStoneConfirmView).isBand;
         }
         frame.dispose();
      }
      
      private function __onRefreshQuest(e:PkgEvent) : void
      {
         RewardTaskControl.instance.model.questID = e.pkg.readInt();
         RewardTaskControl.instance.model.multiple = e.pkg.readInt();
         RewardTaskControl.instance.model.buyTimes = e.pkg.readInt();
         RewardTaskControl.instance.model.times = e.pkg.readInt();
         RewardTaskControl.instance.model.status = e.pkg.readInt();
         updateView();
      }
      
      private function __onAddTimes(e:PkgEvent) : void
      {
         RewardTaskControl.instance.model.questID = e.pkg.readInt();
         RewardTaskControl.instance.model.multiple = e.pkg.readInt();
         RewardTaskControl.instance.model.buyTimes = e.pkg.readInt();
         RewardTaskControl.instance.model.times = e.pkg.readInt();
         RewardTaskControl.instance.model.status = e.pkg.readInt();
         updateView();
      }
      
      private function __onRefreshReward(e:PkgEvent) : void
      {
         RewardTaskControl.instance.model.questID = e.pkg.readInt();
         RewardTaskControl.instance.model.multiple = e.pkg.readInt();
         RewardTaskControl.instance.model.buyTimes = e.pkg.readInt();
         RewardTaskControl.instance.model.times = e.pkg.readInt();
         RewardTaskControl.instance.model.status = e.pkg.readInt();
         updateView();
      }
      
      private function __onUpdateItems(e:PkgEvent) : void
      {
         RewardTaskControl.instance.model.questID = e.pkg.readInt();
         RewardTaskControl.instance.model.multiple = e.pkg.readInt();
         RewardTaskControl.instance.model.buyTimes = e.pkg.readInt();
         RewardTaskControl.instance.model.times = e.pkg.readInt();
         RewardTaskControl.instance.model.status = e.pkg.readInt();
         updateView();
      }
      
      private function __onAceptQuest(e:PkgEvent) : void
      {
         updateView();
      }
      
      private function initEvent() : void
      {
         SocketManager.Instance.addEventListener(PkgEvent.format(629,1),__onUpdateItems);
         SocketManager.Instance.addEventListener(PkgEvent.format(629,2),__onRefreshQuest);
         SocketManager.Instance.addEventListener(PkgEvent.format(629,3),__onAddTimes);
         SocketManager.Instance.addEventListener(PkgEvent.format(629,4),__onRefreshReward);
         SocketManager.Instance.addEventListener(PkgEvent.format(629,5),__onAceptQuest);
         _refreshRewardBtn.addEventListener("click",__onClickrefreshReward);
         _addTaskNumberBtn.addEventListener("click",__addTaskNumberClick);
         _refreshTaskBtn.addEventListener("click",__onClickRefreshTask);
      }
      
      private function removeEvent() : void
      {
         SocketManager.Instance.removeEventListener(PkgEvent.format(629,1),__onUpdateItems);
         SocketManager.Instance.removeEventListener(PkgEvent.format(629,2),__onRefreshQuest);
         SocketManager.Instance.removeEventListener(PkgEvent.format(629,3),__onAddTimes);
         SocketManager.Instance.removeEventListener(PkgEvent.format(629,4),__onRefreshReward);
         SocketManager.Instance.removeEventListener(PkgEvent.format(629,5),__onAceptQuest);
         _refreshRewardBtn.removeEventListener("click",__onClickrefreshReward);
         _addTaskNumberBtn.removeEventListener("click",__addTaskNumberClick);
         _refreshTaskBtn.removeEventListener("click",__onClickRefreshTask);
      }
      
      public function updateView() : void
      {
         _number.count = RewardTaskControl.instance.model.multiple;
         _taskNumberText.htmlText = LanguageMgr.GetTranslation("rewardTask.taskNumber",RewardTaskControl.instance.model.times);
         if(!PlayerManager.Instance.Self.IsVIP)
         {
            _vipBuyNumText.htmlText = "";
         }
         else
         {
            _vipBuyNumText.htmlText = LanguageMgr.GetTranslation("rewardTask.vipBuyNum",PlayerManager.Instance.Self.VIPLevel - RewardTaskControl.instance.model.buyTimes,PlayerManager.Instance.Self.VIPLevel);
         }
         if(RewardTaskControl.instance.model.multiple < 5)
         {
            _multiplemax.visible = false;
         }
         else
         {
            _multiplemax.visible = true;
         }
         if(RewardTaskControl.instance.model.status == 1 || RewardTaskControl.instance.model.times == 0)
         {
            _refreshRewardBtn.enable = false;
            _refreshTaskBtn.enable = false;
         }
         else
         {
            _refreshRewardBtn.enable = true;
            _refreshTaskBtn.enable = true;
         }
         if(_multipleStatus)
         {
            _multipleStatus = false;
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("rewardTask.refreshOK"));
         }
         if(_addNumberStatus)
         {
            _addNumberStatus = false;
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("rewardTask.addNumberOK"));
         }
         if(_taskStatus)
         {
            _taskStatus = false;
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("rewardTask.refreshOK"));
         }
         _questView.updateInfo();
      }
      
      override protected function onFrameClose() : void
      {
         SoundManager.instance.playButtonSound();
         this.dispose();
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_btnHelp);
         _btnHelp = null;
         super.dispose();
         _bg = null;
         _questView = null;
         _multiplemax = null;
         _multipleX = null;
         _number = null;
         _refreshRewardBtn = null;
         _refreshTaskBtn = null;
         _taskNumberText = null;
         _vipBuyNumText = null;
         _addTaskNumberBtn = null;
      }
   }
}
