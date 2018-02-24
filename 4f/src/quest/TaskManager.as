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
      
      public function TaskManager(){super();}
      
      public static function get instance() : TaskManager{return null;}
      
      public function get improve() : QuestImproveInfo{return null;}
      
      public function set selectedQuest(param1:QuestInfo) : void{}
      
      public function get selectedQuest() : QuestInfo{return null;}
      
      public function switchVisible() : void{}
      
      public function taskFrameShow() : void{}
      
      override protected function start() : void{}
      
      public function taskFrameHide() : void{}
      
      private function moduleLoad() : void{}
      
      private function questOnLoaded() : void{}
      
      public function get isShow() : Boolean{return false;}
      
      public function set isShow(param1:Boolean) : void{}
      
      public function setup(param1:QuestListAnalyzer) : void{}
      
      public function reloadNewQuest(param1:QuestListAnalyzer) : void{}
      
      private function getImproveArray(param1:XML) : QuestImproveInfo{return null;}
      
      public function addQuest(param1:QuestInfo) : void{}
      
      public function loadQuestLog(param1:ByteArray) : void{}
      
      private function IsQuestFinish(param1:int) : Boolean{return false;}
      
      public function get allQuests() : Dictionary{return null;}
      
      public function set allQuests(param1:Dictionary) : void{}
      
      public function getQuestByID(param1:int) : QuestInfo{return null;}
      
      public function getQuestDataByID(param1:int) : QuestDataInfo{return null;}
      
      public function getAllQuestInfoByType(param1:int) : Array{return null;}
      
      public function getAvailableQuests(param1:int = -1, param2:Boolean = true) : QuestCategory{return null;}
      
      public function getQuestCategory() : void{}
      
      public function get allHotQuests() : Array{return null;}
      
      public function get allAvailableQuests() : Array{return null;}
      
      public function get allCurrentQuest() : Array{return null;}
      
      public function get mainQuests() : Array{return null;}
      
      public function get sideQuests() : Array{return null;}
      
      public function get dailyQuests() : Array{return null;}
      
      public function get texpQuests() : Array{return null;}
      
      public function get newQuests() : Array{return null;}
      
      public function set currentCategory(param1:int) : void{}
      
      public function get currentCategory() : int{return 0;}
      
      public function get welcomeQuests() : Array{return null;}
      
      public function get welcomeGuildQuests() : Array{return null;}
      
      public function getTaskData(param1:int) : QuestDataInfo{return null;}
      
      public function isAvailableQuest(param1:QuestInfo, param2:Boolean = false) : Boolean{return false;}
      
      public function isAchieved(param1:QuestInfo) : Boolean{return false;}
      
      public function isCompleted(param1:QuestInfo) : Boolean{return false;}
      
      public function isAvailable(param1:QuestInfo) : Boolean{return false;}
      
      private function haveLog(param1:QuestInfo) : Boolean{return false;}
      
      public function isValidateByDate(param1:QuestInfo) : Boolean{return false;}
      
      public function isAvailableByGuild(param1:QuestInfo) : Boolean{return false;}
      
      public function isAvailableByMarry(param1:QuestInfo) : Boolean{return false;}
      
      private function questManuGetHandler(param1:PkgEvent) : void{}
      
      public function __updateAcceptedTask(param1:PkgEvent) : void{}
      
      private function addNewQuest(param1:QuestInfo) : void{}
      
      private function availableForMainToolBar() : Boolean{return false;}
      
      public function clearNewQuest() : void{}
      
      public function showGetNewQuest() : void{}
      
      private function __onComplete(param1:Event) : void{}
      
      private function __onclicked(param1:MouseEvent) : void{}
      
      public function get currentNewQuest() : QuestInfo{return null;}
      
      private function __questFinish(param1:PkgEvent) : void{}
      
      private function onFinishQuest(param1:int) : void{}
      
      public function jumpToQuest(param1:QuestInfo) : void{}
      
      public function onBagChanged() : void{}
      
      public function onGuildUpdate() : void{}
      
      public function onPlayerLevelUp() : void{}
      
      public function finshMarriage() : void{}
      
      public function get achievementQuest() : QuestInfo{return null;}
      
      public function requestAchievementReward() : void{}
      
      public function requestCanAcceptTask() : void{}
      
      public function requestQuest(param1:QuestInfo) : void{}
      
      public function isRequestQuest(param1:QuestInfo) : Boolean{return false;}
      
      public function addRequestAddQuestDic(param1:*, param2:QuestInfo) : void{}
      
      public function checkSendRequestAddQuestDic() : void{}
      
      public function requestClubTask() : void{}
      
      public function isHaveBuriedQuest() : Boolean{return false;}
      
      public function addEquipUpdateListener() : void{}
      
      private function __onEquipUpdate(param1:BagEvent) : void{}
      
      public function addItemListener(param1:int) : void{}
      
      private function __onBagUpdate(param1:BagEvent) : void{}
      
      public function addGradeListener() : void{}
      
      private function __onPlayerPropertyChange(param1:PlayerPropertyEvent) : void{}
      
      public function onMarriaged() : void{}
      
      public function addGuildMemberListener() : void{}
      
      public function addAnnexListener(param1:QuestCondition) : void{}
      
      public function addDesktopListener(param1:QuestCondition) : void{}
      
      public function onDesktopApp() : void{}
      
      public function onSendAnnex(param1:Array) : void{}
      
      public function addFriendListener(param1:QuestCondition) : void{}
      
      private function __onQuestChange(param1:TaskEvent) : void{}
      
      private function __onFriendListComplete(param1:Event) : void{}
      
      private function __onFriendListUpdated(param1:DictionaryEvent) : void{}
      
      public function hasConsortiaSayTask() : Boolean{return false;}
      
      public function addConsortaChatCondition(param1:QuestCondition) : void{}
      
      private function __onConsortiaChat(param1:ChatEvent) : void{}
      
      public function sendQuestFinish(param1:uint, param2:int = 0) : void{}
      
      private function questFinishHook(param1:uint) : void{}
      
      public function sendQuestData(param1:int, param2:int) : void{}
      
      public function HighLightChecked(param1:QuestInfo) : void{}
      
      public function checkQuest(param1:int, param2:int, param3:int) : void{}
      
      private function socketSendQuestAdd(param1:Array) : void{}
      
      public function checkHighLight() : void{}
      
      private function showTaskHightLight() : void{}
      
      public function jumpToQuestByID(param1:int = -1) : void{}
      
      public function get manuGetList() : DictionaryData{return null;}
   }
}
