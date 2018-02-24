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
      
      public function CollectionTaskManager(param1:IEventDispatcher = null){super(null);}
      
      public static function get Instance() : CollectionTaskManager{return null;}
      
      public function setUp() : void{}
      
      public function robertDataSetup(param1:CollectionTaskAnalyzer) : void{}
      
      private function loadMap() : void{}
      
      private function onMapSrcLoadedComplete(param1:LoaderEvent = null) : void{}
   }
}
