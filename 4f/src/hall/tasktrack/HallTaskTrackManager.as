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
      
      public function HallTaskTrackManager(param1:IEventDispatcher = null){super(null);}
      
      public static function get instance() : HallTaskTrackManager{return null;}
      
      public function moduleLoad(param1:Function = null, param2:Array = null) : void{}
      
      private function __onTaskLoadComplete(param1:UIModuleEvent) : void{}
      
      private function __onTaskLoadProgress(param1:UIModuleEvent) : void{}
      
      private function __onClose(param1:Event) : void{}
      
      public function addCompleteTask(param1:int) : void{}
      
      public function checkOpenCommitView() : void{}
      
      private function openCommitView(param1:int) : void{}
      
      private function getTypeStr(param1:QuestInfo) : String{return null;}
   }
}
