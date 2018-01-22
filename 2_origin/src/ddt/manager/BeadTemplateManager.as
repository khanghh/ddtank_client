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
      
      public function setup(param1:BeadAnalyzer) : void
      {
         _beadList = param1.list;
      }
      
      public function setupAdvanceBead(param1:AdvanceBeadAnalyzer) : void
      {
         _advanceBeadList = param1.list;
      }
      
      public function getBeadAdvanceData(param1:int) : DictionaryData
      {
         var _loc2_:int = 0;
         var _loc3_:Array = _advanceBeadList.list;
         var _loc5_:int = _loc3_.length;
         if(_loc5_ <= 0)
         {
            return null;
         }
         var _loc4_:DictionaryData = new DictionaryData();
         _loc2_ = 0;
         while(_loc2_ < _loc5_)
         {
            if(_loc3_[_loc2_].quality == param1)
            {
               _loc4_.add(_loc3_[_loc2_].advancedTempId,_loc3_[_loc2_]);
            }
            _loc2_++;
         }
         return _loc4_;
      }
      
      public function GetBeadInfobyID(param1:int) : BeadInfo
      {
         return _beadList[param1];
      }
      
      public function GetBeadTemplateIDByLv(param1:int, param2:int) : int
      {
         var _loc3_:int = 0;
         var _loc5_:BeadInfo = BeadTemplateManager.Instance.GetBeadInfobyID(param2);
         var _loc7_:int = 0;
         var _loc6_:* = _beadList;
         for each(var _loc4_ in _beadList)
         {
            if(_loc5_.Name == _loc4_.Name)
            {
               if(param1 >= _loc4_.BaseLevel && param1 < _loc4_.BaseLevel + _loc4_.MaxLevel)
               {
                  _loc3_ = _loc4_.TemplateID;
                  break;
               }
            }
         }
         return _loc3_;
      }
   }
}
