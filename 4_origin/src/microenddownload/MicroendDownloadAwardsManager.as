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
      
      public function MicroendDownloadAwardsManager(single:inner)
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
      
      public function setup(list:Array) : void
      {
         var i:int = 0;
         _list = list;
         bagCellIdList = new Vector.<ItemTemplateInfo>();
         for(i = 0; i < list.length; )
         {
            bagCellIdList[i] = ItemManager.Instance.getTemplateById(list[i]["id"]);
            i++;
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
      
      public function getCount(index:int) : int
      {
         return _list[index]["count"];
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
