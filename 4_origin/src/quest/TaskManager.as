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
      
      public function set selectedQuest(param1:QuestInfo) : void
      {
         _selectedQuest = param1;
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
         var _loc1_:Event = _events.shift();
         dispatchEvent(_loc1_);
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
      
      public function set isShow(param1:Boolean) : void
      {
         _isShown = param1;
      }
      
      public function setup(param1:QuestListAnalyzer) : void
      {
         allQuests = param1.list;
         _questDataInited = false;
         _improve = getImproveArray(param1.improveXml);
         SocketManager.Instance.addEventListener(PkgEvent.format(178),__updateAcceptedTask);
         SocketManager.Instance.addEventListener(PkgEvent.format(179),__questFinish);
         SocketManager.Instance.addEventListener(PkgEvent.format(273),questManuGetHandler);
      }
      
      public function reloadNewQuest(param1:QuestListAnalyzer) : void
      {
         var _loc2_:Dictionary = param1.list;
         var _loc5_:int = 0;
         var _loc4_:* = _loc2_;
         for each(var _loc3_ in _loc2_)
         {
            if(getQuestByID(_loc3_.id) == null)
            {
               addQuest(_loc3_);
            }
         }
      }
      
      private function getImproveArray(param1:XML) : QuestImproveInfo
      {
         var _loc2_:QuestImproveInfo = new QuestImproveInfo();
         _loc2_.bindMoneyRate = String(param1.@BindMoneyRate).split("|");
         _loc2_.expRate = String(param1.@ExpRate).split("|");
         _loc2_.goldRate = String(param1.@GoldRate).split("|");
         _loc2_.exploitRate = String(param1.@ExploitRate).split("|");
         _loc2_.canOneKeyFinishTime = Number(param1.@CanOneKeyFinishTime);
         return _loc2_;
      }
      
      public function addQuest(param1:QuestInfo) : void
      {
         TaskManager.instance.allQuests[param1.Id] = param1;
      }
      
      public function loadQuestLog(param1:ByteArray) : void
      {
         var _loc2_:int = 0;
         param1.position = 0;
         _questLog = new BitArray();
         _loc2_ = 0;
         while(_loc2_ < param1.length)
         {
            _questLog.writeByte(param1.readByte());
            _loc2_++;
         }
      }
      
      private function IsQuestFinish(param1:int) : Boolean
      {
         if(!_questLog)
         {
            return false;
         }
         if(param1 > _questLog.length * 8 || param1 < 1)
         {
            return false;
         }
         param1--;
         var _loc3_:int = param1 / 8;
         var _loc4_:int = param1 % 8;
         var _loc2_:* = _questLog[_loc3_] & 1 << _loc4_;
         return _loc2_ != 0;
      }
      
      public function get allQuests() : Dictionary
      {
         if(!_allQuests)
         {
            _allQuests = new Dictionary();
         }
         return _allQuests;
      }
      
      public function set allQuests(param1:Dictionary) : void
      {
         _allQuests = param1;
      }
      
      public function getQuestByID(param1:int) : QuestInfo
      {
         if(!allQuests)
         {
            return null;
         }
         return allQuests[param1];
      }
      
      public function getQuestDataByID(param1:int) : QuestDataInfo
      {
         if(!getQuestByID(param1))
         {
            return null;
         }
         return getQuestByID(param1).data;
      }
      
      public function getAllQuestInfoByType(param1:int) : Array
      {
         var _loc2_:Array = [];
         var _loc5_:int = 0;
         var _loc4_:* = allQuests;
         for each(var _loc3_ in allQuests)
         {
            if(_loc3_.Type == param1)
            {
               _loc2_.push(_loc3_);
            }
         }
         return _loc2_;
      }
      
      public function getAvailableQuests(param1:int = -1, param2:Boolean = true) : QuestCategory
      {
         var _loc3_:QuestCategory = new QuestCategory();
         var _loc6_:int = 0;
         var _loc5_:* = allQuests;
         for each(var _loc4_ in allQuests)
         {
            if(!(_loc4_.id >= 4001 && _loc4_.id <= 4024))
            {
               if(param1 > -1)
               {
                  if(param1 == 0)
                  {
                     if(_loc4_.Type != 0)
                     {
                        continue;
                     }
                  }
                  else if(param1 == 1)
                  {
                     if(_loc4_.Type != 4 && _loc4_.Type != 1 && _loc4_.Type != 6 && _loc4_.Type != 15)
                     {
                        continue;
                     }
                  }
                  else if(param1 == 2)
                  {
                     if(_loc4_.Type != 2 && _loc4_.Type < 100)
                     {
                        continue;
                     }
                  }
                  else if(param1 == 3)
                  {
                     if(_loc4_.Type != 3)
                     {
                        continue;
                     }
                  }
                  else if(param1 == 4)
                  {
                     if(_loc4_.Type != 7)
                     {
                        continue;
                     }
                  }
                  else if(param1 == 5)
                  {
                     if(_loc4_.Type != 10)
                     {
                        continue;
                     }
                  }
                  else if(param1 == 6)
                  {
                     if(_loc4_.Type != 66)
                     {
                        continue;
                     }
                  }
                  else if(param1 == 7)
                  {
                     if(_loc4_.Type != 12)
                     {
                        continue;
                     }
                  }
                  else if(param1 == 8)
                  {
                     if(_loc4_.Type != 17)
                     {
                        continue;
                     }
                  }
               }
               if(!(param2 && _loc4_.data && !_loc4_.data.isExist))
               {
                  if(isAvailableQuest(_loc4_,true))
                  {
                     if(_loc4_.Id != 1000)
                     {
                        if(_loc4_.isCompleted)
                        {
                           _loc3_.addCompleted(_loc4_);
                        }
                        else if(_loc4_.data && _loc4_.data.isNew)
                        {
                           _loc3_.addNew(_loc4_);
                        }
                        else
                        {
                           _loc3_.addQuest(_loc4_);
                        }
                     }
                  }
               }
            }
         }
         checkSendRequestAddQuestDic();
         return _loc3_;
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
         var _loc1_:QuestCategory = new QuestCategory();
         var _loc4_:int = 0;
         var _loc3_:* = allQuests;
         for each(var _loc2_ in allQuests)
         {
            if(_loc2_.Type >= 100)
            {
               if(_loc2_.data && !_loc2_.data.isExist)
               {
                  addRequestAddQuestDic(_loc2_.QuestID,_loc2_);
               }
               else if(isAvailableQuest(_loc2_,true))
               {
                  if(_loc2_.Id != 1000)
                  {
                     trace(_loc2_.Detail);
                     if(_loc2_.isCompleted)
                     {
                        _loc1_.addCompleted(_loc2_);
                     }
                     else if(_loc2_.data && _loc2_.data.isNew)
                     {
                        _loc1_.addNew(_loc2_);
                     }
                     else
                     {
                        _loc1_.addQuest(_loc2_);
                     }
                  }
               }
            }
         }
         checkSendRequestAddQuestDic();
         return _loc1_.list;
      }
      
      public function get newQuests() : Array
      {
         var _loc1_:Array = [];
         var _loc4_:int = 0;
         var _loc3_:* = allAvailableQuests;
         for each(var _loc2_ in allAvailableQuests)
         {
            if(_loc2_.data && _loc2_.data.needInformed && _loc2_.Type != 2)
            {
               _loc1_.push(_loc2_);
            }
         }
         _newQuests = _loc1_;
         return _loc1_;
      }
      
      public function set currentCategory(param1:int) : void
      {
         _currentCategory = param1;
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
         var _loc1_:Array = [];
         var _loc4_:int = 0;
         var _loc3_:* = dailyQuests;
         for each(var _loc2_ in dailyQuests)
         {
            if(_loc2_.otherCondition != 1)
            {
               _loc1_.push(_loc2_);
            }
         }
         _loc1_ = _loc1_.reverse();
         return _loc1_;
      }
      
      public function get welcomeGuildQuests() : Array
      {
         var _loc1_:Array = [];
         var _loc4_:int = 0;
         var _loc3_:* = dailyQuests;
         for each(var _loc2_ in dailyQuests)
         {
            if(_loc2_.otherCondition == 1)
            {
               _loc1_.push(_loc2_);
            }
         }
         _loc1_ = _loc1_.reverse();
         return _loc1_;
      }
      
      public function getTaskData(param1:int) : QuestDataInfo
      {
         if(getQuestByID(param1))
         {
            return getQuestByID(param1).data;
         }
         return null;
      }
      
      public function isAvailableQuest(param1:QuestInfo, param2:Boolean = false) : Boolean
      {
         var _loc8_:int = 0;
         var _loc6_:int = 0;
         var _loc3_:* = null;
         var _loc5_:* = null;
         var _loc4_:Array = PathManager.DISABLE_TASK_ID;
         _loc8_ = 0;
         while(_loc8_ < _loc4_.length)
         {
            if(param1.id == parseInt(_loc4_[_loc8_]))
            {
               return false;
            }
            _loc8_++;
         }
         if(param1.disabled)
         {
            return false;
         }
         if(param1.texpTaskIsTimeOut())
         {
            return false;
         }
         if(param1.Type <= 100)
         {
            _loc6_ = PlayerManager.Instance.Self.Grade;
            if(param1.NeedMinLevel > _loc6_ || param1.NeedMaxLevel < _loc6_)
            {
               return false;
            }
         }
         if(param1.PreQuestID != "0,")
         {
            _loc3_ = [];
            _loc3_ = param1.PreQuestID.split(",");
            var _loc10_:int = 0;
            var _loc9_:* = _loc3_;
            for each(var _loc7_ in _loc3_)
            {
               if(_loc7_ != 0)
               {
                  if(getQuestByID(_loc7_))
                  {
                     _loc5_ = getQuestByID(_loc7_);
                     if(!_loc5_)
                     {
                        return false;
                     }
                     if(!isAchieved(_loc5_))
                     {
                        return false;
                     }
                  }
               }
            }
         }
         if(!(isValidateByDate(param1) && isAvailableByGuild(param1) && isAvailableByMarry(param1)))
         {
            return false;
         }
         if(param1.Type <= 100 && haveLog(param1))
         {
            return false;
         }
         if(!param1.isAvailable)
         {
            return false;
         }
         if(param1.data == null || !param1.data.isExist && param1.CanRepeat)
         {
            addRequestAddQuestDic(param1.QuestID,param1);
            if(param2 && param1.Type != 4)
            {
               return false;
            }
         }
         if(param1.isManuGet && (!param1.data || !param1.data.isGet))
         {
            if(!_manuGetList.hasKey(param1.id))
            {
               _manuGetList.add(param1.id,param1);
            }
            return false;
         }
         return true;
      }
      
      public function isAchieved(param1:QuestInfo) : Boolean
      {
         if(param1.isAchieved)
         {
            return true;
         }
         if(!param1.CanRepeat)
         {
            if(IsQuestFinish(param1.Id))
            {
               return true;
            }
         }
         return false;
      }
      
      public function isCompleted(param1:QuestInfo) : Boolean
      {
         if(param1.isCompleted)
         {
            return true;
         }
         return false;
      }
      
      public function isAvailable(param1:QuestInfo) : Boolean
      {
         if(!param1)
         {
            return false;
         }
         return isAvailableQuest(param1) && !param1.isCompleted;
      }
      
      private function haveLog(param1:QuestInfo) : Boolean
      {
         if(param1.CanRepeat)
         {
            if(param1.data && param1.data.repeatLeft == 0)
            {
               return true;
            }
            return false;
         }
         if(IsQuestFinish(param1.Id))
         {
            return true;
         }
         return false;
      }
      
      public function isValidateByDate(param1:QuestInfo) : Boolean
      {
         if(!param1)
         {
            return false;
         }
         return !param1.isTimeOut();
      }
      
      public function isAvailableByGuild(param1:QuestInfo) : Boolean
      {
         if(!param1)
         {
            return false;
         }
         return param1.otherCondition != 1 || PlayerManager.Instance.Self.ConsortiaID != 0;
      }
      
      public function isAvailableByMarry(param1:QuestInfo) : Boolean
      {
         if(!param1)
         {
            return false;
         }
         return param1.otherCondition != 2 || PlayerManager.Instance.Self.IsMarried;
      }
      
      private function questManuGetHandler(param1:PkgEvent) : void
      {
         var _loc2_:PackageIn = param1.pkg;
         var _loc3_:Boolean = _loc2_.readBoolean();
         var _loc4_:int = _loc2_.readInt();
         _manuGetList.remove(_loc4_);
         if(_loc3_)
         {
            SoundManager.instance.play("216");
         }
         if(_loc4_ == 559 || _loc4_ == 561 || _loc4_ == 563 || _loc4_ == 565 || _loc4_ == 567 || _loc4_ == 569)
         {
            TaskManager.instance.jumpToQuestByID(_loc4_);
         }
         if(_loc4_ == 558)
         {
            NoviceDataManager.instance.saveNoviceData(340,PathManager.userName(),PathManager.solveRequestPath());
         }
         if(_loc4_ == 559)
         {
            NoviceDataManager.instance.saveNoviceData(380,PathManager.userName(),PathManager.solveRequestPath());
         }
         if(_loc4_ == 560)
         {
            NoviceDataManager.instance.saveNoviceData(480,PathManager.userName(),PathManager.solveRequestPath());
         }
         if(_loc4_ == 562)
         {
            NoviceDataManager.instance.saveNoviceData(660,PathManager.userName(),PathManager.solveRequestPath());
         }
         if(_loc4_ == 563)
         {
            NoviceDataManager.instance.saveNoviceData(580,PathManager.userName(),PathManager.solveRequestPath());
         }
         if(_loc4_ == 564)
         {
            NoviceDataManager.instance.saveNoviceData(990,PathManager.userName(),PathManager.solveRequestPath());
         }
         if(_loc4_ == 565)
         {
            NoviceDataManager.instance.saveNoviceData(810,PathManager.userName(),PathManager.solveRequestPath());
         }
         if(_loc4_ == 566)
         {
            NoviceDataManager.instance.saveNoviceData(840,PathManager.userName(),PathManager.solveRequestPath());
         }
         if(_loc4_ == 567)
         {
            NoviceDataManager.instance.saveNoviceData(920,PathManager.userName(),PathManager.solveRequestPath());
         }
         if(_loc4_ == 569)
         {
            NoviceDataManager.instance.saveNoviceData(740,PathManager.userName(),PathManager.solveRequestPath());
         }
      }
      
      public function __updateAcceptedTask(param1:PkgEvent) : void
      {
         var _loc9_:int = 0;
         var _loc11_:int = 0;
         var _loc10_:* = null;
         var _loc5_:* = null;
         var _loc19_:int = 0;
         var _loc20_:int = 0;
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         var _loc15_:Boolean = false;
         var _loc14_:Boolean = false;
         var _loc13_:Boolean = false;
         var _loc12_:Boolean = false;
         var _loc7_:* = null;
         var _loc18_:* = undefined;
         var _loc4_:int = 0;
         var _loc8_:int = 0;
         var _loc17_:int = 0;
         var _loc6_:PackageIn = param1.pkg;
         var _loc16_:int = _loc6_.readInt();
         _loc9_ = 0;
         while(_loc9_ < _loc16_)
         {
            _loc11_ = _loc6_.readInt();
            _loc10_ = new QuestInfo();
            if(getQuestByID(_loc11_))
            {
               _loc10_ = getQuestByID(_loc11_);
               if(_loc10_.data)
               {
                  _loc5_ = _loc10_.data;
               }
               else
               {
                  _loc5_ = new QuestDataInfo(_loc11_);
                  if(_loc10_.required)
                  {
                     _loc5_.isNew = true;
                  }
               }
               _loc5_.isAchieved = _loc6_.readBoolean();
               _loc19_ = _loc6_.readInt();
               _loc20_ = _loc6_.readInt();
               _loc3_ = _loc6_.readInt();
               _loc2_ = _loc6_.readInt();
               _loc5_.setProgress(_loc19_,_loc20_,_loc3_,_loc2_);
               _loc5_.CompleteDate = _loc6_.readDate();
               _loc5_.repeatLeft = _loc6_.readInt();
               _loc5_.quality = _loc6_.readInt();
               _loc5_.isExist = _loc6_.readBoolean();
               _loc10_.QuestLevel = _loc6_.readInt();
               _loc5_.AddTiemsDate = _loc6_.readDate();
               _loc15_ = _loc6_.readInt() == 0?false:true;
               _loc14_ = _loc6_.readInt() == 0?false:true;
               _loc13_ = _loc6_.readInt() == 0?false:true;
               _loc12_ = _loc6_.readInt() == 0?false:true;
               _loc5_.setIsAutoComplete(_loc15_,_loc14_,_loc13_,_loc12_);
               _loc7_ = [0,0,0,0];
               _loc18_ = new <Boolean>[false,false,false,false];
               _loc4_ = _loc6_.readInt();
               _loc8_ = 0;
               while(_loc8_ < _loc4_)
               {
                  _loc17_ = _loc6_.readInt() - 4;
                  _loc7_[_loc17_] = _loc6_.readInt();
                  _loc18_[_loc17_] = _loc6_.readInt() == 0?false:true;
                  _loc8_++;
               }
               _loc5_.setProgressConcoat(_loc7_);
               _loc5_.setIsAutoCompleteConcoat(_loc18_);
               _loc5_.isGet = _loc6_.readBoolean();
               _loc10_.data = _loc5_;
               if(_loc5_.isNew)
               {
                  addNewQuest(_loc10_);
               }
               if(PetsBagManager.instance().isPetFarmGuildeTask(_loc10_.QuestID))
               {
                  PetsBagManager.instance().dispatchEvent(new UpdatePetFarmGuildeEvent("finish",_loc10_));
               }
               dispatchEvent(new TaskEvent("changed",_loc10_,_loc5_));
            }
            _loc9_++;
         }
         rewardTaskMultiple = _loc6_.readInt();
         loadQuestLog(_loc6_.readByteArray());
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
      
      private function addNewQuest(param1:QuestInfo) : void
      {
         if(!_newQuests)
         {
            _newQuests = [];
         }
         if(_newQuests.indexOf(param1) == -1 && !_isShowing)
         {
            showGetNewQuest();
         }
         _newQuests.push(param1);
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
         for each(var _loc1_ in allAvailableQuests)
         {
         }
      }
      
      public function showGetNewQuest() : void
      {
      }
      
      private function __onComplete(param1:Event) : void
      {
         mc.movie.removeEventListener("click",__onclicked);
         mc.removeEventListener("complete",__onComplete);
         ObjectUtils.disposeObject(mc);
         mc = null;
         _isShowing = false;
      }
      
      private function __onclicked(param1:MouseEvent) : void
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
      
      private function __questFinish(param1:PkgEvent) : void
      {
         var _loc3_:PackageIn = param1.pkg;
         var _loc2_:int = _loc3_.readInt();
         if(_loc2_ == 1000)
         {
            return;
         }
         onFinishQuest(_loc2_);
         if(_loc2_ == 346)
         {
            NoviceDataManager.instance.saveNoviceData(1120,PathManager.userName(),PathManager.solveRequestPath());
         }
         else if(_loc2_ == 558)
         {
            NoviceDataManager.instance.saveNoviceData(370,PathManager.userName(),PathManager.solveRequestPath());
         }
         else if(_loc2_ == 560)
         {
            NoviceDataManager.instance.saveNoviceData(550,PathManager.userName(),PathManager.solveRequestPath());
         }
         else if(_loc2_ == 562)
         {
            NoviceDataManager.instance.saveNoviceData(710,PathManager.userName(),PathManager.solveRequestPath());
         }
         else if(_loc2_ == 564)
         {
            NoviceDataManager.instance.saveNoviceData(1010,PathManager.userName(),PathManager.solveRequestPath());
         }
         else if(_loc2_ == 565)
         {
            NoviceDataManager.instance.saveNoviceData(830,PathManager.userName(),PathManager.solveRequestPath());
         }
         else if(_loc2_ == 566)
         {
            NoviceDataManager.instance.saveNoviceData(900,PathManager.userName(),PathManager.solveRequestPath());
         }
         else if(_loc2_ == 569)
         {
            NoviceDataManager.instance.saveNoviceData(800,PathManager.userName(),PathManager.solveRequestPath());
         }
      }
      
      private function onFinishQuest(param1:int) : void
      {
         var _loc2_:QuestInfo = getQuestByID(param1);
         if(_loc2_.isAvailable || _loc2_.NextQuestID)
         {
            requestCanAcceptTask();
         }
         dispatchEvent(new TaskEvent("finish",_loc2_,_loc2_.data));
      }
      
      public function jumpToQuest(param1:QuestInfo) : void
      {
         selectedQuest = param1;
         dispatchEvent(new CEvent("taskJumpToQuest",param1));
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
         var _loc1_:* = null;
         var _loc4_:int = 0;
         var _loc3_:* = allQuests;
         for each(var _loc2_ in allQuests)
         {
            _loc1_ = _loc2_.data;
            if(_loc1_)
            {
               if(!_loc1_.isAchieved)
               {
                  if(_loc2_.Condition == 21)
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
         var _loc1_:* = null;
         var _loc2_:Array = allAvailableQuests;
         if(_loc2_.length != 0)
         {
            _loc1_ = [];
            var _loc5_:int = 0;
            var _loc4_:* = _loc2_;
            for each(var _loc3_ in _loc2_)
            {
               if(_loc3_.Type <= 100)
               {
                  if(!(_loc3_.data && _loc3_.data.isExist))
                  {
                     if(_loc3_.Level <= PlayerManager.Instance.Self.Grade)
                     {
                        _loc1_.push(_loc3_.QuestID);
                        if(_questDataInited)
                        {
                           _loc3_.required = true;
                        }
                     }
                  }
               }
            }
            socketSendQuestAdd(_loc1_);
         }
      }
      
      public function requestQuest(param1:QuestInfo) : void
      {
         var _loc2_:* = null;
         if(StateManager.currentStateType == "login")
         {
            return;
         }
         if(isRequestQuest(param1))
         {
            _loc2_ = [];
            _loc2_.push(param1.QuestID);
            if(_questDataInited)
            {
               param1.required = true;
            }
            socketSendQuestAdd(_loc2_);
         }
      }
      
      public function isRequestQuest(param1:QuestInfo) : Boolean
      {
         if(!param1.CanRepeat && param1.isAchieved)
         {
            return false;
         }
         if(param1.Type > 100)
         {
            return false;
         }
         if(param1.Level > PlayerManager.Instance.Self.Grade)
         {
            return false;
         }
         return true;
      }
      
      public function addRequestAddQuestDic(param1:*, param2:QuestInfo) : void
      {
         if(_requestAddQuestDic == null)
         {
            _requestAddQuestDic = new Dictionary();
         }
         if(isRequestQuest(param2))
         {
            if(_questDataInited)
            {
               param2.required = true;
            }
            _requestAddQuestDic[param1] = param2;
         }
      }
      
      public function checkSendRequestAddQuestDic() : void
      {
         var _loc2_:* = null;
         var _loc1_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         if(_requestAddQuestDic)
         {
            _loc2_ = [];
            var _loc7_:int = 0;
            var _loc6_:* = _requestAddQuestDic;
            for each(var _loc5_ in _requestAddQuestDic)
            {
               _loc2_.push(_loc5_.QuestID);
            }
            _loc1_ = 50;
            if(_loc2_.length > _loc1_)
            {
               _loc3_ = Math.ceil(_loc2_.length / _loc1_);
               _loc4_ = 0;
               while(_loc4_ < _loc3_)
               {
                  socketSendQuestAdd(_loc2_.slice(_loc4_ * 50,(_loc4_ + 1) * 50));
                  _loc4_++;
               }
            }
            else
            {
               socketSendQuestAdd(_loc2_);
            }
            _requestAddQuestDic = null;
         }
      }
      
      public function requestClubTask() : void
      {
         var _loc1_:Array = [];
         var _loc4_:int = 0;
         var _loc3_:* = allAvailableQuests;
         for each(var _loc2_ in allAvailableQuests)
         {
            if(_loc2_.otherCondition == 1)
            {
               if(isAvailableQuest(_loc2_) && _loc2_.Level <= PlayerManager.Instance.Self.Grade)
               {
                  _loc1_.push(_loc2_.QuestID);
               }
            }
         }
         if(_loc1_.length > 0)
         {
            socketSendQuestAdd(_loc1_);
         }
         checkSendRequestAddQuestDic();
      }
      
      public function isHaveBuriedQuest() : Boolean
      {
         var _loc1_:QuestCategory = getAvailableQuests(5);
         if(!_loc1_ || _loc1_.list.length == 0)
         {
            return false;
         }
         return true;
      }
      
      public function addEquipUpdateListener() : void
      {
         PlayerManager.Instance.Self.Bag.addEventListener("update",__onEquipUpdate);
      }
      
      private function __onEquipUpdate(param1:BagEvent) : void
      {
         PlayerManager.Instance.Self.Bag.removeEventListener("update",__onEquipUpdate);
         checkHighLight();
      }
      
      public function addItemListener(param1:int) : void
      {
         if(!_itemListenerArr)
         {
            _itemListenerArr = [];
         }
         _itemListenerArr.push(param1);
         var _loc2_:SelfInfo = PlayerManager.Instance.Self;
         _loc2_.getBag(0).addEventListener("update",__onBagUpdate);
         _loc2_.getBag(1).addEventListener("update",__onBagUpdate);
      }
      
      private function __onBagUpdate(param1:BagEvent) : void
      {
         var _loc7_:int = 0;
         var _loc6_:* = param1.changedSlots;
         for each(var _loc3_ in param1.changedSlots)
         {
            var _loc5_:int = 0;
            var _loc4_:* = _itemListenerArr;
            for each(var _loc2_ in _itemListenerArr)
            {
               if(_loc2_ == _loc3_.TemplateID)
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
      
      private function __onPlayerPropertyChange(param1:PlayerPropertyEvent) : void
      {
         if(param1.changedProperties["Grade"])
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
      
      public function addAnnexListener(param1:QuestCondition) : void
      {
         if(!_annexListenerArr)
         {
            _annexListenerArr = [];
         }
         _annexListenerArr.push(param1);
      }
      
      public function addDesktopListener(param1:QuestCondition) : void
      {
         _desktopCond = param1;
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
      
      public function onSendAnnex(param1:Array) : void
      {
         var _loc7_:int = 0;
         var _loc6_:* = param1;
         for each(var _loc2_ in param1)
         {
            var _loc5_:int = 0;
            var _loc4_:* = _annexListenerArr;
            for each(var _loc3_ in _annexListenerArr)
            {
               if(_loc3_.param2 == _loc2_.TemplateID)
               {
                  if(isAvailableQuest(getQuestByID(_loc3_.questID),true))
                  {
                     checkQuest(_loc3_.questID,_loc3_.ConID,0);
                  }
               }
            }
         }
         checkSendRequestAddQuestDic();
      }
      
      public function addFriendListener(param1:QuestCondition) : void
      {
         if(!_friendListenerArr)
         {
            _friendListenerArr = [];
         }
         _friendListenerArr.push(param1);
         PlayerManager.Instance.addEventListener("friendListComplete",__onFriendListComplete);
         addEventListener("changed",__onQuestChange);
      }
      
      private function __onQuestChange(param1:TaskEvent) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = _friendListenerArr;
         for each(var _loc2_ in _friendListenerArr)
         {
            if(param1.info.Id == _loc2_.questID)
            {
               checkQuest(_loc2_.questID,_loc2_.ConID,_loc2_.param2 - PlayerManager.Instance.friendList.length);
            }
         }
      }
      
      private function __onFriendListComplete(param1:Event) : void
      {
         PlayerManager.Instance.friendList.addEventListener("add",__onFriendListUpdated);
         PlayerManager.Instance.friendList.addEventListener("remove",__onFriendListUpdated);
         var _loc4_:int = 0;
         var _loc3_:* = _friendListenerArr;
         for each(var _loc2_ in _friendListenerArr)
         {
            checkQuest(_loc2_.questID,_loc2_.ConID,_loc2_.param2 - PlayerManager.Instance.friendList.length);
         }
      }
      
      private function __onFriendListUpdated(param1:DictionaryEvent) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = _friendListenerArr;
         for each(var _loc2_ in _friendListenerArr)
         {
            checkQuest(_loc2_.questID,_loc2_.ConID,_loc2_.param2 - PlayerManager.Instance.friendList.length);
         }
      }
      
      public function hasConsortiaSayTask() : Boolean
      {
         var _loc3_:Array = getAvailableQuests(-1,true).list;
         var _loc7_:int = 0;
         var _loc6_:* = _loc3_;
         for each(var _loc2_ in _loc3_)
         {
            if(!_loc2_.isAchieved)
            {
               var _loc5_:int = 0;
               var _loc4_:* = _loc2_.conditions;
               for each(var _loc1_ in _loc2_.conditions)
               {
                  if(_loc1_.type == 20 && _loc1_.param == 4)
                  {
                     return true;
                  }
               }
               continue;
            }
         }
         return false;
      }
      
      public function addConsortaChatCondition(param1:QuestCondition) : void
      {
         if(_consortChatConditions == null)
         {
            _consortChatConditions = [];
         }
         _consortChatConditions.push(param1);
         ChatManager.Instance.addEventListener("sendConsortia",__onConsortiaChat);
      }
      
      private function __onConsortiaChat(param1:ChatEvent) : void
      {
         if(!hasConsortiaSayTask())
         {
            return;
         }
         var _loc4_:int = 0;
         var _loc3_:* = _consortChatConditions;
         for each(var _loc2_ in _consortChatConditions)
         {
            checkQuest(_loc2_.questID,_loc2_.ConID,0);
         }
      }
      
      public function sendQuestFinish(param1:uint, param2:int = 0) : void
      {
         SocketManager.Instance.out.sendQuestFinish(param1,itemAwardSelected,param2);
         questFinishHook(param1);
      }
      
      private function questFinishHook(param1:uint) : void
      {
         var _loc4_:Number = NaN;
         var _loc2_:* = null;
         var _loc3_:* = null;
         if(!(int(param1) - 544))
         {
            _loc4_ = PlayerManager.Instance.Self.ID;
            _loc2_ = RequestVairableCreater.creatWidthKey(true);
            _loc2_["selfid"] = _loc4_;
            _loc2_["url"] = PathManager.solveLogin();
            _loc2_["nickname"] = PlayerManager.Instance.Self.NickName;
            _loc2_["rnd"] = Math.random();
            _loc3_ = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("SendMailGameUrl.ashx"),6,_loc2_);
            LoadResourceManager.Instance.startLoad(_loc3_);
         }
      }
      
      public function sendQuestData(param1:int, param2:int) : void
      {
         if(!getQuestByID(param1).data)
         {
            return;
         }
         var _loc3_:int = getQuestByID(param1).data.progress[param2];
         _loc3_--;
         checkQuest(param1,param2,_loc3_);
      }
      
      public function HighLightChecked(param1:QuestInfo) : void
      {
         if(param1.isCompleted)
         {
            param1.hadChecked = true;
         }
      }
      
      public function checkQuest(param1:int, param2:int, param3:int) : void
      {
         SocketManager.Instance.out.sendQuestCheck(param1,param2,param3);
      }
      
      private function socketSendQuestAdd(param1:Array) : void
      {
         if(param1 && param1.length > 0)
         {
            SocketManager.Instance.out.sendQuestAdd(param1);
         }
      }
      
      public function checkHighLight() : void
      {
         ExitPromptManager.Instance.changeJSQuestVar();
         var _loc1_:int = 0;
         var _loc2_:QuestCategory = getAvailableQuests(4);
         var _loc5_:int = 0;
         var _loc4_:* = allCurrentQuest;
         for each(var _loc3_ in allCurrentQuest)
         {
            if(_loc2_.list.indexOf(_loc3_) == -1)
            {
               if(!_loc3_.isAchieved || _loc3_.CanRepeat)
               {
                  if(_loc3_.isCompleted && _loc3_.Type != 12 && _loc3_.Type != 13 && _loc3_.Type != 14)
                  {
                     if(!_loc3_.hadChecked)
                     {
                        _loc1_++;
                        HallTaskTrackManager.instance.addCompleteTask(_loc3_.QuestID);
                     }
                  }
               }
            }
         }
         if(_loc1_ > 0)
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
      
      public function jumpToQuestByID(param1:int = -1) : void
      {
         if(param1 == -1)
         {
            param1 = tmpQuestId;
         }
         if(firstshowTask)
         {
            tmpQuestId = param1;
            _returnFun = jumpToQuestByID;
            moduleLoad();
            return;
         }
         var _loc2_:QuestInfo = getQuestByID(param1);
         _isShown = true;
         _events.push(new CEvent("taskGotoQuest",_loc2_));
         show();
      }
      
      public function get manuGetList() : DictionaryData
      {
         return _manuGetList;
      }
   }
}
