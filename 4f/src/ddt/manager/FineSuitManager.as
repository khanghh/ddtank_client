package ddt.manager
{
   import ddt.data.analyze.FineSuitAnalyze;
   import ddt.data.store.FineSuitVo;
   import road7th.data.DictionaryData;
   
   public class FineSuitManager
   {
      
      private static var _instance:FineSuitManager;
       
      
      private var _model:DictionaryData;
      
      private var _materialIDList:Array;
      
      private var _data:DictionaryData;
      
      private var propertyList:Array;
      
      private var nameList:Array;
      
      public function FineSuitManager(){super();}
      
      public static function get Instance() : FineSuitManager{return null;}
      
      public function setup(param1:FineSuitAnalyze) : void{}
      
      public function getSuitVoByExp(param1:int) : FineSuitVo{return null;}
      
      public function getNextLevelSuiteVo(param1:int) : FineSuitVo{return null;}
      
      public function getNextSuitVoByExp(param1:int) : FineSuitVo{return null;}
      
      public function updateFineSuitProperty(param1:int, param2:DictionaryData) : void{}
      
      public function getFineSuitPropertyByExp(param1:int) : FineSuitVo{return null;}
      
      public function getTipsPropertyInfoList(param1:int, param2:String) : Array{return null;}
      
      public function getTipsPropertyInfoListToString(param1:int, param2:String) : String{return null;}
      
      public function get materialIDList() : Array{return null;}
      
      public function get tipsData() : DictionaryData{return null;}
      
      public function getSuitVoByLevel(param1:int) : FineSuitVo{return null;}
   }
}
