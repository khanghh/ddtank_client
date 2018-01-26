package ddt.dailyRecord
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import ddt.events.PkgEvent;
   import ddt.manager.ServerManager;
   import ddt.manager.SocketManager;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   
   public class DailyRecordControl extends EventDispatcher
   {
      
      public static const RECORDLIST_IS_READY:String = "recordListIsReady";
      
      private static var _instance:DailyRecordControl;
       
      
      public var recordList:Vector.<DailiyRecordInfo>;
      
      public function DailyRecordControl(){super();}
      
      public static function get Instance() : DailyRecordControl{return null;}
      
      private function __changeServerHandler(param1:Event) : void{}
      
      private function daily(param1:PkgEvent) : void{}
      
      private function sortPos(param1:DailiyRecordInfo) : void{}
      
      private function isUpdate(param1:int) : Boolean{return false;}
      
      public function alertDailyFrame() : void{}
   }
}
