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
      
      public function ConsortionModel(param1:IEventDispatcher = null)
      {
         activeTargetDic = new Dictionary(true);
         activeTargetStautsDic = new Dictionary(true);
         super(param1);
      }
      
      public function get memberList() : DictionaryData
      {
         if(_memberList == null)
         {
            _memberList = new DictionaryData();
         }
         return _memberList;
      }
      
      public function set memberList(param1:DictionaryData) : void
      {
         if(_memberList == param1)
         {
            return;
         }
         _memberList = param1;
         dispatchEvent(new ConsortionEvent("memberListLoadComplete"));
      }
      
      public function addMember(param1:ConsortiaPlayerInfo) : void
      {
         _memberList.add(param1.ID,param1);
         dispatchEvent(new ConsortionEvent("addMember",param1));
      }
      
      public function removeMember(param1:ConsortiaPlayerInfo) : void
      {
         _memberList.remove(param1.ID);
         dispatchEvent(new ConsortionEvent("removeMember",param1));
      }
      
      public function updataMember(param1:ConsortiaPlayerInfo) : void
      {
         _memberList.add(param1.ID,param1);
         dispatchEvent(new ConsortionEvent("memberUpdata",param1));
      }
      
      public function get consortiaInfo() : Array
      {
         var _loc2_:Array = [];
         var _loc3_:Array = onlineConsortiaMemberList;
         var _loc1_:ConsortiaPlayerInfo = new ConsortiaPlayerInfo();
         _loc1_.type = 0;
         _loc1_.isSelected = true;
         _loc1_.RatifierName = LanguageMgr.GetTranslation("ddt.consortion.ratifierName") + " [" + _loc3_.length + "/" + this.memberList.length + "]";
         _loc2_.push(_loc1_);
         return _loc2_;
      }
      
      public function get onlineConsortiaMemberList() : Array
      {
         var _loc1_:Array = [];
         var _loc4_:int = 0;
         var _loc3_:* = memberList;
         for each(var _loc2_ in memberList)
         {
            if(_loc2_.playerState.StateID != 0)
            {
               _loc1_.push(_loc2_);
            }
         }
         return _loc1_;
      }
      
      public function getConsortiaMemberInfo(param1:int) : ConsortiaPlayerInfo
      {
         var _loc4_:int = 0;
         var _loc3_:* = memberList;
         for each(var _loc2_ in memberList)
         {
            if(_loc2_.ID == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function get offlineConsortiaMemberList() : Array
      {
         var _loc1_:Array = [];
         var _loc4_:int = 0;
         var _loc3_:* = memberList;
         for each(var _loc2_ in memberList)
         {
            if(_loc2_.playerState.StateID == 0)
            {
               _loc1_.push(_loc2_);
            }
         }
         return _loc1_;
      }
      
      public function consortiaPlayerStateChange(param1:int, param2:int) : void
      {
         var _loc4_:* = null;
         var _loc3_:ConsortiaPlayerInfo = getConsortiaMemberInfo(param1);
         if(_loc3_ == null)
         {
            return;
         }
         if(_loc3_)
         {
            _loc4_ = new PlayerState(param2);
            _loc3_.playerState = _loc4_;
            updataMember(_loc3_);
         }
      }
      
      public function set consortionList(param1:Vector.<ConsortiaInfo>) : void
      {
         if(_consortionList == param1)
         {
            return;
         }
         _consortionList = param1;
         dispatchEvent(new ConsortionEvent("consortionListIsChange"));
      }
      
      public function get consortionList() : Vector.<ConsortiaInfo>
      {
         return _consortionList;
      }
      
      public function set myApplyList(param1:Vector.<ConsortiaApplyInfo>) : void
      {
         if(_myApplyList == param1)
         {
            return;
         }
         _myApplyList = param1;
         dispatchEvent(new ConsortionEvent("myApplyListIsChange"));
      }
      
      public function get myApplyList() : Vector.<ConsortiaApplyInfo>
      {
         return _myApplyList;
      }
      
      public function getapplyListWithPage(param1:int, param2:int = 10) : Vector.<ConsortiaApplyInfo>
      {
         param1 = param1 < 0?1:param1 > Math.ceil(_myApplyList.length / param2)?Math.ceil(_myApplyList.length / param2):param1;
         return myApplyList.slice((param1 - 1) * param2,param1 * param2);
      }
      
      public function deleteOneApplyRecord(param1:int) : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = myApplyList.length;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            if(myApplyList[_loc3_].ID == param1)
            {
               myApplyList.splice(_loc3_,1);
               dispatchEvent(new ConsortionEvent("myApplyListIsChange"));
               break;
            }
            _loc3_++;
         }
      }
      
      public function set inventList(param1:Vector.<ConsortiaInventData>) : void
      {
         if(_inventList == param1)
         {
            return;
         }
         _inventList = param1;
         dispatchEvent(new ConsortionEvent("inventListIsChange"));
      }
      
      public function get inventList() : Vector.<ConsortiaInventData>
      {
         return _inventList;
      }
      
      public function get eventList() : Vector.<ConsortiaEventInfo>
      {
         return _eventList;
      }
      
      public function set eventList(param1:Vector.<ConsortiaEventInfo>) : void
      {
         if(_eventList == param1)
         {
            return;
         }
         _eventList = param1;
         dispatchEvent(new ConsortionEvent("eventListChange"));
      }
      
      public function get useConditionList() : Vector.<ConsortiaAssetLevelOffer>
      {
         return _useConditionList;
      }
      
      public function set useConditionList(param1:Vector.<ConsortiaAssetLevelOffer>) : void
      {
         if(_useConditionList == param1)
         {
            return;
         }
         _useConditionList = param1;
         ConsortionModelManager.Instance.model.dispatchEvent(new ConsortionEvent("useConditionChange"));
      }
      
      public function get dutyList() : Vector.<ConsortiaDutyInfo>
      {
         return _dutyList;
      }
      
      public function set dutyList(param1:Vector.<ConsortiaDutyInfo>) : void
      {
         if(_dutyList == param1)
         {
            return;
         }
         _dutyList = param1;
         dispatchEvent(new ConsortionEvent("dutyListChange"));
      }
      
      public function changeDutyListName(param1:int, param2:String) : void
      {
         var _loc3_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < _dutyList.length)
         {
            if(_dutyList[_loc3_].DutyID == param1)
            {
               _dutyList[_loc3_].DutyName = param2;
               break;
            }
            _loc3_++;
         }
      }
      
      public function get pollList() : Vector.<ConsortionPollInfo>
      {
         return _pollList;
      }
      
      public function set pollList(param1:Vector.<ConsortionPollInfo>) : void
      {
         if(_pollList == param1)
         {
            return;
         }
         _pollList = param1;
         dispatchEvent(new ConsortionEvent("pollListChange"));
      }
      
      public function get skillInfoList() : Vector.<ConsortionSkillInfo>
      {
         return _skillInfoList;
      }
      
      public function set skillInfoList(param1:Vector.<ConsortionSkillInfo>) : void
      {
         if(_skillInfoList == param1)
         {
            return;
         }
         _skillInfoList = param1;
         dispatchEvent(new ConsortionEvent("skillListChange"));
      }
      
      public function getskillInfoWithTypeAndLevel(param1:int, param2:int) : Vector.<ConsortionSkillInfo>
      {
         var _loc4_:int = 0;
         var _loc5_:Vector.<ConsortionSkillInfo> = new Vector.<ConsortionSkillInfo>();
         var _loc3_:int = skillInfoList.length;
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            if(skillInfoList[_loc4_].type == param1 && skillInfoList[_loc4_].level == param2)
            {
               _loc5_.push(skillInfoList[_loc4_]);
            }
            _loc4_++;
         }
         return _loc5_;
      }
      
      public function getSkillInfoByID(param1:int) : ConsortionSkillInfo
      {
         var _loc3_:* = null;
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < skillInfoList.length)
         {
            if(skillInfoList[_loc2_].id == param1)
            {
               _loc3_ = skillInfoList[_loc2_];
            }
            _loc2_++;
         }
         return _loc3_;
      }
      
      public function updateSkillInfo(param1:int, param2:Boolean, param3:Date, param4:int) : void
      {
         var _loc6_:int = 0;
         var _loc5_:int = skillInfoList.length;
         _loc6_ = 0;
         while(_loc6_ < _loc5_)
         {
            if(skillInfoList[_loc6_].id == param1)
            {
               skillInfoList[_loc6_].isOpen = param2;
               skillInfoList[_loc6_].beginDate = param3;
               skillInfoList[_loc6_].validDate = param4;
               break;
            }
            _loc6_++;
         }
      }
      
      public function hasSomeGroupSkill(param1:int, param2:int) : Boolean
      {
         var _loc4_:int = 0;
         var _loc3_:int = skillInfoList.length;
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            if(skillInfoList[_loc4_].group == param1 && skillInfoList[_loc4_].isOpen && skillInfoList[_loc4_].id != param2)
            {
               return true;
            }
            _loc4_++;
         }
         return false;
      }
      
      public function set levelUpData(param1:Vector.<ConsortiaLevelInfo>) : void
      {
         if(_levelUpData == param1)
         {
            return;
         }
         _levelUpData = param1;
         dispatchEvent(new ConsortionEvent("levelUpRuleChange"));
      }
      
      public function get levelUpData() : Vector.<ConsortiaLevelInfo>
      {
         return _levelUpData;
      }
      
      public function getLevelData(param1:int) : ConsortiaLevelInfo
      {
         var _loc2_:* = 0;
         if(levelUpData == null)
         {
            return null;
         }
         _loc2_ = uint(0);
         while(_loc2_ < levelUpData.length)
         {
            if(levelUpData[_loc2_]["Level"] == param1)
            {
               return levelUpData[_loc2_];
            }
            _loc2_++;
         }
         return null;
      }
      
      public function getLevelString(param1:int, param2:int) : Vector.<String>
      {
         var _loc3_:Vector.<String> = new Vector.<String>(4);
         switch(int(param1))
         {
            case 0:
               if(param2 >= 10)
               {
                  _loc3_[0] = LanguageMgr.GetTranslation("tank.consortia.myconsortia.frame.MyConsortiaUpgrade.explainTxt",getLevelData(param2).Count);
                  _loc3_[1] = LanguageMgr.GetTranslation("tank.consortia.myconsortia.frame.MyConsortiaUpgrade.null");
                  _loc3_[3] = LanguageMgr.GetTranslation("tank.consortia.myconsortia.frame.MyConsortiaUpgrade.null");
               }
               else
               {
                  _loc3_[0] = LanguageMgr.GetTranslation("tank.consortia.myconsortia.frame.MyConsortiaUpgrade.upgrade",getLevelData(param2).Count);
                  _loc3_[1] = LanguageMgr.GetTranslation("tank.consortia.myconsortia.frame.MyConsortiaUpgrade.nextLevel",param2 + 1,getLevelData(param2 + 1).Count);
                  _loc3_[3] = LanguageMgr.GetTranslation("tank.consortia.myconsortia.frame.MyConsortiaUpgrade.consumeTxt",String(getLevelData(param2 + 1).Riches),checkRiches(getLevelData(param2 + 1).Riches),getLevelData(param2 + 1).NeedGold) + checkGold(getLevelData(param2 + 1).NeedGold);
               }
               _loc3_[2] = LanguageMgr.GetTranslation("tank.consortia.myconsortia.frame.MyConsortiaUpgrade.null");
               break;
            case 1:
               if(param2 >= 5)
               {
                  _loc3_[0] = LanguageMgr.GetTranslation("tank.consortia.myconsortia.frame.MyConsortiaUpgrade.consortiaShopLevel");
                  _loc3_[1] = LanguageMgr.GetTranslation("tank.consortia.myconsortia.frame.MyConsortiaUpgrade.null");
                  _loc3_[2] = LanguageMgr.GetTranslation("tank.consortia.myconsortia.frame.MyConsortiaUpgrade.null");
                  _loc3_[3] = LanguageMgr.GetTranslation("tank.consortia.myconsortia.frame.MyConsortiaUpgrade.null");
               }
               else
               {
                  _loc3_[0] = LanguageMgr.GetTranslation("tank.consortia.myconsortia.frame.MyConsortiaUpgrade.CONSORTIASHOPGRADE.explainTxt");
                  _loc3_[1] = LanguageMgr.GetTranslation("tank.consortia.consortiashop.ConsortiaShopView.titleText") + (param2 + 1) + LanguageMgr.GetTranslation("grade");
                  _loc3_[2] = LanguageMgr.GetTranslation("consortia.upgrade") + (param2 + 1) * 2 + LanguageMgr.GetTranslation("grade");
                  if(getLevelData(param2 + 1))
                  {
                     _loc3_[3] = getLevelData(param2 + 1).ShopRiches + LanguageMgr.GetTranslation("consortia.Money") + checkRiches(getLevelData(param2 + 1).ShopRiches);
                  }
               }
               break;
            case 2:
               if(param2 >= 10)
               {
                  _loc3_[0] = LanguageMgr.GetTranslation("tank.consortia.myconsortia.frame.MyConsortiaUpgrade.store");
                  _loc3_[1] = LanguageMgr.GetTranslation("tank.consortia.myconsortia.frame.MyConsortiaUpgrade.null");
                  _loc3_[2] = LanguageMgr.GetTranslation("tank.consortia.myconsortia.frame.MyConsortiaUpgrade.null");
                  _loc3_[3] = LanguageMgr.GetTranslation("tank.consortia.myconsortia.frame.MyConsortiaUpgrade.null");
               }
               else
               {
                  _loc3_[0] = LanguageMgr.GetTranslation("tank.consortia.myconsortia.frame.MyConsortiaUpgrade.success") + param2 * 10 + "%";
                  _loc3_[1] = LanguageMgr.GetTranslation("tank.consortia.myconsortia.frame.MyConsortiaUpgrade.storeSuccess",param2 + 1,(param2 + 1) * 10 + "%");
                  _loc3_[2] = LanguageMgr.GetTranslation("tank.consortia.myconsortia.frame.MyConsortiaUpgrade.appealTxt",param2 + 1);
                  if(getLevelData(param2 + 1))
                  {
                     _loc3_[3] = getLevelData(param2 + 1).SmithRiches + LanguageMgr.GetTranslation("consortia.Money") + checkRiches(getLevelData(param2 + 1).SmithRiches);
                  }
               }
               break;
            case 3:
               if(param2 >= 10)
               {
                  _loc3_[0] = LanguageMgr.GetTranslation("tank.consortia.myconsortia.frame.MyConsortiaUpgrade.bank");
                  _loc3_[1] = LanguageMgr.GetTranslation("tank.consortia.myconsortia.frame.MyConsortiaUpgrade.null");
                  _loc3_[2] = LanguageMgr.GetTranslation("tank.consortia.myconsortia.frame.MyConsortiaUpgrade.null");
                  _loc3_[3] = LanguageMgr.GetTranslation("tank.consortia.myconsortia.frame.MyConsortiaUpgrade.null");
               }
               else
               {
                  _loc3_[0] = LanguageMgr.GetTranslation("tank.consortia.myconsortia.frame.MyConsortiaUpgrade.contentUpgrade",param2 * 10);
                  _loc3_[1] = LanguageMgr.GetTranslation("tank.consortia.myconsortia.frame.MyConsortiaUpgrade.contentSmith",param2 + 1,(param2 + 1) * 10);
                  _loc3_[2] = LanguageMgr.GetTranslation("tank.consortia.myconsortia.frame.MyConsortiaUpgrade.appealTxt",param2 + 1);
                  if(getLevelData(param2 + 1))
                  {
                     _loc3_[3] = getLevelData(param2 + 1).StoreRiches + LanguageMgr.GetTranslation("consortia.Money") + checkRiches(getLevelData(param2 + 1).StoreRiches);
                  }
               }
               break;
            case 4:
               if(param2 >= 10)
               {
                  _loc3_[0] = LanguageMgr.GetTranslation("tank.consortia.myconsortia.frame.MyConsortiaUpgrade.skill");
                  _loc3_[1] = LanguageMgr.GetTranslation("tank.consortia.myconsortia.frame.MyConsortiaUpgrade.null");
                  _loc3_[2] = LanguageMgr.GetTranslation("tank.consortia.myconsortia.frame.MyConsortiaUpgrade.null");
                  _loc3_[3] = LanguageMgr.GetTranslation("tank.consortia.myconsortia.frame.MyConsortiaUpgrade.null");
                  break;
               }
               _loc3_[0] = LanguageMgr.GetTranslation("tank.consortia.myconsortia.frame.MyConsortiaUpgrade.skill.explainTxt");
               _loc3_[1] = LanguageMgr.GetTranslation("tank.consortia.consortiashop.ConsortiaShopView.skill",param2 + 1);
               _loc3_[2] = LanguageMgr.GetTranslation("consortia.upgrade") + (param2 + 1) + LanguageMgr.GetTranslation("grade");
               if(getLevelData(param2 + 1))
               {
                  _loc3_[3] = getLevelData(param2 + 1).BufferRiches + LanguageMgr.GetTranslation("consortia.Money") + checkRiches(getLevelData(param2 + 1).BufferRiches);
                  break;
               }
               break;
         }
         return _loc3_;
      }
      
      public function checkConsortiaRichesForUpGrade(param1:int) : Boolean
      {
         var _loc3_:* = null;
         var _loc2_:int = PlayerManager.Instance.Self.consortiaInfo.Riches;
         switch(int(param1))
         {
            case 0:
               if(PlayerManager.Instance.Self.consortiaInfo.Level < 10)
               {
                  _loc3_ = getLevelData(PlayerManager.Instance.Self.consortiaInfo.Level + 1);
                  if(!_loc3_)
                  {
                     return false;
                  }
                  if(_loc2_ < _loc3_.Riches)
                  {
                     return false;
                  }
               }
               break;
            case 1:
               if(PlayerManager.Instance.Self.consortiaInfo.SmithLevel < 10)
               {
                  _loc3_ = getLevelData(PlayerManager.Instance.Self.consortiaInfo.SmithLevel + 1);
                  if(!_loc3_)
                  {
                     return false;
                  }
                  if(_loc2_ < _loc3_.SmithRiches)
                  {
                     return false;
                  }
               }
               break;
            case 2:
               if(PlayerManager.Instance.Self.consortiaInfo.ShopLevel < 5)
               {
                  _loc3_ = getLevelData(PlayerManager.Instance.Self.consortiaInfo.ShopLevel + 1);
                  if(!_loc3_)
                  {
                     return false;
                  }
                  if(_loc2_ < _loc3_.ShopRiches)
                  {
                     return false;
                  }
               }
               break;
            case 3:
               if(PlayerManager.Instance.Self.consortiaInfo.StoreLevel < 10)
               {
                  _loc3_ = getLevelData(PlayerManager.Instance.Self.consortiaInfo.StoreLevel + 1);
                  if(!_loc3_)
                  {
                     return false;
                  }
                  if(_loc2_ < _loc3_.StoreRiches)
                  {
                     return false;
                  }
               }
               break;
            case 4:
               if(PlayerManager.Instance.Self.consortiaInfo.BufferLevel < 10)
               {
                  _loc3_ = getLevelData(PlayerManager.Instance.Self.consortiaInfo.BufferLevel + 1);
                  if(!_loc3_)
                  {
                     return false;
                  }
                  if(_loc2_ < _loc3_.BufferRiches)
                  {
                     return false;
                  }
                  break;
               }
         }
         return true;
      }
      
      private function checkRiches(param1:int) : String
      {
         var _loc2_:String = "";
         if(PlayerManager.Instance.Self.consortiaInfo.Riches < param1)
         {
            _loc2_ = LanguageMgr.GetTranslation("tank.consortia.myconsortia.frame.MyConsortiaUpgrade.condition");
         }
         return _loc2_;
      }
      
      private function checkGold(param1:int) : String
      {
         var _loc2_:String = "";
         if(PlayerManager.Instance.Self.Gold < param1)
         {
            _loc2_ = LanguageMgr.GetTranslation("tank.consortia.myconsortia.frame.MyConsortiaUpgrade.condition");
         }
         return _loc2_;
      }
      
      public function set richRankList(param1:Array) : void
      {
         _richRankList = param1;
      }
      
      public function set weekReward(param1:DictionaryData) : void
      {
         _weekReward = param1;
      }
      
      public function get richRankList() : Array
      {
         return _richRankList;
      }
      
      public function get weekReward() : DictionaryData
      {
         return _weekReward;
      }
      
      public function get callBackModel() : CallBackModel
      {
         if(_callBackModel == null)
         {
            _callBackModel = new CallBackModel();
         }
         return _callBackModel;
      }
   }
}
