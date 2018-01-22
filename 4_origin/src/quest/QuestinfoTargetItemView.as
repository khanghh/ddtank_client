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
      
      public function QuestinfoTargetItemView(param1:Boolean)
      {
         _isOptional = param1;
         super();
      }
      
      public function set sLevel(param1:int) : void
      {
         if(param1 < 1)
         {
            param1 = 1;
         }
         _sLevel = param1;
         _starLevel.level(_sLevel,isImprove);
      }
      
      override public function set info(param1:QuestInfo) : void
      {
         var _loc6_:int = 0;
         var _loc4_:* = null;
         var _loc3_:* = null;
         var _loc2_:* = null;
         _info = param1;
         _loc6_ = 0;
         while(_info.conditions[_loc6_])
         {
            _loc4_ = _info.conditions[_loc6_];
            if(_loc4_.isOpitional == _isOptional)
            {
               _loc3_ = new QuestConditionView(_loc4_);
               _loc3_.status = _info.conditionStatus[_loc6_];
               if(_info.progress[_loc6_] <= 0)
               {
                  _loc3_.isComplete = true;
               }
               _targets.addChild(_loc3_);
            }
            _loc6_++;
         }
         if(_info.QuestID == 544)
         {
            _targets.addChild(new InfoCollectViewMail());
         }
         else if(_info.isPhoneTask)
         {
            _loc2_ = new InfoCollectView(_info.QuestID);
            _loc2_.getPhoneData();
            _targets.addChild(_loc2_);
         }
         _spand = _info.OneKeyFinishNeedMoney;
         sLevel = _info.QuestLevel;
         var _loc5_:int = TaskManager.instance.improve.canOneKeyFinishTime + int(ServerConfigManager.instance.VIPQuestFinishDirect[PlayerManager.Instance.Self.VIPLevel - 1]) - PlayerManager.Instance.Self.uesedFinishTime;
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
         var _loc1_:int = TaskManager.instance.improve.canOneKeyFinishTime;
         if(PlayerManager.Instance.Self.IsVIP)
         {
            _loc1_ = _loc1_ + int(ServerConfigManager.instance.VIPQuestFinishDirect[PlayerManager.Instance.Self.VIPLevel - 1]);
         }
         var _loc2_:int = _loc1_ - PlayerManager.Instance.Self.uesedFinishTime;
         return _loc2_;
      }
      
      private function _activeGetBtnClick(param1:MouseEvent) : void
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
         var _loc3_:String = LanguageMgr.GetTranslation("tank.manager.TaskManager.completeText",_spand);
         var _loc2_:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),_loc3_,LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,true,1,null,"SimpleAlert",30,true,0);
         _loc2_.addEventListener("response",__confirmResponse);
      }
      
      private function __confirmResponse(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:BaseAlerFrame = param1.currentTarget as BaseAlerFrame;
         _loc2_.removeEventListener("response",__confirmResponse);
         if(_loc2_.parent)
         {
            _loc2_.parent.removeChild(_loc2_);
         }
         ObjectUtils.disposeObject(_loc2_);
         if(param1.responseCode == 3 || param1.responseCode == 2)
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
