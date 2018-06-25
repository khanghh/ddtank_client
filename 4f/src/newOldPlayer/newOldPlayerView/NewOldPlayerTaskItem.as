package newOldPlayer.newOldPlayerView{   import bagAndInfo.cell.BagCell;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.goods.ItemTemplateInfo;   import ddt.data.quest.QuestInfo;   import ddt.data.quest.QuestItemReward;   import ddt.manager.ItemManager;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.TimeManager;   import morn.core.handlers.Handler;   import newOldPlayer.NewOldPlayerManager;   import newOldPlayer.newOldPlayerUI.item.NewOldPlayerTaskItemUI;   import quest.TaskManager;      public class NewOldPlayerTaskItem extends NewOldPlayerTaskItemUI   {                   private var _info:QuestInfo;            private var _cellArr:Array;            private var _specialCell:BagCell;            private var _lastClickTime:Number = 0;            public function NewOldPlayerTaskItem() { super(); }
            public function setData(info:QuestInfo) : void { }
            private function getReward() : void { }
            public function setAward() : void { }
            private function clearCell() : void { }
            override public function dispose() : void { }
   }}