package quest
{
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.quest.QuestCondition;
   import ddt.data.quest.QuestInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.events.MouseEvent;
   
   public class QuestinfoTargetItemView extends QuestInfoItemView
   {
       
      
      private var _targets:VBox;
      
      private var _isOptional:Boolean;
      
      private var _starLevel:QuestStarListView;
      
      private var _completeButton:TextButton;
      
      private var _spand:int;
      
      private var _sLevel:int;
      
      public var isImprove:Boolean;
      
      private var _vipBg:Image;
      
      private var _vipIcon:Image;
      
      private var _vipDescTxt:FilterFrameText;
      
      public function QuestinfoTargetItemView(isOptional:Boolean)
      {
         _isOptional = isOptional;
         super();
      }
      
      public function set sLevel(value:int) : void
      {
         if(value < 1)
         {
            value = 1;
         }
         _sLevel = value;
         _starLevel.level(_sLevel,isImprove);
      }
      
      override public function set info(value:QuestInfo) : void
      {
         var i:int = 0;
         var cond:* = null;
         var condView:* = null;
         var infoCollectView:* = null;
         _info = value;
         i = 0;
         while(_info.conditions[i])
         {
            cond = _info.conditions[i];
            if(cond.isOpitional == _isOptional)
            {
               condView = new QuestConditionView(cond);
               condView.status = _info.conditionStatus[i];
               if(_info.progress[i] <= 0)
               {
                  condView.isComplete = true;
               }
               _targets.addChild(condView);
            }
            i++;
         }
         if(_info.QuestID == 544)
         {
            _targets.addChild(new InfoCollectViewMail());
         }
         else if(_info.isPhoneTask)
         {
            infoCollectView = new InfoCollectView(_info.QuestID);
            infoCollectView.getPhoneData();
            _targets.addChild(infoCollectView);
         }
         _spand = _info.OneKeyFinishNeedMoney;
         sLevel = _info.QuestLevel;
         var vOnkeyRemainTimes:int = TaskManager.instance.improve.canOneKeyFinishTime + int(ServerConfigManager.instance.VIPQuestFinishDirect[PlayerManager.Instance.Self.VIPLevel - 1]) - PlayerManager.Instance.Self.uesedFinishTime;
         if(_spand > 0)
         {
            _completeButton = ComponentFactory.Instance.creatComponentByStylename("quest.complete.button");
            _completeButton.text = LanguageMgr.GetTranslation("tank.manager.TaskManager.complete");
            if(_info.Type != 12)
            {
               _completeButton.tipStyle = "ddt.view.tips.OneLineTip";
               _completeButton.tipData = LanguageMgr.GetTranslation("tank.manager.TaskManager.complete.remained",isInLimitTimes());
            }
            addChild(_completeButton);
            if(_info.isCompleted)
            {
               _completeButton.enable = false;
            }
            else
            {
               _completeButton.addEventListener("click",_activeGetBtnClick);
            }
         }
         _panel.invalidateViewport();
      }
      
      override protected function initView() : void
      {
         super.initView();
         _titleBg.visible = false;
         _titleImg = ComponentFactory.Instance.creatComponentByStylename("quest.targetPanel.titleImg");
         _titleImg.setFrame(!!_isOptional?1:2);
         addChild(_titleImg);
         _targets = ComponentFactory.Instance.creatComponentByStylename("quest.targetPanel.vbox");
         _content.addChild(_targets);
         _starLevel = ComponentFactory.Instance.creatCustomObject("quest.complete.starLevel");
         _starLevel.tipData = LanguageMgr.GetTranslation("tank.manager.TaskManager.viptip");
         addChild(_starLevel);
         _vipBg = ComponentFactory.Instance.creatComponentByStylename("quest.vipBg");
         _vipIcon = ComponentFactory.Instance.creatComponentByStylename("quest.vipIcon");
         _vipDescTxt = ComponentFactory.Instance.creatComponentByStylename("quest.vipDescTxt");
         _vipDescTxt.text = LanguageMgr.GetTranslation("tank.manager.TaskManager.VipDescTxt");
         addChild(_vipBg);
         addChild(_vipIcon);
         addChild(_vipDescTxt);
      }
      
      private function isInLimitTimes() : int
      {
         var totalOnKeyCompleteTimes:int = TaskManager.instance.improve.canOneKeyFinishTime;
         if(PlayerManager.Instance.Self.IsVIP)
         {
            totalOnKeyCompleteTimes = totalOnKeyCompleteTimes + int(ServerConfigManager.instance.VIPQuestFinishDirect[PlayerManager.Instance.Self.VIPLevel - 1]);
         }
         var spandTimes:int = totalOnKeyCompleteTimes - PlayerManager.Instance.Self.uesedFinishTime;
         return spandTimes;
      }
      
      private function _activeGetBtnClick(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         if(_spand > PlayerManager.Instance.Self.Money)
         {
            LeavePageManager.showFillFrame();
            return;
         }
         if(isInLimitTimes() <= 0)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.manager.TaskManager.oneKeyCompleteTimesOver"));
            return;
         }
         var mes:String = LanguageMgr.GetTranslation("tank.manager.TaskManager.completeText",_spand);
         var alert:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),mes,LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,true,1,null,"SimpleAlert",30,true,0);
         alert.addEventListener("response",__confirmResponse);
      }
      
      private function __confirmResponse(evt:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         var frame:BaseAlerFrame = evt.currentTarget as BaseAlerFrame;
         frame.removeEventListener("response",__confirmResponse);
         if(frame.parent)
         {
            frame.parent.removeChild(frame);
         }
         ObjectUtils.disposeObject(frame);
         if(evt.responseCode == 3 || evt.responseCode == 2)
         {
            if(_info.Type == 12)
            {
               SocketManager.Instance.out.sendQuestFinish(_info.QuestID,TaskManager.itemAwardSelected,1);
            }
            else
            {
               SocketManager.Instance.out.sendQuestOneToFinish(_info.QuestID);
            }
         }
      }
      
      public function setStarVipHide() : void
      {
         _starLevel.visible = false;
         _vipBg.visible = false;
         _vipIcon.visible = false;
         _vipDescTxt.visible = false;
      }
      
      override public function dispose() : void
      {
         if(_completeButton)
         {
            _completeButton.removeEventListener("click",_activeGetBtnClick);
            ObjectUtils.disposeObject(_completeButton);
            _completeButton = null;
         }
         ObjectUtils.disposeObject(_vipBg);
         _vipBg = null;
         ObjectUtils.disposeObject(_vipIcon);
         _vipIcon = null;
         ObjectUtils.disposeObject(_vipDescTxt);
         _vipDescTxt = null;
         ObjectUtils.disposeObject(_targets);
         _targets = null;
         if(_starLevel)
         {
            ObjectUtils.disposeObject(_starLevel);
         }
         _starLevel = null;
         super.dispose();
      }
   }
}
