package quest
{
   import collectionTask.event.CollectionTaskEvent;
   import com.pickgliss.action.ShowTipAction;
   import com.pickgliss.loader.BaseLoader;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.loader.TextLoader;
   import com.pickgliss.manager.CacheSysManager;
   import com.pickgliss.manager.NoviceDataManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.CoreManager;
   import ddt.data.analyze.QuestListAnalyzer;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.player.SelfInfo;
   import ddt.data.quest.QuestCategory;
   import ddt.data.quest.QuestCondition;
   import ddt.data.quest.QuestDataInfo;
   import ddt.data.quest.QuestImproveInfo;
   import ddt.data.quest.QuestInfo;
   import ddt.events.BagEvent;
   import ddt.events.CEvent;
   import ddt.events.PkgEvent;
   import ddt.events.PlayerPropertyEvent;
   import ddt.events.TaskEvent;
   import ddt.manager.ChatManager;
   import ddt.manager.DesktopManager;
   import ddt.manager.ExitPromptManager;
   import ddt.manager.PathManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.StateManager;
   import ddt.utils.BitArray;
   import ddt.utils.HelperUIModuleLoad;
   import ddt.utils.RequestVairableCreater;
   import ddt.view.MainToolBar;
   import ddt.view.chat.ChatEvent;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.net.URLVariables;
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   import hall.tasktrack.HallTaskTrackManager;
   import oldPlayerRegress.RegressEvent;
   import petsBag.PetsBagManager;
   import petsBag.event.UpdatePetFarmGuildeEvent;
   import road7th.comm.PackageIn;
   import road7th.data.DictionaryData;
   import road7th.data.DictionaryEvent;
   import road7th.utils.MovieClipWrapper;
   import trainer.controller.LevelRewardManager;
   import trainer.controller.NewHandGuideManager;
   import trainer.controller.WeakGuildManager;
   import tryonSystem.TryonSystemController;
   
   [Event(name="changed",type="tank.events.TaskEvent")]
   [Event(name="add",type="tank.events.TaskEvent")]
   [Event(name="remove",type="tank.events.TaskEvent")]
   public class TaskManager extends CoreManager
   {
      
      public static const REFRESH_TASK_TRACK_VIEW:String = "taskRefreshHallTaskTrackView";
      
      public static const TASK_FRAME_SHOW:String = "taskFrameShow";
      
      public static const TASK_FRAME_HIDE:String = "taskFrameHide";
      
      public static const TASK_JUMPTOQUEST:String = "taskJumpToQuest";
      
      public static const TASK_GOTOQUEST:String = "taskGotoQuest";
      
      public static const NORMAL:int = 1;
      
      public static const GUIDE:int = 2;
      
      public static const REWARD_UDERLINE:int = 417;
      
      public static const GUIDE_QUEST_ID:int = 339;
      
      public static const COLLECT_INFO_EMAIL:int = 544;
      
      public static const COLLECT_INFO_CELLPHONE:int = 545;
      
      public static const COLLECT_INFO_CELLPHONEII:int = 550;
      
      public static const achievementQuestNo:int = 1000;
      
      public static const HALLICON_TASKTYPE:int = 2042;
      
      public static var itemAwardSelected:int;
      
      private static var _selectedQuest:QuestInfo;
      
      public static var rewardTaskMultiple:int;
      
      public static const SHOW_TASK_HIGHTLIGHT:String = "showTaskHightLight";
      
      public static const HIDE_TASK_HIGHTLIGHT:String = "hideTaskHightLight";
      
      private static var _questListLoader:TextLoader;
      
      private static var _questDataInited:Boolean;
      
      private static var _instance:TaskManager;
      
      private static var firstshowTask:Boolean = true;
      
      private static var _allQuests:Dictionary;
      
      private static var _questLog:BitArray;
      
      public static var _newQuests:Array = [];
      
      public static var _currentCategory:int = 0;
      
      public static var currentQuest:QuestInfo;
      
      private static var _currentNewQuest:QuestInfo;
      
      private static var _isShowing:Boolean;
      
      private static var mc:MovieClipWrapper;
      
      private static var _itemListenerArr:Array;
      
      private static var _consortChatConditions:Array;
       
      
      public var isTaskHightLight:Boolean = false;
      
      public var guideId:int;
      
      private var _improve:QuestImproveInfo;
      
      private var _requestAddQuestDic:Dictionary;
      
      private var _events:Array;
      
      private var _returnFun:Function;
      
      private var _isShown:Boolean = false;
      
      private var _annexListenerArr:Array;
      
      private var _desktopCond:QuestCondition;
      
      private var _friendListenerArr:Array;
      
      private var tmpQuestId:int;
      
      private var _manuGetList:DictionaryData;
      
      public function TaskManager()
      {
         _events = [];
         _manuGetList = new DictionaryData();
         super();
      }
      
      public static function get instance() : TaskManager
      {
         if(_instance == null)
         {
            _instance = new TaskManager();
         }
         return _instance;
      }
      
      public function get improve() : QuestImproveInfo
      {
         return _improve;
      }
      
      public function set selectedQuest(value:QuestInfo) : void
      {
         _selectedQuest = value;
      }
      
      public function get selectedQuest() : QuestInfo
      {
         return _selectedQuest;
      }
      
      public function switchVisible() : void
      {
         if(firstshowTask)
         {
            _returnFun = switchVisible;
            moduleLoad();
            return;
         }
         if(!_isShown)
         {
            _isShown = true;
            taskFrameShow();
         }
         else
         {
            if(TryonSystemController.Instance.view != null)
            {
               return;
            }
            _isShown = false;
            taskFrameHide();
         }
      }
      
      public function taskFrameShow() : void
      {
         _events.push(new Event("taskFrameShow"));
         show();
      }
      
      override protected function start() : void
      {
         if(_events.length <= 0)
         {
            return;
         }
         var event:Event = _events.shift();
         dispatchEvent(event);
         start();
      }
      
      public function taskFrameHide() : void
      {
         dispatchEvent(new Event("taskFrameHide"));
      }
      
      private function moduleLoad() : void
      {
         new HelperUIModuleLoad().loadUIModule(["ddtbagandinfo","quest"],questOnLoaded);
      }
      
      private function questOnLoaded() : void
      {
         firstshowTask = false;
      }
      
      public function get isShow() : Boolean
      {
         return _isShown;
      }
      
      public function set isShow(value:Boolean) : void
      {
         _isShown = value;
      }
      
      public function setup(analyzer:QuestListAnalyzer) : void
      {
         allQuests = analyzer.list;
         _questDataInited = false;
         _improve = getImproveArray(analyzer.improveXml);
         SocketManager.Instance.addEventListener(PkgEvent.format(178),__updateAcceptedTask);
         SocketManager.Instance.addEventListener(PkgEvent.format(179),__questFinish);
         SocketManager.Instance.addEventListener(PkgEvent.format(273),questManuGetHandler);
      }
      
      public function reloadNewQuest(analyzer:QuestListAnalyzer) : void
      {
         var tempQuests:Dictionary = analyzer.list;
         var _loc5_:int = 0;
         var _loc4_:* = tempQuests;
         for each(var info in tempQuests)
         {
            if(getQuestByID(info.id) == null)
            {
               addQuest(info);
            }
         }
      }
      
      private function getImproveArray(xml:XML) : QuestImproveInfo
      {
         var questImprove:QuestImproveInfo = new QuestImproveInfo();
         questImprove.bindMoneyRate = String(xml.@BindMoneyRate).split("|");
         questImprove.expRate = String(xml.@ExpRate).split("|");
         questImprove.goldRate = String(xml.@GoldRate).split("|");
         questImprove.exploitRate = String(xml.@ExploitRate).split("|");
         questImprove.canOneKeyFinishTime = Number(xml.@CanOneKeyFinishTime);
         return questImprove;
      }
      
      public function addQuest(info:QuestInfo) : void
      {
         TaskManager.instance.allQuests[info.Id] = info;
      }
      
      public function loadQuestLog(value:ByteArray) : void
      {
         var i:int = 0;
         value.position = 0;
         _questLog = new BitArray();
         for(i = 0; i < value.length; )
         {
            _questLog.writeByte(value.readByte());
            i++;
         }
      }
      
      private function IsQuestFinish(questId:int) : Boolean
      {
         if(!_questLog)
         {
            return false;
         }
         if(questId > _questLog.length * 8 || questId < 1)
         {
            return false;
         }
         questId--;
         var index:int = questId / 8;
         var offset:int = questId % 8;
         var result:* = _questLog[index] & 1 << offset;
         return result != 0;
      }
      
      public function get allQuests() : Dictionary
      {
         if(!_allQuests)
         {
            _allQuests = new Dictionary();
         }
         return _allQuests;
      }
      
      public function set allQuests(dict:Dictionary) : void
      {
         _allQuests = dict;
      }
      
      public function getQuestByID(id:int) : QuestInfo
      {
         if(!allQuests)
         {
            return null;
         }
         return allQuests[id];
      }
      
      public function getQuestDataByID(id:int) : QuestDataInfo
      {
         if(!getQuestByID(id))
         {
            return null;
         }
         return getQuestByID(id).data;
      }
      
      public function getAllQuestInfoByType(type:int) : Array
      {
         var temArr:Array = [];
         var _loc5_:int = 0;
         var _loc4_:* = allQuests;
         for each(var info in allQuests)
         {
            if(info.Type == type)
            {
               temArr.push(info);
            }
         }
         return temArr;
      }
      
      public function getAvailableQuests(type:int = -1, onlyExist:Boolean = true) : QuestCategory
      {
         var cate:QuestCategory = new QuestCategory();
         var _loc6_:int = 0;
         var _loc5_:* = allQuests;
         for each(var info in allQuests)
         {
            if(!(info.id >= 4001 && info.id <= 4024))
            {
               if(type > -1)
               {
                  if(type == 0)
                  {
                     if(info.Type != 0)
                     {
                        continue;
                     }
                  }
                  else if(type == 1)
                  {
                     if(info.Type != 4 && info.Type != 1 && info.Type != 6 && info.Type != 15)
                     {
                        continue;
                     }
                  }
                  else if(type == 2)
                  {
                     if(info.Type != 2 && info.Type < 100)
                     {
                        continue;
                     }
                  }
                  else if(type == 3)
                  {
                     if(info.Type != 3)
                     {
                        continue;
                     }
                  }
                  else if(type == 4)
                  {
                     if(info.Type != 7)
                     {
                        continue;
                     }
                  }
                  else if(type == 5)
                  {
                     if(info.Type != 10)
                     {
                        continue;
                     }
                  }
                  else if(type == 6)
                  {
                     if(info.Type != 66)
                     {
                        continue;
                     }
                  }
                  else if(type == 7)
                  {
                     if(info.Type != 12)
                     {
                        continue;
                     }
                  }
                  else if(type == 8)
                  {
                     if(info.Type != 17)
                     {
                        continue;
                     }
                  }
               }
               if(!(onlyExist && info.data && !info.data.isExist))
               {
                  if(isAvailableQuest(info,true))
                  {
                     if(info.Id != 1000)
                     {
                        if(info.isCompleted)
                        {
                           cate.addCompleted(info);
                        }
                        else if(info.data && info.data.isNew)
                        {
                           cate.addNew(info);
                        }
                        else
                        {
                           cate.addQuest(info);
                        }
                     }
                  }
               }
            }
         }
         checkSendRequestAddQuestDic();
         return cate;
      }
      
      public function getQuestCategory() : void
      {
      }
      
      public function get allHotQuests() : Array
      {
         return getAvailableQuests(6,false).list;
      }
      
      public function get allAvailableQuests() : Array
      {
         return getAvailableQuests(-1,false).list;
      }
      
      public function get allCurrentQuest() : Array
      {
         return getAvailableQuests(-1,true).list;
      }
      
      public function get mainQuests() : Array
      {
         return getAvailableQuests(0,true).list;
      }
      
      public function get sideQuests() : Array
      {
         return getAvailableQuests(1,true).list;
      }
      
      public function get dailyQuests() : Array
      {
         return getAvailableQuests(2,true).list;
      }
      
      public function get texpQuests() : Array
      {
         var cate:QuestCategory = new QuestCategory();
         var _loc4_:int = 0;
         var _loc3_:* = allQuests;
         for each(var info in allQuests)
         {
            if(info.Type >= 100)
            {
               if(info.data && !info.data.isExist)
               {
                  addRequestAddQuestDic(info.QuestID,info);
               }
               else if(isAvailableQuest(info,true))
               {
                  if(info.Id != 1000)
                  {
                     trace(info.Detail);
                     if(info.isCompleted)
                     {
                        cate.addCompleted(info);
                     }
                     else if(info.data && info.data.isNew)
                     {
                        cate.addNew(info);
                     }
                     else
                     {
                        cate.addQuest(info);
                     }
                  }
               }
            }
         }
         checkSendRequestAddQuestDic();
         return cate.list;
      }
      
      public function get newQuests() : Array
      {
         var tempArr:Array = [];
         var _loc4_:int = 0;
         var _loc3_:* = allAvailableQuests;
         for each(var info in allAvailableQuests)
         {
            if(info.data && info.data.needInformed && info.Type != 2)
            {
               tempArr.push(info);
            }
         }
         _newQuests = tempArr;
         return tempArr;
      }
      
      public function set currentCategory(value:int) : void
      {
         _currentCategory = value;
      }
      
      public function get currentCategory() : int
      {
         if(selectedQuest)
         {
            return selectedQuest.Type;
         }
         return _currentCategory;
      }
      
      public function get welcomeQuests() : Array
      {
         var tempArr:Array = [];
         var _loc4_:int = 0;
         var _loc3_:* = dailyQuests;
         for each(var info in dailyQuests)
         {
            if(info.otherCondition != 1)
            {
               tempArr.push(info);
            }
         }
         tempArr = tempArr.reverse();
         return tempArr;
      }
      
      public function get welcomeGuildQuests() : Array
      {
         var tempArr:Array = [];
         var _loc4_:int = 0;
         var _loc3_:* = dailyQuests;
         for each(var info in dailyQuests)
         {
            if(info.otherCondition == 1)
            {
               tempArr.push(info);
            }
         }
         tempArr = tempArr.reverse();
         return tempArr;
      }
      
      public function getTaskData(id:int) : QuestDataInfo
      {
         if(getQuestByID(id))
         {
            return getQuestByID(id).data;
         }
         return null;
      }
      
      public function isAvailableQuest(info:QuestInfo, checkExist:Boolean = false) : Boolean
      {
         var i:int = 0;
         var grade:int = 0;
         var preArr:* = null;
         var preQuest:* = null;
         var dis:Array = PathManager.DISABLE_TASK_ID;
         for(i = 0; i < dis.length; )
         {
            if(info.id == parseInt(dis[i]))
            {
               return false;
            }
            i++;
         }
         if(info.disabled)
         {
            return false;
         }
         if(info.texpTaskIsTimeOut())
         {
            return false;
         }
         if(info.Type <= 100)
         {
            grade = PlayerManager.Instance.Self.Grade;
            if(info.NeedMinLevel > grade || info.NeedMaxLevel < grade)
            {
               return false;
            }
         }
         if(info.PreQuestID != "0,")
         {
            preArr = [];
            preArr = info.PreQuestID.split(",");
            var _loc10_:int = 0;
            var _loc9_:* = preArr;
            for each(var preId in preArr)
            {
               if(preId != 0)
               {
                  if(getQuestByID(preId))
                  {
                     preQuest = getQuestByID(preId);
                     if(!preQuest)
                     {
                        return false;
                     }
                     if(!isAchieved(preQuest))
                     {
                        return false;
                     }
                  }
               }
            }
         }
         if(!(isValidateByDate(info) && isAvailableByGuild(info) && isAvailableByMarry(info)))
         {
            return false;
         }
         if(info.Type <= 100 && haveLog(info))
         {
            return false;
         }
         if(!info.isAvailable)
         {
            return false;
         }
         if(info.data == null || !info.data.isExist && info.CanRepeat)
         {
            addRequestAddQuestDic(info.QuestID,info);
            if(checkExist && info.Type != 4)
            {
               return false;
            }
         }
         if(info.isManuGet && (!info.data || !info.data.isGet))
         {
            if(!_manuGetList.hasKey(info.id))
            {
               _manuGetList.add(info.id,info);
            }
            return false;
         }
         return true;
      }
      
      public function isAchieved(info:QuestInfo) : Boolean
      {
         if(info.isAchieved)
         {
            return true;
         }
         if(!info.CanRepeat)
         {
            if(IsQuestFinish(info.Id))
            {
               return true;
            }
         }
         return false;
      }
      
      public function isCompleted(info:QuestInfo) : Boolean
      {
         if(info.isCompleted)
         {
            return true;
         }
         return false;
      }
      
      public function isAvailable(info:QuestInfo) : Boolean
      {
         if(!info)
         {
            return false;
         }
         return isAvailableQuest(info) && !info.isCompleted;
      }
      
      private function haveLog(info:QuestInfo) : Boolean
      {
         if(info.CanRepeat)
         {
            if(info.data && info.data.repeatLeft == 0)
            {
               return true;
            }
            return false;
         }
         if(IsQuestFinish(info.Id))
         {
            return true;
         }
         return false;
      }
      
      public function isValidateByDate(info:QuestInfo) : Boolean
      {
         if(!info)
         {
            return false;
         }
         return !info.isTimeOut();
      }
      
      public function isAvailableByGuild(info:QuestInfo) : Boolean
      {
         if(!info)
         {
            return false;
         }
         return info.otherCondition != 1 || PlayerManager.Instance.Self.ConsortiaID != 0;
      }
      
      public function isAvailableByMarry(info:QuestInfo) : Boolean
      {
         if(!info)
         {
            return false;
         }
         return info.otherCondition != 2 || PlayerManager.Instance.Self.IsMarried;
      }
      
      private function questManuGetHandler(event:PkgEvent) : void
      {
         var pkg:PackageIn = event.pkg;
         var isSuccess:Boolean = pkg.readBoolean();
         var questId:int = pkg.readInt();
         _manuGetList.remove(questId);
         if(isSuccess)
         {
            SoundManager.instance.play("216");
         }
         if(questId == 559 || questId == 561 || questId == 563 || questId == 565 || questId == 567 || questId == 569)
         {
            TaskManager.instance.jumpToQuestByID(questId);
         }
         if(questId == 558)
         {
            NoviceDataManager.instance.saveNoviceData(340,PathManager.userName(),PathManager.solveRequestPath());
         }
         if(questId == 559)
         {
            NoviceDataManager.instance.saveNoviceData(380,PathManager.userName(),PathManager.solveRequestPath());
         }
         if(questId == 560)
         {
            NoviceDataManager.instance.saveNoviceData(480,PathManager.userName(),PathManager.solveRequestPath());
         }
         if(questId == 562)
         {
            NoviceDataManager.instance.saveNoviceData(660,PathManager.userName(),PathManager.solveRequestPath());
         }
         if(questId == 563)
         {
            NoviceDataManager.instance.saveNoviceData(580,PathManager.userName(),PathManager.solveRequestPath());
         }
         if(questId == 564)
         {
            NoviceDataManager.instance.saveNoviceData(990,PathManager.userName(),PathManager.solveRequestPath());
         }
         if(questId == 565)
         {
            NoviceDataManager.instance.saveNoviceData(810,PathManager.userName(),PathManager.solveRequestPath());
         }
         if(questId == 566)
         {
            NoviceDataManager.instance.saveNoviceData(840,PathManager.userName(),PathManager.solveRequestPath());
         }
         if(questId == 567)
         {
            NoviceDataManager.instance.saveNoviceData(920,PathManager.userName(),PathManager.solveRequestPath());
         }
         if(questId == 569)
         {
            NoviceDataManager.instance.saveNoviceData(740,PathManager.userName(),PathManager.solveRequestPath());
         }
      }
      
      public function __updateAcceptedTask(event:PkgEvent) : void
      {
         var i:int = 0;
         var id:int = 0;
         var info:* = null;
         var data:* = null;
         var con0:int = 0;
         var con1:int = 0;
         var con2:int = 0;
         var con3:int = 0;
         var isAutoCom0:Boolean = false;
         var isAutoCom1:Boolean = false;
         var isAutoCom2:Boolean = false;
         var isAutoCom3:Boolean = false;
         var tmpConArr:* = null;
         var tmpAutoComVec:* = undefined;
         var tmpConLen:int = 0;
         var k:int = 0;
         var tmpIndex:int = 0;
         var pkg:PackageIn = event.pkg;
         var length:int = pkg.readInt();
         for(i = 0; i < length; )
         {
            id = pkg.readInt();
            info = new QuestInfo();
            if(getQuestByID(id))
            {
               info = getQuestByID(id);
               if(info.data)
               {
                  data = info.data;
               }
               else
               {
                  data = new QuestDataInfo(id);
                  if(info.required)
                  {
                     data.isNew = true;
                  }
               }
               data.isAchieved = pkg.readBoolean();
               con0 = pkg.readInt();
               con1 = pkg.readInt();
               con2 = pkg.readInt();
               con3 = pkg.readInt();
               data.setProgress(con0,con1,con2,con3);
               data.CompleteDate = pkg.readDate();
               data.repeatLeft = pkg.readInt();
               data.quality = pkg.readInt();
               data.isExist = pkg.readBoolean();
               info.QuestLevel = pkg.readInt();
               data.AddTiemsDate = pkg.readDate();
               isAutoCom0 = pkg.readInt() == 0?false:true;
               isAutoCom1 = pkg.readInt() == 0?false:true;
               isAutoCom2 = pkg.readInt() == 0?false:true;
               isAutoCom3 = pkg.readInt() == 0?false:true;
               data.setIsAutoComplete(isAutoCom0,isAutoCom1,isAutoCom2,isAutoCom3);
               tmpConArr = [0,0,0,0];
               tmpAutoComVec = new <Boolean>[false,false,false,false];
               tmpConLen = pkg.readInt();
               for(k = 0; k < tmpConLen; )
               {
                  tmpIndex = pkg.readInt() - 4;
                  tmpConArr[tmpIndex] = pkg.readInt();
                  tmpAutoComVec[tmpIndex] = pkg.readInt() == 0?false:true;
                  k++;
               }
               data.setProgressConcoat(tmpConArr);
               data.setIsAutoCompleteConcoat(tmpAutoComVec);
               data.isGet = pkg.readBoolean();
               info.data = data;
               if(data.isNew)
               {
                  addNewQuest(info);
               }
               if(PetsBagManager.instance().isPetFarmGuildeTask(info.QuestID))
               {
                  PetsBagManager.instance().dispatchEvent(new UpdatePetFarmGuildeEvent("finish",info));
               }
               dispatchEvent(new TaskEvent("changed",info,data));
            }
            i++;
         }
         rewardTaskMultiple = pkg.readInt();
         loadQuestLog(pkg.readByteArray());
         _questDataInited = true;
         checkHighLight();
         if(this.hasEventListener("update_taskMenuItem"))
         {
            dispatchEvent(new RegressEvent("update_taskMenuItem"));
         }
         if(this.hasEventListener("refreshProgress"))
         {
            dispatchEvent(new CollectionTaskEvent("refreshProgress"));
         }
      }
      
      private function addNewQuest(info:QuestInfo) : void
      {
         if(!_newQuests)
         {
            _newQuests = [];
         }
         if(_newQuests.indexOf(info) == -1 && !_isShowing)
         {
            showGetNewQuest();
         }
         _newQuests.push(info);
      }
      
      private function availableForMainToolBar() : Boolean
      {
         if(StateManager.currentStateType == null || StateManager.currentStateType == "login")
         {
            return false;
         }
         return true;
      }
      
      public function clearNewQuest() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = allAvailableQuests;
         for each(var info in allAvailableQuests)
         {
         }
      }
      
      public function showGetNewQuest() : void
      {
      }
      
      private function __onComplete(event:Event) : void
      {
         mc.movie.removeEventListener("click",__onclicked);
         mc.removeEventListener("complete",__onComplete);
         ObjectUtils.disposeObject(mc);
         mc = null;
         _isShowing = false;
      }
      
      private function __onclicked(event:MouseEvent) : void
      {
         mc.movie.removeEventListener("click",__onclicked);
         if(StateManager.currentStateType == "fightLabGameView" || StateManager.currentStateType == "fighting" || StateManager.currentStateType == "trainer1" || StateManager.currentStateType == "trainer2" || StateManager.currentStateType == "gameLoading")
         {
            return;
         }
         mc.movie.visible = false;
         if(!_isShown)
         {
            switchVisible();
         }
      }
      
      public function get currentNewQuest() : QuestInfo
      {
         return _currentNewQuest;
      }
      
      private function __questFinish(evt:PkgEvent) : void
      {
         var pkg:PackageIn = evt.pkg;
         var id:int = pkg.readInt();
         if(id == 1000)
         {
            return;
         }
         onFinishQuest(id);
         if(id == 346)
         {
            NoviceDataManager.instance.saveNoviceData(1120,PathManager.userName(),PathManager.solveRequestPath());
         }
         else if(id == 558)
         {
            NoviceDataManager.instance.saveNoviceData(370,PathManager.userName(),PathManager.solveRequestPath());
         }
         else if(id == 560)
         {
            NoviceDataManager.instance.saveNoviceData(550,PathManager.userName(),PathManager.solveRequestPath());
         }
         else if(id == 562)
         {
            NoviceDataManager.instance.saveNoviceData(710,PathManager.userName(),PathManager.solveRequestPath());
         }
         else if(id == 564)
         {
            NoviceDataManager.instance.saveNoviceData(1010,PathManager.userName(),PathManager.solveRequestPath());
         }
         else if(id == 565)
         {
            NoviceDataManager.instance.saveNoviceData(830,PathManager.userName(),PathManager.solveRequestPath());
         }
         else if(id == 566)
         {
            NoviceDataManager.instance.saveNoviceData(900,PathManager.userName(),PathManager.solveRequestPath());
         }
         else if(id == 569)
         {
            NoviceDataManager.instance.saveNoviceData(800,PathManager.userName(),PathManager.solveRequestPath());
         }
      }
      
      private function onFinishQuest(id:int) : void
      {
         var info:QuestInfo = getQuestByID(id);
         if(info.isAvailable || info.NextQuestID)
         {
            requestCanAcceptTask();
         }
         dispatchEvent(new TaskEvent("finish",info,info.data));
      }
      
      public function jumpToQuest(info:QuestInfo) : void
      {
         selectedQuest = info;
         dispatchEvent(new CEvent("taskJumpToQuest",info));
      }
      
      public function onBagChanged() : void
      {
         checkHighLight();
      }
      
      public function onGuildUpdate() : void
      {
         checkHighLight();
      }
      
      public function onPlayerLevelUp() : void
      {
         checkHighLight();
      }
      
      public function finshMarriage() : void
      {
         var data:* = null;
         var _loc4_:int = 0;
         var _loc3_:* = allQuests;
         for each(var info in allQuests)
         {
            data = info.data;
            if(data)
            {
               if(!data.isAchieved)
               {
                  if(info.Condition == 21)
                  {
                     showTaskHightLight();
                  }
               }
            }
         }
         requestCanAcceptTask();
      }
      
      public function get achievementQuest() : QuestInfo
      {
         return TaskManager.instance.getQuestByID(1000);
      }
      
      public function requestAchievementReward() : void
      {
         SocketManager.Instance.out.sendQuestFinish(1000,0);
      }
      
      public function requestCanAcceptTask() : void
      {
         var arr:* = null;
         var temp:Array = allAvailableQuests;
         if(temp.length != 0)
         {
            arr = [];
            var _loc5_:int = 0;
            var _loc4_:* = temp;
            for each(var info in temp)
            {
               if(info.Type <= 100)
               {
                  if(!(info.data && info.data.isExist))
                  {
                     if(info.Level <= PlayerManager.Instance.Self.Grade)
                     {
                        arr.push(info.QuestID);
                        if(_questDataInited)
                        {
                           info.required = true;
                        }
                     }
                  }
               }
            }
            socketSendQuestAdd(arr);
         }
      }
      
      public function requestQuest(info:QuestInfo) : void
      {
         var arr:* = null;
         if(StateManager.currentStateType == "login")
         {
            return;
         }
         if(isRequestQuest(info))
         {
            arr = [];
            arr.push(info.QuestID);
            if(_questDataInited)
            {
               info.required = true;
            }
            socketSendQuestAdd(arr);
         }
      }
      
      public function isRequestQuest(info:QuestInfo) : Boolean
      {
         if(!info.CanRepeat && info.isAchieved)
         {
            return false;
         }
         if(info.Type > 100)
         {
            return false;
         }
         if(info.Level > PlayerManager.Instance.Self.Grade)
         {
            return false;
         }
         return true;
      }
      
      public function addRequestAddQuestDic(id:*, info:QuestInfo) : void
      {
         if(_requestAddQuestDic == null)
         {
            _requestAddQuestDic = new Dictionary();
         }
         if(isRequestQuest(info))
         {
            if(_questDataInited)
            {
               info.required = true;
            }
            _requestAddQuestDic[id] = info;
         }
      }
      
      public function checkSendRequestAddQuestDic() : void
      {
         var arr:* = null;
         var maxLine:int = 0;
         var tempNum:int = 0;
         var i:int = 0;
         if(_requestAddQuestDic)
         {
            arr = [];
            var _loc7_:int = 0;
            var _loc6_:* = _requestAddQuestDic;
            for each(var info in _requestAddQuestDic)
            {
               arr.push(info.QuestID);
            }
            maxLine = 50;
            if(arr.length > maxLine)
            {
               tempNum = Math.ceil(arr.length / maxLine);
               for(i = 0; i < tempNum; )
               {
                  socketSendQuestAdd(arr.slice(i * 50,(i + 1) * 50));
                  i++;
               }
            }
            else
            {
               socketSendQuestAdd(arr);
            }
            _requestAddQuestDic = null;
         }
      }
      
      public function requestClubTask() : void
      {
         var temp:Array = [];
         var _loc4_:int = 0;
         var _loc3_:* = allAvailableQuests;
         for each(var info in allAvailableQuests)
         {
            if(info.otherCondition == 1)
            {
               if(isAvailableQuest(info) && info.Level <= PlayerManager.Instance.Self.Grade)
               {
                  temp.push(info.QuestID);
               }
            }
         }
         if(temp.length > 0)
         {
            socketSendQuestAdd(temp);
         }
         checkSendRequestAddQuestDic();
      }
      
      public function isHaveBuriedQuest() : Boolean
      {
         var data:QuestCategory = getAvailableQuests(5);
         if(!data || data.list.length == 0)
         {
            return false;
         }
         return true;
      }
      
      public function addEquipUpdateListener() : void
      {
         PlayerManager.Instance.Self.Bag.addEventListener("update",__onEquipUpdate);
      }
      
      private function __onEquipUpdate(evt:BagEvent) : void
      {
         PlayerManager.Instance.Self.Bag.removeEventListener("update",__onEquipUpdate);
         checkHighLight();
      }
      
      public function addItemListener(itemId:int) : void
      {
         if(!_itemListenerArr)
         {
            _itemListenerArr = [];
         }
         _itemListenerArr.push(itemId);
         var self:SelfInfo = PlayerManager.Instance.Self;
         self.getBag(0).addEventListener("update",__onBagUpdate);
         self.getBag(1).addEventListener("update",__onBagUpdate);
      }
      
      private function __onBagUpdate(evt:BagEvent) : void
      {
         var _loc7_:int = 0;
         var _loc6_:* = evt.changedSlots;
         for each(var item in evt.changedSlots)
         {
            var _loc5_:int = 0;
            var _loc4_:* = _itemListenerArr;
            for each(var id in _itemListenerArr)
            {
               if(id == item.TemplateID)
               {
                  checkHighLight();
               }
            }
         }
      }
      
      public function addGradeListener() : void
      {
         PlayerManager.Instance.Self.addEventListener("propertychange",__onPlayerPropertyChange);
      }
      
      private function __onPlayerPropertyChange(e:PlayerPropertyEvent) : void
      {
         if(e.changedProperties["Grade"])
         {
            checkHighLight();
         }
      }
      
      public function onMarriaged() : void
      {
         checkHighLight();
      }
      
      public function addGuildMemberListener() : void
      {
      }
      
      public function addAnnexListener(cond:QuestCondition) : void
      {
         if(!_annexListenerArr)
         {
            _annexListenerArr = [];
         }
         _annexListenerArr.push(cond);
      }
      
      public function addDesktopListener(cond:QuestCondition) : void
      {
         _desktopCond = cond;
         if(DesktopManager.Instance.isDesktop)
         {
            checkQuest(_desktopCond.questID,_desktopCond.ConID,0);
         }
      }
      
      public function onDesktopApp() : void
      {
         if(_desktopCond)
         {
            checkQuest(_desktopCond.questID,_desktopCond.ConID,0);
         }
      }
      
      public function onSendAnnex(itemArr:Array) : void
      {
         var _loc7_:int = 0;
         var _loc6_:* = itemArr;
         for each(var item in itemArr)
         {
            var _loc5_:int = 0;
            var _loc4_:* = _annexListenerArr;
            for each(var cond in _annexListenerArr)
            {
               if(cond.param2 == item.TemplateID)
               {
                  if(isAvailableQuest(getQuestByID(cond.questID),true))
                  {
                     checkQuest(cond.questID,cond.ConID,0);
                  }
               }
            }
         }
         checkSendRequestAddQuestDic();
      }
      
      public function addFriendListener(cond:QuestCondition) : void
      {
         if(!_friendListenerArr)
         {
            _friendListenerArr = [];
         }
         _friendListenerArr.push(cond);
         PlayerManager.Instance.addEventListener("friendListComplete",__onFriendListComplete);
         addEventListener("changed",__onQuestChange);
      }
      
      private function __onQuestChange(evtObj:TaskEvent) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = _friendListenerArr;
         for each(var cond in _friendListenerArr)
         {
            if(evtObj.info.Id == cond.questID)
            {
               checkQuest(cond.questID,cond.ConID,cond.param2 - PlayerManager.Instance.friendList.length);
            }
         }
      }
      
      private function __onFriendListComplete(e:Event) : void
      {
         PlayerManager.Instance.friendList.addEventListener("add",__onFriendListUpdated);
         PlayerManager.Instance.friendList.addEventListener("remove",__onFriendListUpdated);
         var _loc4_:int = 0;
         var _loc3_:* = _friendListenerArr;
         for each(var cond in _friendListenerArr)
         {
            checkQuest(cond.questID,cond.ConID,cond.param2 - PlayerManager.Instance.friendList.length);
         }
      }
      
      private function __onFriendListUpdated(e:DictionaryEvent) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = _friendListenerArr;
         for each(var cond in _friendListenerArr)
         {
            checkQuest(cond.questID,cond.ConID,cond.param2 - PlayerManager.Instance.friendList.length);
         }
      }
      
      public function hasConsortiaSayTask() : Boolean
      {
         var l:Array = getAvailableQuests(-1,true).list;
         var _loc7_:int = 0;
         var _loc6_:* = l;
         for each(var task in l)
         {
            if(!task.isAchieved)
            {
               var _loc5_:int = 0;
               var _loc4_:* = task.conditions;
               for each(var con in task.conditions)
               {
                  if(con.type == 20 && con.param == 4)
                  {
                     return true;
                  }
               }
               continue;
            }
         }
         return false;
      }
      
      public function addConsortaChatCondition(con:QuestCondition) : void
      {
         if(_consortChatConditions == null)
         {
            _consortChatConditions = [];
         }
         _consortChatConditions.push(con);
         ChatManager.Instance.addEventListener("sendConsortia",__onConsortiaChat);
      }
      
      private function __onConsortiaChat(event:ChatEvent) : void
      {
         if(!hasConsortiaSayTask())
         {
            return;
         }
         var _loc4_:int = 0;
         var _loc3_:* = _consortChatConditions;
         for each(var cond in _consortChatConditions)
         {
            checkQuest(cond.questID,cond.ConID,0);
         }
      }
      
      public function sendQuestFinish(questID:uint, type:int = 0) : void
      {
         SocketManager.Instance.out.sendQuestFinish(questID,itemAwardSelected,type);
         questFinishHook(questID);
      }
      
      private function questFinishHook(questID:uint) : void
      {
         var selfid:Number = NaN;
         var args:* = null;
         var request:* = null;
         if(!(int(questID) - 544))
         {
            selfid = PlayerManager.Instance.Self.ID;
            args = RequestVairableCreater.creatWidthKey(true);
            args["selfid"] = selfid;
            args["url"] = PathManager.solveLogin();
            args["nickname"] = PlayerManager.Instance.Self.NickName;
            args["rnd"] = Math.random();
            request = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("SendMailGameUrl.ashx"),6,args);
            LoadResourceManager.Instance.startLoad(request);
         }
      }
      
      public function sendQuestData(questID:int, conID:int) : void
      {
         if(!getQuestByID(questID).data)
         {
            return;
         }
         var value:int = getQuestByID(questID).data.progress[conID];
         value--;
         checkQuest(questID,conID,value);
      }
      
      public function HighLightChecked(info:QuestInfo) : void
      {
         if(info.isCompleted)
         {
            info.hadChecked = true;
         }
      }
      
      public function checkQuest(id:int, conID:int, value:int) : void
      {
         SocketManager.Instance.out.sendQuestCheck(id,conID,value);
      }
      
      private function socketSendQuestAdd(arr:Array) : void
      {
         if(arr && arr.length > 0)
         {
            SocketManager.Instance.out.sendQuestAdd(arr);
         }
      }
      
      public function checkHighLight() : void
      {
         ExitPromptManager.Instance.changeJSQuestVar();
         var count:int = 0;
         var regressTask:QuestCategory = getAvailableQuests(4);
         var _loc5_:int = 0;
         var _loc4_:* = allCurrentQuest;
         for each(var info in allCurrentQuest)
         {
            if(regressTask.list.indexOf(info) == -1)
            {
               if(!info.isAchieved || info.CanRepeat)
               {
                  if(info.isCompleted && info.Type != 12 && info.Type != 13 && info.Type != 14)
                  {
                     if(!info.hadChecked)
                     {
                        count++;
                        HallTaskTrackManager.instance.addCompleteTask(info.QuestID);
                     }
                  }
               }
            }
         }
         if(count > 0)
         {
            showTaskHightLight();
         }
         else
         {
            MainToolBar.Instance.hideTaskHightLight();
            isTaskHightLight = false;
            dispatchEvent(new Event("hideTaskHightLight"));
         }
         dispatchEvent(new Event("taskRefreshHallTaskTrackView"));
      }
      
      private function showTaskHightLight() : void
      {
         if(availableForMainToolBar())
         {
            if(!_isShown)
            {
               MainToolBar.Instance.showTaskHightLight();
               isTaskHightLight = true;
               dispatchEvent(new Event("showTaskHightLight"));
            }
         }
      }
      
      public function jumpToQuestByID(id:int = -1) : void
      {
         if(id == -1)
         {
            id = tmpQuestId;
         }
         if(firstshowTask)
         {
            tmpQuestId = id;
            _returnFun = jumpToQuestByID;
            moduleLoad();
            return;
         }
         var info:QuestInfo = getQuestByID(id);
         _isShown = true;
         _events.push(new CEvent("taskGotoQuest",info));
         show();
      }
      
      public function get manuGetList() : DictionaryData
      {
         return _manuGetList;
      }
   }
}
