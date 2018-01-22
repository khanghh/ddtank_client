package ddtKingWay
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.quest.QuestInfo;
   import ddt.events.PlayerPropertyEvent;
   import ddt.events.TaskEvent;
   import ddt.loader.LoaderCreate;
   import ddt.manager.PlayerManager;
   import ddt.manager.TimeManager;
   import ddt.utils.AssetModuleLoader;
   import ddtKingWay.analyzer.DDTKingWayData;
   import ddtKingWay.analyzer.DDTKingWayDataAnalyzer;
   import hallIcon.HallIconManager;
   import quest.TaskManager;
   import road7th.data.DictionaryData;
   
   public class DDTKingWayManager
   {
      
      public static const QUEST_LIST:Array = [3301,3302,3303,3304,3305];
      
      private static var _instance:DDTKingWayManager;
       
      
      private var _model:DictionaryData;
      
      private var _frame:Frame;
      
      public function DDTKingWayManager(param1:inner){super();}
      
      public static function get instance() : DDTKingWayManager{return null;}
      
      public function checkIcon() : void{}
      
      public function setup() : void{}
      
      protected function ddtKingWayIconShow(param1:PlayerPropertyEvent) : void{}
      
      protected function __onQuestChange(param1:TaskEvent) : void{}
      
      public function analyzer(param1:DDTKingWayDataAnalyzer) : void{}
      
      public function get model() : DictionaryData{return null;}
      
      private function getAllComplete() : Boolean{return false;}
      
      public function get isShowIcon() : Boolean{return false;}
      
      public function getIndexComplete(param1:int) : Boolean{return false;}
      
      public function checkOut(param1:QuestInfo, param2:DDTKingWayData) : Boolean{return false;}
      
      public function getPageIndexByGrade(param1:int) : int{return 0;}
      
      private function showFrame() : void{}
      
      public function show() : void{}
      
      public function closeFrame() : void{}
   }
}

class inner
{
    
   
   function inner(){super();}
}
