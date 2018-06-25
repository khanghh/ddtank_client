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
      
      public function getEffortByID(id:int) : EffortInfo
      {
         if(!allEfforts)
         {
            return null;
         }
         return allEfforts[id];
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
         var i:int = 0;
         honorEfforts = [];
         completeHonorEfforts = [];
         inCompleteHonorEfforts = [];
         var _loc4_:int = 0;
         var _loc3_:* = allEfforts;
         for each(var info in allEfforts)
         {
            if(info.effortRewardArray)
            {
               i = 0;
               while(i < info.effortRewardArray.length)
               {
                  if((info.effortRewardArray[i] as EffortRewardInfo).RewardType == 1)
                  {
                     honorEfforts.push(info);
                     if(info.CompleteStateInfo)
                     {
                        completeHonorEfforts.push(info);
                     }
                     else
                     {
                        inCompleteHonorEfforts.push(info);
                     }
                  }
                  i++;
               }
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
      
      public function set currentEffortList(currentList:Array) : void
      {
         currentEfforts = [];
         currentEfforts = currentList;
         dispatchEvent(new EffortEvent("listChanged"));
      }
      
      public function setEffortType(type:int) : void
      {
         currentType = type;
         switch(int(type))
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
      
      private function splitEffort(dic:DictionaryData) : void
      {
         if(!dic)
         {
            return;
         }
         integrationEfforts = [];
         roleEfforts = [];
         taskEfforts = [];
         duplicateEfforts = [];
         combatEfforts = [];
         var _loc4_:int = 0;
         var _loc3_:* = dic;
         for each(var i in dic)
         {
            if(i)
            {
               switch(int(i.PlaceID))
               {
                  case 0:
                     integrationEfforts.push(i);
                     continue;
                  case 1:
                     roleEfforts.push(i);
                     continue;
                  case 2:
                     taskEfforts.push(i);
                     continue;
                  case 3:
                     duplicateEfforts.push(i);
                     continue;
                  case 4:
                     combatEfforts.push(i);
                     continue;
               }
            }
            else
            {
               continue;
            }
         }
      }
      
      private function __updateAchievement(evt:PkgEvent) : void
      {
         var i:int = 0;
         var info:* = null;
         var len:int = evt.pkg.readInt();
         for(i = 0; i < len; )
         {
            info = new EffortProgressInfo();
            info.RecordID = evt.pkg.readInt();
            info.Total = evt.pkg.readInt();
            progressEfforts[info.RecordID] = info;
            updateProgress(info);
            i++;
         }
      }
      
      private function __initializeAchievement(evt:PkgEvent) : void
      {
         var i:int = 0;
         var info:* = null;
         var len:int = evt.pkg.readInt();
         for(i = 0; i < len; )
         {
            info = new EffortProgressInfo();
            info.RecordID = evt.pkg.readInt();
            info.Total = evt.pkg.readInt();
            progressEfforts.add(info.RecordID,info);
            i++;
         }
         trace("初始化成绩进展成功");
         updateWholeProgress();
         splitHonorEffort();
      }
      
      private function __initializeAchievementData(evt:PkgEvent) : void
      {
         var i:int = 0;
         var info:* = null;
         var fullYearUTC:int = 0;
         var monthUTC:int = 0;
         var dateUTC:int = 0;
         var date:* = null;
         newlyCompleteEffort = [];
         var len:int = evt.pkg.readInt();
         count = len;
         for(i = 0; i < len; )
         {
            info = new EffortCompleteStateInfo();
            info.ID = evt.pkg.readInt();
            fullYearUTC = evt.pkg.readInt();
            monthUTC = evt.pkg.readInt();
            dateUTC = evt.pkg.readInt();
            date = new Date(fullYearUTC,monthUTC - 1,dateUTC);
            info.CompletedDate = date;
            if(allEfforts[info.ID])
            {
               (allEfforts[info.ID] as EffortInfo).CompleteStateInfo = info;
               (allEfforts[info.ID] as EffortInfo).completedDate = info.CompletedDate;
               if(i < 4)
               {
                  newlyCompleteEffort.push(allEfforts[info.ID]);
               }
            }
            i++;
         }
         splitPreEffort();
      }
      
      private function __userRank(event:PkgEvent) : void
      {
         var i:int = 0;
         var titleModel:* = null;
         var id:int = 0;
         var startDate:* = null;
         var endDate:* = null;
         var titleInfo:* = null;
         var j:int = 0;
         honorArray = [];
         var oldTitleArr:Array = [];
         var len:int = event.pkg.readInt();
         for(i = 0; i < len; )
         {
            titleModel = new NewTitleModel();
            id = event.pkg.readInt();
            titleModel.id = id;
            titleModel.Name = event.pkg.readUTF();
            startDate = event.pkg.readDate();
            endDate = event.pkg.readDate();
            titleModel.Valid = DateUtils.getHourDifference(new Date().time,endDate.time) / 24 + 1;
            if(id >= NewTitleManager.FIRST_TITLEID)
            {
               NewTitleManager.instance.titleInfo[id].Valid = titleModel.Valid;
               honorArray.push(NewTitleManager.instance.titleInfo[id]);
            }
            else
            {
               titleInfo = NewTitleManager.instance.getTitleByName(titleModel.Name);
               if(titleInfo)
               {
                  titleModel.Desc = titleInfo.Desc;
                  oldTitleArr.push(titleModel);
               }
            }
            i++;
         }
         honorArray.sortOn("id",16);
         for(j = 0; j < oldTitleArr.length; )
         {
            honorArray.push(oldTitleArr[j]);
            j++;
         }
         dispatchEvent(new EffortEvent("finish"));
      }
      
      private function splitPreEffort() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = allEfforts;
         for each(var info in allEfforts)
         {
            if(estimateEffortState(info))
            {
               preEfforts.add(info.ID,info);
            }
            if(estimateEffortState(info) && (isTopEffort(info) || !info.CompleteStateInfo))
            {
               preTopEfforts.add(info.ID,info);
            }
            else if(!estimateEffortState(info))
            {
               nextEfforts.add(info.ID,info);
            }
         }
         splitCompleteEffort();
         splitEffort(preEfforts);
      }
      
      private function inCompletedToPreTopEfforts() : void
      {
         var tempArray:* = null;
         var tempInfo:* = null;
         var i:int = 0;
         var _loc6_:int = 0;
         var _loc5_:* = completeEfforts;
         for each(var info in completeEfforts)
         {
            tempArray = getFellNextEffort(info.ID);
            tempArray.sortOn("ID");
            for(i = 0; i < tempArray.length; )
            {
               tempInfo = tempArray[i] as EffortInfo;
               if(!tempInfo.CompleteStateInfo && !isTopEffort(tempInfo))
               {
                  preTopEfforts.add(tempInfo.ID,tempInfo);
                  return;
               }
               i++;
            }
         }
      }
      
      private function estimateEffortState(info:EffortInfo) : Boolean
      {
         var i:int = 0;
         var strArray:Array = [];
         strArray = info.PreAchievementID.split(",");
         if(strArray.length == 2 && strArray[0] == "0")
         {
            return true;
         }
         i = 0;
         while(i <= strArray.length)
         {
            if(strArray[i] != "")
            {
               if((allEfforts[int(strArray[i])] as EffortInfo).CompleteStateInfo == null)
               {
                  return false;
               }
               i++;
               continue;
            }
            break;
         }
         return true;
      }
      
      public function getTopEffort1(info:EffortInfo) : int
      {
         var i:int = 0;
         if(isTopEffort(info) || !info.CompleteStateInfo)
         {
            return info.ID;
         }
         i = 1;
         while(!isTopEffort(getEffortByID(info.ID - i)))
         {
            i++;
         }
         return getEffortByID(info.ID - i).ID;
      }
      
      public function getTopEffort(info:EffortInfo) : int
      {
         if(isTopEffort(info) || !info.CompleteStateInfo)
         {
            return info.ID;
         }
         var strArray:Array = [];
         var lastID:int = getLastID(info);
         var resultID:int = -1;
         var info2:EffortInfo = getEffortByID(lastID);
         while(!isTopEffort(info2))
         {
            lastID = getLastID(info2);
            info2 = getEffortByID(lastID);
         }
         return lastID;
      }
      
      private function getLastID(info:EffortInfo) : int
      {
         var j:int = 0;
         var strArray:Array = [];
         strArray = info.PreAchievementID.split(",");
         var lastID:int = -1;
         for(j = 0; j < strArray.length; )
         {
            if(strArray[j].toString().length > 0)
            {
               lastID = strArray[j];
            }
            j++;
         }
         return lastID;
      }
      
      public function getCompleteNextEffort1(id:int) : Array
      {
         var i:int = 0;
         var j:int = 0;
         var completeNextEffortArray:Array = [];
         var strArray:Array = [];
         if(completeEfforts[id])
         {
            completeNextEffortArray.push(completeEfforts[id]);
         }
         i = 1;
         while(completeEfforts[id + i])
         {
            strArray = (completeEfforts[id + i] as EffortInfo).PreAchievementID.split(",");
            for(j = 0; j < strArray.length; )
            {
               if(isTopEffort(completeEfforts[id + i]))
               {
                  return completeNextEffortArray;
               }
               if(id + i - 1 == int(strArray[j]))
               {
                  completeNextEffortArray.push(completeEfforts[id + i]);
               }
               j++;
            }
            i++;
         }
         return completeNextEffortArray;
      }
      
      public function getCompleteNextEffort(id:int) : Array
      {
         var j:int = 0;
         var completeNextEffortArray:Array = [];
         var strArray:Array = [];
         completeEfforts.list.sortOn("ID",16);
         if(completeEfforts[id])
         {
            completeNextEffortArray.push(completeEfforts[id]);
         }
         var lastID:* = id;
         var _loc8_:int = 0;
         var _loc7_:* = completeEfforts.list;
         for each(var info in completeEfforts.list)
         {
            if(info && info.ID != id)
            {
               strArray = info.PreAchievementID.split(",");
               for(j = 0; j < strArray.length; )
               {
                  if(!isTopEffort(info))
                  {
                     if(lastID == int(strArray[j]))
                     {
                        completeNextEffortArray.push(info);
                        lastID = int(info.ID);
                     }
                  }
                  j++;
               }
               continue;
            }
         }
         return completeNextEffortArray;
      }
      
      public function getFellNextEffort(id:int) : Array
      {
         var i:int = 0;
         var j:int = 0;
         var fellNextEffortArray:Array = [];
         var strArray:Array = [];
         if(allEfforts[id])
         {
            fellNextEffortArray.push(allEfforts[id]);
         }
         i = 1;
         while(allEfforts[id + i])
         {
            strArray = (allEfforts[id + i] as EffortInfo).PreAchievementID.split(",");
            for(j = 0; j < strArray.length; )
            {
               if(isTopEffort(allEfforts[id + i]))
               {
                  return fellNextEffortArray;
               }
               if(id + i - 1 == int(strArray[j]))
               {
                  fellNextEffortArray.push(allEfforts[id + i]);
               }
               j++;
            }
            i++;
         }
         return fellNextEffortArray;
      }
      
      private function splitCompleteEffort() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = preEfforts;
         for each(var info in preEfforts)
         {
            if(info.CompleteStateInfo != null && isTopEffort(info))
            {
               completeTopEfforts.add(info.ID,info);
            }
            if(info.CompleteStateInfo != null)
            {
               completeEfforts.add(info.ID,info);
            }
            else
            {
               inCompleteEfforts.add(info.ID,info);
            }
         }
      }
      
      private function __AchievementFinish(evt:PkgEvent) : void
      {
         var info:EffortCompleteStateInfo = new EffortCompleteStateInfo();
         info.ID = evt.pkg.readInt();
         var fullYearUTC:int = evt.pkg.readInt();
         var monthUTC:int = evt.pkg.readInt();
         var dateUTC:int = evt.pkg.readInt();
         var date:Date = new Date(fullYearUTC,monthUTC - 1,dateUTC);
         info.CompletedDate = date;
         trace("接受完成" + info.ID);
         if(inCompleteEfforts[info.ID])
         {
            (inCompleteEfforts[info.ID] as EffortInfo).CompleteStateInfo = info;
            (inCompleteEfforts[info.ID] as EffortInfo).completedDate = info.CompletedDate;
         }
         if(allEfforts[info.ID])
         {
            (allEfforts[info.ID] as EffortInfo).CompleteStateInfo = info;
            (allEfforts[info.ID] as EffortInfo).completedDate = info.CompletedDate;
         }
         completeToInComplete(info.ID);
         if(newlyCompleteEffort)
         {
            newlyCompleteEffort.unshift(completeEfforts[info.ID]);
         }
         dispatchEvent(new EffortEvent("finish"));
      }
      
      private function updateWholeProgress() : void
      {
         var j:int = 0;
         var _loc9_:int = 0;
         var _loc8_:* = allEfforts;
         for each(var effortInfo in allEfforts)
         {
            var _loc7_:int = 0;
            var _loc6_:* = effortInfo.EffortQualificationList;
            for each(var effortQualificationInfo in effortInfo.EffortQualificationList)
            {
               if(!progressEfforts[effortQualificationInfo.CondictionType])
               {
                  trace("成就进展出错，没有" + effortQualificationInfo.CondictionType + "（CondictionType）");
               }
               effortQualificationInfo.para2_currentValue = (progressEfforts[effortQualificationInfo.CondictionType] as EffortProgressInfo).Total;
               effortInfo.addEffortQualification(effortQualificationInfo);
            }
            allEfforts[effortInfo.ID] = effortInfo;
         }
         trace("初始化成绩赋值成功");
         trace("初始化成绩赋值成功");
         var tempArray:Array = [];
         var _loc11_:int = 0;
         var _loc10_:* = allEfforts;
         for each(var i in allEfforts)
         {
            if(testEffortIsComplete(i))
            {
               tempArray.push(i);
            }
         }
         tempArray.sortOn("ID");
         if(count != tempArray.length)
         {
            for(j = 0; j < tempArray.length; )
            {
               trace("初始化发送已完成" + tempArray[j].ID);
               SocketManager.Instance.out.sendAchievementFinish(tempArray[j].ID);
               j++;
            }
         }
      }
      
      private function updateProgress(info:EffortProgressInfo) : void
      {
         var k:int = 0;
         var tempArray:Array = [];
         var _loc11_:int = 0;
         var _loc10_:* = allEfforts;
         for each(var effortInfo in allEfforts)
         {
            var _loc9_:int = 0;
            var _loc8_:* = effortInfo.EffortQualificationList;
            for each(var effortQualificationInfo in effortInfo.EffortQualificationList)
            {
               if(effortQualificationInfo.CondictionType == info.RecordID)
               {
                  effortQualificationInfo.para2_currentValue = info.Total;
                  effortInfo.addEffortQualification(effortQualificationInfo);
               }
            }
         }
         var _loc13_:int = 0;
         var _loc12_:* = inCompleteEfforts;
         for each(var i in inCompleteEfforts)
         {
            if(testEffortIsComplete(i))
            {
               tempArray.push(i);
            }
         }
         var _loc15_:int = 0;
         var _loc14_:* = nextEfforts;
         for each(var j in nextEfforts)
         {
            if(testEffortIsComplete(j))
            {
               tempArray.push(j);
            }
         }
         if(tempArray && tempArray[0])
         {
            tempArray.sortOn("ID");
         }
         k = 0;
         while(k < tempArray.length)
         {
            trace("初始化发送已完成" + tempArray[k].ID);
            SocketManager.Instance.out.sendAchievementFinish(tempArray[k].ID);
            k++;
         }
      }
      
      private function testEffortIsComplete(info:EffortInfo) : Boolean
      {
         var _loc4_:int = 0;
         var _loc3_:* = info.EffortQualificationList;
         for each(var effortQualificationInfo in info.EffortQualificationList)
         {
            if(effortQualificationInfo.para2_currentValue < effortQualificationInfo.Condiction_Para2)
            {
               return false;
            }
         }
         return true;
      }
      
      public function splitTitle(str:String) : String
      {
         var strArray:Array = [];
         strArray = str.split("/");
         if(strArray.length > 1 && strArray[1] != "")
         {
            if(PlayerManager.Instance.Self.Sex)
            {
               return strArray[0];
            }
            return strArray[1];
         }
         return strArray[0];
      }
      
      public function testFunction(id:int) : void
      {
      }
      
      private function completeToInComplete(id:int) : void
      {
         if(inCompleteEfforts[id] && isTopEffort(inCompleteEfforts[id]))
         {
            completeTopEfforts.add(id,inCompleteEfforts[id]);
            preTopEfforts.add(id,inCompleteEfforts[id]);
         }
         if(inCompleteEfforts[id])
         {
            completeEfforts.add(id,inCompleteEfforts[id]);
         }
         var fullEffort:Array = getFellNextEffort(id);
         if(id == fullEffort[fullEffort.length - 1].ID && (allEfforts[id] as EffortInfo).IsOther)
         {
            preTopEfforts.remove(id);
         }
         inCompleteEfforts.remove(id);
         nextToPre();
      }
      
      private function isTopEffort(info:EffortInfo) : Boolean
      {
         return info.PreAchievementID == "0,";
      }
      
      private function nextToPre() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = nextEfforts;
         for each(var info in nextEfforts)
         {
            if(estimateEffortState(info))
            {
               preEfforts.add(info.ID,info);
               nextEfforts.remove(info.ID);
               nexToPreTop(info);
               if(testEffortIsComplete(info) && isTopEffort(info))
               {
                  completeTopEfforts.add(info.ID,info);
               }
               if(testEffortIsComplete(info))
               {
                  completeEfforts.add(info.ID,info);
               }
               else
               {
                  inCompleteEfforts.add(info.ID,info);
               }
            }
         }
         setEffortType(currentType);
      }
      
      private function nexToPreTop(info:EffortInfo) : void
      {
         var strArray:* = null;
         var i:int = 0;
         if(!info.CompleteStateInfo)
         {
            preTopEfforts.add(info.ID,info);
            if(info.PreAchievementID != "0,")
            {
               strArray = [];
               strArray = info.PreAchievementID.split(",");
               for(i = 0; i <= strArray.length; )
               {
                  if(strArray[i] != "")
                  {
                     if(preTopEfforts[int(strArray[i])] && !isTopEffort(preTopEfforts[int(strArray[i])]))
                     {
                        preTopEfforts.remove(int(strArray[i]));
                     }
                     i++;
                     continue;
                  }
                  break;
               }
            }
         }
      }
      
      public function lookUpEffort(id:int) : void
      {
         SocketManager.Instance.out.sendLookupEffort(id);
      }
      
      private function __lookUpEffort(evt:PkgEvent) : void
      {
         var i:int = 0;
         tempPreEfforts = new DictionaryData();
         tempPreTopEfforts = new DictionaryData();
         tempCompleteEfforts = new DictionaryData();
         tempInCompleteEfforts = new DictionaryData();
         tempCompleteNextEfforts = new DictionaryData();
         tempInCompleteTopEfforts = new DictionaryData();
         tempNewlyCompleteEffort = [];
         tempCompleteID = [];
         tempAchievementPoint = evt.pkg.readInt();
         var len:int = evt.pkg.readInt();
         for(i = 0; i < len; )
         {
            if(len != 0)
            {
               tempCompleteID[i] = evt.pkg.readInt();
               if(allEfforts[tempCompleteID[i]] && isTopEffort(allEfforts[tempCompleteID[i]]))
               {
                  tempInCompleteTopEfforts.add(tempCompleteID[i],allEfforts[tempCompleteID[i]]);
               }
               if(allEfforts[tempCompleteID[i]])
               {
                  tempCompleteEfforts.add(tempCompleteID[i],allEfforts[tempCompleteID[i]]);
               }
               if(i < 4)
               {
                  tempNewlyCompleteEffort[i] = allEfforts[tempCompleteID[i]];
               }
               i++;
               continue;
            }
            break;
         }
         var _loc6_:int = 0;
         var _loc5_:* = allEfforts;
         for each(var info in allEfforts)
         {
            if(estimateTempEffortState(info))
            {
               tempPreEfforts.add(info.ID,info);
               if(isTopEffort(info) || !tempCompleteEfforts[info.ID])
               {
                  tempPreTopEfforts.add(info.ID,info);
               }
               if(!tempCompleteEfforts[info.ID])
               {
                  tempInCompleteEfforts.add(info.ID,info);
               }
            }
         }
         setTempEffortType(0);
         isSelf = false;
         EffortManager.Instance.switchVisible();
      }
      
      private function estimateTempEffortState(info:EffortInfo) : Boolean
      {
         var i:int = 0;
         var strArray:Array = [];
         strArray = info.PreAchievementID.split(",");
         if(strArray.length == 2 && strArray[0] == "0")
         {
            return true;
         }
         i = 0;
         while(i <= strArray.length)
         {
            if(strArray[i] != "")
            {
               if(tempCompleteEfforts[int(strArray[i])] == null)
               {
                  return false;
               }
               i++;
               continue;
            }
            break;
         }
         return true;
      }
      
      public function setTempEffortType(type:int) : void
      {
         switch(int(type))
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
      
      private function splitTempEffort(dic:DictionaryData) : void
      {
         if(!dic)
         {
            return;
         }
         tempIntegrationEfforts = [];
         tempRoleEfforts = [];
         tempTaskEfforts = [];
         tempDuplicateEfforts = [];
         tempCombatEfforts = [];
         var _loc4_:int = 0;
         var _loc3_:* = dic;
         for each(var i in dic)
         {
            if(i)
            {
               switch(int(i.PlaceID))
               {
                  case 0:
                     tempIntegrationEfforts.push(i);
                     continue;
                  case 1:
                     tempRoleEfforts.push(i);
                     continue;
                  case 2:
                     tempTaskEfforts.push(i);
                     continue;
                  case 3:
                     tempDuplicateEfforts.push(i);
                     continue;
                  case 4:
                     tempCombatEfforts.push(i);
                     continue;
               }
            }
            else
            {
               continue;
            }
         }
      }
      
      public function getTempTopEffort(info:EffortInfo) : int
      {
         var i:int = 0;
         if(isTopEffort(info) || !tempEffortIsComplete(info.ID))
         {
            return info.ID;
         }
         i = 1;
         while(!isTopEffort(getEffortByID(info.ID - i)))
         {
            i++;
         }
         return getEffortByID(info.ID - i).ID;
      }
      
      public function getTempCompleteNextEffort(id:int) : Array
      {
         var i:int = 0;
         var j:int = 0;
         var completeNextEffortArray:Array = [];
         var strArray:Array = [];
         if(tempEffortIsComplete(id))
         {
            completeNextEffortArray.push(tempCompleteEfforts[id]);
         }
         i = 1;
         while(tempCompleteEfforts[id + i])
         {
            strArray = (tempCompleteEfforts[id + i] as EffortInfo).PreAchievementID.split(",");
            for(j = 0; j < strArray.length; )
            {
               if(isTopEffort(tempCompleteEfforts[id + i]))
               {
                  return completeNextEffortArray;
               }
               if(id + i - 1 == int(strArray[j]))
               {
                  completeNextEffortArray.push(tempCompleteEfforts[id + i]);
               }
               j++;
            }
            i++;
         }
         return completeNextEffortArray;
      }
      
      private function splitTempHonorEffort() : void
      {
         var i:int = 0;
         tempHonorEfforts = [];
         tempCompleteHonorEfforts = [];
         tempInCompleteHonorEfforts = [];
         var _loc4_:int = 0;
         var _loc3_:* = allEfforts;
         for each(var info in allEfforts)
         {
            if(info.effortRewardArray)
            {
               i = 0;
               while(i < info.effortRewardArray.length)
               {
                  if((info.effortRewardArray[i] as EffortRewardInfo).RewardType == 1)
                  {
                     tempHonorEfforts.push(info);
                     if(EffortManager.Instance.tempEffortIsComplete(info.ID))
                     {
                        tempCompleteHonorEfforts.push(info);
                     }
                     else
                     {
                        tempInCompleteHonorEfforts.push(info);
                     }
                  }
                  i++;
               }
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
      
      public function tempEffortIsComplete(id:int) : Boolean
      {
         return tempCompleteEfforts[id];
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
      
      public function set isSelf(value:Boolean) : void
      {
         _isSelf = value;
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
      
      private function __onClose(event:Event) : void
      {
         UIModuleLoader.Instance.removeEventListener("uiModuleComplete",__onUIModuleComplete);
         UIModuleSmallLoading.Instance.hide();
         UIModuleSmallLoading.Instance.removeEventListener("close",__onClose);
      }
      
      private function __onProgress(event:UIModuleEvent) : void
      {
         UIModuleSmallLoading.Instance.progress = event.loader.progress * 100;
      }
      
      private function __onUIModuleComplete(event:UIModuleEvent) : void
      {
         if(event.module == "ddtEffort")
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
      
      private function __frameEvent(event:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         switch(int(event.responseCode))
         {
            default:
            default:
            default:
            default:
         }
      }
   }
}
