package hall.tasktrack
{
   import com.pickgliss.events.UIModuleEvent;
   import com.pickgliss.loader.UIModuleLoader;
   import com.pickgliss.manager.NoviceDataManager;
   import ddt.data.quest.QuestInfo;
   import ddt.manager.ChatManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PathManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.StateManager;
   import ddt.manager.TimeManager;
   import ddt.view.UIModuleSmallLoading;
   import ddt.view.chat.ChatData;
   import ddtKingWay.DDTKingWayManager;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import flash.utils.Dictionary;
   import quest.TaskManager;
   import road7th.data.DictionaryData;
   import sevenday.SevendayManager;
   
   public class HallTaskTrackManager extends EventDispatcher
   {
      
      private static var _instance:HallTaskTrackManager;
       
      
      public var btnIndexMap:Dictionary;
      
      public var btnList:Array;
      
      private var _func:Function;
      
      private var _funcParams:Array;
      
      private var _completeTaskList:DictionaryData;
      
      private var _hasOpenCommitViewList:DictionaryData;
      
      public function HallTaskTrackManager(target:IEventDispatcher = null)
      {
         _completeTaskList = new DictionaryData();
         _hasOpenCommitViewList = new DictionaryData();
         super(target);
         btnIndexMap = new Dictionary();
      }
      
      public static function get instance() : HallTaskTrackManager
      {
         if(_instance == null)
         {
            _instance = new HallTaskTrackManager();
         }
         return _instance;
      }
      
      public function moduleLoad(complete:Function = null, completeParams:Array = null) : void
      {
         _func = complete;
         _funcParams = completeParams;
         UIModuleSmallLoading.Instance.progress = 0;
         UIModuleSmallLoading.Instance.show();
         UIModuleSmallLoading.Instance.addEventListener("close",__onClose);
         UIModuleLoader.Instance.addEventListener("uiMoudleProgress",__onTaskLoadProgress);
         UIModuleLoader.Instance.addEventListener("uiModuleComplete",__onTaskLoadComplete);
         UIModuleLoader.Instance.addUIModuleImp("quest");
      }
      
      private function __onTaskLoadComplete(event:UIModuleEvent) : void
      {
         if(event.module == "quest")
         {
            UIModuleLoader.Instance.removeEventListener("uiModuleComplete",__onTaskLoadComplete);
            UIModuleLoader.Instance.removeEventListener("uiMoudleProgress",__onTaskLoadProgress);
            UIModuleSmallLoading.Instance.removeEventListener("close",__onClose);
            UIModuleSmallLoading.Instance.hide();
            if(null != _func)
            {
               _func.apply(null,_funcParams);
            }
            _func = null;
            _funcParams = null;
         }
      }
      
      private function __onTaskLoadProgress(event:UIModuleEvent) : void
      {
         if(event.module == "quest")
         {
            UIModuleSmallLoading.Instance.progress = event.loader.progress * 100;
         }
      }
      
      private function __onClose(event:Event) : void
      {
         UIModuleLoader.Instance.removeEventListener("uiModuleComplete",__onTaskLoadComplete);
         UIModuleLoader.Instance.removeEventListener("uiMoudleProgress",__onTaskLoadProgress);
         UIModuleSmallLoading.Instance.removeEventListener("close",__onClose);
      }
      
      public function addCompleteTask(questId:int) : void
      {
         if(StateManager.currentStateType == "main" || StateManager.currentStateType == "matchRoom" || StateManager.currentStateType == "challengeRoom" || StateManager.currentStateType == "dungeonRoom" || StateManager.currentStateType == "freshmanRoom2" || StateManager.currentStateType == "freshmanRoom1" || StateManager.currentStateType == "missionResult" || StateManager.currentStateType == "worldbossRoom")
         {
            openCommitView(questId);
         }
         else if(!_completeTaskList.hasKey(questId))
         {
            _completeTaskList.add(questId,questId);
         }
         if(questId == 558)
         {
            HallTaskGuideManager.instance.clearTask1Arrow();
            NoviceDataManager.instance.saveNoviceData(360,PathManager.userName(),PathManager.solveRequestPath());
         }
      }
      
      public function checkOpenCommitView() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = _completeTaskList;
         for each(var questId in _completeTaskList)
         {
            openCommitView(questId);
         }
      }
      
      private function openCommitView(questId:int) : void
      {
         var startTime:Number = NaN;
         var endTime:Number = NaN;
         var currentTime:Number = NaN;
         var questIndex:int = 0;
         var index1:int = 0;
         var index2:int = 0;
         var questInfo:QuestInfo = TaskManager.instance.getQuestByID(questId);
         if(questInfo.Type == 13 || questInfo.Type == 14)
         {
            currentTime = TimeManager.Instance.Now().time;
            questIndex = 0;
            if(questInfo.Type == 13)
            {
               index1 = SevendayManager.QUEST_LIST_1.indexOf(questId);
               index2 = SevendayManager.QUEST_LIST_2.indexOf(questId);
               if(index1 < 0 && index2 < 0)
               {
                  trace("当前任务类型13，id:" + questInfo.Id + ", 七日目标任务配置出问题！尽快解决(HallTaskTraceManager.as)");
                  return;
               }
               questIndex = index1 == -1?index2:int(index1);
               startTime = PlayerManager.Instance.Self.createPlayerDate.time + questIndex * 86400000;
               endTime = PlayerManager.Instance.Self.createPlayerDate.time + 7 * 86400000;
            }
            else if(questInfo.Type == 14)
            {
               questIndex = DDTKingWayManager.QUEST_LIST.indexOf(questId);
               if(questIndex < 0)
               {
                  trace("当前任务类型14，id:" + questInfo.Id + ", 弹王之路任务配置出问题！尽快解决(HallTaskTraceManager.as)");
                  return;
               }
               startTime = questInfo.data.AddTiemsDate.time;
               endTime = questInfo.data.AddTiemsDate.time + DDTKingWayManager.instance.model[DDTKingWayManager.QUEST_LIST[questIndex]].Validay * 86400000;
            }
            if(currentTime < startTime || currentTime > endTime)
            {
               return;
            }
         }
         if(_hasOpenCommitViewList.hasKey(questId))
         {
            return;
         }
         var chatData:ChatData = new ChatData();
         var _questInfo:QuestInfo = TaskManager.instance.getQuestByID(questId);
         getTypeStr(_questInfo) + LanguageMgr.GetTranslation("hall.taskCompleteCommit.contentTxt",_questInfo.Title);
         var taskStr:String = "<CT7>" + getTypeStr(_questInfo) + LanguageMgr.GetTranslation("hall.taskCompleteCommit.contentTxt",_questInfo.Title) + " " + "</CT7>";
         var getStr:String = "<CT14><u><a href=\'event:clicktype:114|questId:" + questId + "\'>" + LanguageMgr.GetTranslation("hall.taskCompleteCommit.getPrize") + "</a></u></CT14><BR>";
         chatData.htmlMessage = taskStr + getStr;
         chatData.channel = 31;
         ChatManager.Instance.chat(chatData,false);
         _hasOpenCommitViewList.add(questId,questId);
      }
      
      private function getTypeStr(questInfo:QuestInfo) : String
      {
         var tmp:String = "";
         switch(int(questInfo.Type))
         {
            case 0:
               tmp = LanguageMgr.GetTranslation("tank.view.quest.bubble.TankLink");
               break;
            case 1:
               tmp = LanguageMgr.GetTranslation("tank.view.quest.bubble.BranchLine");
               break;
            case 2:
               tmp = LanguageMgr.GetTranslation("tank.view.quest.bubble.Daily");
               break;
            case 3:
               tmp = LanguageMgr.GetTranslation("tank.view.quest.bubble.Act");
               break;
            default:
               tmp = LanguageMgr.GetTranslation("tank.view.quest.bubble.Act");
               break;
            default:
            case 6:
               tmp = LanguageMgr.GetTranslation("tank.view.quest.bubble.Act");
               break;
            default:
               tmp = LanguageMgr.GetTranslation("tank.view.quest.bubble.Act");
               break;
            default:
               tmp = LanguageMgr.GetTranslation("tank.view.quest.bubble.Act");
               break;
            default:
               tmp = LanguageMgr.GetTranslation("tank.view.quest.bubble.Act");
               break;
            case 10:
               tmp = LanguageMgr.GetTranslation("tank.view.quest.bubble.buried");
               break;
            default:
               tmp = LanguageMgr.GetTranslation("tank.view.quest.bubble.buried");
               break;
            case 12:
               tmp = LanguageMgr.GetTranslation("tank.view.quest.bubble.reward");
               break;
            case 13:
               tmp = LanguageMgr.GetTranslation("tank.view.quest.bubble.sevenday");
               break;
            case 14:
               tmp = LanguageMgr.GetTranslation("tank.view.quest.bubble.danwang");
               break;
            default:
               tmp = LanguageMgr.GetTranslation("tank.view.quest.bubble.danwang");
               break;
            case 16:
               tmp = LanguageMgr.GetTranslation("tank.view.quest.bubble.sevenHappy");
               break;
            case 17:
               tmp = LanguageMgr.GetTranslation("tank.view.quest.bubble.weak");
         }
         return tmp;
      }
   }
}
