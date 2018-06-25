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
      
      public function BeadTemplateManager()
      {
         super();
         _beadList = new DictionaryData();
         _advanceBeadList = new DictionaryData();
      }
      
      public static function get Instance() : BeadTemplateManager
      {
         if(_instance == null)
         {
            _instance = new BeadTemplateManager();
         }
         return _instance;
      }
      
      public function setup(pAnalyzer:BeadAnalyzer) : void
      {
         _beadList = pAnalyzer.list;
      }
      
      public function setupAdvanceBead(analyzer:AdvanceBeadAnalyzer) : void
      {
         _advanceBeadList = analyzer.list;
      }
      
      public function getBeadAdvanceData(type:int) : DictionaryData
      {
         var index:int = 0;
         var temArr:Array = _advanceBeadList.list;
         var len:int = temArr.length;
         if(len <= 0)
         {
            return null;
         }
         var temDic:DictionaryData = new DictionaryData();
         for(index = 0; index < len; )
         {
            if(temArr[index].quality == type)
            {
               temDic.add(temArr[index].advancedTempId,temArr[index]);
            }
            index++;
         }
         return temDic;
      }
      
      public function GetBeadInfobyID(pBeadTemplateID:int) : BeadInfo
      {
         return _beadList[pBeadTemplateID];
      }
      
      public function GetBeadTemplateIDByLv(pLv:int, pIDbefore:int) : int
      {
         var vResultID:int = 0;
         var info:BeadInfo = BeadTemplateManager.Instance.GetBeadInfobyID(pIDbefore);
         var _loc7_:int = 0;
         var _loc6_:* = _beadList;
         for each(var o in _beadList)
         {
            if(info.Name == o.Name)
            {
               if(pLv >= o.BaseLevel && pLv < o.BaseLevel + o.MaxLevel)
               {
                  vResultID = o.TemplateID;
                  break;
               }
            }
         }
         return vResultID;
      }
   }
}
