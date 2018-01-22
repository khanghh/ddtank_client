package store.newFusion
{
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import store.newFusion.data.FusionNewDataAnalyzer;
   
   public class FusionNewManager extends EventDispatcher
   {
      
      private static var _instance:FusionNewManager;
       
      
      public var isInContinuousFusion:Boolean;
      
      private var _dataList:Object;
      
      public function FusionNewManager(param1:IEventDispatcher = null)
      {
         super(param1);
      }
      
      public static function get instance() : FusionNewManager
      {
         if(_instance == null)
         {
            _instance = new FusionNewManager();
         }
         return _instance;
      }
      
      public function setup(param1:FusionNewDataAnalyzer) : void
      {
         _dataList = param1.data;
      }
      
      public function getDataListByType(param1:int) : Array
      {
         if(_dataList)
         {
            return _dataList[param1] as Array;
         }
         return [];
      }
      
      public function get dataList() : Object
      {
         return _dataList;
      }
   }
}
