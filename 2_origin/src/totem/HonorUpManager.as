package totem
{
   import ddt.events.PkgEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.SocketManager;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import road7th.comm.PackageIn;
   import totem.data.HonorUpDataAnalyz;
   
   public class HonorUpManager extends EventDispatcher
   {
      
      public static const UP_COUNT_UPDATE:String = "up_count_update";
      
      private static var _instance:HonorUpManager;
       
      
      public var upCount:int = -1;
      
      private var _dataList:Array;
      
      public function HonorUpManager()
      {
         super();
         SocketManager.Instance.addEventListener(PkgEvent.format(96),updateUpCount);
      }
      
      public static function get instance() : HonorUpManager
      {
         if(_instance == null)
         {
            _instance = new HonorUpManager();
         }
         return _instance;
      }
      
      public function get dataList() : Array
      {
         return _dataList;
      }
      
      private function updateUpCount(event:PkgEvent) : void
      {
         var pkg:PackageIn = event.pkg;
         var tmp:int = pkg.readInt();
         if(upCount != -1 && upCount != tmp)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.totem.honorUp.success",dataList[tmp - 1].honor),0,true);
         }
         upCount = tmp;
         dispatchEvent(new Event("up_count_update"));
      }
      
      public function setup(analyzer:HonorUpDataAnalyz) : void
      {
         _dataList = analyzer.dataList;
      }
   }
}
