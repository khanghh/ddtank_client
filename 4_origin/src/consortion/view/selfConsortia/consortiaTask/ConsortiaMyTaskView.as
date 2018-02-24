package consortion.view.selfConsortia.consortiaTask
{
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import consortion.ConsortionModelManager;
   import consortion.data.ConsortionSkillInfo;
   import ddt.events.PlayerPropertyEvent;
   import ddt.manager.ChatManager;
   import ddt.manager.ConsortiaDutyManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.CheckMoneyUtils;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class ConsortiaMyTaskView extends Sprite implements Disposeable
   {
       
      
      private var _taskInfo:ConsortiaTaskInfo;
      
      private var _vbox:VBox;
      
      private var _finishItemList:Vector.<ConsortiaMyTaskFinishItem>;
      
      private var _myFinishTxt:FilterFrameText;
      
      private var _expTxt:FilterFrameText;
      
      private var _offerTxt:FilterFrameText;
      
      private var _richesTxt:FilterFrameText;
      
      private var _skillNameTxt:FilterFrameText;
      
      private var _contentTxt1:FilterFrameText;
      
      private var _contentTxt2:FilterFrameText;
      
      private var _contentTxt3:FilterFrameText;
      
      private var _expText:FilterFrameText;
      
      private var _moneyText:FilterFrameText;
      
      private var _caiText:FilterFrameText;
      
      private var _skillText:FilterFrameText;
      
      private var _contributionLbl:FilterFrameText;
      
      private var _contributionTxt:FilterFrameText;
      
      private var _badgeLbl:FilterFrameText;
      
      private var _badgeText:FilterFrameText;
      
      private var _myReseBtn:TextButton;
      
      private var _contributionRankBtn:TextButton;
      
      private var _delayTimeBtn:TextButton;
      
      private var _reSetTaskMoney:int;
      
      public function ConsortiaMyTaskView()
      {
         super();
         initView();
         initEvents();
      }
      
      private function initView() : void
      {
         var _loc5_:int = 0;
         var _loc3_:* = null;
         _finishItemList = new Vector.<ConsortiaMyTaskFinishItem>();
         var _loc2_:MutipleImage = ComponentFactory.Instance.creatComponentByStylename("consortion.task.bgI");
         var _loc6_:MutipleImage = ComponentFactory.Instance.creatComponentByStylename("consortion.task.bgII");
         _vbox = ComponentFactory.Instance.creatComponentByStylename("consortion.task.vboxI");
         _myFinishTxt = ComponentFactory.Instance.creatComponentByStylename("consortion.task.MyfinishTxt");
         _expText = ComponentFactory.Instance.creatComponentByStylename("consortion.task.expTxt");
         _expText.text = LanguageMgr.GetTranslation("consortion.task.exp");
         _moneyText = ComponentFactory.Instance.creatComponentByStylename("consortion.task.FontIMoneyTxt");
         _moneyText.text = LanguageMgr.GetTranslation("consortion.task.offer");
         _caiText = ComponentFactory.Instance.creatComponentByStylename("consortion.task.FontCaiTxt");
         _caiText.text = LanguageMgr.GetTranslation("consortion.task.Money");
         _skillText = ComponentFactory.Instance.creatComponentByStylename("consortion.task.FontSkillTxt");
         _skillText.text = LanguageMgr.GetTranslation("consortion.task.skillName");
         _expTxt = ComponentFactory.Instance.creatComponentByStylename("consortion.task.EXPTxt");
         _offerTxt = ComponentFactory.Instance.creatComponentByStylename("consortion.task.MoneyTxt");
         _richesTxt = ComponentFactory.Instance.creatComponentByStylename("consortion.task.caiTxt");
         _skillNameTxt = ComponentFactory.Instance.creatComponentByStylename("consortion.task.SkillTxt");
         _contributionLbl = ComponentFactory.Instance.creatComponentByStylename("consortion.task.contributionLbl");
         _contributionLbl.text = LanguageMgr.GetTranslation("consortion.task.contribution");
         _contributionTxt = ComponentFactory.Instance.creatComponentByStylename("consortion.task.contributionTxt");
         _badgeLbl = ComponentFactory.Instance.creatComponentByStylename("consortion.task.badgeLbl");
         _badgeLbl.text = LanguageMgr.GetTranslation("consortion.task.badge");
         _badgeText = ComponentFactory.Instance.creatComponentByStylename("consortion.task.badgeTxt");
         var _loc1_:Bitmap = ComponentFactory.Instance.creatBitmap("asset.conortionTask.FontContent");
         _contentTxt1 = ComponentFactory.Instance.creatComponentByStylename("consortion.task.contentTxt1");
         _contentTxt2 = ComponentFactory.Instance.creatComponentByStylename("consortion.task.contentTxt2");
         _contentTxt3 = ComponentFactory.Instance.creatComponentByStylename("consortion.task.contentTxt3");
         _loc5_ = 0;
         while(_loc5_ < 3)
         {
            _loc3_ = ComponentFactory.Instance.creatCustomObject("ConsortiaMyTaskFinishItem");
            _finishItemList.push(_loc3_);
            _vbox.addChild(_loc3_);
            _loc5_++;
         }
         addChild(_loc2_);
         addChild(_loc6_);
         addChild(_vbox);
         addChild(_myFinishTxt);
         addChild(_expText);
         addChild(_moneyText);
         addChild(_caiText);
         addChild(_skillText);
         addChild(_contributionLbl);
         addChild(_badgeLbl);
         addChild(_badgeText);
         addChild(_expTxt);
         addChild(_offerTxt);
         addChild(_richesTxt);
         addChild(_skillNameTxt);
         addChild(_contributionTxt);
         _myReseBtn = ComponentFactory.Instance.creatComponentByStylename("consortion.submitTask.reset1");
         _myReseBtn.text = LanguageMgr.GetTranslation("consortia.task.resetTable");
         addChild(_myReseBtn);
         _contributionRankBtn = ComponentFactory.Instance.creatComponentByStylename("consortion.submitTask.btn");
         PositionUtils.setPos(_contributionRankBtn,"taskRank.taskRankBtn.posNotFisished");
         _contributionRankBtn.text = LanguageMgr.GetTranslation("consortia.task.cRank");
         addChild(_contributionRankBtn);
         _delayTimeBtn = ComponentFactory.Instance.creatComponentByStylename("consortion.task.delayTimeBtn");
         _delayTimeBtn.text = LanguageMgr.GetTranslation("consortia.task.delayTime");
         addChild(_delayTimeBtn);
         var _loc4_:int = PlayerManager.Instance.Self.Right;
         _myReseBtn.visible = ConsortiaDutyManager.GetRight(_loc4_,512);
         _delayTimeBtn.visible = ConsortiaDutyManager.GetRight(_loc4_,512);
         ConsortionModelManager.Instance.TaskModel.lockNum = 0;
      }
      
      private function initEvents() : void
      {
         _myReseBtn.addEventListener("click",__resetClick);
         _contributionRankBtn.addEventListener("click",__taskRankClick);
         _delayTimeBtn.addEventListener("click",__delayTimeClick);
         PlayerManager.Instance.Self.addEventListener("propertychange",__propChange);
      }
      
      protected function __taskRankClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:ConsortionTaskRank = ComponentFactory.Instance.creatComponentByStylename("consortion.taskRank.frame");
         LayerManager.Instance.addToLayer(_loc2_,3,true,1);
      }
      
      private function __delayTimeClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var _loc2_:int = ConsortionModelManager.Instance.TaskModel.taskInfo.level - 1;
         var _loc3_:int = ServerConfigManager.instance.consortiaTaskDelayInfo[_loc2_][0];
         var _loc5_:int = ServerConfigManager.instance.consortiaTaskDelayInfo[_loc2_][1];
         var _loc4_:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("consortia.task.delayTime"),LanguageMgr.GetTranslation("consortia.task.delayTimeContent",_loc5_,_loc3_),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,true,1);
         _loc4_.moveEnable = false;
         _loc4_.addEventListener("response",_responseII);
      }
      
      private function _responseII(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         (param1.currentTarget as BaseAlerFrame).removeEventListener("response",_responseII);
         if(param1.responseCode == 2 || param1.responseCode == 3)
         {
            SocketManager.Instance.out.sendReleaseConsortiaTask(6);
         }
      }
      
      private function getLockIdArr() : Array
      {
         var _loc2_:int = 0;
         var _loc1_:Array = [];
         _loc2_ = 0;
         while(_loc2_ < _finishItemList.length)
         {
            if(_finishItemList[_loc2_].isLock)
            {
               _loc1_.push(_finishItemList[_loc2_].lockId);
            }
            _loc2_++;
         }
         return _loc1_;
      }
      
      private function __resetClick(param1:MouseEvent) : void
      {
         var _loc3_:* = null;
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         if(ConsortionModelManager.Instance.TaskModel.taskInfo == null)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("consortia.task.stopTable"));
         }
         var _loc2_:Array = getLockIdArr();
         var _loc4_:int = _loc2_.length;
         if(_loc4_)
         {
            if(_loc4_ == 1)
            {
               _reSetTaskMoney = ConsortiaTaskView.RESET_MONEY + int(ServerConfigManager.instance.consortiaTaskPriceArr[0]);
            }
            else if(_loc4_ == 2)
            {
               _reSetTaskMoney = ConsortiaTaskView.RESET_MONEY + int(ServerConfigManager.instance.consortiaTaskPriceArr[0]) + int(ServerConfigManager.instance.consortiaTaskPriceArr[1]);
            }
            _loc3_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("consortia.task.resetTable"),LanguageMgr.GetTranslation("consortia.task.resetLuckContent",_loc2_.length,_reSetTaskMoney),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,true,2,null,"SimpleAlert",30,true,1);
            _loc3_.moveEnable = false;
            _loc3_.addEventListener("response",_responseI);
         }
         else
         {
            _reSetTaskMoney = ConsortiaTaskView.RESET_MONEY;
            _loc3_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("consortia.task.resetTable"),LanguageMgr.GetTranslation("consortia.task.resetContent",_reSetTaskMoney),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,true,2,null,"SimpleAlert",30,true,1);
            _loc3_.moveEnable = false;
            _loc3_.addEventListener("response",_responseI);
         }
      }
      
      private function _responseI(param1:FrameEvent) : void
      {
         (param1.currentTarget as BaseAlerFrame).removeEventListener("response",_responseI);
         if(param1.responseCode == 2 || param1.responseCode == 3)
         {
            if(ConsortionModelManager.Instance.TaskModel.taskInfo == null)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("consortia.task.stopTable"));
               ChatManager.Instance.sysChatYellow(LanguageMgr.GetTranslation("consortia.task.stopTable"));
            }
            else
            {
               CheckMoneyUtils.instance.checkMoney(param1.currentTarget.isBand,_reSetTaskMoney,onCheckComplete);
            }
         }
         ObjectUtils.disposeObject(param1.currentTarget as BaseAlerFrame);
      }
      
      protected function onCheckComplete() : void
      {
         var _loc1_:Array = getLockIdArr();
         var _loc3_:int = !!_loc1_[0]?_loc1_[0]:0;
         var _loc2_:int = !!_loc1_[1]?_loc1_[1]:0;
         SocketManager.Instance.out.sendReleaseConsortiaTask(1,CheckMoneyUtils.instance.isBind,1,1,_loc3_,_loc2_);
         SocketManager.Instance.out.sendReleaseConsortiaTask(2);
      }
      
      private function __onNoMoneyResponse(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:BaseAlerFrame = param1.currentTarget as BaseAlerFrame;
         _loc2_.removeEventListener("response",__onNoMoneyResponse);
         _loc2_.disposeChildren = true;
         _loc2_.dispose();
         _loc2_ = null;
         if(param1.responseCode == 3)
         {
            LeavePageManager.leaveToFillPath();
         }
      }
      
      private function removeEvents() : void
      {
         if(_myReseBtn)
         {
            _myReseBtn.removeEventListener("click",__resetClick);
         }
         if(_delayTimeBtn)
         {
            _delayTimeBtn.removeEventListener("click",__delayTimeClick);
         }
         if(_contributionRankBtn)
         {
            _contributionRankBtn.removeEventListener("click",__taskRankClick);
         }
         PlayerManager.Instance.Self.removeEventListener("propertychange",__propChange);
      }
      
      private function __propChange(param1:PlayerPropertyEvent) : void
      {
         var _loc2_:int = 0;
         if(param1.changedProperties["Right"])
         {
            _loc2_ = PlayerManager.Instance.Self.Right;
            _myReseBtn.visible = ConsortiaDutyManager.GetRight(_loc2_,512);
            _delayTimeBtn.visible = ConsortiaDutyManager.GetRight(_loc2_,512);
         }
      }
      
      private function update() : void
      {
         var _loc11_:int = 0;
         var _loc5_:int = 0;
         var _loc10_:int = 0;
         var _loc8_:int = PlayerManager.Instance.Self.Right;
         var _loc4_:Boolean = true;
         var _loc6_:int = _taskInfo.itemList.length;
         _loc11_ = 0;
         while(_loc11_ < _loc6_)
         {
            if(_taskInfo.itemList[_loc11_].currenValue - _taskInfo.itemList[_loc11_].targetValue < 0)
            {
               _loc4_ = false;
               break;
            }
            _loc11_++;
         }
         PositionUtils.setPos(_contributionRankBtn,!!_loc4_?"taskRank.taskRankBtn.posFisished":"taskRank.taskRankBtn.posNotFisished");
         _myReseBtn.visible = ConsortiaDutyManager.GetRight(_loc8_,512) && !_loc4_;
         _delayTimeBtn.visible = ConsortiaDutyManager.GetRight(_loc8_,512);
         var _loc7_:int = 0;
         var _loc3_:Array = getLockIdArr();
         _loc5_ = 0;
         while(_loc5_ < _finishItemList.length)
         {
            if(_loc3_.length)
            {
               if(_finishItemList[_loc5_].isLock)
               {
                  _loc10_ = 0;
                  while(_loc10_ < _taskInfo.itemList.length)
                  {
                     if(_finishItemList[_loc5_].taskId == _taskInfo.itemList[_loc10_]["id"])
                     {
                        _finishItemList[_loc5_].updateFinishTxt(_taskInfo.itemList[_loc10_]["currenValue"]);
                     }
                     _loc10_++;
                  }
               }
               else
               {
                  _loc7_;
                  while(_loc7_ < _taskInfo.itemList.length)
                  {
                     if(_loc3_.indexOf(_taskInfo.itemList[_loc7_]["id"]) == -1)
                     {
                        _finishItemList[_loc5_].update(_taskInfo.itemList[_loc7_]["taskType"],_taskInfo.itemList[_loc7_]["content"],_taskInfo.itemList[_loc7_]["currenValue"],_taskInfo.itemList[_loc7_]["targetValue"],_taskInfo.itemList[_loc7_]["id"]);
                        _loc7_++;
                        break;
                     }
                     _loc7_++;
                  }
               }
            }
            else
            {
               _finishItemList[_loc5_].update(_taskInfo.itemList[_loc5_]["taskType"],_taskInfo.itemList[_loc5_]["content"],_taskInfo.itemList[_loc5_]["currenValue"],_taskInfo.itemList[_loc5_]["targetValue"],_taskInfo.itemList[_loc5_]["id"]);
            }
            _loc5_++;
         }
         _expTxt.text = _taskInfo.exp.toString();
         _offerTxt.text = _taskInfo.offer.toString();
         _richesTxt.text = _taskInfo.riches.toString();
         _contributionTxt.text = _taskInfo.contribution.toString();
         var _loc9_:ConsortionSkillInfo = ConsortionModelManager.Instance.model.getSkillInfoByID(_taskInfo.buffID);
         if(_loc9_ != null)
         {
            _skillNameTxt.text = _loc9_.name + "*1天";
         }
         _contentTxt1.text = "1. " + _taskInfo.itemList[0]["content"];
         _contentTxt2.text = "2. " + _taskInfo.itemList[1]["content"];
         _contentTxt3.text = "3. " + _taskInfo.itemList[2]["content"];
         var _loc2_:Number = (_taskInfo.itemList[0]["finishValue"] / _taskInfo.itemList[0]["targetValue"] + _taskInfo.itemList[1]["finishValue"] / _taskInfo.itemList[1]["targetValue"] + _taskInfo.itemList[2]["finishValue"] / _taskInfo.itemList[2]["targetValue"]) / 3;
         var _loc1_:int = _loc2_ * 100;
         _myFinishTxt.text = _loc1_ + "%";
         _badgeText.text = String(50 * (_taskInfo.level + 1));
      }
      
      public function set taskInfo(param1:ConsortiaTaskInfo) : void
      {
         _taskInfo = param1;
         update();
      }
      
      public function dispose() : void
      {
         var _loc1_:int = 0;
         removeEvents();
         _taskInfo = null;
         if(_myReseBtn)
         {
            ObjectUtils.disposeObject(_myReseBtn);
         }
         _myReseBtn = null;
         if(_contributionRankBtn)
         {
            ObjectUtils.disposeObject(_contributionRankBtn);
         }
         _contributionRankBtn = null;
         if(_delayTimeBtn)
         {
            ObjectUtils.disposeObject(_delayTimeBtn);
         }
         _delayTimeBtn = null;
         _loc1_ = 0;
         while(_finishItemList != null && _loc1_ < _finishItemList.length)
         {
            ObjectUtils.disposeObject(_finishItemList[_loc1_]);
            _loc1_++;
         }
         _finishItemList = null;
         if(_vbox)
         {
            ObjectUtils.disposeObject(_vbox);
         }
         _vbox = null;
         if(_myFinishTxt)
         {
            ObjectUtils.disposeObject(_myFinishTxt);
         }
         _myFinishTxt = null;
         if(_expText)
         {
            ObjectUtils.disposeObject(_expText);
         }
         _expText = null;
         if(_moneyText)
         {
            ObjectUtils.disposeObject(_moneyText);
         }
         _moneyText = null;
         if(_caiText)
         {
            ObjectUtils.disposeObject(_caiText);
         }
         _caiText = null;
         if(_skillText)
         {
            ObjectUtils.disposeObject(_skillText);
         }
         _skillText = null;
         if(_expTxt)
         {
            ObjectUtils.disposeObject(_expTxt);
         }
         _expTxt = null;
         if(_offerTxt)
         {
            ObjectUtils.disposeObject(_offerTxt);
         }
         _offerTxt = null;
         if(_richesTxt)
         {
            ObjectUtils.disposeObject(_richesTxt);
         }
         _richesTxt = null;
         if(_skillNameTxt)
         {
            ObjectUtils.disposeObject(_skillNameTxt);
         }
         _skillNameTxt = null;
         if(_contentTxt1)
         {
            ObjectUtils.disposeObject(_contentTxt1);
         }
         _contentTxt1 = null;
         if(_contentTxt2)
         {
            ObjectUtils.disposeObject(_contentTxt2);
         }
         _contentTxt2 = null;
         if(_contentTxt3)
         {
            ObjectUtils.disposeObject(_contentTxt3);
         }
         _contentTxt3 = null;
         ObjectUtils.disposeAllChildren(this);
         _badgeLbl = null;
         _badgeText = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
