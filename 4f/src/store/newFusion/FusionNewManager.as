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
      
      public function FusionNewManager(param1:IEventDispatcher = null){super(null);}
      
      public static function get instance() : FusionNewManager{return null;}
      
      public function setup(param1:FusionNewDataAnalyzer) : void{}
      
      public function getDataListByType(param1:int) : Array{return null;}
      
      public function get dataList() : Object{return null;}
   }
}
