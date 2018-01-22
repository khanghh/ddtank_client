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
      
      public function HallTaskTrackManager(param1:IEventDispatcher = null)
      {
         _completeTaskList = new DictionaryData();
         _hasOpenCommitViewList = new DictionaryData();
         super(param1);
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
      
      public function moduleLoad(param1:Function = null, param2:Array = null) : void
      {
         _func = param1;
         _funcParams = param2;
         UIModuleSmallLoading.Instance.progress = 0;
         UIModuleSmallLoading.Instance.show();
         UIModuleSmallLoading.Instance.addEventListener("close",__onClose);
         UIModuleLoader.Instance.addEventListener("uiMoudleProgress",__onTaskLoadProgress);
         UIModuleLoader.Instance.addEventListener("uiModuleComplete",__onTaskLoadComplete);
         UIModuleLoader.Instance.addUIModuleImp("quest");
      }
      
      private function __onTaskLoadComplete(param1:UIModuleEvent) : void
      {
         if(param1.module == "quest")
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
      
      private function __onTaskLoadProgress(param1:UIModuleEvent) : void
      {
         if(param1.module == "quest")
         {
            UIModuleSmallLoading.Instance.progress = param1.loader.progress * 100;
         }
      }
      
      private function __onClose(param1:Event) : void
      {
         UIModuleLoader.Instance.removeEventListener("uiModuleComplete",__onTaskLoadComplete);
         UIModuleLoader.Instance.removeEventListener("uiMoudleProgress",__onTaskLoadProgress);
         UIModuleSmallLoading.Instance.removeEventListener("close",__onClose);
      }
      
      public function addCompleteTask(param1:int) : void
      {
         if(StateManager.currentStateType == "main" || StateManager.currentStateType == "matchRoom" || StateManager.currentStateType == "challengeRoom" || StateManager.currentStateType == "dungeonRoom" || StateManager.currentStateType == "freshmanRoom2" || StateManager.currentStateType == "freshmanRoom1" || StateManager.currentStateType == "missionResult" || StateManager.currentStateType == "worldbossRoom")
         {
            openCommitView(param1);
         }
         else if(!_completeTaskList.hasKey(param1))
         {
            _completeTaskList.add(param1,param1);
         }
         if(param1 == 558)
         {
            HallTaskGuideManager.instance.clearTask1Arrow();
            NoviceDataManager.instance.saveNoviceData(360,PathManager.userName(),PathManager.solveRequestPath());
         }
      }
      
      public function checkOpenCommitView() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = _completeTaskList;
         for each(var _loc1_ in _completeTaskList)
         {
            openCommitView(_loc1_);
         }
      }
      
      private function openCommitView(param1:int) : void
      {
         var _loc3_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc2_:Number = NaN;
         var _loc7_:int = 0;
         var _loc6_:int = 0;
         var _loc9_:int = 0;
         var _loc12_:QuestInfo = TaskManager.instance.getQuestByID(param1);
         if(_loc12_.Type == 13 || _loc12_.Type == 14)
         {
            _loc2_ = TimeManager.Instance.Now().time;
            _loc7_ = 0;
            if(_loc12_.Type == 13)
            {
               _loc6_ = SevendayManager.QUEST_LIST_1.indexOf(param1);
               _loc9_ = SevendayManager.QUEST_LIST_2.indexOf(param1);
               if(_loc6_ < 0 && _loc9_ < 0)
               {
                  return;
                  §§push(trace("当前任务类型13，id:" + _loc12_.Id + ", 七日目标任务配置出问题！尽快解决(HallTaskTraceManager.as)"));
               }
               else
               {
                  _loc7_ = _loc6_ == -1?_loc9_:int(_loc6_);
                  _loc3_ = PlayerManager.Instance.Self.createPlayerDate.time + _loc7_ * 86400000;
                  _loc10_ = PlayerManager.Instance.Self.createPlayerDate.time + 7 * 86400000;
               }
            }
            else if(_loc12_.Type == 14)
            {
               _loc7_ = DDTKingWayManager.QUEST_LIST.indexOf(param1);
               if(_loc7_ < 0)
               {
                  return;
                  §§push(trace("当前任务类型14，id:" + _loc12_.Id + ", 弹王之路任务配置出问题！尽快解决(HallTaskTraceManager.as)"));
               }
               else
               {
                  _loc3_ = _loc12_.data.AddTiemsDate.time;
                  _loc10_ = _loc12_.data.AddTiemsDate.time + DDTKingWayManager.instance.model[DDTKingWayManager.QUEST_LIST[_loc7_]].Validay * 86400000;
               }
            }
            if(_loc2_ < _loc3_ || _loc2_ > _loc10_)
            {
               return;
            }
         }
         if(_hasOpenCommitViewList.hasKey(param1))
         {
            return;
         }
         var _loc8_:ChatData = new ChatData();
         var _loc5_:QuestInfo = TaskManager.instance.getQuestByID(param1);
         getTypeStr(_loc5_) + LanguageMgr.GetTranslation("hall.taskCompleteCommit.contentTxt",_loc5_.Title);
         var _loc4_:String = "<CT7>" + getTypeStr(_loc5_) + LanguageMgr.GetTranslation("hall.taskCompleteCommit.contentTxt",_loc5_.Title) + " " + "</CT7>";
         var _loc11_:String = "<CT14><u><a href=\'event:clicktype:114|questId:" + param1 + "\'>" + LanguageMgr.GetTranslation("hall.taskCompleteCommit.getPrize") + "</a></u></CT14><BR>";
         _loc8_.htmlMessage = _loc4_ + _loc11_;
         _loc8_.channel = 31;
         ChatManager.Instance.chat(_loc8_,false);
         _hasOpenCommitViewList.add(param1,param1);
      }
      
      private function getTypeStr(param1:QuestInfo) : String
      {
         var _loc2_:String = "";
         switch(int(param1.Type))
         {
            case 0:
               _loc2_ = LanguageMgr.GetTranslation("tank.view.quest.bubble.TankLink");
               break;
            case 1:
               _loc2_ = LanguageMgr.GetTranslation("tank.view.quest.bubble.BranchLine");
               break;
            case 2:
               _loc2_ = LanguageMgr.GetTranslation("tank.view.quest.bubble.Daily");
               break;
            case 3:
               _loc2_ = LanguageMgr.GetTranslation("tank.view.quest.bubble.Act");
               break;
            default:
               _loc2_ = LanguageMgr.GetTranslation("tank.view.quest.bubble.Act");
               break;
            default:
            case 6:
               _loc2_ = LanguageMgr.GetTranslation("tank.view.quest.bubble.Act");
               break;
            default:
               _loc2_ = LanguageMgr.GetTranslation("tank.view.quest.bubble.Act");
               break;
            default:
               _loc2_ = LanguageMgr.GetTranslation("tank.view.quest.bubble.Act");
               break;
            default:
               _loc2_ = LanguageMgr.GetTranslation("tank.view.quest.bubble.Act");
               break;
            case 10:
               _loc2_ = LanguageMgr.GetTranslation("tank.view.quest.bubble.buried");
               break;
            default:
               _loc2_ = LanguageMgr.GetTranslation("tank.view.quest.bubble.buried");
               break;
            case 12:
               _loc2_ = LanguageMgr.GetTranslation("tank.view.quest.bubble.reward");
               break;
            case 13:
               _loc2_ = LanguageMgr.GetTranslation("tank.view.quest.bubble.sevenday");
               break;
            case 14:
               _loc2_ = LanguageMgr.GetTranslation("tank.view.quest.bubble.danwang");
               break;
            default:
               _loc2_ = LanguageMgr.GetTranslation("tank.view.quest.bubble.danwang");
               break;
            case 16:
               _loc2_ = LanguageMgr.GetTranslation("tank.view.quest.bubble.sevenHappy");
               break;
            case 17:
               _loc2_ = LanguageMgr.GetTranslation("tank.view.quest.bubble.weak");
         }
         return _loc2_;
      }
   }
}
