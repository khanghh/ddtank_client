package newOldPlayer.newOldPlayerView
{
   import bagAndInfo.cell.BagCell;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.data.quest.QuestInfo;
   import ddt.data.quest.QuestItemReward;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.TimeManager;
   import morn.core.handlers.Handler;
   import newOldPlayer.NewOldPlayerManager;
   import newOldPlayer.newOldPlayerUI.item.NewOldPlayerTaskItemUI;
   import quest.TaskManager;
   
   public class NewOldPlayerTaskItem extends NewOldPlayerTaskItemUI
   {
       
      
      private var _info:QuestInfo;
      
      private var _cellArr:Array;
      
      private var _specialCell:BagCell;
      
      private var _lastClickTime:Number = 0;
      
      public function NewOldPlayerTaskItem()
      {
         _cellArr = [];
         super();
      }
      
      public function setData(info:QuestInfo) : void
      {
         _info = info;
         condition.text = info.conditions[0].description;
         setAward();
         getBtn.disabled = !info.isCompleted || info.isAchieved;
         getBtn.label = !!info.isAchieved?LanguageMgr.GetTranslation("daily.view.DetList.getBtnText2"):LanguageMgr.GetTranslation("daily.view.DetList.getBtnText1");
         getBtn.clickHandler = new Handler(getReward);
      }
      
      private function getReward() : void
      {
         var now:Date = TimeManager.Instance.Now();
         if(now.time - _lastClickTime > 1000)
         {
            _lastClickTime = now.time;
            TaskManager.instance.sendQuestFinish(_info.QuestID);
         }
         else
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.storeIIStrength.startStrengthClickTimerMsg"));
         }
      }
      
      public function setAward() : void
      {
         var i:int = 0;
         var cell:* = null;
         var reward:* = null;
         var tempId:int = 0;
         var tempInfo:* = null;
         var newInfo:* = null;
         var specialInfo:* = null;
         var allMoney:int = 0;
         clearCell();
         var arr:Array = _info.itemRewards;
         for(i = 0; i < arr.length; )
         {
            cell = new BagCell(0);
            reward = arr[i];
            tempId = reward.itemID;
            tempInfo = ItemManager.Instance.getTemplateById(tempId);
            cell.info = tempInfo;
            rewardBox.addChild(cell);
            cell.setCount(reward.count[0]);
            cell.x = i * 58;
            i++;
         }
         if(_info.RewardMoney)
         {
            newInfo = new ItemTemplateInfo();
            specialInfo = ItemManager.Instance.getTemplateById(-3200);
            ObjectUtils.copyProperties(newInfo,specialInfo);
            newInfo.Description = LanguageMgr.GetTranslation("tank.oldPlayer.rewardTxt",_info.RewardMoney);
            if(_specialCell)
            {
               ObjectUtils.disposeObject(_specialCell);
               _specialCell = null;
            }
            _specialCell = new BagCell(0);
            _specialCell.info = newInfo;
            _specialCell.x = i * 58;
            allMoney = NewOldPlayerManager.instance.rechargeMoney + NewOldPlayerManager.instance.exchangeMoney;
            _specialCell.setCount(int(allMoney * _info.RewardMoney / 100));
            rewardBox.addChild(_specialCell);
         }
      }
      
      private function clearCell() : void
      {
         var cell:* = null;
         while(_cellArr.length)
         {
            cell = _cellArr.shift();
            ObjectUtils.disposeObject(cell);
            cell = null;
         }
         rewardBox.removeAllChild();
      }
      
      override public function dispose() : void
      {
         clearCell();
         if(_specialCell)
         {
            ObjectUtils.disposeObject(_specialCell);
            _specialCell = null;
         }
         super.dispose();
      }
   }
}
