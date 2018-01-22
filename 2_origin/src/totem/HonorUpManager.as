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
      
      private function updateUpCount(param1:PkgEvent) : void
      {
         var _loc3_:PackageIn = param1.pkg;
         var _loc2_:int = _loc3_.readInt();
         if(upCount != -1 && upCount != _loc2_)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.totem.honorUp.success",dataList[_loc2_ - 1].honor),0,true);
         }
         upCount = _loc2_;
         dispatchEvent(new Event("up_count_update"));
      }
      
      public function setup(param1:HonorUpDataAnalyz) : void
      {
         _dataList = param1.dataList;
      }
   }
}
