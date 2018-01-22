package ddt.manager
{
   import bagAndInfo.BagAndInfoManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.events.UIModuleEvent;
   import com.pickgliss.loader.UIModuleLoader;
   import ddt.data.effort.EffortCompleteStateInfo;
   import ddt.data.effort.EffortInfo;
   import ddt.data.effort.EffortProgressInfo;
   import ddt.data.effort.EffortQualificationInfo;
   import ddt.data.effort.EffortRewardInfo;
   import ddt.events.EffortEvent;
   import ddt.events.PkgEvent;
   import ddt.view.UIModuleSmallLoading;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import newTitle.NewTitleManager;
   import newTitle.model.NewTitleModel;
   import road7th.data.DictionaryData;
   import road7th.utils.DateUtils;
   
   public class EffortManager extends EventDispatcher
   {
      
      private static var _instance:EffortManager;
       
      
      private var allEfforts:DictionaryData;
      
      private var integrationEfforts:Array;
      
      private var roleEfforts:Array;
      
      private var taskEfforts:Array;
      
      private var duplicateEfforts:Array;
      
      private var combatEfforts:Array;
      
      private var currentEfforts:Array;
      
      private var newlyCompleteEffort:Array;
      
      private var preEfforts:DictionaryData;
      
      private var preTopEfforts:DictionaryData;
      
      private var nextEfforts:DictionaryData;
      
      private var completeEfforts:DictionaryData;
      
      private var completeTopEfforts:DictionaryData;
      
      private var inCompleteEfforts:DictionaryData;
      
      private var progressEfforts:DictionaryData;
      
      private var honorEfforts:Array;
      
      private var completeHonorEfforts:Array;
      
      private var inCompleteHonorEfforts:Array;
      
      private var honorArray:Array;
      
      private var tempPreEfforts:DictionaryData;
      
      private var tempCompleteEfforts:DictionaryData;
      
      private var tempInCompleteEfforts:DictionaryData;
      
      private var tempInCompleteTopEfforts:DictionaryData;
      
      private var tempIntegrationEfforts:Array;
      
      private var tempRoleEfforts:Array;
      
      private var tempTaskEfforts:Array;
      
      private var tempDuplicateEfforts:Array;
      
      private var tempCombatEfforts:Array;
      
      private var tempNewlyCompleteEffort:Array;
      
      private var tempCompleteID:Array;
      
      private var tempAchievementPoint:int;
      
      private var tempPreTopEfforts:DictionaryData;
      
      private var tempCompleteNextEfforts:DictionaryData;
      
      private var tempHonorEfforts:Array;
      
      private var tempCompleteHonorEfforts:Array;
      
      private var tempInCompleteHonorEfforts:Array;
      
      private var _isSelf:Boolean = true;
      
      private var currentType:int;
      
      private var count:int;
      
      public function EffortManager()
      {
         super();
      }
      
      public static function get Instance() : EffortManager
      {
         if(_instance == null)
         {
            _instance = new EffortManager();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         initDictionaryData();
         SocketManager.Instance.addEventListener(PkgEvent.format(229),__updateAchievement);
         SocketManager.Instance.addEventListener(PkgEvent.format(230),__AchievementFinish);
         SocketManager.Instance.addEventListener(PkgEvent.format(228),__initializeAchievement);
         SocketManager.Instance.addEventListener(PkgEvent.format(231),__initializeAchievementData);
         SocketManager.Instance.addEventListener(PkgEvent.format(203),__lookUpEffort);
         SocketManager.Instance.addEventListener(PkgEvent.format(34),__userRank);
      }
      
      private function initDictionaryData() : void
      {
         preEfforts = new DictionaryData();
         preTopEfforts = new DictionaryData();
         nextEfforts = new DictionaryData();
         progressEfforts = new DictionaryData();
         completeEfforts = new DictionaryData();
         completeTopEfforts = new DictionaryData();
         inCompleteEfforts = new DictionaryData();
      }
      
      public function getProgressEfforts() : DictionaryData
      {
         return progressEfforts;
      }
      
      public function getEffortByID(param1:int) : EffortInfo
      {
         if(!allEfforts)
         {
            return null;
         }
         return allEfforts[param1];
      }
      
      public function getIntegrationEffort() : Array
      {
         return integrationEfforts;
      }
      
      public function getRoleEffort() : Array
      {
         return roleEfforts;
      }
      
      public function getTaskEffort() : Array
      {
         return taskEfforts;
      }
      
      public function getDuplicateEffort() : Array
      {
         return duplicateEfforts;
      }
      
      public function getCombatEffort() : Array
      {
         return combatEfforts;
      }
      
      public function getNewlyCompleteEffort() : Array
      {
         return newlyCompleteEffort;
      }
      
      public function getHonorArray() : Array
      {
         if(!honorArray)
         {
            return [];
         }
         return honorArray;
      }
      
      private function splitHonorEffort() : void
      {
         var _loc1_:int = 0;
         honorEfforts = [];
         completeHonorEfforts = [];
         inCompleteHonorEfforts = [];
         var _loc4_:int = 0;
         var _loc3_:* = allEfforts;
         for each(var _loc2_ in allEfforts)
         {
            if(_loc2_.effortRewardArray)
            {
               _loc1_ = 0;
               while(_loc1_ < _loc2_.effortRewardArray.length)
               {
                  if((_loc2_.effortRewardArray[_loc1_] as EffortRewardInfo).RewardType == 1)
                  {
                     honorEfforts.push(_loc2_);
                     if(_loc2_.CompleteStateInfo)
                     {
                        completeHonorEfforts.push(_loc2_);
                     }
                     else
                     {
                        inCompleteHonorEfforts.push(_loc2_);
                     }
                  }
                  _loc1_++;
               }
               continue;
            }
         }
      }
      
      public function getHonorEfforts() : Array
      {
         splitHonorEffort();
         return honorEfforts;
      }
      
      public function getCompleteHonorEfforts() : Array
      {
         splitHonorEffort();
         return completeHonorEfforts;
      }
      
      public function getInCompleteHonorEfforts() : Array
      {
         splitHonorEffort();
         return inCompleteHonorEfforts;
      }
      
      public function get completeList() : DictionaryData
      {
         return completeEfforts;
      }
      
      public function get fullList() : DictionaryData
      {
         return allEfforts;
      }
      
      public function get currentEffortList() : Array
      {
         return currentEfforts;
      }
      
      public function set currentEffortList(param1:Array) : void
      {
         currentEfforts = [];
         currentEfforts = param1;
         dispatchEvent(new EffortEvent("listChanged"));
      }
      
      public function setEffortType(param1:int) : void
      {
         currentType = param1;
         switch(int(param1))
         {
            case 0:
               splitEffort(preTopEfforts);
               break;
            case 1:
               splitEffort(completeTopEfforts);
               break;
            case 2:
               splitEffort(inCompleteEfforts);
         }
         dispatchEvent(new EffortEvent("typeChanged"));
      }
      
      private function splitEffort(param1:DictionaryData) : void
      {
         if(!param1)
         {
            return;
         }
         integrationEfforts = [];
         roleEfforts = [];
         taskEfforts = [];
         duplicateEfforts = [];
         combatEfforts = [];
         var _loc4_:int = 0;
         var _loc3_:* = param1;
         for each(var _loc2_ in param1)
         {
            if(_loc2_)
            {
               switch(int(_loc2_.PlaceID))
               {
                  case 0:
                     integrationEfforts.push(_loc2_);
                     continue;
                  case 1:
                     roleEfforts.push(_loc2_);
                     continue;
                  case 2:
                     taskEfforts.push(_loc2_);
                     continue;
                  case 3:
                     duplicateEfforts.push(_loc2_);
                     continue;
                  case 4:
                     combatEfforts.push(_loc2_);
                     continue;
               }
            }
            else
            {
               continue;
            }
         }
      }
      
      private function __updateAchievement(param1:PkgEvent) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = null;
         var _loc2_:int = param1.pkg.readInt();
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            _loc3_ = new EffortProgressInfo();
            _loc3_.RecordID = param1.pkg.readInt();
            _loc3_.Total = param1.pkg.readInt();
            progressEfforts[_loc3_.RecordID] = _loc3_;
            updateProgress(_loc3_);
            _loc4_++;
         }
      }
      
      private function __initializeAchievement(param1:PkgEvent) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = null;
         var _loc2_:int = param1.pkg.readInt();
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            _loc3_ = new EffortProgressInfo();
            _loc3_.RecordID = param1.pkg.readInt();
            _loc3_.Total = param1.pkg.readInt();
            progressEfforts.add(_loc3_.RecordID,_loc3_);
            _loc4_++;
         }
         trace("初始化成绩进展成功");
         updateWholeProgress();
         splitHonorEffort();
      }
      
      private function __initializeAchievementData(param1:PkgEvent) : void
      {
         var _loc8_:int = 0;
         var _loc7_:* = null;
         var _loc6_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc5_:* = null;
         newlyCompleteEffort = [];
         var _loc4_:int = param1.pkg.readInt();
         count = _loc4_;
         _loc8_ = 0;
         while(_loc8_ < _loc4_)
         {
            _loc7_ = new EffortCompleteStateInfo();
            _loc7_.ID = param1.pkg.readInt();
            _loc6_ = param1.pkg.readInt();
            _loc2_ = param1.pkg.readInt();
            _loc3_ = param1.pkg.readInt();
            _loc5_ = new Date(_loc6_,_loc2_ - 1,_loc3_);
            _loc7_.CompletedDate = _loc5_;
            if(allEfforts[_loc7_.ID])
            {
               (allEfforts[_loc7_.ID] as EffortInfo).CompleteStateInfo = _loc7_;
               (allEfforts[_loc7_.ID] as EffortInfo).completedDate = _loc7_.CompletedDate;
               if(_loc8_ < 4)
               {
                  newlyCompleteEffort.push(allEfforts[_loc7_.ID]);
               }
            }
            _loc8_++;
         }
         splitPreEffort();
      }
      
      private function __userRank(param1:PkgEvent) : void
      {
         var _loc10_:int = 0;
         var _loc6_:* = null;
         var _loc2_:int = 0;
         var _loc3_:* = null;
         var _loc5_:* = null;
         var _loc7_:* = null;
         var _loc9_:int = 0;
         honorArray = [];
         var _loc4_:Array = [];
         var _loc8_:int = param1.pkg.readInt();
         _loc10_ = 0;
         while(_loc10_ < _loc8_)
         {
            _loc6_ = new NewTitleModel();
            _loc2_ = param1.pkg.readInt();
            _loc6_.id = _loc2_;
            _loc6_.Name = param1.pkg.readUTF();
            _loc3_ = param1.pkg.readDate();
            _loc5_ = param1.pkg.readDate();
            _loc6_.Valid = DateUtils.getHourDifference(new Date().time,_loc5_.time) / 24 + 1;
            if(_loc2_ >= NewTitleManager.FIRST_TITLEID)
            {
               NewTitleManager.instance.titleInfo[_loc2_].Valid = _loc6_.Valid;
               honorArray.push(NewTitleManager.instance.titleInfo[_loc2_]);
            }
            else
            {
               _loc7_ = NewTitleManager.instance.getTitleByName(_loc6_.Name);
               if(_loc7_)
               {
                  _loc6_.Desc = _loc7_.Desc;
                  _loc4_.push(_loc6_);
               }
            }
            _loc10_++;
         }
         honorArray.sortOn("id",16);
         _loc9_ = 0;
         while(_loc9_ < _loc4_.length)
         {
            honorArray.push(_loc4_[_loc9_]);
            _loc9_++;
         }
         dispatchEvent(new EffortEvent("finish"));
      }
      
      private function splitPreEffort() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = allEfforts;
         for each(var _loc1_ in allEfforts)
         {
            if(estimateEffortState(_loc1_))
            {
               preEfforts.add(_loc1_.ID,_loc1_);
            }
            if(estimateEffortState(_loc1_) && (isTopEffort(_loc1_) || !_loc1_.CompleteStateInfo))
            {
               preTopEfforts.add(_loc1_.ID,_loc1_);
            }
            else if(!estimateEffortState(_loc1_))
            {
               nextEfforts.add(_loc1_.ID,_loc1_);
            }
         }
         splitCompleteEffort();
         splitEffort(preEfforts);
      }
      
      private function inCompletedToPreTopEfforts() : void
      {
         var _loc1_:* = null;
         var _loc2_:* = null;
         var _loc3_:int = 0;
         var _loc6_:int = 0;
         var _loc5_:* = completeEfforts;
         for each(var _loc4_ in completeEfforts)
         {
            _loc1_ = getFellNextEffort(_loc4_.ID);
            _loc1_.sortOn("ID");
            _loc3_ = 0;
            while(_loc3_ < _loc1_.length)
            {
               _loc2_ = _loc1_[_loc3_] as EffortInfo;
               if(!_loc2_.CompleteStateInfo && !isTopEffort(_loc2_))
               {
                  preTopEfforts.add(_loc2_.ID,_loc2_);
                  return;
               }
               _loc3_++;
            }
         }
      }
      
      private function estimateEffortState(param1:EffortInfo) : Boolean
      {
         var _loc3_:int = 0;
         var _loc2_:Array = [];
         _loc2_ = param1.PreAchievementID.split(",");
         if(_loc2_.length == 2 && _loc2_[0] == "0")
         {
            return true;
         }
         _loc3_ = 0;
         while(_loc3_ <= _loc2_.length)
         {
            if(_loc2_[_loc3_] != "")
            {
               if((allEfforts[int(_loc2_[_loc3_])] as EffortInfo).CompleteStateInfo == null)
               {
                  return false;
               }
               _loc3_++;
               continue;
            }
            break;
         }
         return true;
      }
      
      public function getTopEffort1(param1:EffortInfo) : int
      {
         var _loc2_:int = 0;
         if(isTopEffort(param1) || !param1.CompleteStateInfo)
         {
            return param1.ID;
         }
         _loc2_ = 1;
         while(!isTopEffort(getEffortByID(param1.ID - _loc2_)))
         {
            _loc2_++;
         }
         return getEffortByID(param1.ID - _loc2_).ID;
      }
      
      public function getTopEffort(param1:EffortInfo) : int
      {
         if(isTopEffort(param1) || !param1.CompleteStateInfo)
         {
            return param1.ID;
         }
         var _loc2_:Array = [];
         var _loc4_:int = getLastID(param1);
         var _loc3_:int = -1;
         var _loc5_:EffortInfo = getEffortByID(_loc4_);
         while(!isTopEffort(_loc5_))
         {
            _loc4_ = getLastID(_loc5_);
            _loc5_ = getEffortByID(_loc4_);
         }
         return _loc4_;
      }
      
      private function getLastID(param1:EffortInfo) : int
      {
         var _loc3_:int = 0;
         var _loc2_:Array = [];
         _loc2_ = param1.PreAchievementID.split(",");
         var _loc4_:int = -1;
         _loc3_ = 0;
         while(_loc3_ < _loc2_.length)
         {
            if(_loc2_[_loc3_].toString().length > 0)
            {
               _loc4_ = _loc2_[_loc3_];
            }
            _loc3_++;
         }
         return _loc4_;
      }
      
      public function getCompleteNextEffort1(param1:int) : Array
      {
         var _loc5_:int = 0;
         var _loc4_:int = 0;
         var _loc2_:Array = [];
         var _loc3_:Array = [];
         if(completeEfforts[param1])
         {
            _loc2_.push(completeEfforts[param1]);
         }
         _loc5_ = 1;
         while(completeEfforts[param1 + _loc5_])
         {
            _loc3_ = (completeEfforts[param1 + _loc5_] as EffortInfo).PreAchievementID.split(",");
            _loc4_ = 0;
            while(_loc4_ < _loc3_.length)
            {
               if(isTopEffort(completeEfforts[param1 + _loc5_]))
               {
                  return _loc2_;
               }
               if(param1 + _loc5_ - 1 == int(_loc3_[_loc4_]))
               {
                  _loc2_.push(completeEfforts[param1 + _loc5_]);
               }
               _loc4_++;
            }
            _loc5_++;
         }
         return _loc2_;
      }
      
      public function getCompleteNextEffort(param1:int) : Array
      {
         var _loc4_:int = 0;
         var _loc2_:Array = [];
         var _loc3_:Array = [];
         completeEfforts.list.sortOn("ID",16);
         if(completeEfforts[param1])
         {
            _loc2_.push(completeEfforts[param1]);
         }
         var _loc5_:* = param1;
         var _loc8_:int = 0;
         var _loc7_:* = completeEfforts.list;
         for each(var _loc6_ in completeEfforts.list)
         {
            if(_loc6_ && _loc6_.ID != param1)
            {
               _loc3_ = _loc6_.PreAchievementID.split(",");
               _loc4_ = 0;
               while(_loc4_ < _loc3_.length)
               {
                  if(!isTopEffort(_loc6_))
                  {
                     if(_loc5_ == int(_loc3_[_loc4_]))
                     {
                        _loc2_.push(_loc6_);
                        _loc5_ = int(_loc6_.ID);
                     }
                  }
                  _loc4_++;
               }
               continue;
            }
         }
         return _loc2_;
      }
      
      public function getFellNextEffort(param1:int) : Array
      {
         var _loc5_:int = 0;
         var _loc4_:int = 0;
         var _loc3_:Array = [];
         var _loc2_:Array = [];
         if(allEfforts[param1])
         {
            _loc3_.push(allEfforts[param1]);
         }
         _loc5_ = 1;
         while(allEfforts[param1 + _loc5_])
         {
            _loc2_ = (allEfforts[param1 + _loc5_] as EffortInfo).PreAchievementID.split(",");
            _loc4_ = 0;
            while(_loc4_ < _loc2_.length)
            {
               if(isTopEffort(allEfforts[param1 + _loc5_]))
               {
                  return _loc3_;
               }
               if(param1 + _loc5_ - 1 == int(_loc2_[_loc4_]))
               {
                  _loc3_.push(allEfforts[param1 + _loc5_]);
               }
               _loc4_++;
            }
            _loc5_++;
         }
         return _loc3_;
      }
      
      private function splitCompleteEffort() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = preEfforts;
         for each(var _loc1_ in preEfforts)
         {
            if(_loc1_.CompleteStateInfo != null && isTopEffort(_loc1_))
            {
               completeTopEfforts.add(_loc1_.ID,_loc1_);
            }
            if(_loc1_.CompleteStateInfo != null)
            {
               completeEfforts.add(_loc1_.ID,_loc1_);
            }
            else
            {
               inCompleteEfforts.add(_loc1_.ID,_loc1_);
            }
         }
      }
      
      private function __AchievementFinish(param1:PkgEvent) : void
      {
         var _loc6_:EffortCompleteStateInfo = new EffortCompleteStateInfo();
         _loc6_.ID = param1.pkg.readInt();
         var _loc5_:int = param1.pkg.readInt();
         var _loc2_:int = param1.pkg.readInt();
         var _loc3_:int = param1.pkg.readInt();
         var _loc4_:Date = new Date(_loc5_,_loc2_ - 1,_loc3_);
         _loc6_.CompletedDate = _loc4_;
         trace("接受完成" + _loc6_.ID);
         if(inCompleteEfforts[_loc6_.ID])
         {
            (inCompleteEfforts[_loc6_.ID] as EffortInfo).CompleteStateInfo = _loc6_;
            (inCompleteEfforts[_loc6_.ID] as EffortInfo).completedDate = _loc6_.CompletedDate;
         }
         if(allEfforts[_loc6_.ID])
         {
            (allEfforts[_loc6_.ID] as EffortInfo).CompleteStateInfo = _loc6_;
            (allEfforts[_loc6_.ID] as EffortInfo).completedDate = _loc6_.CompletedDate;
         }
         completeToInComplete(_loc6_.ID);
         if(newlyCompleteEffort)
         {
            newlyCompleteEffort.unshift(completeEfforts[_loc6_.ID]);
         }
         dispatchEvent(new EffortEvent("finish"));
      }
      
      private function updateWholeProgress() : void
      {
         var _loc4_:int = 0;
         var _loc9_:int = 0;
         var _loc8_:* = allEfforts;
         for each(var _loc1_ in allEfforts)
         {
            var _loc7_:int = 0;
            var _loc6_:* = _loc1_.EffortQualificationList;
            for each(var _loc3_ in _loc1_.EffortQualificationList)
            {
               if(!progressEfforts[_loc3_.CondictionType])
               {
                  trace("成就进展出错，没有" + _loc3_.CondictionType + "（CondictionType）");
               }
               _loc3_.para2_currentValue = (progressEfforts[_loc3_.CondictionType] as EffortProgressInfo).Total;
               _loc1_.addEffortQualification(_loc3_);
            }
            allEfforts[_loc1_.ID] = _loc1_;
         }
         trace("初始化成绩赋值成功");
         trace("初始化成绩赋值成功");
         var _loc2_:Array = [];
         var _loc11_:int = 0;
         var _loc10_:* = allEfforts;
         for each(var _loc5_ in allEfforts)
         {
            if(testEffortIsComplete(_loc5_))
            {
               _loc2_.push(_loc5_);
            }
         }
         _loc2_.sortOn("ID");
         if(count != _loc2_.length)
         {
            _loc4_ = 0;
            while(_loc4_ < _loc2_.length)
            {
               trace("初始化发送已完成" + _loc2_[_loc4_].ID);
               SocketManager.Instance.out.sendAchievementFinish(_loc2_[_loc4_].ID);
               _loc4_++;
            }
         }
      }
      
      private function updateProgress(param1:EffortProgressInfo) : void
      {
         var _loc6_:int = 0;
         var _loc3_:Array = [];
         var _loc11_:int = 0;
         var _loc10_:* = allEfforts;
         for each(var _loc2_ in allEfforts)
         {
            var _loc9_:int = 0;
            var _loc8_:* = _loc2_.EffortQualificationList;
            for each(var _loc4_ in _loc2_.EffortQualificationList)
            {
               if(_loc4_.CondictionType == param1.RecordID)
               {
                  _loc4_.para2_currentValue = param1.Total;
                  _loc2_.addEffortQualification(_loc4_);
               }
            }
         }
         var _loc13_:int = 0;
         var _loc12_:* = inCompleteEfforts;
         for each(var _loc7_ in inCompleteEfforts)
         {
            if(testEffortIsComplete(_loc7_))
            {
               _loc3_.push(_loc7_);
            }
         }
         var _loc15_:int = 0;
         var _loc14_:* = nextEfforts;
         for each(var _loc5_ in nextEfforts)
         {
            if(testEffortIsComplete(_loc5_))
            {
               _loc3_.push(_loc5_);
            }
         }
         if(_loc3_ && _loc3_[0])
         {
            _loc3_.sortOn("ID");
         }
         _loc6_ = 0;
         while(_loc6_ < _loc3_.length)
         {
            trace("初始化发送已完成" + _loc3_[_loc6_].ID);
            SocketManager.Instance.out.sendAchievementFinish(_loc3_[_loc6_].ID);
            _loc6_++;
         }
      }
      
      private function testEffortIsComplete(param1:EffortInfo) : Boolean
      {
         var _loc4_:int = 0;
         var _loc3_:* = param1.EffortQualificationList;
         for each(var _loc2_ in param1.EffortQualificationList)
         {
            if(_loc2_.para2_currentValue < _loc2_.Condiction_Para2)
            {
               return false;
            }
         }
         return true;
      }
      
      public function splitTitle(param1:String) : String
      {
         var _loc2_:Array = [];
         _loc2_ = param1.split("/");
         if(_loc2_.length > 1 && _loc2_[1] != "")
         {
            if(PlayerManager.Instance.Self.Sex)
            {
               return _loc2_[0];
            }
            return _loc2_[1];
         }
         return _loc2_[0];
      }
      
      public function testFunction(param1:int) : void
      {
      }
      
      private function completeToInComplete(param1:int) : void
      {
         if(inCompleteEfforts[param1] && isTopEffort(inCompleteEfforts[param1]))
         {
            completeTopEfforts.add(param1,inCompleteEfforts[param1]);
            preTopEfforts.add(param1,inCompleteEfforts[param1]);
         }
         if(inCompleteEfforts[param1])
         {
            completeEfforts.add(param1,inCompleteEfforts[param1]);
         }
         var _loc2_:Array = getFellNextEffort(param1);
         if(param1 == _loc2_[_loc2_.length - 1].ID && (allEfforts[param1] as EffortInfo).IsOther)
         {
            preTopEfforts.remove(param1);
         }
         inCompleteEfforts.remove(param1);
         nextToPre();
      }
      
      private function isTopEffort(param1:EffortInfo) : Boolean
      {
         return param1.PreAchievementID == "0,";
      }
      
      private function nextToPre() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = nextEfforts;
         for each(var _loc1_ in nextEfforts)
         {
            if(estimateEffortState(_loc1_))
            {
               preEfforts.add(_loc1_.ID,_loc1_);
               nextEfforts.remove(_loc1_.ID);
               nexToPreTop(_loc1_);
               if(testEffortIsComplete(_loc1_) && isTopEffort(_loc1_))
               {
                  completeTopEfforts.add(_loc1_.ID,_loc1_);
               }
               if(testEffortIsComplete(_loc1_))
               {
                  completeEfforts.add(_loc1_.ID,_loc1_);
               }
               else
               {
                  inCompleteEfforts.add(_loc1_.ID,_loc1_);
               }
            }
         }
         setEffortType(currentType);
      }
      
      private function nexToPreTop(param1:EffortInfo) : void
      {
         var _loc2_:* = null;
         var _loc3_:int = 0;
         if(!param1.CompleteStateInfo)
         {
            preTopEfforts.add(param1.ID,param1);
            if(param1.PreAchievementID != "0,")
            {
               _loc2_ = [];
               _loc2_ = param1.PreAchievementID.split(",");
               _loc3_ = 0;
               while(_loc3_ <= _loc2_.length)
               {
                  if(_loc2_[_loc3_] != "")
                  {
                     if(preTopEfforts[int(_loc2_[_loc3_])] && !isTopEffort(preTopEfforts[int(_loc2_[_loc3_])]))
                     {
                        preTopEfforts.remove(int(_loc2_[_loc3_]));
                     }
                     _loc3_++;
                     continue;
                  }
                  break;
               }
            }
         }
      }
      
      public function lookUpEffort(param1:int) : void
      {
         SocketManager.Instance.out.sendLookupEffort(param1);
      }
      
      private function __lookUpEffort(param1:PkgEvent) : void
      {
         var _loc4_:int = 0;
         tempPreEfforts = new DictionaryData();
         tempPreTopEfforts = new DictionaryData();
         tempCompleteEfforts = new DictionaryData();
         tempInCompleteEfforts = new DictionaryData();
         tempCompleteNextEfforts = new DictionaryData();
         tempInCompleteTopEfforts = new DictionaryData();
         tempNewlyCompleteEffort = [];
         tempCompleteID = [];
         tempAchievementPoint = param1.pkg.readInt();
         var _loc2_:int = param1.pkg.readInt();
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            if(_loc2_ != 0)
            {
               tempCompleteID[_loc4_] = param1.pkg.readInt();
               if(allEfforts[tempCompleteID[_loc4_]] && isTopEffort(allEfforts[tempCompleteID[_loc4_]]))
               {
                  tempInCompleteTopEfforts.add(tempCompleteID[_loc4_],allEfforts[tempCompleteID[_loc4_]]);
               }
               if(allEfforts[tempCompleteID[_loc4_]])
               {
                  tempCompleteEfforts.add(tempCompleteID[_loc4_],allEfforts[tempCompleteID[_loc4_]]);
               }
               if(_loc4_ < 4)
               {
                  tempNewlyCompleteEffort[_loc4_] = allEfforts[tempCompleteID[_loc4_]];
               }
               _loc4_++;
               continue;
            }
            break;
         }
         var _loc6_:int = 0;
         var _loc5_:* = allEfforts;
         for each(var _loc3_ in allEfforts)
         {
            if(estimateTempEffortState(_loc3_))
            {
               tempPreEfforts.add(_loc3_.ID,_loc3_);
               if(isTopEffort(_loc3_) || !tempCompleteEfforts[_loc3_.ID])
               {
                  tempPreTopEfforts.add(_loc3_.ID,_loc3_);
               }
               if(!tempCompleteEfforts[_loc3_.ID])
               {
                  tempInCompleteEfforts.add(_loc3_.ID,_loc3_);
               }
            }
         }
         setTempEffortType(0);
         isSelf = false;
         EffortManager.Instance.switchVisible();
      }
      
      private function estimateTempEffortState(param1:EffortInfo) : Boolean
      {
         var _loc3_:int = 0;
         var _loc2_:Array = [];
         _loc2_ = param1.PreAchievementID.split(",");
         if(_loc2_.length == 2 && _loc2_[0] == "0")
         {
            return true;
         }
         _loc3_ = 0;
         while(_loc3_ <= _loc2_.length)
         {
            if(_loc2_[_loc3_] != "")
            {
               if(tempCompleteEfforts[int(_loc2_[_loc3_])] == null)
               {
                  return false;
               }
               _loc3_++;
               continue;
            }
            break;
         }
         return true;
      }
      
      public function setTempEffortType(param1:int) : void
      {
         switch(int(param1))
         {
            case 0:
               splitTempEffort(tempPreTopEfforts);
               break;
            case 1:
               splitTempEffort(tempInCompleteTopEfforts);
               break;
            case 2:
               splitTempEffort(tempInCompleteEfforts);
         }
         dispatchEvent(new EffortEvent("typeChanged"));
      }
      
      private function splitTempEffort(param1:DictionaryData) : void
      {
         if(!param1)
         {
            return;
         }
         tempIntegrationEfforts = [];
         tempRoleEfforts = [];
         tempTaskEfforts = [];
         tempDuplicateEfforts = [];
         tempCombatEfforts = [];
         var _loc4_:int = 0;
         var _loc3_:* = param1;
         for each(var _loc2_ in param1)
         {
            if(_loc2_)
            {
               switch(int(_loc2_.PlaceID))
               {
                  case 0:
                     tempIntegrationEfforts.push(_loc2_);
                     continue;
                  case 1:
                     tempRoleEfforts.push(_loc2_);
                     continue;
                  case 2:
                     tempTaskEfforts.push(_loc2_);
                     continue;
                  case 3:
                     tempDuplicateEfforts.push(_loc2_);
                     continue;
                  case 4:
                     tempCombatEfforts.push(_loc2_);
                     continue;
               }
            }
            else
            {
               continue;
            }
         }
      }
      
      public function getTempTopEffort(param1:EffortInfo) : int
      {
         var _loc2_:int = 0;
         if(isTopEffort(param1) || !tempEffortIsComplete(param1.ID))
         {
            return param1.ID;
         }
         _loc2_ = 1;
         while(!isTopEffort(getEffortByID(param1.ID - _loc2_)))
         {
            _loc2_++;
         }
         return getEffortByID(param1.ID - _loc2_).ID;
      }
      
      public function getTempCompleteNextEffort(param1:int) : Array
      {
         var _loc5_:int = 0;
         var _loc4_:int = 0;
         var _loc2_:Array = [];
         var _loc3_:Array = [];
         if(tempEffortIsComplete(param1))
         {
            _loc2_.push(tempCompleteEfforts[param1]);
         }
         _loc5_ = 1;
         while(tempCompleteEfforts[param1 + _loc5_])
         {
            _loc3_ = (tempCompleteEfforts[param1 + _loc5_] as EffortInfo).PreAchievementID.split(",");
            _loc4_ = 0;
            while(_loc4_ < _loc3_.length)
            {
               if(isTopEffort(tempCompleteEfforts[param1 + _loc5_]))
               {
                  return _loc2_;
               }
               if(param1 + _loc5_ - 1 == int(_loc3_[_loc4_]))
               {
                  _loc2_.push(tempCompleteEfforts[param1 + _loc5_]);
               }
               _loc4_++;
            }
            _loc5_++;
         }
         return _loc2_;
      }
      
      private function splitTempHonorEffort() : void
      {
         var _loc1_:int = 0;
         tempHonorEfforts = [];
         tempCompleteHonorEfforts = [];
         tempInCompleteHonorEfforts = [];
         var _loc4_:int = 0;
         var _loc3_:* = allEfforts;
         for each(var _loc2_ in allEfforts)
         {
            if(_loc2_.effortRewardArray)
            {
               _loc1_ = 0;
               while(_loc1_ < _loc2_.effortRewardArray.length)
               {
                  if((_loc2_.effortRewardArray[_loc1_] as EffortRewardInfo).RewardType == 1)
                  {
                     tempHonorEfforts.push(_loc2_);
                     if(EffortManager.Instance.tempEffortIsComplete(_loc2_.ID))
                     {
                        tempCompleteHonorEfforts.push(_loc2_);
                     }
                     else
                     {
                        tempInCompleteHonorEfforts.push(_loc2_);
                     }
                  }
                  _loc1_++;
               }
               continue;
            }
         }
      }
      
      public function getTempHonorEfforts() : Array
      {
         splitTempHonorEffort();
         return tempHonorEfforts;
      }
      
      public function getTempCompleteHonorEfforts() : Array
      {
         splitTempHonorEffort();
         return tempCompleteHonorEfforts;
      }
      
      public function getTempInCompleteHonorEfforts() : Array
      {
         splitTempHonorEffort();
         return tempInCompleteHonorEfforts;
      }
      
      public function tempEffortIsComplete(param1:int) : Boolean
      {
         return tempCompleteEfforts[param1];
      }
      
      public function getTempIntegrationEffort() : Array
      {
         return tempIntegrationEfforts;
      }
      
      public function getTempRoleEffort() : Array
      {
         return tempRoleEfforts;
      }
      
      public function getTempTaskEffort() : Array
      {
         return tempTaskEfforts;
      }
      
      public function getTempDuplicateEffort() : Array
      {
         return tempDuplicateEfforts;
      }
      
      public function getTempCombatEffort() : Array
      {
         return tempCombatEfforts;
      }
      
      public function getTempNewlyCompleteEffort() : Array
      {
         return tempNewlyCompleteEffort;
      }
      
      public function set isSelf(param1:Boolean) : void
      {
         _isSelf = param1;
      }
      
      public function get isSelf() : Boolean
      {
         return _isSelf;
      }
      
      public function getTempAchievementPoint() : int
      {
         return tempAchievementPoint;
      }
      
      public function getMainFrameVisible() : Boolean
      {
         return false;
      }
      
      public function switchVisible() : void
      {
         UIModuleLoader.Instance.addEventListener("uiModuleComplete",__onUIModuleComplete);
         UIModuleSmallLoading.Instance.progress = 0;
         UIModuleSmallLoading.Instance.show();
         UIModuleSmallLoading.Instance.addEventListener("close",__onClose);
         UIModuleLoader.Instance.addEventListener("uiMoudleProgress",__onProgress);
         UIModuleLoader.Instance.addUIModuleImp("ddtEffort");
      }
      
      private function __onClose(param1:Event) : void
      {
         UIModuleLoader.Instance.removeEventListener("uiModuleComplete",__onUIModuleComplete);
         UIModuleSmallLoading.Instance.hide();
         UIModuleSmallLoading.Instance.removeEventListener("close",__onClose);
      }
      
      private function __onProgress(param1:UIModuleEvent) : void
      {
         UIModuleSmallLoading.Instance.progress = param1.loader.progress * 100;
      }
      
      private function __onUIModuleComplete(param1:UIModuleEvent) : void
      {
         if(param1.module == "ddtEffort")
         {
            UIModuleSmallLoading.Instance.hide();
            UIModuleSmallLoading.Instance.removeEventListener("close",__onClose);
            UIModuleLoader.Instance.removeEventListener("uiModuleComplete",__onUIModuleComplete);
            if(!getMainFrameVisible())
            {
               show();
            }
         }
      }
      
      private function show() : void
      {
         BagAndInfoManager.Instance.showBagAndInfo(3);
      }
      
      private function __frameEvent(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         switch(int(param1.responseCode))
         {
            default:
            default:
            default:
            default:
         }
      }
   }
}
