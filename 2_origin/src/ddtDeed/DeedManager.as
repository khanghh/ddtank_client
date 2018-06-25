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
      
      public function DeedManager(target:IEventDispatcher = null)
      {
         super(target);
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
         var obj:* = null;
         var stateTipStr:* = null;
         var petGrantTipStr:* = null;
         var petStarStr:* = null;
         var horseLightTipStr:* = null;
         var horseAngerTipStr:* = null;
         var bottomStr:* = null;
         if(isOpen)
         {
            stateTipStr = LanguageMgr.GetTranslation("ddt.deedFrame.awardNameStateTxt") + "\r";
            petGrantTipStr = LanguageMgr.GetTranslation("ddt.deedFrame.awardNameTxt1",getOneBuffData(10)) + "\r";
            petStarStr = LanguageMgr.GetTranslation("ddt.deedFrame.awardNameTxt2",getOneBuffData(11)) + "\r";
            horseLightTipStr = LanguageMgr.GetTranslation("ddt.deedFrame.awardNameTxt3",getOneBuffData(12)) + "\r";
            horseAngerTipStr = LanguageMgr.GetTranslation("ddt.deedFrame.awardNameTxt4",getOneBuffData(13)) + "\r";
            bottomStr = LanguageMgr.GetTranslation("ddt.deedFrame.remainTimeTxt") + deedTimeStr;
         }
         else
         {
            stateTipStr = LanguageMgr.GetTranslation("ddt.deedFrame.awardNameStateTxt2") + "\r";
            petGrantTipStr = LanguageMgr.GetTranslation("ddt.deedFrame.awardNameTxt1",1) + "\r";
            petStarStr = LanguageMgr.GetTranslation("ddt.deedFrame.awardNameTxt2",1) + "\r";
            horseLightTipStr = LanguageMgr.GetTranslation("ddt.deedFrame.awardNameTxt3",1) + "\r";
            horseAngerTipStr = LanguageMgr.GetTranslation("ddt.deedFrame.awardNameTxt4",1) + "\r";
            bottomStr = LanguageMgr.GetTranslation("ddt.deedFrame.remainTimeTxt") + 7 + LanguageMgr.GetTranslation("day");
         }
         var sumStr:String = petGrantTipStr + petStarStr + horseLightTipStr + horseAngerTipStr;
         obj = {};
         var _loc9_:Boolean = true;
         obj.isOpen = _loc9_;
         obj.isSelf = _loc9_;
         obj.title = stateTipStr;
         obj.content = sumStr;
         obj.bottom = bottomStr;
         return obj;
      }
      
      public function get isOpen() : Boolean
      {
         if(_endTime == null)
         {
            _endTime = TimeManager.Instance.Now();
         }
         var differ:Number = _endTime.getTime() - TimeManager.Instance.Now().getTime();
         if(_openType == 0 || differ < 1000)
         {
            return false;
         }
         return true;
      }
      
      public function get deedTimeStr() : String
      {
         var timeTxtStr:* = null;
         if(_endTime == null)
         {
            _endTime = TimeManager.Instance.Now();
         }
         var endTimestamp:Number = _endTime.getTime();
         var nowTimestamp:Number = TimeManager.Instance.Now().getTime();
         var differ:Number = endTimestamp - nowTimestamp;
         var count:int = 0;
         if(differ / 86400000 > 1)
         {
            count = differ / 86400000;
            if(count < 0)
            {
               count = 0;
            }
            timeTxtStr = count + LanguageMgr.GetTranslation("day");
         }
         else if(differ / 3600000 > 1)
         {
            count = differ / 3600000;
            if(count < 0)
            {
               count = 0;
            }
            timeTxtStr = count + LanguageMgr.GetTranslation("hour");
         }
         else if(differ / 60000 > 1)
         {
            count = differ / 60000;
            if(count < 0)
            {
               count = 0;
            }
            timeTxtStr = count + LanguageMgr.GetTranslation("minute");
         }
         else
         {
            count = differ / 1000;
            if(count < 0)
            {
               count = 0;
            }
            timeTxtStr = count + LanguageMgr.GetTranslation("second");
         }
         return timeTxtStr;
      }
      
      public function getOneBuffData(type:int) : int
      {
         if(_openType > 0 && _buffData)
         {
            return _buffData[type];
         }
         return 0;
      }
      
      public function get openType() : int
      {
         return _openType;
      }
      
      private function updateAllData(event:CrazyTankSocketEvent) : void
      {
         var count:int = 0;
         var i:int = 0;
         var tmpkey:int = 0;
         var pkg:PackageIn = event.pkg;
         _openType = pkg.readInt();
         _endTime = pkg.readDate();
         if(_openType > 0)
         {
            count = pkg.readInt();
            _buffData = {};
            for(i = 0; i < count; )
            {
               tmpkey = pkg.readInt();
               _buffData[tmpkey] = pkg.readInt();
               i++;
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
      
      private function updateBuffData(event:CrazyTankSocketEvent) : void
      {
         var pkg:PackageIn = event.pkg;
         var tmpkey:int = pkg.readInt();
         _buffData[tmpkey] = pkg.readInt();
         dispatchEvent(new Event("update_buff_data_event"));
      }
      
      private function timerHandler(event:TimerEvent) : void
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
