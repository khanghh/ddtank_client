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
      
      public static function createFromXML(param1:XML) : QuestInfo
      {
         var _loc11_:int = 0;
         var _loc7_:* = null;
         var _loc5_:* = null;
         var _loc9_:int = 0;
         var _loc4_:* = null;
         var _loc2_:* = null;
         var _loc10_:* = null;
         var _loc6_:QuestInfo = new QuestInfo();
         _loc6_.QuestID = param1.@ID;
         _loc6_.Type = param1.@QuestID;
         _loc6_.Detail = param1.@Detail;
         _loc6_.Title = param1.@Title;
         _loc6_.Objective = param1.@Objective;
         _loc6_.StarLev = param1.@StarLev;
         _loc6_.QuestLevel = param1.@QuestLevel;
         _loc6_.NeedMinLevel = param1.@NeedMinLevel;
         _loc6_.NeedMaxLevel = param1.@NeedMaxLevel;
         _loc6_.PreQuestID = param1.@PreQuestID;
         _loc6_.NextQuestID = param1.@NextQuestID;
         _loc6_.CanRepeat = param1.@CanRepeat == "true"?true:false;
         _loc6_.RepeatInterval = param1.@RepeatInterval;
         _loc6_.RepeatMax = param1.@RepeatMax;
         _loc6_.RewardGold = param1.@RewardGold;
         _loc6_.RewardGP = param1.@RewardGP;
         _loc6_.RewardMoney = param1.@RewardMoney;
         _loc6_.OneKeyFinishNeedMoney = param1.@OneKeyFinishNeedMoney;
         _loc6_.TrusteeshipCost = param1.@CollocationCost;
         _loc6_.TrusteeshipNeedTime = param1.@CollocationColdTime;
         _loc6_.Rank = param1.@Rank;
         _loc6_.RewardOffer = param1.@RewardOffer;
         _loc6_.RewardRiches = param1.@RewardRiches;
         _loc6_.RewardBindMoney = param1.@RewardBindMoney;
         _loc6_.TimeLimit = param1.@TimeMode;
         _loc6_.RewardBuffID = param1.@RewardBuffID;
         _loc6_.RewardBuffDate = param1.@RewardBuffDate;
         _loc6_.Level2NeedMoney = param1.@Level2NeedMoney;
         _loc6_.Level3NeedMoney = param1.@Level3NeedMoney;
         _loc6_.Level4NeedMoney = param1.@Level4NeedMoney;
         _loc6_.Level5NeedMoney = param1.@Level5NeedMoney;
         _loc6_.otherCondition = param1.@IsOther;
         _loc6_.StartDate = DateUtils.decodeDated(String(param1.@StartDate));
         _loc6_.EndDate = DateUtils.decodeDated(String(param1.@EndDate));
         _loc6_.MapID = param1.@MapID;
         _loc6_.AutoEquip = StringUtils.converBoolean(param1.@AutoEquip);
         _loc6_.optionalConditionNeed = param1.@NotMustCount;
         _loc6_.isManuGet = param1.@IsAccept == "true"?true:false;
         var _loc3_:XMLList = param1..Item_Condiction;
         _loc11_ = 0;
         for(; _loc11_ < _loc3_.length(); _loc6_.addCondition(_loc5_),_loc11_++)
         {
            _loc7_ = _loc3_[_loc11_];
            _loc5_ = new QuestCondition(_loc6_.QuestID,_loc7_.@CondictionID,_loc7_.@CondictionType,_loc7_.@CondictionTitle,_loc7_.@Para1,_loc7_.@Para2,_loc7_.@Turn);
            if(_loc7_.@isOpitional == "true")
            {
               _loc5_.isOpitional = true;
            }
            else
            {
               _loc5_.isOpitional = false;
            }
            var _loc12_:* = _loc5_.type;
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
                                 switch(int(_loc5_.param) - 1)
                                 {
                                    case 0:
                                       if(!_loc6_.isTimeOut())
                                       {
                                          TaskManager.instance.addDesktopListener(_loc5_);
                                       }
                                       break;
                                    case 1:
                                       TaskManager.instance.addAnnexListener(_loc5_);
                                       break;
                                    case 2:
                                       TaskManager.instance.addFriendListener(_loc5_);
                                    default:
                                       TaskManager.instance.addFriendListener(_loc5_);
                                 }
                              }
                           }
                           continue;
                        }
                     }
                     addr244:
                     TaskManager.instance.addItemListener(_loc5_.param);
                     continue;
                  }
                  addr243:
                  §§goto(addr244);
               }
               §§goto(addr243);
            }
            else
            {
               TaskManager.instance.addGradeListener();
               continue;
            }
         }
         _loc6_.checkIsPhoneTask();
         var _loc8_:XMLList = param1..Item_Good;
         _loc9_ = 0;
         while(_loc9_ < _loc8_.length())
         {
            _loc4_ = _loc8_[_loc9_];
            _loc2_ = new Array(int(_loc4_.@RewardItemCount1),int(_loc4_.@RewardItemCount2),int(_loc4_.@RewardItemCount3),int(_loc4_.@RewardItemCount4),int(_loc4_.@RewardItemCount5));
            _loc10_ = new QuestItemReward(_loc4_.@RewardItemID,_loc2_,_loc4_.@IsSelect,_loc4_.@IsBind);
            _loc10_.time = _loc4_.@RewardItemValid;
            _loc10_.AttackCompose = _loc4_.@AttackCompose;
            _loc10_.DefendCompose = _loc4_.@DefendCompose;
            _loc10_.AgilityCompose = _loc4_.@AgilityCompose;
            _loc10_.LuckCompose = _loc4_.@LuckCompose;
            _loc10_.StrengthenLevel = _loc4_.@StrengthenLevel;
            _loc10_.IsCount = _loc4_.@IsCount;
            _loc10_.MagicAttack = _loc4_.@MagicAttack;
            _loc10_.MagicDefence = _loc4_.@MagicDefence;
            _loc6_.addReward(_loc10_);
            _loc9_++;
         }
         return _loc6_;
      }
      
      public function get QuestLevel() : int
      {
         return _questLevel;
      }
      
      public function set QuestLevel(param1:int) : void
      {
         if(param1 < 1)
         {
            param1 = 1;
         }
         if(param1 > 5)
         {
            param1 = 5;
         }
         _questLevel = param1;
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
      
      public function set hadChecked(param1:Boolean) : void
      {
         if(data)
         {
            data.hadChecked = param1;
         }
      }
      
      public function BuffName() : String
      {
         return ItemManager.Instance.getTemplateById(this.BuffID).Name;
      }
      
      public function addCondition(param1:QuestCondition) : void
      {
         if(!conditions)
         {
            conditions = [];
         }
         conditions.push(param1);
      }
      
      public function addReward(param1:QuestItemReward) : void
      {
         if(!_itemRewards)
         {
            _itemRewards = [];
         }
         _itemRewards.push(param1);
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
         var _loc3_:Date = TimeManager.Instance.Now();
         var _loc2_:Date = new Date(1990,1,1,_loc3_.getHours(),_loc3_.getMinutes(),_loc3_.getSeconds());
         var _loc1_:Date = new Date(1990,1,1,StartDate.getHours(),StartDate.getMinutes(),StartDate.getSeconds());
         var _loc4_:Date = new Date(1990,1,1,EndDate.getHours(),EndDate.getMinutes(),EndDate.getSeconds());
         if(_loc3_.time > EndDate.time || _loc3_.time < StartDate.time)
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
      
      public function isAvailableFor(param1:SelfInfo) : Boolean
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
         if(!data || !data.isAchieved)
         {
            return false;
         }
         return true;
      }
      
      private function getProgressById(param1:uint) : uint
      {
         var _loc5_:* = null;
         var _loc4_:* = null;
         var _loc29_:* = null;
         var _loc24_:int = 0;
         var _loc22_:int = 0;
         var _loc17_:int = 0;
         var _loc28_:int = 0;
         var _loc25_:int = 0;
         var _loc23_:int = 0;
         var _loc30_:int = 0;
         var _loc18_:int = 0;
         var _loc2_:* = null;
         var _loc26_:* = null;
         var _loc27_:int = 0;
         var _loc12_:int = 0;
         var _loc14_:int = 0;
         var _loc15_:int = 0;
         var _loc16_:int = 0;
         var _loc11_:int = 0;
         var _loc7_:* = null;
         var _loc13_:Boolean = getIsAutoComplete(param1);
         if(_loc13_)
         {
            return 0;
         }
         var _loc3_:SelfInfo = PlayerManager.Instance.Self;
         var _loc6_:QuestCondition = getConditionById(param1);
         var _loc9_:* = 0;
         if(data == null || data.progress[param1] == null)
         {
            _loc9_ = 0;
         }
         else
         {
            _loc9_ = int(data.progress[param1]);
         }
         var _loc32_:* = _loc6_.type;
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
                                                                        if(data == null || data.progress[param1] == null)
                                                                        {
                                                                           _loc9_ = 0;
                                                                        }
                                                                        else
                                                                        {
                                                                           _loc9_ = int(data.progress[param1]);
                                                                        }
                                                                     }
                                                                     else
                                                                     {
                                                                        _loc9_ = 0;
                                                                        _loc9_ = int(_loc6_.target - 1);
                                                                        if(data && data.progress[param1] <= _loc6_.target && data.progress[param1] > 0)
                                                                        {
                                                                           _loc9_ = int(_loc6_.target);
                                                                        }
                                                                     }
                                                                  }
                                                                  else
                                                                  {
                                                                     _loc7_ = PlayerManager.Instance.Self.pets;
                                                                     var _loc40_:int = 0;
                                                                     var _loc39_:* = _loc7_;
                                                                     for each(var _loc19_ in _loc7_)
                                                                     {
                                                                        if(_loc19_.StarLevel >= _loc6_.param)
                                                                        {
                                                                           _loc9_ = int(_loc6_.target);
                                                                           break;
                                                                        }
                                                                     }
                                                                  }
                                                               }
                                                               else if(_loc6_.param == 0)
                                                               {
                                                                  _loc27_ = _loc3_.getBag(41).getItemCountByTemplateId(100901,false);
                                                                  _loc12_ = _loc3_.getBag(41).getItemCountByTemplateId(100902,false);
                                                                  _loc14_ = _loc3_.getBag(41).getItemCountByTemplateId(100903,false);
                                                                  _loc15_ = _loc3_.getBag(41).getItemCountByTemplateId(100904,false);
                                                                  _loc16_ = _loc3_.getBag(41).getItemCountByTemplateId(100905,false);
                                                                  _loc11_ = _loc3_.getBag(41).getItemCountByTemplateId(100906,false);
                                                                  _loc9_ = int(_loc27_ + _loc12_ + _loc14_ + _loc15_ + _loc16_ + _loc11_);
                                                               }
                                                            }
                                                            else if(_loc6_.param == 0)
                                                            {
                                                               _loc9_ = int(_loc3_.evolutionGrade);
                                                            }
                                                         }
                                                         else if(_loc6_.param == 0)
                                                         {
                                                            _loc18_ = 8;
                                                            while(_loc18_ < 10)
                                                            {
                                                               _loc2_ = _loc3_.getBag(0).findItems(_loc18_);
                                                               _loc26_ = _loc3_.getBag(12).findItems(_loc18_);
                                                               var _loc36_:int = 0;
                                                               var _loc35_:* = _loc2_;
                                                               for each(var _loc20_ in _loc2_)
                                                               {
                                                                  if(_loc20_.MagicLevel >= _loc6_.target)
                                                                  {
                                                                     _loc9_ = int(_loc6_.target);
                                                                     break;
                                                                  }
                                                               }
                                                               var _loc38_:int = 0;
                                                               var _loc37_:* = _loc26_;
                                                               for each(var _loc10_ in _loc26_)
                                                               {
                                                                  if(_loc10_.MagicLevel >= _loc6_.target)
                                                                  {
                                                                     _loc9_ = int(_loc6_.target);
                                                                     break;
                                                                  }
                                                               }
                                                               _loc18_++;
                                                            }
                                                         }
                                                      }
                                                      else if(data && _loc6_.param == 0)
                                                      {
                                                         _loc30_ = TotemManager.instance.getTotemPointLevel(PlayerManager.Instance.Self.totemId);
                                                         _loc9_ = _loc30_;
                                                      }
                                                   }
                                                   else if(_loc6_.param == 0)
                                                   {
                                                      _loc9_ = int(FineSuitManager.Instance.getNextSuitVoByExp(PlayerManager.Instance.Self.fineSuitExp).level - 1);
                                                   }
                                                }
                                                else
                                                {
                                                   _loc25_ = _loc3_.getBag(0).getBagItemCountByTemplateId(_loc6_.param,false);
                                                   _loc23_ = _loc3_.getBag(1).getBagItemCountByTemplateId(_loc6_.param,false);
                                                   _loc9_ = int(_loc25_ + _loc23_);
                                                }
                                             }
                                             else
                                             {
                                                _loc17_ = PetsBagManager.instance().curMaxBreakGrade();
                                                _loc28_ = _loc6_.param;
                                                _loc9_ = int(_loc17_ >= _loc28_?0:-1);
                                             }
                                          }
                                          else if(DayActivityManager.Instance.activityValue >= _loc6_.target)
                                          {
                                             _loc9_ = int(_loc6_.target);
                                          }
                                          else
                                          {
                                             _loc9_ = int(DayActivityManager.Instance.activityValue);
                                          }
                                       }
                                       else if(HorseManager.instance.curLevel >= _loc6_.param)
                                       {
                                          _loc9_ = 0;
                                       }
                                       else
                                       {
                                          _loc9_ = int(_loc6_.target - 1);
                                       }
                                    }
                                    else
                                    {
                                       _loc9_ = int(_loc6_.target - 1);
                                       if(data && data.progress[param1] < _loc6_.target && data.progress[param1] >= 0)
                                       {
                                          _loc9_ = int(_loc6_.target);
                                       }
                                    }
                                 }
                                 else
                                 {
                                    if(data)
                                    {
                                       _loc9_ = int(_loc6_.target - data.progress[param1]);
                                    }
                                    if(_loc6_.param == 3)
                                    {
                                       _loc9_ = int(PlayerManager.Instance.friendList.length);
                                    }
                                 }
                              }
                              else
                              {
                                 switch(int(_loc6_.param))
                                 {
                                    case 0:
                                       if(ConsortionModelManager.Instance.model.memberList.length > 0)
                                       {
                                          _loc9_ = int(ConsortionModelManager.Instance.model.memberList.length);
                                       }
                                       break;
                                    case 1:
                                       if(PlayerManager.Instance.Self.UseOffer)
                                       {
                                          _loc9_ = int(PlayerManager.Instance.Self.UseOffer);
                                       }
                                       break;
                                    case 2:
                                       if(PlayerManager.Instance.Self.consortiaInfo.SmithLevel)
                                       {
                                          _loc9_ = int(PlayerManager.Instance.Self.consortiaInfo.SmithLevel);
                                       }
                                       break;
                                    case 3:
                                       if(PlayerManager.Instance.Self.consortiaInfo.ShopLevel)
                                       {
                                          _loc9_ = int(PlayerManager.Instance.Self.consortiaInfo.ShopLevel);
                                       }
                                       break;
                                    case 4:
                                       if(PlayerManager.Instance.Self.consortiaInfo.StoreLevel)
                                       {
                                          _loc9_ = int(PlayerManager.Instance.Self.consortiaInfo.StoreLevel);
                                          break;
                                       }
                                 }
                              }
                           }
                           else
                           {
                              _loc9_ = int(!!_loc3_.IsMarried?1:0);
                           }
                        }
                        else
                        {
                           _loc9_ = 1;
                        }
                     }
                  }
                  if(_loc9_ < _loc6_.target)
                  {
                     _loc24_ = _loc3_.getBag(0).getItemCountByTemplateId(_loc6_.param,false);
                     _loc22_ = _loc3_.getBag(1).getItemCountByTemplateId(_loc6_.param,false);
                     _loc9_ = int(_loc24_ + _loc22_);
                  }
               }
               else
               {
                  _loc9_ = 0;
                  _loc4_ = _loc3_.getBag(0).findItemsForEach(_loc6_.param);
                  _loc29_ = _loc3_.getBag(12).findItemsForEach(_loc6_.param);
                  _loc32_ = 0;
                  var _loc31_:* = _loc4_;
                  for each(var _loc21_ in _loc4_)
                  {
                     if(_loc21_.StrengthenLevel >= _loc6_.target)
                     {
                        _loc9_ = int(_loc6_.target);
                        break;
                     }
                  }
                  var _loc34_:int = 0;
                  var _loc33_:* = _loc29_;
                  for each(var _loc8_ in _loc29_)
                  {
                     if(_loc8_.StrengthenLevel >= _loc6_.target)
                     {
                        _loc9_ = int(_loc6_.target);
                        break;
                     }
                  }
               }
            }
            else
            {
               _loc9_ = 0;
               _loc5_ = _loc3_.getBag(0).findEquipedItemByTemplateId(_loc6_.param,false);
               if(_loc5_ && _loc5_.Place <= 30)
               {
                  _loc9_ = 1;
               }
            }
         }
         else
         {
            _loc9_ = int(_loc3_.Grade);
         }
         if(_loc9_ > _loc6_.target)
         {
            return 0;
         }
         return _loc6_.target - _loc9_;
      }
      
      public function get progress() : Array
      {
         var _loc2_:int = 0;
         if(!conditions)
         {
            conditions = [];
         }
         var _loc1_:Array = [];
         _loc2_ = 0;
         while(conditions[_loc2_])
         {
            _loc1_[_loc2_] = getProgressById(_loc2_);
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function get conditionStatusBoolean() : Array
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         if(!conditions)
         {
            conditions = [];
         }
         var _loc1_:Array = [];
         _loc3_ = 0;
         while(conditions[_loc3_])
         {
            _loc2_ = progress[_loc3_];
            if(_loc2_ <= 0 || isCompleted)
            {
               _loc1_[_loc3_] = true;
            }
            else
            {
               _loc1_[_loc3_] = false;
            }
            _loc3_++;
         }
         return _loc1_;
      }
      
      public function get conditionStatus() : Array
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         if(!conditions)
         {
            conditions = [];
         }
         var _loc1_:Array = [];
         _loc3_ = 0;
         while(conditions[_loc3_])
         {
            _loc2_ = progress[_loc3_];
            if(id == 1277)
            {
               if(data != null && data.progress[0] == 0)
               {
                  _loc1_[_loc3_] = LanguageMgr.GetTranslation("tank.view.task.TaskCatalogContentView.over");
               }
               else
               {
                  _loc1_[_loc3_] = LanguageMgr.GetTranslation("tank.view.task.Taskstatus.onProgress");
               }
            }
            else if(_loc2_ <= 0 || isCompleted)
            {
               _loc1_[_loc3_] = LanguageMgr.GetTranslation("tank.view.task.TaskCatalogContentView.over");
            }
            else if(conditions[_loc3_].type == 9 || conditions[_loc3_].type == 12 || conditions[_loc3_].type == 17 || conditions[_loc3_].type == 21 || conditions[_loc3_].type == 50 || conditions[_loc3_].type == 69 || conditions[_loc3_].type == 79 || conditions[_loc3_].type == 105 || conditions[_loc3_].type == 112 || conditions[_loc3_].type == 113 || conditions[_loc3_].type == 114 || conditions[_loc3_].type == 115)
            {
               _loc1_[_loc3_] = LanguageMgr.GetTranslation("tank.view.task.Taskstatus.onProgress");
            }
            else if(conditions[_loc3_].type == 20 && conditions[_loc3_].param == 2)
            {
               _loc1_[_loc3_] = LanguageMgr.GetTranslation("tank.view.task.Taskstatus.onProgress");
            }
            else
            {
               _loc1_[_loc3_] = "(" + (String(conditions[_loc3_].target - _loc2_)) + "/" + String(conditions[_loc3_].target) + ")";
            }
            _loc3_++;
         }
         return _loc1_;
      }
      
      public function get conditionDescription() : Array
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         if(!conditions)
         {
            conditions = [];
         }
         var _loc1_:Array = [];
         _loc3_ = 0;
         while(conditions[_loc3_])
         {
            _loc2_ = progress[_loc3_];
            if(_loc2_ <= 0 || isCompleted)
            {
               _loc1_[_loc3_] = conditions[_loc3_].description + LanguageMgr.GetTranslation("tank.view.task.TaskCatalogContentView.over");
            }
            else if(conditions[_loc3_].type == 9 || conditions[_loc3_].type == 12 || conditions[_loc3_].type == 21 || conditions[_loc3_].type == 79)
            {
               _loc1_[_loc3_] = conditions[_loc3_].description + LanguageMgr.GetTranslation("tank.view.task.Taskstatus.onProgress");
            }
            else if(conditions[_loc3_].type == 20 && conditions[_loc3_].param == 2)
            {
               _loc1_[_loc3_] = conditions[_loc3_].description + LanguageMgr.GetTranslation("tank.view.task.Taskstatus.onProgress");
            }
            else
            {
               _loc1_[_loc3_] = conditions[_loc3_].description + "(" + (String(conditions[_loc3_].target - _loc2_)) + "/" + String(conditions[_loc3_].target) + ")";
            }
            _loc3_++;
         }
         return _loc1_;
      }
      
      public function get conditionProgress() : Array
      {
         var _loc3_:int = 0;
         var _loc1_:int = 0;
         var _loc2_:Array = [];
         _loc3_ = 0;
         while(conditions[_loc3_])
         {
            _loc1_ = progress[_loc3_];
            _loc2_.push(ItemManager.Instance.getTemplateById(conditions[_loc3_].param).Name + "," + (String(conditions[_loc3_].target - _loc1_)) + "/" + String(conditions[_loc3_].target));
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function get isCompleted() : Boolean
      {
         var _loc3_:int = 0;
         var _loc1_:* = null;
         var _loc5_:int = 0;
         var _loc2_:Boolean = false;
         if(TrusteeshipManager.instance.isTrusteeshipQuestEnd(id))
         {
            return true;
         }
         if(id >= 2153 && id <= 2160)
         {
            _loc3_ = Game360VIP.vipLevel;
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
         var _loc4_:int = optionalConditionNeed;
         _loc5_ = 0;
         while(true)
         {
            _loc1_ = getConditionById(_loc5_);
            if(getConditionById(_loc5_))
            {
               if(_loc1_)
               {
                  if(_loc1_.type == 90)
                  {
                     if(data)
                     {
                        if(data.progress[_loc5_] > 0 && data.progress[_loc5_] >= _loc1_.param2)
                        {
                           return true;
                        }
                        return false;
                     }
                     return false;
                  }
                  _loc2_ = getIsAutoComplete(_loc5_);
                  if(progress[_loc5_] > 0 && _loc2_ == false)
                  {
                     if(!_loc1_.isOpitional)
                     {
                        return false;
                     }
                  }
                  else
                  {
                     _loc4_--;
                  }
                  _loc5_++;
                  continue;
               }
               break;
            }
            break;
         }
         if(_loc4_ > 0)
         {
            return false;
         }
         return true;
      }
      
      private function getConditionById(param1:uint) : QuestCondition
      {
         if(!conditions)
         {
            conditions = [];
         }
         return conditions[param1] as QuestCondition;
      }
      
      private function getIsAutoComplete(param1:int) : Boolean
      {
         if(data == null)
         {
            return false;
         }
         return data.isAutoComplete && data.isAutoComplete[param1];
      }
      
      public function get questProgressNum() : Number
      {
         var _loc2_:int = 0;
         var _loc1_:int = 0;
         var _loc3_:int = 0;
         _loc3_ = 0;
         while(conditions[_loc3_])
         {
            _loc2_ = _loc2_ + progress[_loc3_];
            _loc1_ = _loc1_ + conditions[_loc3_].target;
            _loc3_++;
         }
         return _loc2_ / _loc1_;
      }
      
      public function get canViewWithProgress() : Boolean
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         if(!conditions)
         {
            conditions = [];
         }
         var _loc1_:Boolean = true;
         if(isCompleted)
         {
            return _loc1_;
         }
         _loc4_ = 0;
         while(conditions[_loc4_])
         {
            _loc3_ = _loc3_ + progress[_loc4_];
            _loc2_ = _loc2_ + conditions[_loc4_].target;
            _loc4_++;
         }
         if(_loc3_ == _loc2_)
         {
            _loc1_ = false;
         }
         _loc4_ = 0;
         while(conditions[_loc4_])
         {
            if(conditions[_loc4_].type == 9 || conditions[_loc4_].type == 12 || conditions[_loc4_].type == 17 || conditions[_loc4_].type == 21)
            {
               _loc1_ = false;
            }
            if(conditions[_loc4_].type == 20 && conditions[_loc4_].param == 2)
            {
               _loc1_ = false;
            }
            _loc4_++;
         }
         return _loc1_;
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
         var _loc1_:int = 0;
         if(conditions)
         {
            _loc1_ = 0;
            while(_loc1_ < conditions.length)
            {
               if(conditions[_loc1_].type == 42)
               {
                  _isPhoneTask = true;
                  break;
               }
               _loc1_++;
            }
         }
      }
      
      public function set cellHeight(param1:Number) : void
      {
         _cellHeight = param1;
      }
      
      public function getCellHeight() : Number
      {
         return _cellHeight;
      }
      
      public function get conditions() : Array
      {
         return _conditions;
      }
      
      public function set conditions(param1:Array) : void
      {
         _conditions = param1;
      }
   }
}
