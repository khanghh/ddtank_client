package oldPlayerComeBack.view.task
{
   import bagAndInfo.BagAndInfoManager;
   import collectionTask.CollectionTaskManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.quest.QuestCondition;
   import ddt.data.quest.QuestInfo;
   import ddt.data.quest.QuestItemReward;
   import ddt.manager.BattleGroudManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.StateManager;
   import ddt.utils.HelperUIModuleLoad;
   import ddtBuried.BuriedManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import giftSystem.GiftManager;
   import hall.tasktrack.HallTaskTrackManager;
   import horse.HorseManager;
   import petsBag.PetsBagManager;
   import quest.TaskManager;
   
   public class OldPlayerTaskItem extends Sprite
   {
       
      
      private var _complateBg:Bitmap;
      
      private var _notComplateBg:Bitmap;
      
      private var _awardTxt:FilterFrameText;
      
      private var _completeCount:FilterFrameText;
      
      private var _progress:FilterFrameText;
      
      private var _awardValue:FilterFrameText;
      
      private var _getBtn:SimpleBitmapButton;
      
      private var _goToBtn:SimpleBitmapButton;
      
      private var _receivedBtn:Bitmap;
      
      private var _questInfo:QuestInfo;
      
      public function OldPlayerTaskItem()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _complateBg = ComponentFactory.Instance.creat("asset.oldPlayerComeBack.taskCompleteBg");
         addChild(_complateBg);
         _complateBg.visible = false;
         _notComplateBg = ComponentFactory.Instance.creat("asset.oldPlayerComeBack.taskNotCompleteBg");
         addChild(_notComplateBg);
         _notComplateBg.visible = true;
         _awardTxt = ComponentFactory.Instance.creatComponentByStylename("oldPlayerComeBack.taskView.awardTxt");
         addChild(_awardTxt);
         _awardValue = ComponentFactory.Instance.creatComponentByStylename("oldPlayerComeBack.taskView.awardValueTxt");
         addChild(_awardValue);
         _completeCount = ComponentFactory.Instance.creatComponentByStylename("oldPlayerComeBack.taskView.complateCountTxt");
         addChild(_completeCount);
         _progress = ComponentFactory.Instance.creatComponentByStylename("oldPlayerComeBack.taskView.complateProgressTxt");
         addChild(_progress);
         _getBtn = ComponentFactory.Instance.creatComponentByStylename("oldPlayerComeBack.taskView.getBtn");
         addChild(_getBtn);
         _getBtn.visible = false;
         _goToBtn = ComponentFactory.Instance.creatComponentByStylename("oldPlayerComeBack.taskView.goToBtn");
         addChild(_goToBtn);
         _goToBtn.visible = true;
         _receivedBtn = ComponentFactory.Instance.creatBitmap("asset.oldPlayerComeBack.receivedBtn");
         addChild(_receivedBtn);
         _receivedBtn.visible = false;
      }
      
      private function initEvent() : void
      {
         _goToBtn.addEventListener("click",__gotoBtnClickHandler);
         _getBtn.addEventListener("click",__getBtnClickHandler);
      }
      
      private function removeEvent() : void
      {
         _goToBtn.removeEventListener("click",__gotoBtnClickHandler);
         _getBtn.removeEventListener("click",__getBtnClickHandler);
      }
      
      private function __gotoBtnClickHandler(evt:MouseEvent) : void
      {
         LayerManager.Instance.clearnGameDynamic();
         jumpTo();
      }
      
      private function __getBtnClickHandler(evt:MouseEvent) : void
      {
         TaskManager.instance.sendQuestFinish(_questInfo.QuestID);
      }
      
      public function get completeType() : int
      {
         if(_questInfo.isCompleted && !_questInfo.isAchieved && _questInfo.data)
         {
            return 1;
         }
         if(_questInfo.isAvailable && !_questInfo.isAchieved && _questInfo.data)
         {
            return 2;
         }
         return 3;
      }
      
      public function set info(data:QuestInfo) : void
      {
         _questInfo = data;
         _awardTxt.text = data.Detail;
         _completeCount.text = initCompleteCount();
         _progress.text = initProgress();
         _awardValue.text = (data.itemRewards[0] as QuestItemReward).count[0] + "个";
         updateGuideState();
      }
      
      public function getInfo() : QuestInfo
      {
         return _questInfo;
      }
      
      private function updateGuideState() : void
      {
         _complateBg.visible = _questInfo.isCompleted || _questInfo.isAchieved && !_questInfo.CanRepeat || _questInfo.data == null;
         _notComplateBg.visible = !_complateBg.visible;
         _getBtn.visible = _questInfo.isCompleted && !_questInfo.isAchieved && _questInfo.data != null && _questInfo.isAvailable;
         _goToBtn.visible = !_questInfo.isCompleted && _questInfo.data != null && _questInfo.isAvailable;
         _receivedBtn.visible = _questInfo.data == null || !_questInfo.isAvailable || _questInfo.isAchieved && _questInfo.isCompleted;
      }
      
      private function jumpTo() : void
      {
         var limitLev:int = 0;
         if(_questInfo.MapID > 0)
         {
            TaskManager.instance.jumpToQuestByID(_questInfo.QuestID);
            return;
         }
         var idxMap:Dictionary = HallTaskTrackManager.instance.btnIndexMap;
         var _loc3_:* = _questInfo.ConditionTurn;
         if(-1 !== _loc3_)
         {
            if(1 !== _loc3_)
            {
               if(2 !== _loc3_)
               {
                  if(3 !== _loc3_)
                  {
                     if(4 !== _loc3_)
                     {
                        if(5 !== _loc3_)
                        {
                           if(6 !== _loc3_)
                           {
                              if(7 !== _loc3_)
                              {
                                 if(8 !== _loc3_)
                                 {
                                    if(9 !== _loc3_)
                                    {
                                       if(10 !== _loc3_)
                                       {
                                          if(11 !== _loc3_)
                                          {
                                             if(12 !== _loc3_)
                                             {
                                                if(13 !== _loc3_)
                                                {
                                                   if(14 !== _loc3_)
                                                   {
                                                      if(15 !== _loc3_)
                                                      {
                                                         if(16 !== _loc3_)
                                                         {
                                                            if(20 !== _loc3_)
                                                            {
                                                               if(18 !== _loc3_)
                                                               {
                                                                  if(19 === _loc3_)
                                                                  {
                                                                     if(PlayerManager.Instance.Self.Grade < 23)
                                                                     {
                                                                        MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.functionLimitTip",23));
                                                                        return;
                                                                     }
                                                                     new HelperUIModuleLoad().loadUIModule(["ddtbagandinfo"],GiftManager.Instance.show);
                                                                  }
                                                               }
                                                               else
                                                               {
                                                                  limitLev = ServerConfigManager.instance.trialBattleLevelLimit;
                                                                  if(PlayerManager.Instance.Self.Grade < limitLev)
                                                                  {
                                                                     MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.functionLimitTip",limitLev));
                                                                     return;
                                                                  }
                                                                  BattleGroudManager.Instance.onShow();
                                                               }
                                                            }
                                                            else
                                                            {
                                                               HorseManager.instance.show();
                                                            }
                                                         }
                                                         else
                                                         {
                                                            (HallTaskTrackManager.instance.btnList[idxMap["ringStation"]] as BaseButton).dispatchEvent(new MouseEvent("click"));
                                                         }
                                                      }
                                                      else
                                                      {
                                                         BuriedManager.Instance.enter();
                                                      }
                                                   }
                                                   else
                                                   {
                                                      (HallTaskTrackManager.instance.btnList[idxMap["labyrinth"]] as BaseButton).dispatchEvent(new MouseEvent("click"));
                                                   }
                                                }
                                                else
                                                {
                                                   PetsBagManager.instance().show();
                                                }
                                             }
                                             else
                                             {
                                                CollectionTaskManager.Instance.setUp();
                                             }
                                          }
                                          else
                                          {
                                             (HallTaskTrackManager.instance.btnList[idxMap["cryptBoss"]] as BaseButton).dispatchEvent(new MouseEvent("click"));
                                          }
                                       }
                                       else
                                       {
                                          (HallTaskTrackManager.instance.btnList[idxMap["home"]] as BaseButton).dispatchEvent(new MouseEvent("click"));
                                       }
                                    }
                                 }
                                 else
                                 {
                                    StateManager.setState("shop");
                                 }
                              }
                           }
                           else
                           {
                              BagAndInfoManager.Instance.showBagAndInfo();
                           }
                        }
                        else
                        {
                           (HallTaskTrackManager.instance.btnList[idxMap["roomList"]] as BaseButton).dispatchEvent(new MouseEvent("click"));
                        }
                     }
                     else
                     {
                        (HallTaskTrackManager.instance.btnList[idxMap["dungeon"]] as BaseButton).dispatchEvent(new MouseEvent("click"));
                     }
                  }
                  else
                  {
                     StateManager.setState("ddtchurchroomlist");
                  }
               }
               else
               {
                  (HallTaskTrackManager.instance.btnList[idxMap["constrion"]] as BaseButton).dispatchEvent(new MouseEvent("click"));
               }
            }
            else
            {
               (HallTaskTrackManager.instance.btnList[idxMap["store"]] as BaseButton).dispatchEvent(new MouseEvent("click"));
            }
         }
         else
         {
            TaskManager.instance.jumpToQuestByID(_questInfo.QuestID);
         }
      }
      
      private function initCompleteCount() : String
      {
         var temStr:* = null;
         if(_questInfo.CanRepeat)
         {
            if(_questInfo.RepeatInterval == 1)
            {
               temStr = "每日";
            }
            else
            {
               temStr = "每" + _questInfo.RepeatInterval + "天";
            }
            if(_questInfo.RepeatMax == 999)
            {
               temStr = "不限";
            }
            else
            {
               temStr = temStr + (_questInfo.RepeatMax + "次");
            }
         }
         else
         {
            temStr = _questInfo.RepeatMax + "次";
         }
         return temStr;
      }
      
      private function initProgress() : String
      {
         var tmpText:* = null;
         var i:int = 0;
         var cond:* = null;
         if(_questInfo.data == null)
         {
            tmpText = LanguageMgr.GetTranslation("tank.view.task.TaskCatalogContentView.over");
         }
         else
         {
            i = 0;
            while(_questInfo.conditions[i])
            {
               cond = _questInfo.conditions[i];
               if(cond.type == 90)
               {
                  if(_questInfo.data && _questInfo.data.progress[i] <= 0)
                  {
                     tmpText = "(0/1)";
                  }
                  else if(_questInfo.data && _questInfo.data.progress[i] > 0 && _questInfo.data.progress[i] <= cond.param2)
                  {
                     tmpText = LanguageMgr.GetTranslation("tank.view.task.TaskCatalogContentView.over");
                  }
               }
               else
               {
                  tmpText = _questInfo.conditionStatus[i];
               }
               i++;
            }
         }
         return tmpText;
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(_complateBg)
         {
            ObjectUtils.disposeObject(_complateBg);
         }
         _complateBg = null;
         if(_notComplateBg)
         {
            ObjectUtils.disposeObject(_notComplateBg);
         }
         _notComplateBg = null;
         if(_awardTxt)
         {
            ObjectUtils.disposeObject(_awardTxt);
         }
         _awardTxt = null;
         if(_completeCount)
         {
            ObjectUtils.disposeObject(_completeCount);
         }
         _completeCount = null;
         if(_progress)
         {
            ObjectUtils.disposeObject(_progress);
         }
         _progress = null;
         if(_getBtn)
         {
            ObjectUtils.disposeObject(_getBtn);
         }
         _getBtn = null;
         if(_goToBtn)
         {
            ObjectUtils.disposeObject(_goToBtn);
         }
         _goToBtn = null;
         if(_receivedBtn)
         {
            ObjectUtils.disposeObject(_receivedBtn);
         }
         _receivedBtn = null;
         if(_awardValue)
         {
            ObjectUtils.disposeObject(_awardValue);
         }
         _awardValue = null;
         _questInfo = null;
      }
   }
}
