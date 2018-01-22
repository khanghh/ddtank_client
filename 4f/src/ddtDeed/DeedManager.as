package ddtDeed
{
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SocketManager;
   import ddt.manager.TimeManager;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import road7th.comm.PackageIn;
   
   public class DeedManager extends EventDispatcher
   {
      
      private static var _instance:DeedManager;
      
      public static const UPDATE_BUFF_DATA_EVENT:String = "update_buff_data_event";
      
      public static const UPDATE_MAIN_EVENT:String = "update_main_event";
      
      public static const PET_GRANT:int = 10;
      
      public static const PET_STAR:int = 11;
      
      public static const HORSE_LIGHT:int = 12;
      
      public static const HORSE_ANGER:int = 13;
       
      
      private var _openType:int;
      
      private var _endTime:Date;
      
      private var _buffData:Object;
      
      private var _timer:Timer;
      
      private var _count:int;
      
      private var _func:Function;
      
      private var _funcParams:Array;
      
      private var _isChecked:Boolean = false;
      
      private var _confirmFrame:BaseAlerFrame;
      
      public function DeedManager(param1:IEventDispatcher = null){super(null);}
      
      public static function get instance() : DeedManager{return null;}
      
      public function setup() : void{}
      
      public function getRemainTimeTxt() : Object{return null;}
      
      public function get isOpen() : Boolean{return false;}
      
      public function get deedTimeStr() : String{return null;}
      
      public function getOneBuffData(param1:int) : int{return 0;}
      
      public function get openType() : int{return 0;}
      
      private function updateAllData(param1:CrazyTankSocketEvent) : void{}
      
      private function updateBuffData(param1:CrazyTankSocketEvent) : void{}
      
      private function timerHandler(param1:TimerEvent) : void{}
   }
}
