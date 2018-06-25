package redPackage{   import ddt.CoreManager;   import ddt.events.CEvent;   import ddt.events.PkgEvent;   import ddt.manager.GameInSocketOut;   import ddt.manager.LanguageMgr;   import ddt.manager.SocketManager;   import ddt.utils.ConfirmAlertData;   import ddt.utils.ConfirmAlertHelper;   import road7th.comm.PackageIn;      public class RedPackageManager extends CoreManager   {            public static const SHOW:String = "RedPkg_show";            public static const UPDATE_SEND_RECORD_VIEW:String = "RedPkg_update_send_record_view";            public static const UPDATE_GAIN_RECORD_VIEW:String = "RedPkg_update_gain_record_view";            public static const t_consortia_Send:String = "red_pkg_consortia_send";            public static const t_consortia_Gain:String = "red_pkg_consortia_gain";            public static const t_consortia_Select:String = "red_pkg_consortia_select";            public static const t_more_Select:String = "red_pkg_more_select";            public static const t_Send1:String = "red_pkg_send1";            public static const t_Send2:String = "red_pkg_send2";            public static const t_Gain_And_Send:String = "red_pkg_gain_and_send";            private static var instance:RedPackageManager;                   private var _curFrameData:Object;            private var _curFrameType:String;            private var _sendRecordArr:Array;            private var _gainRecordObj:Object;            private var _moneyNeededData:ConfirmAlertData;            public function RedPackageManager(single:inner) { super(); }
            public static function getInstance() : RedPackageManager { return null; }
            public function get curFrameData() : Object { return null; }
            public function get curFrameType() : String { return null; }
            public function get sendRecordArr() : Array { return null; }
            public function get gainRecordObj() : Object { return null; }
            public function setup() : void { }
            protected function onGainRecordSocketPkg(e:PkgEvent) : void { }
            protected function onSendRecordSocketPkg(e:PkgEvent) : void { }
            override protected function start() : void { }
            public function showView(type:String, data:Object = null) : void { }
            public function onConsortionMakePackage(numMoney:int, numPackage:int, wishWords:String, isAverage:Boolean) : void { }
            public function onConsortionGainPackage(pkgID:int) : void { }
            public function onConsortionGainRecord(pkgID:int) : void { }
            public function onConsortionSendRecord() : void { }
   }}class inner{          function inner() { super(); }
}