package collectionTask
{
   import collectionTask.model.CollectionTaskAnalyzer;
   import collectionTask.vo.CollectionRobertVo;
   import com.pickgliss.loader.BaseLoader;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.loader.LoaderEvent;
   import ddt.data.quest.QuestInfo;
   import ddt.manager.PathManager;
   import ddt.manager.StateManager;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import quest.TaskManager;
   
   public class CollectionTaskManager extends EventDispatcher
   {
      
      private static var _instance:CollectionTaskManager;
       
      
      public var isClickCollection:Boolean;
      
      public var collectionTaskInfoList:Vector.<CollectionRobertVo>;
      
      public var isCollecting:Boolean;
      
      public var collectedId:int;
      
      public var isTaskComplete:Boolean;
      
      public var questInfo:QuestInfo;
      
      private const CONDITION_ID:int = 64;
      
      private var _mapLoader:BaseLoader;
      
      public function CollectionTaskManager(param1:IEventDispatcher = null)
      {
         super(param1);
      }
      
      public static function get Instance() : CollectionTaskManager
      {
         if(_instance == null)
         {
            _instance = new CollectionTaskManager();
         }
         return _instance;
      }
      
      public function setUp() : void
      {
         var _loc1_:Array = TaskManager.instance.allCurrentQuest;
         var _loc4_:int = 0;
         var _loc3_:* = _loc1_;
         for each(var _loc2_ in _loc1_)
         {
            if(_loc2_.Condition == 64)
            {
               questInfo = _loc2_;
               break;
            }
         }
         loadMap();
      }
      
      public function robertDataSetup(param1:CollectionTaskAnalyzer) : void
      {
         collectionTaskInfoList = param1.collectionTaskInfoList;
      }
      
      private function loadMap() : void
      {
         _mapLoader = LoadResourceManager.Instance.createLoader(PathManager.solveCollectionTaskSceneSourcePath("collectionScene"),4);
         _mapLoader.addEventListener("complete",onMapSrcLoadedComplete);
         LoadResourceManager.Instance.startLoad(_mapLoader);
      }
      
      private function onMapSrcLoadedComplete(param1:LoaderEvent = null) : void
      {
         if(_mapLoader.isSuccess)
         {
            StateManager.setState("collectionTaskScene");
         }
      }
   }
}
