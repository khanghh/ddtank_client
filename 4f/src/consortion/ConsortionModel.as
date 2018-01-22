package consortion
{
   import consortion.data.CallBackModel;
   import consortion.data.ConsortiaApplyInfo;
   import consortion.data.ConsortiaAssetLevelOffer;
   import consortion.data.ConsortiaDutyInfo;
   import consortion.data.ConsortiaInventData;
   import consortion.data.ConsortiaLevelInfo;
   import consortion.data.ConsortionPollInfo;
   import consortion.data.ConsortionSkillInfo;
   import consortion.event.ConsortionEvent;
   import ddt.data.ConsortiaEventInfo;
   import ddt.data.ConsortiaInfo;
   import ddt.data.player.ConsortiaPlayerInfo;
   import ddt.data.player.PlayerState;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import flash.utils.Dictionary;
   import road7th.data.DictionaryData;
   
   public class ConsortionModel extends EventDispatcher
   {
      
      public static const CONSORTION_MAX_LEVEL:int = 10;
      
      public static const SHOP_MAX_LEVEL:int = 5;
      
      public static const STORE_MAX_LEVEL:int = 10;
      
      public static const BANK_MAX_LEVEL:int = 10;
      
      public static const SKILL_MAX_LEVEL:int = 10;
      
      public static const LEVEL:int = 0;
      
      public static const SHOP:int = 1;
      
      public static const STORE:int = 2;
      
      public static const BANK:int = 3;
      
      public static const SKILL:int = 4;
      
      public static const CONSORTION_SKILL:int = 1;
      
      public static const PERSONAL_SKILL:int = 2;
      
      public static const CLUB:String = "consortiaClub";
      
      public static const SELF_CONSORTIA:String = "selfConsortia";
      
      public static const ConsortionListEachPageNum:int = 6;
      
      public static const ACTIVE_TARGET_TYPE_FIRST:int = 1;
      
      public static const ACTIVE_TARGET_TYPE_SECOND:int = 2;
      
      public static const ACTIVE_TARGET_TYPE_THIRD:int = 3;
      
      public static const STATUS_UNACTIVE:int = 0;
      
      public static const STATUS_ACTIVE:int = 1;
      
      public static const STATUS_AWARD:int = 2;
      
      public static const STATUS_AWARD_RECIVED:int = 3;
       
      
      public var systemDate:String;
      
      private var _callBackModel:CallBackModel;
      
      public var activeTargetDic:Dictionary;
      
      public var activeTargetStautsDic:Dictionary;
      
      public var hasActiveTargetInited:Boolean = false;
      
      public var rewardLv:int = 0;
      
      private var _memberList:DictionaryData;
      
      private var _consortionList:Vector.<ConsortiaInfo>;
      
      public var consortionsListTotalCount:int;
      
      private var _myApplyList:Vector.<ConsortiaApplyInfo>;
      
      public var applyListTotalCount:int;
      
      private var _inventList:Vector.<ConsortiaInventData>;
      
      public var inventListTotalCount:int;
      
      private var _eventList:Vector.<ConsortiaEventInfo>;
      
      private var _useConditionList:Vector.<ConsortiaAssetLevelOffer>;
      
      private var _dutyList:Vector.<ConsortiaDutyInfo>;
      
      private var _pollList:Vector.<ConsortionPollInfo>;
      
      private var _skillInfoList:Vector.<ConsortionSkillInfo>;
      
      private var _levelUpData:Vector.<ConsortiaLevelInfo>;
      
      private var _richRankList:Array;
      
      private var _weekReward:DictionaryData;
      
      public function ConsortionModel(param1:IEventDispatcher = null){super(null);}
      
      public function get memberList() : DictionaryData{return null;}
      
      public function set memberList(param1:DictionaryData) : void{}
      
      public function addMember(param1:ConsortiaPlayerInfo) : void{}
      
      public function removeMember(param1:ConsortiaPlayerInfo) : void{}
      
      public function updataMember(param1:ConsortiaPlayerInfo) : void{}
      
      public function get consortiaInfo() : Array{return null;}
      
      public function get onlineConsortiaMemberList() : Array{return null;}
      
      public function getConsortiaMemberInfo(param1:int) : ConsortiaPlayerInfo{return null;}
      
      public function get offlineConsortiaMemberList() : Array{return null;}
      
      public function consortiaPlayerStateChange(param1:int, param2:int) : void{}
      
      public function set consortionList(param1:Vector.<ConsortiaInfo>) : void{}
      
      public function get consortionList() : Vector.<ConsortiaInfo>{return null;}
      
      public function set myApplyList(param1:Vector.<ConsortiaApplyInfo>) : void{}
      
      public function get myApplyList() : Vector.<ConsortiaApplyInfo>{return null;}
      
      public function getapplyListWithPage(param1:int, param2:int = 10) : Vector.<ConsortiaApplyInfo>{return null;}
      
      public function deleteOneApplyRecord(param1:int) : void{}
      
      public function set inventList(param1:Vector.<ConsortiaInventData>) : void{}
      
      public function get inventList() : Vector.<ConsortiaInventData>{return null;}
      
      public function get eventList() : Vector.<ConsortiaEventInfo>{return null;}
      
      public function set eventList(param1:Vector.<ConsortiaEventInfo>) : void{}
      
      public function get useConditionList() : Vector.<ConsortiaAssetLevelOffer>{return null;}
      
      public function set useConditionList(param1:Vector.<ConsortiaAssetLevelOffer>) : void{}
      
      public function get dutyList() : Vector.<ConsortiaDutyInfo>{return null;}
      
      public function set dutyList(param1:Vector.<ConsortiaDutyInfo>) : void{}
      
      public function changeDutyListName(param1:int, param2:String) : void{}
      
      public function get pollList() : Vector.<ConsortionPollInfo>{return null;}
      
      public function set pollList(param1:Vector.<ConsortionPollInfo>) : void{}
      
      public function get skillInfoList() : Vector.<ConsortionSkillInfo>{return null;}
      
      public function set skillInfoList(param1:Vector.<ConsortionSkillInfo>) : void{}
      
      public function getskillInfoWithTypeAndLevel(param1:int, param2:int) : Vector.<ConsortionSkillInfo>{return null;}
      
      public function getSkillInfoByID(param1:int) : ConsortionSkillInfo{return null;}
      
      public function updateSkillInfo(param1:int, param2:Boolean, param3:Date, param4:int) : void{}
      
      public function hasSomeGroupSkill(param1:int, param2:int) : Boolean{return false;}
      
      public function set levelUpData(param1:Vector.<ConsortiaLevelInfo>) : void{}
      
      public function get levelUpData() : Vector.<ConsortiaLevelInfo>{return null;}
      
      public function getLevelData(param1:int) : ConsortiaLevelInfo{return null;}
      
      public function getLevelString(param1:int, param2:int) : Vector.<String>{return null;}
      
      public function checkConsortiaRichesForUpGrade(param1:int) : Boolean{return false;}
      
      private function checkRiches(param1:int) : String{return null;}
      
      private function checkGold(param1:int) : String{return null;}
      
      public function set richRankList(param1:Array) : void{}
      
      public function set weekReward(param1:DictionaryData) : void{}
      
      public function get richRankList() : Array{return null;}
      
      public function get weekReward() : DictionaryData{return null;}
      
      public function get callBackModel() : CallBackModel{return null;}
   }
}
