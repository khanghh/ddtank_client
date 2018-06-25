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
         var i:int = 0;
         var item:* = null;
         _finishItemList = new Vector.<ConsortiaMyTaskFinishItem>();
         var bgI:MutipleImage = ComponentFactory.Instance.creatComponentByStylename("consortion.task.bgI");
         var bgII:MutipleImage = ComponentFactory.Instance.creatComponentByStylename("consortion.task.bgII");
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
         var font1:Bitmap = ComponentFactory.Instance.creatBitmap("asset.conortionTask.FontContent");
         _contentTxt1 = ComponentFactory.Instance.creatComponentByStylename("consortion.task.contentTxt1");
         _contentTxt2 = ComponentFactory.Instance.creatComponentByStylename("consortion.task.contentTxt2");
         _contentTxt3 = ComponentFactory.Instance.creatComponentByStylename("consortion.task.contentTxt3");
         for(i = 0; i < 3; )
         {
            item = ComponentFactory.Instance.creatCustomObject("ConsortiaMyTaskFinishItem");
            _finishItemList.push(item);
            _vbox.addChild(item);
            i++;
         }
         addChild(bgI);
         addChild(bgII);
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
         var right:int = PlayerManager.Instance.Self.Right;
         _myReseBtn.visible = ConsortiaDutyManager.GetRight(right,512);
         _delayTimeBtn.visible = ConsortiaDutyManager.GetRight(right,512);
         ConsortionModelManager.Instance.TaskModel.lockNum = 0;
      }
      
      private function initEvents() : void
      {
         _myReseBtn.addEventListener("click",__resetClick);
         _contributionRankBtn.addEventListener("click",__taskRankClick);
         _delayTimeBtn.addEventListener("click",__delayTimeClick);
         PlayerManager.Instance.Self.addEventListener("propertychange",__propChange);
      }
      
      protected function __taskRankClick(e:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         var taskRankFrame:ConsortionTaskRank = ComponentFactory.Instance.creatComponentByStylename("consortion.taskRank.frame");
         LayerManager.Instance.addToLayer(taskRankFrame,3,true,1);
      }
      
      private function __delayTimeClick(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var tmpLevel:int = ConsortionModelManager.Instance.TaskModel.taskInfo.level - 1;
         var tmpTime:int = ServerConfigManager.instance.consortiaTaskDelayInfo[tmpLevel][0];
         var tmpRich:int = ServerConfigManager.instance.consortiaTaskDelayInfo[tmpLevel][1];
         var alert:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("consortia.task.delayTime"),LanguageMgr.GetTranslation("consortia.task.delayTimeContent",tmpRich,tmpTime),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,true,1);
         alert.moveEnable = false;
         alert.addEventListener("response",_responseII);
      }
      
      private function _responseII(event:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         (event.currentTarget as BaseAlerFrame).removeEventListener("response",_responseII);
         if(event.responseCode == 2 || event.responseCode == 3)
         {
            SocketManager.Instance.out.sendReleaseConsortiaTask(6);
         }
      }
      
      private function getLockIdArr() : Array
      {
         var i:int = 0;
         var arr:Array = [];
         for(i = 0; i < _finishItemList.length; )
         {
            if(_finishItemList[i].isLock)
            {
               arr.push(_finishItemList[i].lockId);
            }
            i++;
         }
         return arr;
      }
      
      private function __resetClick(event:MouseEvent) : void
      {
         var alert:* = null;
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
         var arr:Array = getLockIdArr();
         var length:int = arr.length;
         if(length)
         {
            if(length == 1)
            {
               _reSetTaskMoney = ConsortiaTaskView.RESET_MONEY + int(ServerConfigManager.instance.consortiaTaskPriceArr[0]);
            }
            else if(length == 2)
            {
               _reSetTaskMoney = ConsortiaTaskView.RESET_MONEY + int(ServerConfigManager.instance.consortiaTaskPriceArr[0]) + int(ServerConfigManager.instance.consortiaTaskPriceArr[1]);
            }
            alert = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("consortia.task.resetTable"),LanguageMgr.GetTranslation("consortia.task.resetLuckContent",arr.length,_reSetTaskMoney),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,true,2,null,"SimpleAlert",30,true,1);
            alert.moveEnable = false;
            alert.addEventListener("response",_responseI);
         }
         else
         {
            _reSetTaskMoney = ConsortiaTaskView.RESET_MONEY;
            alert = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("consortia.task.resetTable"),LanguageMgr.GetTranslation("consortia.task.resetContent",_reSetTaskMoney),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,true,2,null,"SimpleAlert",30,true,1);
            alert.moveEnable = false;
            alert.addEventListener("response",_responseI);
         }
      }
      
      private function _responseI(event:FrameEvent) : void
      {
         (event.currentTarget as BaseAlerFrame).removeEventListener("response",_responseI);
         if(event.responseCode == 2 || event.responseCode == 3)
         {
            if(ConsortionModelManager.Instance.TaskModel.taskInfo == null)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("consortia.task.stopTable"));
               ChatManager.Instance.sysChatYellow(LanguageMgr.GetTranslation("consortia.task.stopTable"));
            }
            else
            {
               CheckMoneyUtils.instance.checkMoney(event.currentTarget.isBand,_reSetTaskMoney,onCheckComplete);
            }
         }
         ObjectUtils.disposeObject(event.currentTarget as BaseAlerFrame);
      }
      
      protected function onCheckComplete() : void
      {
         var lockArr:Array = getLockIdArr();
         var lock1:int = !!lockArr[0]?lockArr[0]:0;
         var lock2:int = !!lockArr[1]?lockArr[1]:0;
         SocketManager.Instance.out.sendReleaseConsortiaTask(1,CheckMoneyUtils.instance.isBind,1,1,lock1,lock2);
         SocketManager.Instance.out.sendReleaseConsortiaTask(2);
      }
      
      private function __onNoMoneyResponse(event:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         var alert:BaseAlerFrame = event.currentTarget as BaseAlerFrame;
         alert.removeEventListener("response",__onNoMoneyResponse);
         alert.disposeChildren = true;
         alert.dispose();
         alert = null;
         if(event.responseCode == 3)
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
      
      private function __propChange(event:PlayerPropertyEvent) : void
      {
         var right:int = 0;
         if(event.changedProperties["Right"])
         {
            right = PlayerManager.Instance.Self.Right;
            _myReseBtn.visible = ConsortiaDutyManager.GetRight(right,512);
            _delayTimeBtn.visible = ConsortiaDutyManager.GetRight(right,512);
         }
      }
      
      private function update() : void
      {
         var i:int = 0;
         var m:int = 0;
         var h:int = 0;
         var right:int = PlayerManager.Instance.Self.Right;
         var isFinished:Boolean = true;
         var len:int = _taskInfo.itemList.length;
         for(i = 0; i < len; )
         {
            if(_taskInfo.itemList[i].currenValue - _taskInfo.itemList[i].targetValue < 0)
            {
               isFinished = false;
               break;
            }
            i++;
         }
         PositionUtils.setPos(_contributionRankBtn,!!isFinished?"taskRank.taskRankBtn.posFisished":"taskRank.taskRankBtn.posNotFisished");
         _myReseBtn.visible = ConsortiaDutyManager.GetRight(right,512) && !isFinished;
         _delayTimeBtn.visible = ConsortiaDutyManager.GetRight(right,512);
         var j:int = 0;
         var arr:Array = getLockIdArr();
         for(m = 0; m < _finishItemList.length; )
         {
            if(arr.length)
            {
               if(_finishItemList[m].isLock)
               {
                  for(h = 0; h < _taskInfo.itemList.length; )
                  {
                     if(_finishItemList[m].taskId == _taskInfo.itemList[h]["id"])
                     {
                        _finishItemList[m].updateFinishTxt(_taskInfo.itemList[h]["currenValue"]);
                     }
                     h++;
                  }
               }
               else
               {
                  j;
                  while(j < _taskInfo.itemList.length)
                  {
                     if(arr.indexOf(_taskInfo.itemList[j]["id"]) == -1)
                     {
                        _finishItemList[m].update(_taskInfo.itemList[j]["taskType"],_taskInfo.itemList[j]["content"],_taskInfo.itemList[j]["currenValue"],_taskInfo.itemList[j]["targetValue"],_taskInfo.itemList[j]["id"]);
                        j++;
                        break;
                     }
                     j++;
                  }
               }
            }
            else
            {
               _finishItemList[m].update(_taskInfo.itemList[m]["taskType"],_taskInfo.itemList[m]["content"],_taskInfo.itemList[m]["currenValue"],_taskInfo.itemList[m]["targetValue"],_taskInfo.itemList[m]["id"]);
            }
            m++;
         }
         _expTxt.text = _taskInfo.exp.toString();
         _offerTxt.text = _taskInfo.offer.toString();
         _richesTxt.text = _taskInfo.riches.toString();
         _contributionTxt.text = _taskInfo.contribution.toString();
         var buffinfo:ConsortionSkillInfo = ConsortionModelManager.Instance.model.getSkillInfoByID(_taskInfo.buffID);
         if(buffinfo != null)
         {
            _skillNameTxt.text = buffinfo.name + "*1天";
         }
         _contentTxt1.text = "1. " + _taskInfo.itemList[0]["content"];
         _contentTxt2.text = "2. " + _taskInfo.itemList[1]["content"];
         _contentTxt3.text = "3. " + _taskInfo.itemList[2]["content"];
         var myFinishRate:Number = (_taskInfo.itemList[0]["finishValue"] / _taskInfo.itemList[0]["targetValue"] + _taskInfo.itemList[1]["finishValue"] / _taskInfo.itemList[1]["targetValue"] + _taskInfo.itemList[2]["finishValue"] / _taskInfo.itemList[2]["targetValue"]) / 3;
         var myFinish:int = myFinishRate * 100;
         _myFinishTxt.text = myFinish + "%";
         _badgeText.text = String(50 * (_taskInfo.level + 1));
      }
      
      public function set taskInfo(info:ConsortiaTaskInfo) : void
      {
         _taskInfo = info;
         update();
      }
      
      public function dispose() : void
      {
         var i:int = 0;
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
         i = 0;
         while(_finishItemList != null && i < _finishItemList.length)
         {
            ObjectUtils.disposeObject(_finishItemList[i]);
            i++;
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
