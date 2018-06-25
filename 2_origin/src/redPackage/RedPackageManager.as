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
      
      public function RedPackageManager(single:inner)
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
      
      protected function onGainRecordSocketPkg(e:PkgEvent) : void
      {
         var pkg:PackageIn = e.pkg;
         _gainRecordObj = {};
         _gainRecordObj.nick = pkg.readUTF();
         _gainRecordObj.moneyNum = pkg.readInt();
         _gainRecordObj.wishWords = pkg.readUTF();
         var count:int = pkg.readInt();
         var arr:Array = [];
         while(pkg.bytesAvailable > 0)
         {
            arr.push({
               "gainedNick":_gainRecordObj.nick,
               "sendNick":pkg.readUTF(),
               "money":pkg.readInt(),
               "date":pkg.readDate()
            });
         }
         _gainRecordObj.arr = arr;
         dispatchEvent(new CEvent("RedPkg_update_gain_record_view"));
      }
      
      protected function onSendRecordSocketPkg(e:PkgEvent) : void
      {
         e = e;
         compareTime = function(a:Object, b:Object):Number
         {
            return (b["date"] as Date).time - (a["date"] as Date).time;
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
      
      public function showView(type:String, data:Object = null) : void
      {
         _curFrameType = type;
         _curFrameData = data;
         show();
      }
      
      public function onConsortionMakePackage(numMoney:int, numPackage:int, wishWords:String, isAverage:Boolean) : void
      {
         numMoney = numMoney;
         numPackage = numPackage;
         wishWords = wishWords;
         isAverage = isAverage;
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
      
      public function onConsortionGainPackage(pkgID:int) : void
      {
         var i:int = 0;
         var len:int = _sendRecordArr.length;
         for(i = 0; i < len; )
         {
            if(_sendRecordArr[i].id == pkgID)
            {
               _sendRecordArr[i]["isGained"] = true;
            }
            i++;
         }
         GameInSocketOut.sendRedPkgGain(pkgID);
      }
      
      public function onConsortionGainRecord(pkgID:int) : void
      {
         GameInSocketOut.sendRedPkgGainRecord(pkgID);
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
