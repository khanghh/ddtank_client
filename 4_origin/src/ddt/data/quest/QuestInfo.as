package ddt.data.quest
{
   import com.pickgliss.ui.controls.cell.INotSameHeightListCellData;
   import com.pickgliss.utils.StringUtils;
   import consortion.ConsortionModelManager;
   import dayActivity.DayActivityManager;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.player.SelfInfo;
   import ddt.manager.FineSuitManager;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PathManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.TimeManager;
   import hall.gameVIP.Game360VIP;
   import horse.HorseManager;
   import newOldPlayer.NewOldPlayerManager;
   import pet.data.PetInfo;
   import petsBag.PetsBagManager;
   import quest.TaskManager;
   import quest.TrusteeshipManager;
   import road7th.data.DictionaryData;
   import road7th.utils.DateUtils;
   import totem.TotemManager;
   
   public class QuestInfo implements INotSameHeightListCellData
   {
      
      public static const PET:int = 0;
       
      
      public var QuestID:int;
      
      public var data:QuestDataInfo;
      
      public var Detail:String;
      
      public var Objective:String;
      
      public var otherCondition:int;
      
      public var Level:int;
      
      public var NeedMinLevel:int;
      
      public var NeedMaxLevel:int;
      
      public var required:Boolean = false;
      
      public var Type:int;
      
      public var PreQuestID:String;
      
      public var NextQuestID:String;
      
      public var CanRepeat:Boolean;
      
      public var RepeatInterval:int;
      
      public var RepeatMax:int;
      
      public var Title:String;
      
      public var disabled:Boolean = false;
      
      public var optionalConditionNeed:uint = 0;
      
      private var _conditions:Array;
      
      private var _itemRewards:Array;
      
      public var StrengthenLevel:int;
      
      public var FinishCount:int;
      
      public var ReqItemID:int;
      
      public var ReqKillLevel:int;
      
      public var ReqBeCaption:Boolean;
      
      public var ReqMap:int;
      
      public var ReqFightMode:int;
      
      public var ReqTimeMode:int;
      
      public var RewardGold:int;
      
      public var RewardMoney:int;
      
      public var RewardGP:int;
      
      public var OneKeyFinishNeedMoney:int;
      
      public var TrusteeshipCost:int;
      
      public var TrusteeshipNeedTime:int;
      
      public var RewardOffer:int;
      
      public var RewardRiches:int;
      
      public var RewardBindMoney:int;
      
      public var RewardBuffID:int;
      
      public var RewardBuffDate:int;
      
      public var Rank:String;
      
      public var Level2NeedMoney:int;
      
      public var Level3NeedMoney:int;
      
      public var Level4NeedMoney:int;
      
      public var Level5NeedMoney:int;
      
      public var MapID:int;
      
      public var AutoEquip:Boolean;
      
      public var StarLev:int;
      
      private var _questLevel:int;
      
      public var TimeLimit:Boolean;
      
      public var StartDate:Date;
      
      public var EndDate:Date;
      
      public var BuffID:int;
      
      public var BuffValidDate:int;
      
      public var isManuGet:Boolean;
      
      private var _isPhoneTask:Boolean;
      
      private var _cellHeight:Number = 0;
      
      public function QuestInfo()
      {
         super();
      }
      
      public static function createFromXML(xml:XML) : QuestInfo
      {
         var i:int = 0;
         var tempCondXML:* = null;
         var tempCondition:* = null;
         var j:int = 0;
         var tempItemXML:* = null;
         var countAryy:* = null;
         var tempReward:* = null;
         var q:QuestInfo = new QuestInfo();
         q.QuestID = xml.@ID;
         q.Type = xml.@QuestID;
         q.Detail = xml.@Detail;
         q.Title = xml.@Title;
         q.Objective = xml.@Objective;
         q.StarLev = xml.@StarLev;
         q.QuestLevel = xml.@QuestLevel;
         q.NeedMinLevel = xml.@NeedMinLevel;
         q.NeedMaxLevel = xml.@NeedMaxLevel;
         q.PreQuestID = xml.@PreQuestID;
         q.NextQuestID = xml.@NextQuestID;
         q.CanRepeat = xml.@CanRepeat == "true"?true:false;
         q.RepeatInterval = xml.@RepeatInterval;
         q.RepeatMax = xml.@RepeatMax;
         q.RewardGold = xml.@RewardGold;
         q.RewardGP = xml.@RewardGP;
         q.RewardMoney = xml.@RewardMoney;
         q.OneKeyFinishNeedMoney = xml.@OneKeyFinishNeedMoney;
         q.TrusteeshipCost = xml.@CollocationCost;
         q.TrusteeshipNeedTime = xml.@CollocationColdTime;
         q.Rank = xml.@Rank;
         q.RewardOffer = xml.@RewardOffer;
         q.RewardRiches = xml.@RewardRiches;
         q.RewardBindMoney = xml.@RewardBindMoney;
         q.TimeLimit = xml.@TimeMode;
         q.RewardBuffID = xml.@RewardBuffID;
         q.RewardBuffDate = xml.@RewardBuffDate;
         q.Level2NeedMoney = xml.@Level2NeedMoney;
         q.Level3NeedMoney = xml.@Level3NeedMoney;
         q.Level4NeedMoney = xml.@Level4NeedMoney;
         q.Level5NeedMoney = xml.@Level5NeedMoney;
         q.otherCondition = xml.@IsOther;
         q.StartDate = DateUtils.decodeDated(String(xml.@StartDate));
         q.EndDate = DateUtils.decodeDated(String(xml.@EndDate));
         q.MapID = xml.@MapID;
         q.AutoEquip = StringUtils.converBoolean(xml.@AutoEquip);
         q.optionalConditionNeed = xml.@NotMustCount;
         q.isManuGet = xml.@IsAccept == "true"?true:false;
         var conditions:XMLList = xml..Item_Condiction;
         for(i = 0; i < conditions.length(); q.addCondition(tempCondition),i++)
         {
            tempCondXML = conditions[i];
            tempCondition = new QuestCondition(q.QuestID,tempCondXML.@CondictionID,tempCondXML.@CondictionType,tempCondXML.@CondictionTitle,tempCondXML.@Para1,tempCondXML.@Para2,tempCondXML.@Turn);
            if(tempCondXML.@isOpitional == "true")
            {
               tempCondition.isOpitional = true;
            }
            else
            {
               tempCondition.isOpitional = false;
            }
            var _loc12_:* = tempCondition.type;
            if(1 !== _loc12_)
            {
               if(2 !== _loc12_)
               {
                  if(14 !== _loc12_)
                  {
                     if(15 !== _loc12_)
                     {
                        if(99 !== _loc12_)
                        {
                           if(18 !== _loc12_)
                           {
                              if(20 === _loc12_)
                              {
                                 switch(int(tempCondition.param) - 1)
                                 {
                                    case 0:
                                       if(!q.isTimeOut())
                                       {
                                          TaskManager.instance.addDesktopListener(tempCondition);
                                       }
                                       break;
                                    case 1:
                                       TaskManager.instance.addAnnexListener(tempCondition);
                                       break;
                                    case 2:
                                       TaskManager.instance.addFriendListener(tempCondition);
                                    default:
                                       TaskManager.instance.addFriendListener(tempCondition);
                                 }
                              }
                           }
                           continue;
                        }
                     }
                     addr307:
                     TaskManager.instance.addItemListener(tempCondition.param);
                     continue;
                  }
                  addr306:
                  §§goto(addr307);
               }
               §§goto(addr306);
            }
            else
            {
               TaskManager.instance.addGradeListener();
               continue;
            }
         }
         q.checkIsPhoneTask();
         var rewards:XMLList = xml..Item_Good;
         for(j = 0; j < rewards.length(); )
         {
            tempItemXML = rewards[j];
            countAryy = new Array(int(tempItemXML.@RewardItemCount1),int(tempItemXML.@RewardItemCount2),int(tempItemXML.@RewardItemCount3),int(tempItemXML.@RewardItemCount4),int(tempItemXML.@RewardItemCount5));
            tempReward = new QuestItemReward(tempItemXML.@RewardItemID,countAryy,tempItemXML.@IsSelect,tempItemXML.@IsBind);
            tempReward.time = tempItemXML.@RewardItemValid;
            tempReward.AttackCompose = tempItemXML.@AttackCompose;
            tempReward.DefendCompose = tempItemXML.@DefendCompose;
            tempReward.AgilityCompose = tempItemXML.@AgilityCompose;
            tempReward.LuckCompose = tempItemXML.@LuckCompose;
            tempReward.StrengthenLevel = tempItemXML.@StrengthenLevel;
            tempReward.IsCount = tempItemXML.@IsCount;
            tempReward.MagicAttack = tempItemXML.@MagicAttack;
            tempReward.MagicDefence = tempItemXML.@MagicDefence;
            q.addReward(tempReward);
            j++;
         }
         return q;
      }
      
      public function get QuestLevel() : int
      {
         return _questLevel;
      }
      
      public function set QuestLevel(value:int) : void
      {
         if(value < 1)
         {
            value = 1;
         }
         if(value > 5)
         {
            value = 5;
         }
         _questLevel = value;
      }
      
      public function get RewardItemCount() : int
      {
         return this._itemRewards[0].count;
      }
      
      public function get RewardItemValidate() : int
      {
         return this._itemRewards[0].count;
      }
      
      public function get itemRewards() : Array
      {
         return _itemRewards;
      }
      
      public function get Id() : int
      {
         return QuestID;
      }
      
      public function get hadChecked() : Boolean
      {
         if(data && data.hadChecked)
         {
            return true;
         }
         return false;
      }
      
      public function set hadChecked(value:Boolean) : void
      {
         if(data)
         {
            data.hadChecked = value;
         }
      }
      
      public function BuffName() : String
      {
         return ItemManager.Instance.getTemplateById(this.BuffID).Name;
      }
      
      public function addCondition(condition:QuestCondition) : void
      {
         if(!conditions)
         {
            conditions = [];
         }
         conditions.push(condition);
      }
      
      public function addReward(reward:QuestItemReward) : void
      {
         if(!_itemRewards)
         {
            _itemRewards = [];
         }
         _itemRewards.push(reward);
      }
      
      public function texpTaskIsTimeOut() : Boolean
      {
         if(Type > 100 && PlayerManager.Instance.Self.texpTaskDate)
         {
            return TimeManager.Instance.Now().getDate() != PlayerManager.Instance.Self.texpTaskDate.getDate();
         }
         return false;
      }
      
      public function isTimeOut() : Boolean
      {
         if(Id == 538 && PathManager.solveClientDownloadPath() == "")
         {
            return true;
         }
         var now:Date = TimeManager.Instance.Now();
         var nt:Date = new Date(1990,1,1,now.getHours(),now.getMinutes(),now.getSeconds());
         var startTime:Date = new Date(1990,1,1,StartDate.getHours(),StartDate.getMinutes(),StartDate.getSeconds());
         var endTime:Date = new Date(1990,1,1,EndDate.getHours(),EndDate.getMinutes(),EndDate.getSeconds());
         if(now.time > EndDate.time || now.time < StartDate.time)
         {
            return true;
         }
         return false;
      }
      
      public function get id() : int
      {
         return QuestID;
      }
      
      public function get Condition() : int
      {
         return conditions[0].type;
      }
      
      public function get ConditionTurn() : int
      {
         return conditions[0].turnType;
      }
      
      public function get RewardItemID() : int
      {
         return _itemRewards[0].itemID;
      }
      
      public function get RewardItemValidateTime() : int
      {
         return _itemRewards[0].time;
      }
      
      public function isAvailableFor(self:SelfInfo) : Boolean
      {
         return false;
      }
      
      public function get isAvailable() : Boolean
      {
         if(!isAchieved)
         {
            return true;
         }
         if(!CanRepeat)
         {
            return false;
         }
         if(TimeManager.Instance.TotalDaysToNow2(data.CompleteDate) < RepeatInterval)
         {
            if(data.repeatLeft < 1 && !data.isExist)
            {
               return false;
            }
         }
         return true;
      }
      
      public function get isAchieved() : Boolean
      {
         if(NewOldPlayerManager.instance.isQuestFinished(id))
         {
            return true;
         }
         if(!data || !data.isAchieved)
         {
            return false;
         }
         return true;
      }
      
      private function getProgressById(id:uint) : uint
      {
         var tempItem:* = null;
         var equips:* = null;
         var storeBag:* = null;
         var count1:int = 0;
         var count2:int = 0;
         var maxGrade:int = 0;
         var needGrade:int = 0;
         var Count3:int = 0;
         var Count4:int = 0;
         var curLv:int = 0;
         var j:int = 0;
         var equips3:* = null;
         var storeBag3:* = null;
         var magicCount1:int = 0;
         var magicCount2:int = 0;
         var magicCount3:int = 0;
         var magicCount4:int = 0;
         var magicCount5:int = 0;
         var magicCount6:int = 0;
         var dd:* = null;
         var autoComplete:Boolean = getIsAutoComplete(id);
         if(autoComplete)
         {
            return 0;
         }
         var self:SelfInfo = PlayerManager.Instance.Self;
         var cond:QuestCondition = getConditionById(id);
         var prog:* = 0;
         if(data == null || data.progress[id] == null)
         {
            prog = 0;
         }
         else
         {
            prog = int(data.progress[id]);
         }
         var _loc32_:* = cond.type;
         if(1 !== _loc32_)
         {
            if(2 !== _loc32_)
            {
               if(9 !== _loc32_)
               {
                  if(14 !== _loc32_)
                  {
                     if(15 !== _loc32_)
                     {
                        if(16 !== _loc32_)
                        {
                           if(17 !== _loc32_)
                           {
                              if(18 !== _loc32_)
                              {
                                 if(20 !== _loc32_)
                                 {
                                    if(21 !== _loc32_)
                                    {
                                       if(69 !== _loc32_)
                                       {
                                          if(72 !== _loc32_)
                                          {
                                             if(79 !== _loc32_)
                                             {
                                                if(99 !== _loc32_)
                                                {
                                                   if(80 !== _loc32_)
                                                   {
                                                      if(92 !== _loc32_)
                                                      {
                                                         if(203 !== _loc32_)
                                                         {
                                                            if(204 !== _loc32_)
                                                            {
                                                               if(205 !== _loc32_)
                                                               {
                                                                  if(209 !== _loc32_)
                                                                  {
                                                                     if(208 !== _loc32_)
                                                                     {
                                                                        if(data == null || data.progress[id] == null)
                                                                        {
                                                                           prog = 0;
                                                                        }
                                                                        else
                                                                        {
                                                                           prog = int(data.progress[id]);
                                                                        }
                                                                     }
                                                                     else
                                                                     {
                                                                        prog = 0;
                                                                        prog = int(cond.target - 1);
                                                                        if(data && data.progress[id] <= cond.target && data.progress[id] > 0)
                                                                        {
                                                                           prog = int(cond.target);
                                                                        }
                                                                     }
                                                                  }
                                                                  else
                                                                  {
                                                                     dd = PlayerManager.Instance.Self.pets;
                                                                     var _loc40_:int = 0;
                                                                     var _loc39_:* = dd;
                                                                     for each(var pInfo2 in dd)
                                                                     {
                                                                        if(pInfo2.StarLevel >= cond.param)
                                                                        {
                                                                           prog = int(cond.target);
                                                                           break;
                                                                        }
                                                                     }
                                                                  }
                                                               }
                                                               else if(cond.param == 0)
                                                               {
                                                                  magicCount1 = self.getBag(41).getItemCountByTemplateId(100901,false);
                                                                  magicCount2 = self.getBag(41).getItemCountByTemplateId(100902,false);
                                                                  magicCount3 = self.getBag(41).getItemCountByTemplateId(100903,false);
                                                                  magicCount4 = self.getBag(41).getItemCountByTemplateId(100904,false);
                                                                  magicCount5 = self.getBag(41).getItemCountByTemplateId(100905,false);
                                                                  magicCount6 = self.getBag(41).getItemCountByTemplateId(100906,false);
                                                                  prog = int(magicCount1 + magicCount2 + magicCount3 + magicCount4 + magicCount5 + magicCount6);
                                                               }
                                                            }
                                                            else if(cond.param == 0)
                                                            {
                                                               prog = int(self.evolutionGrade);
                                                            }
                                                         }
                                                         else if(cond.param == 0)
                                                         {
                                                            for(j = 8; j < 10; )
                                                            {
                                                               equips3 = self.getBag(0).findItems(j);
                                                               storeBag3 = self.getBag(12).findItems(j);
                                                               var _loc36_:int = 0;
                                                               var _loc35_:* = equips3;
                                                               for each(var item3 in equips3)
                                                               {
                                                                  if(item3.MagicLevel >= cond.target)
                                                                  {
                                                                     prog = int(cond.target);
                                                                     break;
                                                                  }
                                                               }
                                                               var _loc38_:int = 0;
                                                               var _loc37_:* = storeBag3;
                                                               for each(var storeItem3 in storeBag3)
                                                               {
                                                                  if(storeItem3.MagicLevel >= cond.target)
                                                                  {
                                                                     prog = int(cond.target);
                                                                     break;
                                                                  }
                                                               }
                                                               j++;
                                                            }
                                                         }
                                                      }
                                                      else if(data && cond.param == 0)
                                                      {
                                                         curLv = TotemManager.instance.getTotemPointLevel(PlayerManager.Instance.Self.totemId);
                                                         prog = curLv;
                                                      }
                                                   }
                                                   else if(cond.param == 0)
                                                   {
                                                      prog = int(FineSuitManager.Instance.getNextSuitVoByExp(PlayerManager.Instance.Self.fineSuitExp).level - 1);
                                                   }
                                                }
                                                else
                                                {
                                                   Count3 = self.getBag(0).getBagItemCountByTemplateId(cond.param,false);
                                                   Count4 = self.getBag(1).getBagItemCountByTemplateId(cond.param,false);
                                                   prog = int(Count3 + Count4);
                                                }
                                             }
                                             else
                                             {
                                                maxGrade = PetsBagManager.instance().curMaxBreakGrade();
                                                needGrade = cond.param;
                                                prog = int(maxGrade >= needGrade?0:-1);
                                             }
                                          }
                                          else if(DayActivityManager.Instance.activityValue >= cond.target)
                                          {
                                             prog = int(cond.target);
                                          }
                                          else
                                          {
                                             prog = int(DayActivityManager.Instance.activityValue);
                                          }
                                       }
                                       else if(HorseManager.instance.curLevel >= cond.param)
                                       {
                                          prog = 0;
                                       }
                                       else
                                       {
                                          prog = int(cond.target - 1);
                                       }
                                    }
                                    else
                                    {
                                       prog = int(cond.target - 1);
                                       if(data && data.progress[id] < cond.target && data.progress[id] >= 0)
                                       {
                                          prog = int(cond.target);
                                       }
                                    }
                                 }
                                 else
                                 {
                                    if(data)
                                    {
                                       prog = int(cond.target - data.progress[id]);
                                    }
                                    if(cond.param == 3)
                                    {
                                       prog = int(PlayerManager.Instance.friendList.length);
                                    }
                                 }
                              }
                              else
                              {
                                 switch(int(cond.param))
                                 {
                                    case 0:
                                       if(ConsortionModelManager.Instance.model.memberList.length > 0)
                                       {
                                          prog = int(ConsortionModelManager.Instance.model.memberList.length);
                                       }
                                       break;
                                    case 1:
                                       if(PlayerManager.Instance.Self.UseOffer)
                                       {
                                          prog = int(PlayerManager.Instance.Self.UseOffer);
                                       }
                                       break;
                                    case 2:
                                       if(PlayerManager.Instance.Self.consortiaInfo.SmithLevel)
                                       {
                                          prog = int(PlayerManager.Instance.Self.consortiaInfo.SmithLevel);
                                       }
                                       break;
                                    case 3:
                                       if(PlayerManager.Instance.Self.consortiaInfo.ShopLevel)
                                       {
                                          prog = int(PlayerManager.Instance.Self.consortiaInfo.ShopLevel);
                                       }
                                       break;
                                    case 4:
                                       if(PlayerManager.Instance.Self.consortiaInfo.StoreLevel)
                                       {
                                          prog = int(PlayerManager.Instance.Self.consortiaInfo.StoreLevel);
                                          break;
                                       }
                                 }
                              }
                           }
                           else
                           {
                              prog = int(!!self.IsMarried?1:0);
                           }
                        }
                        else
                        {
                           prog = 1;
                        }
                     }
                  }
                  if(prog < cond.target)
                  {
                     count1 = self.getBag(0).getItemCountByTemplateId(cond.param,false);
                     count2 = self.getBag(1).getItemCountByTemplateId(cond.param,false);
                     prog = int(count1 + count2);
                  }
               }
               else
               {
                  prog = 0;
                  equips = self.getBag(0).findItemsForEach(cond.param);
                  storeBag = self.getBag(12).findItemsForEach(cond.param);
                  _loc32_ = 0;
                  var _loc31_:* = equips;
                  for each(var item in equips)
                  {
                     if(item.StrengthenLevel >= cond.target)
                     {
                        prog = int(cond.target);
                        break;
                     }
                  }
                  var _loc34_:int = 0;
                  var _loc33_:* = storeBag;
                  for each(var storeItem in storeBag)
                  {
                     if(storeItem.StrengthenLevel >= cond.target)
                     {
                        prog = int(cond.target);
                        break;
                     }
                  }
               }
            }
            else
            {
               prog = 0;
               tempItem = self.getBag(0).findEquipedItemByTemplateId(cond.param,false);
               if(tempItem && tempItem.Place <= 30)
               {
                  prog = 1;
               }
            }
         }
         else
         {
            prog = int(self.Grade);
         }
         if(prog > cond.target)
         {
            return 0;
         }
         return cond.target - prog;
      }
      
      public function get progress() : Array
      {
         var i:int = 0;
         if(!conditions)
         {
            conditions = [];
         }
         var tempArr:Array = [];
         i = 0;
         while(conditions[i])
         {
            tempArr[i] = getProgressById(i);
            i++;
         }
         return tempArr;
      }
      
      public function get conditionStatusBoolean() : Array
      {
         var i:int = 0;
         var pro:int = 0;
         if(!conditions)
         {
            conditions = [];
         }
         var tempArr:Array = [];
         i = 0;
         while(conditions[i])
         {
            pro = progress[i];
            if(pro <= 0 || isCompleted)
            {
               tempArr[i] = true;
            }
            else
            {
               tempArr[i] = false;
            }
            i++;
         }
         return tempArr;
      }
      
      public function get conditionStatus() : Array
      {
         var i:int = 0;
         var pro:int = 0;
         if(!conditions)
         {
            conditions = [];
         }
         var tempArr:Array = [];
         i = 0;
         while(conditions[i])
         {
            pro = progress[i];
            if(id == 1277)
            {
               if(data != null && data.progress[0] == 0)
               {
                  tempArr[i] = LanguageMgr.GetTranslation("tank.view.task.TaskCatalogContentView.over");
               }
               else
               {
                  tempArr[i] = LanguageMgr.GetTranslation("tank.view.task.Taskstatus.onProgress");
               }
            }
            else if(pro <= 0 || isCompleted)
            {
               tempArr[i] = LanguageMgr.GetTranslation("tank.view.task.TaskCatalogContentView.over");
            }
            else if(conditions[i].type == 9 || conditions[i].type == 12 || conditions[i].type == 17 || conditions[i].type == 21 || conditions[i].type == 50 || conditions[i].type == 69 || conditions[i].type == 79 || conditions[i].type == 105 || conditions[i].type == 112 || conditions[i].type == 113 || conditions[i].type == 114 || conditions[i].type == 115)
            {
               tempArr[i] = LanguageMgr.GetTranslation("tank.view.task.Taskstatus.onProgress");
            }
            else if(conditions[i].type == 20 && conditions[i].param == 2)
            {
               tempArr[i] = LanguageMgr.GetTranslation("tank.view.task.Taskstatus.onProgress");
            }
            else
            {
               tempArr[i] = "(" + (String(conditions[i].target - pro)) + "/" + String(conditions[i].target) + ")";
            }
            i++;
         }
         return tempArr;
      }
      
      public function get conditionDescription() : Array
      {
         var i:int = 0;
         var pro:int = 0;
         if(!conditions)
         {
            conditions = [];
         }
         var tempArr:Array = [];
         i = 0;
         while(conditions[i])
         {
            pro = progress[i];
            if(pro <= 0 || isCompleted)
            {
               tempArr[i] = conditions[i].description + LanguageMgr.GetTranslation("tank.view.task.TaskCatalogContentView.over");
            }
            else if(conditions[i].type == 9 || conditions[i].type == 12 || conditions[i].type == 21 || conditions[i].type == 79)
            {
               tempArr[i] = conditions[i].description + LanguageMgr.GetTranslation("tank.view.task.Taskstatus.onProgress");
            }
            else if(conditions[i].type == 20 && conditions[i].param == 2)
            {
               tempArr[i] = conditions[i].description + LanguageMgr.GetTranslation("tank.view.task.Taskstatus.onProgress");
            }
            else
            {
               tempArr[i] = conditions[i].description + "(" + (String(conditions[i].target - pro)) + "/" + String(conditions[i].target) + ")";
            }
            i++;
         }
         return tempArr;
      }
      
      public function get conditionProgress() : Array
      {
         var i:int = 0;
         var pro:int = 0;
         var temp:Array = [];
         i = 0;
         while(conditions[i])
         {
            pro = progress[i];
            temp.push(ItemManager.Instance.getTemplateById(conditions[i].param).Name + "," + (String(conditions[i].target - pro)) + "/" + String(conditions[i].target));
            i++;
         }
         return temp;
      }
      
      public function get isCompleted() : Boolean
      {
         var ttt:int = 0;
         var tempCond:* = null;
         var i:int = 0;
         var autoComplete:Boolean = false;
         if(TrusteeshipManager.instance.isTrusteeshipQuestEnd(id))
         {
            return true;
         }
         if(id >= 2153 && id <= 2160)
         {
            ttt = Game360VIP.vipLevel;
            if(Game360VIP.vipLevel >= 1 && id == 2153 || Game360VIP.vipLevel >= 2 && id == 2154 || Game360VIP.vipLevel >= 3 && id == 2155 || Game360VIP.vipLevel >= 4 && id == 2156 || Game360VIP.vipLevel >= 5 && id == 2157 || Game360VIP.vipLevel >= 6 && id == 2158 || Game360VIP.vipLevel >= 7 && id == 2159 || Game360VIP.vipLevel >= 8 && id == 2160)
            {
               return true;
            }
            return false;
         }
         if(Type == 4)
         {
            if(!PlayerManager.Instance.Self.IsVIP)
            {
               return false;
            }
            if(id == 306 && PlayerManager.Instance.Self.typeVIP < 2)
            {
               return false;
            }
         }
         if(id == 1277)
         {
            if(data == null)
            {
               return true;
            }
            return data.progress[0] == 0;
         }
         if(!CanRepeat && isAchieved)
         {
            return false;
         }
         var optionalCondNeed:int = optionalConditionNeed;
         i = 0;
         while(true)
         {
            tempCond = getConditionById(i);
            if(getConditionById(i))
            {
               if(tempCond)
               {
                  if(tempCond.type == 90)
                  {
                     if(data)
                     {
                        if(data.progress[i] > 0 && data.progress[i] >= tempCond.param2)
                        {
                           return true;
                        }
                        return false;
                     }
                     return false;
                  }
                  autoComplete = getIsAutoComplete(i);
                  if(progress[i] > 0 && autoComplete == false)
                  {
                     if(!tempCond.isOpitional)
                     {
                        return false;
                     }
                  }
                  else
                  {
                     optionalCondNeed--;
                  }
                  i++;
                  continue;
               }
               break;
            }
            break;
         }
         if(optionalCondNeed > 0)
         {
            return false;
         }
         return true;
      }
      
      private function getConditionById(id:uint) : QuestCondition
      {
         if(!conditions)
         {
            conditions = [];
         }
         return conditions[id] as QuestCondition;
      }
      
      private function getIsAutoComplete(index:int) : Boolean
      {
         if(data == null)
         {
            return false;
         }
         return data.isAutoComplete && data.isAutoComplete[index];
      }
      
      public function get questProgressNum() : Number
      {
         var numerator:int = 0;
         var denominator:int = 0;
         var i:int = 0;
         i = 0;
         while(conditions[i])
         {
            numerator = numerator + progress[i];
            denominator = denominator + conditions[i].target;
            i++;
         }
         return numerator / denominator;
      }
      
      public function get canViewWithProgress() : Boolean
      {
         var numerator:int = 0;
         var denominator:int = 0;
         var i:int = 0;
         if(!conditions)
         {
            conditions = [];
         }
         var boo:Boolean = true;
         if(isCompleted)
         {
            return boo;
         }
         i = 0;
         while(conditions[i])
         {
            numerator = numerator + progress[i];
            denominator = denominator + conditions[i].target;
            i++;
         }
         if(numerator == denominator)
         {
            boo = false;
         }
         i = 0;
         while(conditions[i])
         {
            if(conditions[i].type == 9 || conditions[i].type == 12 || conditions[i].type == 17 || conditions[i].type == 21)
            {
               boo = false;
            }
            if(conditions[i].type == 20 && conditions[i].param == 2)
            {
               boo = false;
            }
            i++;
         }
         return boo;
      }
      
      public function hasOtherAward() : Boolean
      {
         if(RewardGP > 0)
         {
            return true;
         }
         if(RewardGold > 0)
         {
            return true;
         }
         if(RewardMoney > 0)
         {
            return true;
         }
         if(RewardOffer > 0)
         {
            return true;
         }
         if(RewardRiches > 0)
         {
            return true;
         }
         if(RewardBindMoney > 0)
         {
            return true;
         }
         if(Rank != "")
         {
            return true;
         }
         if(RewardBuffID != 0)
         {
            return true;
         }
         return false;
      }
      
      public function get isPhoneTask() : Boolean
      {
         return _isPhoneTask;
      }
      
      private function checkIsPhoneTask() : void
      {
         var i:int = 0;
         if(conditions)
         {
            for(i = 0; i < conditions.length; )
            {
               if(conditions[i].type == 42)
               {
                  _isPhoneTask = true;
                  break;
               }
               i++;
            }
         }
      }
      
      public function set cellHeight(value:Number) : void
      {
         _cellHeight = value;
      }
      
      public function getCellHeight() : Number
      {
         return _cellHeight;
      }
      
      public function get conditions() : Array
      {
         return _conditions;
      }
      
      public function set conditions(value:Array) : void
      {
         _conditions = value;
      }
   }
}
