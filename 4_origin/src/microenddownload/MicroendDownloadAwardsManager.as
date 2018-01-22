package microenddownload
{
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.ItemManager;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   
   public class MicroendDownloadAwardsManager extends EventDispatcher
   {
      
      public static const MICROENDDOWNLOAD_OPENVIEW:String = "microendDownloadOpenView";
      
      private static var instance:MicroendDownloadAwardsManager;
       
      
      private var info:ItemTemplateInfo;
      
      private var bagCellIdList:Vector.<ItemTemplateInfo>;
      
      private var _list:Array;
      
      public function MicroendDownloadAwardsManager(param1:inner)
      {
         super();
      }
      
      public static function getInstance() : MicroendDownloadAwardsManager
      {
         if(!instance)
         {
            instance = new MicroendDownloadAwardsManager(new inner());
         }
         return instance;
      }
      
      public function setup(param1:Array) : void
      {
         var _loc2_:int = 0;
         _list = param1;
         bagCellIdList = new Vector.<ItemTemplateInfo>();
         _loc2_ = 0;
         while(_loc2_ < param1.length)
         {
            bagCellIdList[_loc2_] = ItemManager.Instance.getTemplateById(param1[_loc2_]["id"]);
            _loc2_++;
         }
      }
      
      public function show() : void
      {
         dispatchEvent(new Event("microendDownloadOpenView"));
      }
      
      public function getAwardsDetail() : Vector.<ItemTemplateInfo>
      {
         return bagCellIdList;
      }
      
      public function getCount(param1:int) : int
      {
         return _list[param1]["count"];
      }
   }
}

class inner
{
    
   
   function inner()
   {
      super();
   }
}
