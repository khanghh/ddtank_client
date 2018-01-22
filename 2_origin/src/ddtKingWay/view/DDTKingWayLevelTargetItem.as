package ddtKingWay.view
{
   import bagAndInfo.BagAndInfoManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.bagStore.BagStore;
   import ddt.data.quest.QuestInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import ddt.manager.StateManager;
   import ddtKingWay.DDTKingWayManager;
   import farm.FarmModelController;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import hall.tasktrack.HallTaskTrackManager;
   import horse.HorseManager;
   import petsBag.PetsBagManager;
   import quest.TaskManager;
   
   public class DDTKingWayLevelTargetItem extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _taskTargetText:FilterFrameText;
      
      private var _stateImage:ScaleFrameImage;
      
      private var _jumpBtn:BaseButton;
      
      private var _num:int;
      
      private var _taskStatus:Boolean;
      
      private var _info:QuestInfo;
      
      public function DDTKingWayLevelTargetItem(param1:int = 0)
      {
         super();
         _num = param1;
         _bg = ComponentFactory.Instance.creatBitmap("asset.ddtKingWay.itembg" + (param1 % 2 + 1));
         _stateImage = ComponentFactory.Instance.creatComponentByStylename("asset.ddtKingWay.completestatusIcom");
         _taskTargetText = ComponentFactory.Instance.creatComponentByStylename("asset.ddtKingWay.taskTargetText");
         _jumpBtn = ComponentFactory.Instance.creatComponentByStylename("asset.ddtKingWay.upgradeBtn");
         _jumpBtn.addEventListener("click",textClickHandler);
         addChild(_bg);
         addChild(_taskTargetText);
         addChild(_stateImage);
         addChild(_jumpBtn);
      }
      
      public function updataStutas(param1:QuestInfo, param2:Boolean, param3:Boolean) : void
      {
         _info = param1;
         _taskStatus = param2;
         creatStateText(param3);
      }
      
      private function creatStateText(param1:Boolean) : void
      {
         var _loc2_:int = 0;
         if((!_info.data || _info.progress[_num] <= 0) && param1)
         {
            _loc2_ = 2;
         }
         else
         {
            _loc2_ = 1;
         }
         _stateImage.setFrame(_loc2_);
         _taskTargetText.setFrame(_loc2_);
         _taskTargetText.text = _info.conditions[_num].description;
      }
      
      private function textClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         if(_info.MapID > 0)
         {
            TaskManager.instance.jumpToQuestByID(_info.QuestID);
            return;
         }
         var _loc3_:Dictionary = HallTaskTrackManager.instance.btnIndexMap;
         var _loc2_:int = _info.conditions[_num].type;
         var _loc4_:* = _info.conditions[_num].turnType;
         if(-1 !== _loc4_)
         {
            if(1 !== _loc4_)
            {
               if(4 !== _loc4_)
               {
                  if(6 !== _loc4_)
                  {
                     if(13 !== _loc4_)
                     {
                        if(20 !== _loc4_)
                        {
                           if(26 === _loc4_)
                           {
                              BagAndInfoManager.Instance.showBagAndInfo(5);
                           }
                        }
                        else
                        {
                           HorseManager.instance.show();
                        }
                     }
                     else if(_loc2_ == 94)
                     {
                        FarmModelController.instance.goFarm(PlayerManager.Instance.Self.ID,PlayerManager.Instance.Self.NickName);
                     }
                     else
                     {
                        PetsBagManager.instance().show();
                     }
                  }
                  else if(_loc2_ == 82)
                  {
                     if(PlayerManager.Instance.Self.Grade < 35)
                     {
                        MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("levelFund.buyLevelFund.buyLevelLimitMsg"));
                        return;
                     }
                     BagAndInfoManager.Instance.showBagAndInfo(9);
                  }
                  else if(_loc2_ == 205)
                  {
                     if(PlayerManager.Instance.Self.Grade < 40)
                     {
                        MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("levelFund.buyLevelFund.buyLevelLimitMsg"));
                        return;
                     }
                     BagAndInfoManager.Instance.showBagAndInfo(8);
                  }
               }
               else
               {
                  StateManager.setState("dungeon");
               }
            }
            else if(_loc2_ == 9)
            {
               if(_info.conditions[_num].target <= 12)
               {
                  BagStore.instance.openStore("bag_store");
               }
               else
               {
                  BagStore.instance.openStore("bag_store",1);
               }
            }
            else if(_loc2_ == 202)
            {
               BagStore.instance.openStore("forge_store",3);
            }
            else if(_loc2_ == 203)
            {
               BagStore.instance.openStore("forge_store",4);
            }
            else if(_loc2_ == 80)
            {
               if(PlayerManager.Instance.Self.Grade < 35)
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("levelFund.buyLevelFund.buyLevelLimitMsg"));
                  return;
               }
               BagStore.instance.openStore("fine_store");
            }
         }
         else
         {
            TaskManager.instance.jumpToQuestByID(_info.QuestID);
         }
         DDTKingWayManager.instance.closeFrame();
      }
      
      public function dispose() : void
      {
         _jumpBtn.removeEventListener("click",textClickHandler);
         ObjectUtils.disposeObject(_taskTargetText);
         _taskTargetText = null;
         ObjectUtils.disposeObject(_stateImage);
         _stateImage = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_jumpBtn);
         _jumpBtn = null;
      }
   }
}
