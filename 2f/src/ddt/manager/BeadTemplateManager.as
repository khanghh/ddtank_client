package ddt.manager
{
   import beadSystem.model.BeadInfo;
   import ddt.data.analyze.AdvanceBeadAnalyzer;
   import ddt.data.analyze.BeadAnalyzer;
   import flash.events.EventDispatcher;
   import road7th.data.DictionaryData;
   
   public class BeadTemplateManager extends EventDispatcher
   {
      
      private static var _instance:BeadTemplateManager;
       
      
      public var _beadList:DictionaryData;
      
      public var _advanceBeadList:DictionaryData;
      
      public function BeadTemplateManager(){super();}
      
      public static function get Instance() : BeadTemplateManager{return null;}
      
      public function setup(param1:BeadAnalyzer) : void{}
      
      public function setupAdvanceBead(param1:AdvanceBeadAnalyzer) : void{}
      
      public function getBeadAdvanceData(param1:int) : DictionaryData{return null;}
      
      public function GetBeadInfobyID(param1:int) : BeadInfo{return null;}
      
      public function GetBeadTemplateIDByLv(param1:int, param2:int) : int{return 0;}
   }
}
