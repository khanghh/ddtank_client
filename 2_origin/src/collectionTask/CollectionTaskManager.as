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
      
      public function CollectionTaskManager(target:IEventDispatcher = null)
      {
         super(target);
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
         var infoArr:Array = TaskManager.instance.allCurrentQuest;
         var _loc4_:int = 0;
         var _loc3_:* = infoArr;
         for each(var info in infoArr)
         {
            if(info.Condition == 64)
            {
               questInfo = info;
               break;
            }
         }
         loadMap();
      }
      
      public function robertDataSetup(analyzer:CollectionTaskAnalyzer) : void
      {
         collectionTaskInfoList = analyzer.collectionTaskInfoList;
      }
      
      private function loadMap() : void
      {
         _mapLoader = LoadResourceManager.Instance.createLoader(PathManager.solveCollectionTaskSceneSourcePath("collectionScene"),4);
         _mapLoader.addEventListener("complete",onMapSrcLoadedComplete);
         LoadResourceManager.Instance.startLoad(_mapLoader);
      }
      
      private function onMapSrcLoadedComplete(event:LoaderEvent = null) : void
      {
         if(_mapLoader.isSuccess)
         {
            StateManager.setState("collectionTaskScene");
         }
      }
   }
}
