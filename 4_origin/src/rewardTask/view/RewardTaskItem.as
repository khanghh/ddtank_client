package rewardTask.view
{
   import bagAndInfo.cell.BagCell;
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.StringUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.quest.QuestInfo;
   import ddt.data.quest.QuestItemReward;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.CheckMoneyUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import quest.QuestDescTextAnalyz;
   import quest.TaskManager;
   import rewardTask.RewardTaskControl;
   
   public class RewardTaskItem extends Sprite implements Disposeable
   {
       
      
      private const ROW_X:int = 59;
      
      private var _cardAsset:ScaleFrameImage;
      
      private var _taskDescriptionText:FilterFrameText;
      
      private var _taskTargetText:FilterFrameText;
      
      private var _taskTargetStatusText:FilterFrameText;
      
      private var _getTaskBtn:SimpleBitmapButton;
      
      private var _taskingBtn:SimpleBitmapButton;
      
      private var _gotoRewardBtn:BaseButton;
      
      private var _completeBtn:SimpleBitmapButton;
      
      private var _taskInfo:QuestInfo;
      
      private var _goodBox:HBox;
      
      private var _bagCell:BagCell;
      
      private var _goodIdBg:Bitmap;
      
      private var _quicklyComplete:Boolean;
      
      private var recordX:int = 0;
      
      private var _cellList:Vector.<BagCell>;
      
      public function RewardTaskItem()
      {
         super();
         init();
      }
      
      private function init() : void
      {
         _taskDescriptionText = ComponentFactory.Instance.creatComponentByStylename("rewardTask.taskDescriptionText");
         _taskTargetText = ComponentFactory.Instance.creatComponentByStylename("rewardTask.taskTargetText");
         _taskTargetStatusText = ComponentFactory.Instance.creatComponentByStylename("rewardTask.taskStatusText");
         _getTaskBtn = ComponentFactory.Instance.creatComponentByStylename("rewardTask.getTaskBtn");
         _taskingBtn = ComponentFactory.Instance.creatComponentByStylename("rewardTask.taskingBtn");
         _gotoRewardBtn = ComponentFactory.Instance.creatComponentByStylename("rewardTask.getAwardBtn");
         _completeBtn = ComponentFactory.Instance.creatComponentByStylename("rewardTask.completeBtn");
         _cellList = new Vector.<BagCell>();
         _goodBox = ComponentFactory.Instance.creatComponentByStylename("rewardTask.hbox");
         _getTaskBtn.addEventListener("click",__onTaskStatusClick);
         _gotoRewardBtn.addEventListener("click",__onGotoRewardClick);
         _completeBtn.addEventListener("click",__onClickcomplete);
         _taskingBtn.enable = false;
         addChild(_taskDescriptionText);
         addChild(_taskTargetText);
         addChild(_taskTargetStatusText);
         addChild(_getTaskBtn);
         addChild(_taskingBtn);
         addChild(_gotoRewardBtn);
         addChild(_completeBtn);
         addChild(_goodBox);
      }
      
      private function rewardItem() : void
      {
         recordX = 0;
         var index:int = 0;
         if(_taskInfo.RewardGP > 0)
         {
            addReward("exp",_taskInfo.RewardGP,index);
            index++;
         }
         if(_taskInfo.RewardGold > 0)
         {
            addReward("gold",_taskInfo.RewardGold,index);
            index++;
         }
         if(_taskInfo.RewardMoney > 0)
         {
            addReward("coin",_taskInfo.RewardMoney,index);
            index++;
         }
         if(_taskInfo.RewardOffer > 0)
         {
            addReward("honor",_taskInfo.RewardOffer,index);
            index++;
         }
         if(_taskInfo.RewardRiches > 0)
         {
            addReward("rich",_taskInfo.RewardRiches,index);
            index++;
         }
         if(_taskInfo.RewardBindMoney > 0)
         {
            addReward("gift",_taskInfo.RewardBindMoney,index);
            index++;
         }
         if(_taskInfo.Rank != "")
         {
            addReward("rank",0,index,true,_taskInfo.Rank);
            index++;
         }
         if(_taskInfo.RewardBuffID != 0)
         {
            _cardAsset = ComponentFactory.Instance.creat("core.quest.MCQuestRewardBuff");
            addChild(_cardAsset);
         }
      }
      
      private function addReward(reward:String, count:int, index:int, isRank:Boolean = false, rank:String = "") : void
      {
         var rewardMC:FilterFrameText = ComponentFactory.Instance.creat("core.quest.MCQuestRewardType");
         rewardMC.y = 297;
         if(index > 3)
         {
            rewardMC.y = rewardMC.y + 20;
         }
         var quantityTxt:FilterFrameText = ComponentFactory.Instance.creat("core.quest.QuestItemRewardQuantity");
         var _loc8_:* = reward;
         if("exp" !== _loc8_)
         {
            if("gold" !== _loc8_)
            {
               if("coin" !== _loc8_)
               {
                  if("rich" !== _loc8_)
                  {
                     if("honor" !== _loc8_)
                     {
                        if("gift" !== _loc8_)
                        {
                           if("medal" !== _loc8_)
                           {
                              if("rank" === _loc8_)
                              {
                                 rewardMC.text = LanguageMgr.GetTranslation("tank.view.effort.EffortRigthItemView.honorNameII");
                              }
                           }
                           else
                           {
                              rewardMC.text = LanguageMgr.GetTranslation("gift");
                           }
                        }
                        else
                        {
                           rewardMC.text = LanguageMgr.GetTranslation("medalMoney");
                        }
                     }
                     else
                     {
                        rewardMC.text = StringUtils.trim(LanguageMgr.GetTranslation("gongxun"));
                     }
                  }
                  else
                  {
                     rewardMC.text = LanguageMgr.GetTranslation("consortia.Money");
                  }
               }
               else
               {
                  rewardMC.text = LanguageMgr.GetTranslation("money");
               }
            }
            else
            {
               rewardMC.text = LanguageMgr.GetTranslation("gold");
            }
         }
         else
         {
            rewardMC.text = LanguageMgr.GetTranslation("exp");
         }
         rewardMC.x = recordX + 59;
         quantityTxt.x = rewardMC.x + rewardMC.textWidth + 5;
         quantityTxt.y = rewardMC.y;
         recordX = quantityTxt.x + quantityTxt.textWidth + 15;
         if(isRank)
         {
            quantityTxt.text = rank;
         }
         else
         {
            quantityTxt.text = String(count);
         }
         addChildAt(rewardMC,0);
         addChildAt(quantityTxt,0);
      }
      
      private function __onTaskStatusClick(e:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         if(RewardTaskControl.instance.model.times == 0 && RewardTaskControl.instance.model.times == 0)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("rewardTask.taskNumber.notTask"));
         }
         else
         {
            SocketManager.Instance.out.sendRewardTaskAcceptQuest();
         }
      }
      
      private function __onGotoRewardClick(e:MouseEvent) : void
      {
         var alert:* = null;
         if(!_taskInfo)
         {
            return;
         }
         _quicklyComplete = false;
         SoundManager.instance.play("008");
         var questInfo:QuestInfo = _taskInfo;
         if(questInfo.RewardBindMoney != 0 && questInfo.RewardBindMoney + PlayerManager.Instance.Self.DDTMoney > ServerConfigManager.instance.getBindBidLimit(PlayerManager.Instance.Self.Grade,PlayerManager.Instance.Self.VIPLevel))
         {
            alert = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),LanguageMgr.GetTranslation("ddt.BindBid.tip"),LanguageMgr.GetTranslation("shop.PresentFrame.OkBtnText"),LanguageMgr.GetTranslation("shop.PresentFrame.CancelBtnText"),true,true,true,1);
            alert.addEventListener("response",__onResponse);
         }
         else
         {
            finishQuest(questInfo);
         }
      }
      
      private function __onResponse(pEvent:FrameEvent) : void
      {
         var questInfo:* = null;
         pEvent.currentTarget.removeEventListener("response",__onResponse);
         if(pEvent.responseCode == 3)
         {
            questInfo = _taskInfo;
            if(_quicklyComplete)
            {
               SocketManager.Instance.out.sendQuestFinish(_taskInfo.QuestID,TaskManager.itemAwardSelected,1);
               SocketManager.Instance.out.sendRewardTaskQuestOfferInfo();
            }
            else
            {
               finishQuest(questInfo);
            }
         }
         ObjectUtils.disposeObject(pEvent.currentTarget);
      }
      
      private function finishQuest(pQuestInfo:QuestInfo) : void
      {
         var info:* = null;
         var items:Array = [];
         var _loc6_:int = 0;
         var _loc5_:* = _taskInfo.itemRewards;
         for each(var temp in _taskInfo.itemRewards)
         {
            info = new InventoryItemInfo();
            info.TemplateID = temp.itemID;
            ItemManager.fill(info);
            info.ValidDate = temp.ValidateTime;
            info.TemplateID = temp.itemID;
            info.IsJudge = true;
            info.IsBinds = temp.isBind;
            info.AttackCompose = temp.AttackCompose;
            info.DefendCompose = temp.DefendCompose;
            info.AgilityCompose = temp.AgilityCompose;
            info.LuckCompose = temp.LuckCompose;
            info.StrengthenLevel = temp.StrengthenLevel;
            info.Count = temp.count[_taskInfo.QuestLevel - 1];
            if(!(0 != info.NeedSex && getSexByInt(PlayerManager.Instance.Self.Sex) != info.NeedSex))
            {
               if(temp.isOptional == 1)
               {
                  items.push(info);
               }
            }
         }
         SocketManager.Instance.out.sendQuestFinish(_taskInfo.QuestID,TaskManager.itemAwardSelected);
         _taskInfo = null;
         SocketManager.Instance.out.sendRewardTaskQuestOfferInfo();
      }
      
      private function getSexByInt(Sex:Boolean) : int
      {
         if(Sex)
         {
            return 1;
         }
         return 2;
      }
      
      private function __onClickcomplete(e:MouseEvent) : void
      {
         _quicklyComplete = true;
         SoundManager.instance.playButtonSound();
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var frame:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),LanguageMgr.GetTranslation("tank.manager.TaskManager.completeText",_taskInfo.OneKeyFinishNeedMoney),"",LanguageMgr.GetTranslation("cancel"),true,true,false,2);
         frame.addEventListener("response",__onComplete);
      }
      
      private function __onComplete(e:FrameEvent) : void
      {
         e = e;
         var frame:BaseAlerFrame = e.currentTarget as BaseAlerFrame;
         frame.removeEventListener("response",__onComplete);
         if(e.responseCode == 3 || e.responseCode == 2)
         {
            CheckMoneyUtils.instance.checkMoney(false,_taskInfo.OneKeyFinishNeedMoney,function():void
            {
               var alert:* = null;
               if(_taskInfo.RewardBindMoney != 0 && _taskInfo.RewardBindMoney + PlayerManager.Instance.Self.DDTMoney > ServerConfigManager.instance.getBindBidLimit(PlayerManager.Instance.Self.Grade,PlayerManager.Instance.Self.VIPLevel))
               {
                  alert = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),LanguageMgr.GetTranslation("ddt.BindBid.tip"),LanguageMgr.GetTranslation("shop.PresentFrame.OkBtnText"),LanguageMgr.GetTranslation("shop.PresentFrame.CancelBtnText"),true,true,true,1);
                  alert.addEventListener("response",__onResponse);
               }
               else
               {
                  SocketManager.Instance.out.sendQuestFinish(_taskInfo.QuestID,TaskManager.itemAwardSelected,1);
                  SocketManager.Instance.out.sendRewardTaskQuestOfferInfo();
               }
            });
         }
         frame.dispose();
      }
      
      private function updataTaskTargetStatusText() : void
      {
         if(RewardTaskControl.instance.model.status == 0 || RewardTaskControl.instance.model.status == 2)
         {
            _taskTargetStatusText.htmlText = "";
         }
         else
         {
            _taskTargetStatusText.htmlText = _taskInfo.conditionStatus[0];
            _taskTargetStatusText.x = _taskTargetText.x + _taskTargetText.textWidth + 5;
         }
      }
      
      public function taskBtnStatus(status:int = 0) : void
      {
         if(status == 1)
         {
            _getTaskBtn.enable = false;
            _getTaskBtn.visible = false;
            _taskingBtn.visible = true;
            _gotoRewardBtn.enable = false;
            _gotoRewardBtn.visible = false;
            _completeBtn.enable = true;
            if(_taskInfo.isCompleted)
            {
               _taskingBtn.visible = false;
               _gotoRewardBtn.enable = true;
               _gotoRewardBtn.visible = true;
               _completeBtn.enable = false;
            }
         }
         else
         {
            _getTaskBtn.visible = true;
            _taskingBtn.visible = false;
            _gotoRewardBtn.enable = false;
            _gotoRewardBtn.visible = false;
            _completeBtn.enable = false;
            if(RewardTaskControl.instance.model.times == 0)
            {
               _getTaskBtn.enable = false;
            }
            else
            {
               _getTaskBtn.enable = true;
            }
         }
      }
      
      public function updateInfo() : void
      {
         updataItem();
      }
      
      private function updataItem() : void
      {
         var i:int = 0;
         var info:* = null;
         var id:int = RewardTaskControl.instance.model.questID;
         _taskInfo = TaskManager.instance.getQuestByID(id);
         _taskDescriptionText.htmlText = QuestDescTextAnalyz.start(_taskInfo.Detail) + "<br/><br/>";
         _taskTargetText.htmlText = _taskInfo.conditions[0].description;
         if(RewardTaskControl.instance.model.status == 0)
         {
            _taskTargetStatusText.htmlText = "";
         }
         else
         {
            _taskTargetStatusText.htmlText = _taskInfo.conditionStatus[0];
            _taskTargetStatusText.x = _taskTargetText.x + _taskTargetText.textWidth + 5;
         }
         updataTaskTargetStatusText();
         var goodArr:Array = _taskInfo.itemRewards;
         var len:int = goodArr.length > _cellList.length?goodArr.length:uint(_cellList.length);
         for(i = 0; i < len; )
         {
            if(i < goodArr.length)
            {
               info = ItemManager.fillByID(goodArr[i].itemID);
               info.IsBinds = goodArr[i].isBind;
               if(i == _cellList.length)
               {
                  _cellList.push(new BagCell(0,null,true,ComponentFactory.Instance.creatBitmap("asset.rewardTask.goodbg")));
                  _goodBox.addChild(_cellList[i]);
               }
               _cellList[i].info = info;
               _cellList[i].setCount(goodArr[i].count[_taskInfo.QuestLevel - 1]);
               _cellList[i].visible = true;
            }
            else
            {
               _cellList[i].visible = false;
            }
            i++;
         }
         _goodBox.arrange();
         taskBtnStatus(RewardTaskControl.instance.model.status);
         rewardItem();
      }
      
      private function createCell(info:InventoryItemInfo) : BagCell
      {
         var bagCell:BagCell = new BagCell(0,info,true,ComponentFactory.Instance.creatBitmap("asset.rewardTask.goodbg"));
         return bagCell;
      }
      
      public function dispose() : void
      {
         _getTaskBtn.removeEventListener("click",__onTaskStatusClick);
         _gotoRewardBtn.removeEventListener("click",__onGotoRewardClick);
         _completeBtn.removeEventListener("click",__onClickcomplete);
         ObjectUtils.disposeObject(_goodBox);
         ObjectUtils.disposeAllChildren(this);
         _taskDescriptionText = null;
         _taskTargetText = null;
         _taskTargetStatusText = null;
         _getTaskBtn = null;
         _gotoRewardBtn = null;
         _taskingBtn = null;
         _completeBtn = null;
         _goodBox = null;
      }
   }
}
