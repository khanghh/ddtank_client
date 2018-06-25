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
      
      public function ConsortionModel(target:IEventDispatcher = null)
      {
         activeTargetDic = new Dictionary(true);
         activeTargetStautsDic = new Dictionary(true);
         super(target);
      }
      
      public function get memberList() : DictionaryData
      {
         if(_memberList == null)
         {
            _memberList = new DictionaryData();
         }
         return _memberList;
      }
      
      public function set memberList(value:DictionaryData) : void
      {
         if(_memberList == value)
         {
            return;
         }
         _memberList = value;
         dispatchEvent(new ConsortionEvent("memberListLoadComplete"));
      }
      
      public function addMember(consortiaPlayerInfo:ConsortiaPlayerInfo) : void
      {
         _memberList.add(consortiaPlayerInfo.ID,consortiaPlayerInfo);
         dispatchEvent(new ConsortionEvent("addMember",consortiaPlayerInfo));
      }
      
      public function removeMember(consortiaPlayerInfo:ConsortiaPlayerInfo) : void
      {
         _memberList.remove(consortiaPlayerInfo.ID);
         dispatchEvent(new ConsortionEvent("removeMember",consortiaPlayerInfo));
      }
      
      public function updataMember(consortiaPlayerInfo:ConsortiaPlayerInfo) : void
      {
         _memberList.add(consortiaPlayerInfo.ID,consortiaPlayerInfo);
         dispatchEvent(new ConsortionEvent("memberUpdata",consortiaPlayerInfo));
      }
      
      public function get consortiaInfo() : Array
      {
         var temp:Array = [];
         var onlineTemp:Array = onlineConsortiaMemberList;
         var consortiaInfo:ConsortiaPlayerInfo = new ConsortiaPlayerInfo();
         consortiaInfo.type = 0;
         consortiaInfo.isSelected = true;
         consortiaInfo.RatifierName = LanguageMgr.GetTranslation("ddt.consortion.ratifierName") + " [" + onlineTemp.length + "/" + this.memberList.length + "]";
         temp.push(consortiaInfo);
         return temp;
      }
      
      public function get onlineConsortiaMemberList() : Array
      {
         var temp:Array = [];
         var _loc4_:int = 0;
         var _loc3_:* = memberList;
         for each(var i in memberList)
         {
            if(i.playerState.StateID != 0)
            {
               temp.push(i);
            }
         }
         return temp;
      }
      
      public function getConsortiaMemberInfo(id:int) : ConsortiaPlayerInfo
      {
         var _loc4_:int = 0;
         var _loc3_:* = memberList;
         for each(var i in memberList)
         {
            if(i.ID == id)
            {
               return i;
            }
         }
         return null;
      }
      
      public function get offlineConsortiaMemberList() : Array
      {
         var temp:Array = [];
         var _loc4_:int = 0;
         var _loc3_:* = memberList;
         for each(var i in memberList)
         {
            if(i.playerState.StateID == 0)
            {
               temp.push(i);
            }
         }
         return temp;
      }
      
      public function consortiaPlayerStateChange(id:int, state:int) : void
      {
         var playerState:* = null;
         var _clube_member_info:ConsortiaPlayerInfo = getConsortiaMemberInfo(id);
         if(_clube_member_info == null)
         {
            return;
         }
         if(_clube_member_info)
         {
            playerState = new PlayerState(state);
            _clube_member_info.playerState = playerState;
            updataMember(_clube_member_info);
         }
      }
      
      public function set consortionList(result:Vector.<ConsortiaInfo>) : void
      {
         if(_consortionList == result)
         {
            return;
         }
         _consortionList = result;
         dispatchEvent(new ConsortionEvent("consortionListIsChange"));
      }
      
      public function get consortionList() : Vector.<ConsortiaInfo>
      {
         return _consortionList;
      }
      
      public function set myApplyList(list:Vector.<ConsortiaApplyInfo>) : void
      {
         if(_myApplyList == list)
         {
            return;
         }
         _myApplyList = list;
         dispatchEvent(new ConsortionEvent("myApplyListIsChange"));
      }
      
      public function get myApplyList() : Vector.<ConsortiaApplyInfo>
      {
         return _myApplyList;
      }
      
      public function getapplyListWithPage(page:int, pageCount:int = 10) : Vector.<ConsortiaApplyInfo>
      {
         page = page < 0?1:page > Math.ceil(_myApplyList.length / pageCount)?Math.ceil(_myApplyList.length / pageCount):page;
         return myApplyList.slice((page - 1) * pageCount,page * pageCount);
      }
      
      public function deleteOneApplyRecord(id:int) : void
      {
         var i:int = 0;
         var len:int = myApplyList.length;
         for(i = 0; i < len; )
         {
            if(myApplyList[i].ID == id)
            {
               myApplyList.splice(i,1);
               dispatchEvent(new ConsortionEvent("myApplyListIsChange"));
               break;
            }
            i++;
         }
      }
      
      public function set inventList(list:Vector.<ConsortiaInventData>) : void
      {
         if(_inventList == list)
         {
            return;
         }
         _inventList = list;
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
      
      public function set eventList(value:Vector.<ConsortiaEventInfo>) : void
      {
         if(_eventList == value)
         {
            return;
         }
         _eventList = value;
         dispatchEvent(new ConsortionEvent("eventListChange"));
      }
      
      public function get useConditionList() : Vector.<ConsortiaAssetLevelOffer>
      {
         return _useConditionList;
      }
      
      public function set useConditionList(value:Vector.<ConsortiaAssetLevelOffer>) : void
      {
         if(_useConditionList == value)
         {
            return;
         }
         _useConditionList = value;
         ConsortionModelManager.Instance.model.dispatchEvent(new ConsortionEvent("useConditionChange"));
      }
      
      public function get dutyList() : Vector.<ConsortiaDutyInfo>
      {
         return _dutyList;
      }
      
      public function set dutyList(value:Vector.<ConsortiaDutyInfo>) : void
      {
         if(_dutyList == value)
         {
            return;
         }
         _dutyList = value;
         dispatchEvent(new ConsortionEvent("dutyListChange"));
      }
      
      public function changeDutyListName(dutyId:int, name:String) : void
      {
         var i:int = 0;
         for(i = 0; i < _dutyList.length; )
         {
            if(_dutyList[i].DutyID == dutyId)
            {
               _dutyList[i].DutyName = name;
               break;
            }
            i++;
         }
      }
      
      public function get pollList() : Vector.<ConsortionPollInfo>
      {
         return _pollList;
      }
      
      public function set pollList(value:Vector.<ConsortionPollInfo>) : void
      {
         if(_pollList == value)
         {
            return;
         }
         _pollList = value;
         dispatchEvent(new ConsortionEvent("pollListChange"));
      }
      
      public function get skillInfoList() : Vector.<ConsortionSkillInfo>
      {
         return _skillInfoList;
      }
      
      public function set skillInfoList(value:Vector.<ConsortionSkillInfo>) : void
      {
         if(_skillInfoList == value)
         {
            return;
         }
         _skillInfoList = value;
         dispatchEvent(new ConsortionEvent("skillListChange"));
      }
      
      public function getskillInfoWithTypeAndLevel(type:int, level:int) : Vector.<ConsortionSkillInfo>
      {
         var i:int = 0;
         var vec:Vector.<ConsortionSkillInfo> = new Vector.<ConsortionSkillInfo>();
         var len:int = skillInfoList.length;
         for(i = 0; i < len; )
         {
            if(skillInfoList[i].type == type && skillInfoList[i].level == level)
            {
               vec.push(skillInfoList[i]);
            }
            i++;
         }
         return vec;
      }
      
      public function getSkillInfoByID(id:int) : ConsortionSkillInfo
      {
         var vec:* = null;
         var i:int = 0;
         for(i = 0; i < skillInfoList.length; )
         {
            if(skillInfoList[i].id == id)
            {
               vec = skillInfoList[i];
            }
            i++;
         }
         return vec;
      }
      
      public function updateSkillInfo(id:int, isopen:Boolean, beginDate:Date, validDate:int) : void
      {
         var i:int = 0;
         var len:int = skillInfoList.length;
         for(i = 0; i < len; )
         {
            if(skillInfoList[i].id == id)
            {
               skillInfoList[i].isOpen = isopen;
               skillInfoList[i].beginDate = beginDate;
               skillInfoList[i].validDate = validDate;
               break;
            }
            i++;
         }
      }
      
      public function hasSomeGroupSkill(group:int, id:int) : Boolean
      {
         var i:int = 0;
         var len:int = skillInfoList.length;
         for(i = 0; i < len; )
         {
            if(skillInfoList[i].group == group && skillInfoList[i].isOpen && skillInfoList[i].id != id)
            {
               return true;
            }
            i++;
         }
         return false;
      }
      
      public function set levelUpData(value:Vector.<ConsortiaLevelInfo>) : void
      {
         if(_levelUpData == value)
         {
            return;
         }
         _levelUpData = value;
         dispatchEvent(new ConsortionEvent("levelUpRuleChange"));
      }
      
      public function get levelUpData() : Vector.<ConsortiaLevelInfo>
      {
         return _levelUpData;
      }
      
      public function getLevelData(level:int) : ConsortiaLevelInfo
      {
         var i:* = 0;
         if(levelUpData == null)
         {
            return null;
         }
         i = uint(0);
         while(i < levelUpData.length)
         {
            if(levelUpData[i]["Level"] == level)
            {
               return levelUpData[i];
            }
            i++;
         }
         return null;
      }
      
      public function getLevelString(type:int, level:int) : Vector.<String>
      {
         var result:Vector.<String> = new Vector.<String>(4);
         switch(int(type))
         {
            case 0:
               if(level >= 10)
               {
                  result[0] = LanguageMgr.GetTranslation("tank.consortia.myconsortia.frame.MyConsortiaUpgrade.explainTxt",getLevelData(level).Count);
                  result[1] = LanguageMgr.GetTranslation("tank.consortia.myconsortia.frame.MyConsortiaUpgrade.null");
                  result[3] = LanguageMgr.GetTranslation("tank.consortia.myconsortia.frame.MyConsortiaUpgrade.null");
               }
               else
               {
                  result[0] = LanguageMgr.GetTranslation("tank.consortia.myconsortia.frame.MyConsortiaUpgrade.upgrade",getLevelData(level).Count);
                  result[1] = LanguageMgr.GetTranslation("tank.consortia.myconsortia.frame.MyConsortiaUpgrade.nextLevel",level + 1,getLevelData(level + 1).Count);
                  result[3] = LanguageMgr.GetTranslation("tank.consortia.myconsortia.frame.MyConsortiaUpgrade.consumeTxt",String(getLevelData(level + 1).Riches),checkRiches(getLevelData(level + 1).Riches),getLevelData(level + 1).NeedGold) + checkGold(getLevelData(level + 1).NeedGold);
               }
               result[2] = LanguageMgr.GetTranslation("tank.consortia.myconsortia.frame.MyConsortiaUpgrade.null");
               break;
            case 1:
               if(level >= 5)
               {
                  result[0] = LanguageMgr.GetTranslation("tank.consortia.myconsortia.frame.MyConsortiaUpgrade.consortiaShopLevel");
                  result[1] = LanguageMgr.GetTranslation("tank.consortia.myconsortia.frame.MyConsortiaUpgrade.null");
                  result[2] = LanguageMgr.GetTranslation("tank.consortia.myconsortia.frame.MyConsortiaUpgrade.null");
                  result[3] = LanguageMgr.GetTranslation("tank.consortia.myconsortia.frame.MyConsortiaUpgrade.null");
               }
               else
               {
                  result[0] = LanguageMgr.GetTranslation("tank.consortia.myconsortia.frame.MyConsortiaUpgrade.CONSORTIASHOPGRADE.explainTxt");
                  result[1] = LanguageMgr.GetTranslation("tank.consortia.consortiashop.ConsortiaShopView.titleText") + (level + 1) + LanguageMgr.GetTranslation("grade");
                  result[2] = LanguageMgr.GetTranslation("consortia.upgrade") + (level + 1) * 2 + LanguageMgr.GetTranslation("grade");
                  if(getLevelData(level + 1))
                  {
                     result[3] = getLevelData(level + 1).ShopRiches + LanguageMgr.GetTranslation("consortia.Money") + checkRiches(getLevelData(level + 1).ShopRiches);
                  }
               }
               break;
            case 2:
               if(level >= 10)
               {
                  result[0] = LanguageMgr.GetTranslation("tank.consortia.myconsortia.frame.MyConsortiaUpgrade.store");
                  result[1] = LanguageMgr.GetTranslation("tank.consortia.myconsortia.frame.MyConsortiaUpgrade.null");
                  result[2] = LanguageMgr.GetTranslation("tank.consortia.myconsortia.frame.MyConsortiaUpgrade.null");
                  result[3] = LanguageMgr.GetTranslation("tank.consortia.myconsortia.frame.MyConsortiaUpgrade.null");
               }
               else
               {
                  result[0] = LanguageMgr.GetTranslation("tank.consortia.myconsortia.frame.MyConsortiaUpgrade.success") + level * 10 + "%";
                  result[1] = LanguageMgr.GetTranslation("tank.consortia.myconsortia.frame.MyConsortiaUpgrade.storeSuccess",level + 1,(level + 1) * 10 + "%");
                  result[2] = LanguageMgr.GetTranslation("tank.consortia.myconsortia.frame.MyConsortiaUpgrade.appealTxt",level + 1);
                  if(getLevelData(level + 1))
                  {
                     result[3] = getLevelData(level + 1).SmithRiches + LanguageMgr.GetTranslation("consortia.Money") + checkRiches(getLevelData(level + 1).SmithRiches);
                  }
               }
               break;
            case 3:
               if(level >= 10)
               {
                  result[0] = LanguageMgr.GetTranslation("tank.consortia.myconsortia.frame.MyConsortiaUpgrade.bank");
                  result[1] = LanguageMgr.GetTranslation("tank.consortia.myconsortia.frame.MyConsortiaUpgrade.null");
                  result[2] = LanguageMgr.GetTranslation("tank.consortia.myconsortia.frame.MyConsortiaUpgrade.null");
                  result[3] = LanguageMgr.GetTranslation("tank.consortia.myconsortia.frame.MyConsortiaUpgrade.null");
               }
               else
               {
                  result[0] = LanguageMgr.GetTranslation("tank.consortia.myconsortia.frame.MyConsortiaUpgrade.contentUpgrade",level * 10);
                  result[1] = LanguageMgr.GetTranslation("tank.consortia.myconsortia.frame.MyConsortiaUpgrade.contentSmith",level + 1,(level + 1) * 10);
                  result[2] = LanguageMgr.GetTranslation("tank.consortia.myconsortia.frame.MyConsortiaUpgrade.appealTxt",level + 1);
                  if(getLevelData(level + 1))
                  {
                     result[3] = getLevelData(level + 1).StoreRiches + LanguageMgr.GetTranslation("consortia.Money") + checkRiches(getLevelData(level + 1).StoreRiches);
                  }
               }
               break;
            case 4:
               if(level >= 10)
               {
                  result[0] = LanguageMgr.GetTranslation("tank.consortia.myconsortia.frame.MyConsortiaUpgrade.skill");
                  result[1] = LanguageMgr.GetTranslation("tank.consortia.myconsortia.frame.MyConsortiaUpgrade.null");
                  result[2] = LanguageMgr.GetTranslation("tank.consortia.myconsortia.frame.MyConsortiaUpgrade.null");
                  result[3] = LanguageMgr.GetTranslation("tank.consortia.myconsortia.frame.MyConsortiaUpgrade.null");
                  break;
               }
               result[0] = LanguageMgr.GetTranslation("tank.consortia.myconsortia.frame.MyConsortiaUpgrade.skill.explainTxt");
               result[1] = LanguageMgr.GetTranslation("tank.consortia.consortiashop.ConsortiaShopView.skill",level + 1);
               result[2] = LanguageMgr.GetTranslation("consortia.upgrade") + (level + 1) + LanguageMgr.GetTranslation("grade");
               if(getLevelData(level + 1))
               {
                  result[3] = getLevelData(level + 1).BufferRiches + LanguageMgr.GetTranslation("consortia.Money") + checkRiches(getLevelData(level + 1).BufferRiches);
                  break;
               }
               break;
         }
         return result;
      }
      
      public function checkConsortiaRichesForUpGrade(type:int) : Boolean
      {
         var consortiaLevelInfo:* = null;
         var riches:int = PlayerManager.Instance.Self.consortiaInfo.Riches;
         switch(int(type))
         {
            case 0:
               if(PlayerManager.Instance.Self.consortiaInfo.Level < 10)
               {
                  consortiaLevelInfo = getLevelData(PlayerManager.Instance.Self.consortiaInfo.Level + 1);
                  if(!consortiaLevelInfo)
                  {
                     return false;
                  }
                  if(riches < consortiaLevelInfo.Riches)
                  {
                     return false;
                  }
               }
               break;
            case 1:
               if(PlayerManager.Instance.Self.consortiaInfo.SmithLevel < 10)
               {
                  consortiaLevelInfo = getLevelData(PlayerManager.Instance.Self.consortiaInfo.SmithLevel + 1);
                  if(!consortiaLevelInfo)
                  {
                     return false;
                  }
                  if(riches < consortiaLevelInfo.SmithRiches)
                  {
                     return false;
                  }
               }
               break;
            case 2:
               if(PlayerManager.Instance.Self.consortiaInfo.ShopLevel < 5)
               {
                  consortiaLevelInfo = getLevelData(PlayerManager.Instance.Self.consortiaInfo.ShopLevel + 1);
                  if(!consortiaLevelInfo)
                  {
                     return false;
                  }
                  if(riches < consortiaLevelInfo.ShopRiches)
                  {
                     return false;
                  }
               }
               break;
            case 3:
               if(PlayerManager.Instance.Self.consortiaInfo.StoreLevel < 10)
               {
                  consortiaLevelInfo = getLevelData(PlayerManager.Instance.Self.consortiaInfo.StoreLevel + 1);
                  if(!consortiaLevelInfo)
                  {
                     return false;
                  }
                  if(riches < consortiaLevelInfo.StoreRiches)
                  {
                     return false;
                  }
               }
               break;
            case 4:
               if(PlayerManager.Instance.Self.consortiaInfo.BufferLevel < 10)
               {
                  consortiaLevelInfo = getLevelData(PlayerManager.Instance.Self.consortiaInfo.BufferLevel + 1);
                  if(!consortiaLevelInfo)
                  {
                     return false;
                  }
                  if(riches < consortiaLevelInfo.BufferRiches)
                  {
                     return false;
                  }
               }
         }
         return true;
      }
      
      private function checkRiches($riches:int) : String
      {
         var result:String = "";
         if(PlayerManager.Instance.Self.consortiaInfo.Riches < $riches)
         {
            result = LanguageMgr.GetTranslation("tank.consortia.myconsortia.frame.MyConsortiaUpgrade.condition");
         }
         return result;
      }
      
      private function checkGold($gold:int) : String
      {
         var result:String = "";
         if(PlayerManager.Instance.Self.Gold < $gold)
         {
            result = LanguageMgr.GetTranslation("tank.consortia.myconsortia.frame.MyConsortiaUpgrade.condition");
         }
         return result;
      }
      
      public function set richRankList(value:Array) : void
      {
         _richRankList = value;
      }
      
      public function set weekReward(value:DictionaryData) : void
      {
         _weekReward = value;
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
