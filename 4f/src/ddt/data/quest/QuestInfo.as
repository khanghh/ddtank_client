package ddt.data.quest{   import com.pickgliss.ui.controls.cell.INotSameHeightListCellData;   import com.pickgliss.utils.StringUtils;   import consortion.ConsortionModelManager;   import dayActivity.DayActivityManager;   import ddt.data.goods.InventoryItemInfo;   import ddt.data.player.SelfInfo;   import ddt.manager.FineSuitManager;   import ddt.manager.ItemManager;   import ddt.manager.LanguageMgr;   import ddt.manager.PathManager;   import ddt.manager.PlayerManager;   import ddt.manager.TimeManager;   import hall.gameVIP.Game360VIP;   import horse.HorseManager;   import newOldPlayer.NewOldPlayerManager;   import pet.data.PetInfo;   import petsBag.PetsBagManager;   import quest.TaskManager;   import quest.TrusteeshipManager;   import road7th.data.DictionaryData;   import road7th.utils.DateUtils;   import totem.TotemManager;      public class QuestInfo implements INotSameHeightListCellData   {            public static const PET:int = 0;                   public var QuestID:int;            public var data:QuestDataInfo;            public var Detail:String;            public var Objective:String;            public var otherCondition:int;            public var Level:int;            public var NeedMinLevel:int;            public var NeedMaxLevel:int;            public var required:Boolean = false;            public var Type:int;            public var PreQuestID:String;            public var NextQuestID:String;            public var CanRepeat:Boolean;            public var RepeatInterval:int;            public var RepeatMax:int;            public var Title:String;            public var disabled:Boolean = false;            public var optionalConditionNeed:uint = 0;            private var _conditions:Array;            private var _itemRewards:Array;            public var StrengthenLevel:int;            public var FinishCount:int;            public var ReqItemID:int;            public var ReqKillLevel:int;            public var ReqBeCaption:Boolean;            public var ReqMap:int;            public var ReqFightMode:int;            public var ReqTimeMode:int;            public var RewardGold:int;            public var RewardMoney:int;            public var RewardGP:int;            public var OneKeyFinishNeedMoney:int;            public var TrusteeshipCost:int;            public var TrusteeshipNeedTime:int;            public var RewardOffer:int;            public var RewardRiches:int;            public var RewardBindMoney:int;            public var RewardBuffID:int;            public var RewardBuffDate:int;            public var Rank:String;            public var Level2NeedMoney:int;            public var Level3NeedMoney:int;            public var Level4NeedMoney:int;            public var Level5NeedMoney:int;            public var MapID:int;            public var AutoEquip:Boolean;            public var StarLev:int;            private var _questLevel:int;            public var TimeLimit:Boolean;            public var StartDate:Date;            public var EndDate:Date;            public var BuffID:int;            public var BuffValidDate:int;            public var isManuGet:Boolean;            private var _isPhoneTask:Boolean;            private var _cellHeight:Number = 0;            public function QuestInfo() { super(); }
            public static function createFromXML(xml:XML) : QuestInfo { return null; }
            public function get QuestLevel() : int { return 0; }
            public function set QuestLevel(value:int) : void { }
            public function get RewardItemCount() : int { return 0; }
            public function get RewardItemValidate() : int { return 0; }
            public function get itemRewards() : Array { return null; }
            public function get Id() : int { return 0; }
            public function get hadChecked() : Boolean { return false; }
            public function set hadChecked(value:Boolean) : void { }
            public function BuffName() : String { return null; }
            public function addCondition(condition:QuestCondition) : void { }
            public function addReward(reward:QuestItemReward) : void { }
            public function texpTaskIsTimeOut() : Boolean { return false; }
            public function isTimeOut() : Boolean { return false; }
            public function get id() : int { return 0; }
            public function get Condition() : int { return 0; }
            public function get ConditionTurn() : int { return 0; }
            public function get RewardItemID() : int { return 0; }
            public function get RewardItemValidateTime() : int { return 0; }
            public function isAvailableFor(self:SelfInfo) : Boolean { return false; }
            public function get isAvailable() : Boolean { return false; }
            public function get isAchieved() : Boolean { return false; }
            private function getProgressById(id:uint) : uint { return null; }
            public function get progress() : Array { return null; }
            public function get conditionStatusBoolean() : Array { return null; }
            public function get conditionStatus() : Array { return null; }
            public function get conditionDescription() : Array { return null; }
            public function get conditionProgress() : Array { return null; }
            public function get isCompleted() : Boolean { return false; }
            private function getConditionById(id:uint) : QuestCondition { return null; }
            private function getIsAutoComplete(index:int) : Boolean { return false; }
            public function get questProgressNum() : Number { return 0; }
            public function get canViewWithProgress() : Boolean { return false; }
            public function hasOtherAward() : Boolean { return false; }
            public function get isPhoneTask() : Boolean { return false; }
            private function checkIsPhoneTask() : void { }
            public function set cellHeight(value:Number) : void { }
            public function getCellHeight() : Number { return 0; }
            public function get conditions() : Array { return null; }
            public function set conditions(value:Array) : void { }
   }}