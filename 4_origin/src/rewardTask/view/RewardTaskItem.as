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
         var _loc1_:int = 0;
         if(_taskInfo.RewardGP > 0)
         {
            addReward("exp",_taskInfo.RewardGP,_loc1_);
            _loc1_++;
         }
         if(_taskInfo.RewardGold > 0)
         {
            addReward("gold",_taskInfo.RewardGold,_loc1_);
            _loc1_++;
         }
         if(_taskInfo.RewardMoney > 0)
         {
            addReward("coin",_taskInfo.RewardMoney,_loc1_);
            _loc1_++;
         }
         if(_taskInfo.RewardOffer > 0)
         {
            addReward("honor",_taskInfo.RewardOffer,_loc1_);
            _loc1_++;
         }
         if(_taskInfo.RewardRiches > 0)
         {
            addReward("rich",_taskInfo.RewardRiches,_loc1_);
            _loc1_++;
         }
         if(_taskInfo.RewardBindMoney > 0)
         {
            addReward("gift",_taskInfo.RewardBindMoney,_loc1_);
            _loc1_++;
         }
         if(_taskInfo.Rank != "")
         {
            addReward("rank",0,_loc1_,true,_taskInfo.Rank);
            _loc1_++;
         }
         if(_taskInfo.RewardBuffID != 0)
         {
            _cardAsset = ComponentFactory.Instance.creat("core.quest.MCQuestRewardBuff");
            addChild(_cardAsset);
         }
      }
      
      private function addReward(param1:String, param2:int, param3:int, param4:Boolean = false, param5:String = "") : void
      {
         var _loc7_:FilterFrameText = ComponentFactory.Instance.creat("core.quest.MCQuestRewardType");
         _loc7_.y = 297;
         if(param3 > 3)
         {
            _loc7_.y = _loc7_.y + 20;
         }
         var _loc6_:FilterFrameText = ComponentFactory.Instance.creat("core.quest.QuestItemRewardQuantity");
         var _loc8_:* = param1;
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
                                 _loc7_.text = LanguageMgr.GetTranslation("tank.view.effort.EffortRigthItemView.honorNameII");
                              }
                           }
                           else
                           {
                              _loc7_.text = LanguageMgr.GetTranslation("gift");
                           }
                        }
                        else
                        {
                           _loc7_.text = LanguageMgr.GetTranslation("medalMoney");
                        }
                     }
                     else
                     {
                        _loc7_.text = StringUtils.trim(LanguageMgr.GetTranslation("gongxun"));
                     }
                  }
                  else
                  {
                     _loc7_.text = LanguageMgr.GetTranslation("consortia.Money");
                  }
               }
               else
               {
                  _loc7_.text = LanguageMgr.GetTranslation("money");
               }
            }
            else
            {
               _loc7_.text = LanguageMgr.GetTranslation("gold");
            }
         }
         else
         {
            _loc7_.text = LanguageMgr.GetTranslation("exp");
         }
         _loc7_.x = recordX + 59;
         _loc6_.x = _loc7_.x + _loc7_.textWidth + 5;
         _loc6_.y = _loc7_.y;
         recordX = _loc6_.x + _loc6_.textWidth + 15;
         if(param4)
         {
            _loc6_.text = param5;
         }
         else
         {
            _loc6_.text = String(param2);
         }
         addChildAt(_loc7_,0);
         addChildAt(_loc6_,0);
      }
      
      private function __onTaskStatusClick(param1:MouseEvent) : void
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
      
      private function __onGotoRewardClick(param1:MouseEvent) : void
      {
         var _loc2_:* = null;
         if(!_taskInfo)
         {
            return;
         }
         _quicklyComplete = false;
         SoundManager.instance.play("008");
         var _loc3_:QuestInfo = _taskInfo;
         if(_loc3_.RewardBindMoney != 0 && _loc3_.RewardBindMoney + PlayerManager.Instance.Self.DDTMoney > ServerConfigManager.instance.getBindBidLimit(PlayerManager.Instance.Self.Grade,PlayerManager.Instance.Self.VIPLevel))
         {
            _loc2_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),LanguageMgr.GetTranslation("ddt.BindBid.tip"),LanguageMgr.GetTranslation("shop.PresentFrame.OkBtnText"),LanguageMgr.GetTranslation("shop.PresentFrame.CancelBtnText"),true,true,true,1);
            _loc2_.addEventListener("response",__onResponse);
         }
         else
         {
            finishQuest(_loc3_);
         }
      }
      
      private function __onResponse(param1:FrameEvent) : void
      {
         var _loc2_:* = null;
         param1.currentTarget.removeEventListener("response",__onResponse);
         if(param1.responseCode == 3)
         {
            _loc2_ = _taskInfo;
            if(_quicklyComplete)
            {
               SocketManager.Instance.out.sendQuestFinish(_taskInfo.QuestID,TaskManager.itemAwardSelected,1);
               SocketManager.Instance.out.sendRewardTaskQuestOfferInfo();
            }
            else
            {
               finishQuest(_loc2_);
            }
         }
         ObjectUtils.disposeObject(param1.currentTarget);
      }
      
      private function finishQuest(param1:QuestInfo) : void
      {
         var _loc4_:* = null;
         var _loc2_:Array = [];
         var _loc6_:int = 0;
         var _loc5_:* = _taskInfo.itemRewards;
         for each(var _loc3_ in _taskInfo.itemRewards)
         {
            _loc4_ = new InventoryItemInfo();
            _loc4_.TemplateID = _loc3_.itemID;
            ItemManager.fill(_loc4_);
            _loc4_.ValidDate = _loc3_.ValidateTime;
            _loc4_.TemplateID = _loc3_.itemID;
            _loc4_.IsJudge = true;
            _loc4_.IsBinds = _loc3_.isBind;
            _loc4_.AttackCompose = _loc3_.AttackCompose;
            _loc4_.DefendCompose = _loc3_.DefendCompose;
            _loc4_.AgilityCompose = _loc3_.AgilityCompose;
            _loc4_.LuckCompose = _loc3_.LuckCompose;
            _loc4_.StrengthenLevel = _loc3_.StrengthenLevel;
            _loc4_.Count = _loc3_.count[_taskInfo.QuestLevel - 1];
            if(!(0 != _loc4_.NeedSex && getSexByInt(PlayerManager.Instance.Self.Sex) != _loc4_.NeedSex))
            {
               if(_loc3_.isOptional == 1)
               {
                  _loc2_.push(_loc4_);
               }
            }
         }
         SocketManager.Instance.out.sendQuestFinish(_taskInfo.QuestID,TaskManager.itemAwardSelected);
         _taskInfo = null;
         SocketManager.Instance.out.sendRewardTaskQuestOfferInfo();
      }
      
      private function getSexByInt(param1:Boolean) : int
      {
         if(param1)
         {
            return 1;
         }
         return 2;
      }
      
      private function __onClickcomplete(param1:MouseEvent) : void
      {
         _quicklyComplete = true;
         SoundManager.instance.playButtonSound();
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var _loc2_:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),LanguageMgr.GetTranslation("tank.manager.TaskManager.completeText",_taskInfo.OneKeyFinishNeedMoney),"",LanguageMgr.GetTranslation("cancel"),true,true,false,2);
         _loc2_.addEventListener("response",__onComplete);
      }
      
      private function __onComplete(param1:FrameEvent) : void
      {
         e = param1;
         var frame:BaseAlerFrame = e.currentTarget as BaseAlerFrame;
         frame.removeEventListener("response",__onComplete);
         if(e.responseCode == 3 || e.responseCode == 2)
         {
            CheckMoneyUtils.instance.checkMoney(false,_taskInfo.OneKeyFinishNeedMoney,function():void
            {
               var _loc1_:* = null;
               if(_taskInfo.RewardBindMoney != 0 && _taskInfo.RewardBindMoney + PlayerManager.Instance.Self.DDTMoney > ServerConfigManager.instance.getBindBidLimit(PlayerManager.Instance.Self.Grade,PlayerManager.Instance.Self.VIPLevel))
               {
                  _loc1_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),LanguageMgr.GetTranslation("ddt.BindBid.tip"),LanguageMgr.GetTranslation("shop.PresentFrame.OkBtnText"),LanguageMgr.GetTranslation("shop.PresentFrame.CancelBtnText"),true,true,true,1);
                  _loc1_.addEventListener("response",__onResponse);
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
      
      public function taskBtnStatus(param1:int = 0) : void
      {
         if(param1 == 1)
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
         var _loc5_:int = 0;
         var _loc4_:* = null;
         var _loc1_:int = RewardTaskControl.instance.model.questID;
         _taskInfo = TaskManager.instance.getQuestByID(_loc1_);
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
         var _loc2_:Array = _taskInfo.itemRewards;
         var _loc3_:int = _loc2_.length > _cellList.length?_loc2_.length:uint(_cellList.length);
         _loc5_ = 0;
         while(_loc5_ < _loc3_)
         {
            if(_loc5_ < _loc2_.length)
            {
               _loc4_ = ItemManager.fillByID(_loc2_[_loc5_].itemID);
               _loc4_.IsBinds = _loc2_[_loc5_].isBind;
               if(_loc5_ == _cellList.length)
               {
                  _cellList.push(new BagCell(0,null,true,ComponentFactory.Instance.creatBitmap("asset.rewardTask.goodbg")));
                  _goodBox.addChild(_cellList[_loc5_]);
               }
               _cellList[_loc5_].info = _loc4_;
               _cellList[_loc5_].setCount(_loc2_[_loc5_].count[_taskInfo.QuestLevel - 1]);
               _cellList[_loc5_].visible = true;
            }
            else
            {
               _cellList[_loc5_].visible = false;
            }
            _loc5_++;
         }
         _goodBox.arrange();
         taskBtnStatus(RewardTaskControl.instance.model.status);
         rewardItem();
      }
      
      private function createCell(param1:InventoryItemInfo) : BagCell
      {
         var _loc2_:BagCell = new BagCell(0,param1,true,ComponentFactory.Instance.creatBitmap("asset.rewardTask.goodbg"));
         return _loc2_;
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
