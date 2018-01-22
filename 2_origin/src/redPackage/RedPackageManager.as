package redPackage
{
   import ddt.CoreManager;
   import ddt.events.CEvent;
   import ddt.events.PkgEvent;
   import ddt.manager.GameInSocketOut;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SocketManager;
   import ddt.utils.ConfirmAlertData;
   import ddt.utils.ConfirmAlertHelper;
   import road7th.comm.PackageIn;
   
   public class RedPackageManager extends CoreManager
   {
      
      public static const SHOW:String = "RedPkg_show";
      
      public static const UPDATE_SEND_RECORD_VIEW:String = "RedPkg_update_send_record_view";
      
      public static const UPDATE_GAIN_RECORD_VIEW:String = "RedPkg_update_gain_record_view";
      
      public static const t_consortia_Send:String = "red_pkg_consortia_send";
      
      public static const t_consortia_Gain:String = "red_pkg_consortia_gain";
      
      public static const t_consortia_Select:String = "red_pkg_consortia_select";
      
      public static const t_more_Select:String = "red_pkg_more_select";
      
      public static const t_Send1:String = "red_pkg_send1";
      
      public static const t_Send2:String = "red_pkg_send2";
      
      public static const t_Gain_And_Send:String = "red_pkg_gain_and_send";
      
      private static var instance:RedPackageManager;
       
      
      private var _curFrameData:Object;
      
      private var _curFrameType:String;
      
      private var _sendRecordArr:Array;
      
      private var _gainRecordObj:Object;
      
      private var _moneyNeededData:ConfirmAlertData;
      
      public function RedPackageManager(param1:inner)
      {
         super();
         _moneyNeededData = new ConfirmAlertData();
         setup();
      }
      
      public static function getInstance() : RedPackageManager
      {
         if(!instance)
         {
            instance = new RedPackageManager(new inner());
         }
         return instance;
      }
      
      public function get curFrameData() : Object
      {
         return _curFrameData;
      }
      
      public function get curFrameType() : String
      {
         return _curFrameType;
      }
      
      public function get sendRecordArr() : Array
      {
         return _sendRecordArr;
      }
      
      public function get gainRecordObj() : Object
      {
         return _gainRecordObj;
      }
      
      public function setup() : void
      {
         SocketManager.Instance.addEventListener(PkgEvent.format(303,4),onGainRecordSocketPkg);
         SocketManager.Instance.addEventListener(PkgEvent.format(303,3),onSendRecordSocketPkg);
      }
      
      protected function onGainRecordSocketPkg(param1:PkgEvent) : void
      {
         var _loc4_:PackageIn = param1.pkg;
         _gainRecordObj = {};
         _gainRecordObj.nick = _loc4_.readUTF();
         _gainRecordObj.moneyNum = _loc4_.readInt();
         _gainRecordObj.wishWords = _loc4_.readUTF();
         var _loc2_:int = _loc4_.readInt();
         var _loc3_:Array = [];
         while(_loc4_.bytesAvailable > 0)
         {
            _loc3_.push({
               "gainedNick":_gainRecordObj.nick,
               "sendNick":_loc4_.readUTF(),
               "money":_loc4_.readInt(),
               "date":_loc4_.readDate()
            });
         }
         _gainRecordObj.arr = _loc3_;
         dispatchEvent(new CEvent("RedPkg_update_gain_record_view"));
      }
      
      protected function onSendRecordSocketPkg(param1:PkgEvent) : void
      {
         e = param1;
         compareTime = function(param1:Object, param2:Object):Number
         {
            return (param2["date"] as Date).time - (param1["date"] as Date).time;
         };
         var pkg:PackageIn = e.pkg;
         var state:int = pkg.readByte();
         if(state == 0)
         {
            _sendRecordArr = [];
         }
         else if(_sendRecordArr == null)
         {
            _sendRecordArr = [];
         }
         var count:int = pkg.readInt();
         while(pkg.bytesAvailable > 0)
         {
            _sendRecordArr.push({
               "id":pkg.readInt(),
               "isGained":pkg.readBoolean(),
               "date":pkg.readDate(),
               "nick":pkg.readUTF(),
               "remain":pkg.readInt()
            });
         }
         _sendRecordArr.sort(compareTime);
         dispatchEvent(new CEvent("RedPkg_update_send_record_view"));
      }
      
      override protected function start() : void
      {
         dispatchEvent(new CEvent("RedPkg_show"));
      }
      
      public function showView(param1:String, param2:Object = null) : void
      {
         _curFrameType = param1;
         _curFrameData = param2;
         show();
      }
      
      public function onConsortionMakePackage(param1:int, param2:int, param3:String, param4:Boolean) : void
      {
         numMoney = param1;
         numPackage = param2;
         wishWords = param3;
         isAverage = param4;
         onCheckOut = function():void
         {
            GameInSocketOut.sendRedPkgSend(numMoney,numPackage,wishWords,isAverage);
         };
         _moneyNeededData.moneyNeeded = numMoney;
         var msg:String = LanguageMgr.GetTranslation("redPackage.confirmSend");
         var a:ConfirmAlertHelper = new ConfirmAlertHelper(_moneyNeededData);
         a.onCheckOut = onCheckOut;
         a.alert("Cảnh cáo：",msg,"O K","Hủy",false,true,false,2,null,"SimpleAlert",30,true,0);
      }
      
      public function onConsortionGainPackage(param1:int) : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = _sendRecordArr.length;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            if(_sendRecordArr[_loc3_].id == param1)
            {
               _sendRecordArr[_loc3_]["isGained"] = true;
            }
            _loc3_++;
         }
         GameInSocketOut.sendRedPkgGain(param1);
      }
      
      public function onConsortionGainRecord(param1:int) : void
      {
         GameInSocketOut.sendRedPkgGainRecord(param1);
      }
      
      public function onConsortionSendRecord() : void
      {
         GameInSocketOut.sendRedPkgSendRecord();
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
