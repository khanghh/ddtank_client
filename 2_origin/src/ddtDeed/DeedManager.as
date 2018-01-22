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
      
      public function DeedManager(param1:IEventDispatcher = null)
      {
         super(param1);
      }
      
      public static function get instance() : DeedManager
      {
         if(_instance == null)
         {
            _instance = new DeedManager();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         SocketManager.Instance.addEventListener("deed_main",updateAllData);
         SocketManager.Instance.addEventListener("deed_update_buff_data",updateBuffData);
         _timer = new Timer(1000);
         _timer.addEventListener("timer",timerHandler);
      }
      
      public function getRemainTimeTxt() : Object
      {
         var _loc4_:* = null;
         var _loc7_:* = null;
         var _loc6_:* = null;
         var _loc8_:* = null;
         var _loc2_:* = null;
         var _loc1_:* = null;
         var _loc3_:* = null;
         if(isOpen)
         {
            _loc7_ = LanguageMgr.GetTranslation("ddt.deedFrame.awardNameStateTxt") + "\r";
            _loc6_ = LanguageMgr.GetTranslation("ddt.deedFrame.awardNameTxt1",getOneBuffData(10)) + "\r";
            _loc8_ = LanguageMgr.GetTranslation("ddt.deedFrame.awardNameTxt2",getOneBuffData(11)) + "\r";
            _loc2_ = LanguageMgr.GetTranslation("ddt.deedFrame.awardNameTxt3",getOneBuffData(12)) + "\r";
            _loc1_ = LanguageMgr.GetTranslation("ddt.deedFrame.awardNameTxt4",getOneBuffData(13)) + "\r";
            _loc3_ = LanguageMgr.GetTranslation("ddt.deedFrame.remainTimeTxt") + deedTimeStr;
         }
         else
         {
            _loc7_ = LanguageMgr.GetTranslation("ddt.deedFrame.awardNameStateTxt2") + "\r";
            _loc6_ = LanguageMgr.GetTranslation("ddt.deedFrame.awardNameTxt1",1) + "\r";
            _loc8_ = LanguageMgr.GetTranslation("ddt.deedFrame.awardNameTxt2",1) + "\r";
            _loc2_ = LanguageMgr.GetTranslation("ddt.deedFrame.awardNameTxt3",1) + "\r";
            _loc1_ = LanguageMgr.GetTranslation("ddt.deedFrame.awardNameTxt4",1) + "\r";
            _loc3_ = LanguageMgr.GetTranslation("ddt.deedFrame.remainTimeTxt") + 7 + LanguageMgr.GetTranslation("day");
         }
         var _loc5_:String = _loc6_ + _loc8_ + _loc2_ + _loc1_;
         _loc4_ = {};
         var _loc9_:Boolean = true;
         _loc4_.isOpen = _loc9_;
         _loc4_.isSelf = _loc9_;
         _loc4_.title = _loc7_;
         _loc4_.content = _loc5_;
         _loc4_.bottom = _loc3_;
         return _loc4_;
      }
      
      public function get isOpen() : Boolean
      {
         if(_endTime == null)
         {
            _endTime = TimeManager.Instance.Now();
         }
         var _loc1_:Number = _endTime.getTime() - TimeManager.Instance.Now().getTime();
         if(_openType == 0 || _loc1_ < 1000)
         {
            return false;
         }
         return true;
      }
      
      public function get deedTimeStr() : String
      {
         var _loc5_:* = null;
         if(_endTime == null)
         {
            _endTime = TimeManager.Instance.Now();
         }
         var _loc4_:Number = _endTime.getTime();
         var _loc3_:Number = TimeManager.Instance.Now().getTime();
         var _loc1_:Number = _loc4_ - _loc3_;
         var _loc2_:int = 0;
         if(_loc1_ / 86400000 > 1)
         {
            _loc2_ = _loc1_ / 86400000;
            if(_loc2_ < 0)
            {
               _loc2_ = 0;
            }
            _loc5_ = _loc2_ + LanguageMgr.GetTranslation("day");
         }
         else if(_loc1_ / 3600000 > 1)
         {
            _loc2_ = _loc1_ / 3600000;
            if(_loc2_ < 0)
            {
               _loc2_ = 0;
            }
            _loc5_ = _loc2_ + LanguageMgr.GetTranslation("hour");
         }
         else if(_loc1_ / 60000 > 1)
         {
            _loc2_ = _loc1_ / 60000;
            if(_loc2_ < 0)
            {
               _loc2_ = 0;
            }
            _loc5_ = _loc2_ + LanguageMgr.GetTranslation("minute");
         }
         else
         {
            _loc2_ = _loc1_ / 1000;
            if(_loc2_ < 0)
            {
               _loc2_ = 0;
            }
            _loc5_ = _loc2_ + LanguageMgr.GetTranslation("second");
         }
         return _loc5_;
      }
      
      public function getOneBuffData(param1:int) : int
      {
         if(_openType > 0 && _buffData)
         {
            return _buffData[param1];
         }
         return 0;
      }
      
      public function get openType() : int
      {
         return _openType;
      }
      
      private function updateAllData(param1:CrazyTankSocketEvent) : void
      {
         var _loc2_:int = 0;
         var _loc5_:int = 0;
         var _loc4_:int = 0;
         var _loc3_:PackageIn = param1.pkg;
         _openType = _loc3_.readInt();
         _endTime = _loc3_.readDate();
         if(_openType > 0)
         {
            _loc2_ = _loc3_.readInt();
            _buffData = {};
            _loc5_ = 0;
            while(_loc5_ < _loc2_)
            {
               _loc4_ = _loc3_.readInt();
               _buffData[_loc4_] = _loc3_.readInt();
               _loc5_++;
            }
            _count = int((_endTime.getTime() - TimeManager.Instance.Now().getTime()) / 1000);
            if(_count > 0)
            {
               _timer.reset();
               _timer.start();
            }
         }
         else
         {
            _buffData = null;
         }
         dispatchEvent(new Event("update_main_event"));
      }
      
      private function updateBuffData(param1:CrazyTankSocketEvent) : void
      {
         var _loc2_:PackageIn = param1.pkg;
         var _loc3_:int = _loc2_.readInt();
         _buffData[_loc3_] = _loc2_.readInt();
         dispatchEvent(new Event("update_buff_data_event"));
      }
      
      private function timerHandler(param1:TimerEvent) : void
      {
         _count = Number(_count) - 1;
         if(_count <= 0)
         {
            _openType = 0;
            _timer.stop();
            dispatchEvent(new Event("update_main_event"));
         }
      }
   }
}
