package giftSystem{   import bagAndInfo.BagAndInfoManager;   import com.pickgliss.events.FrameEvent;   import com.pickgliss.loader.BaseLoader;   import com.pickgliss.loader.LoadResourceManager;   import com.pickgliss.ui.AlertManager;   import com.pickgliss.ui.controls.alert.BaseAlerFrame;   import ddt.CoreManager;   import ddt.data.RecordInfo;   import ddt.data.analyze.RecordAnalyzer;   import ddt.manager.LanguageMgr;   import ddt.manager.PathManager;   import ddt.utils.RequestVairableCreater;   import flash.events.Event;   import flash.events.IEventDispatcher;   import flash.net.URLVariables;      public class GiftManager extends CoreManager   {            public static const RECEIVEDPATH:String = "GiftRecieveLog.ashx";            public static const SENDEDPATH:String = "GiftSendLog.ashx";            private static var _instance:GiftManager;                   private var _recordInfo:RecordInfo;            private var _rebackName:String = "";            private var _alertFrame:BaseAlerFrame;            private var _canActive:Boolean;            private var _path:String;            private var _inChurch:Boolean;            public function GiftManager(target:IEventDispatcher = null) { super(null); }
            public static function get Instance() : GiftManager { return null; }
            public function get canActive() : Boolean { return false; }
            public function set canActive(value:Boolean) : void { }
            public function get inChurch() : Boolean { return false; }
            public function set inChurch(value:Boolean) : void { }
            private function initEvent() : void { }
            public function loadRecord(path:String, userID:int) : void { }
            public function get recordInfo() : RecordInfo { return null; }
            private function __setupRecord(analyzer:RecordAnalyzer) : void { }
            public function get rebackName() : String { return null; }
            public function set rebackName(value:String) : void { }
            public function RebackClick(value:String) : void { }
            private function __responsehandler(event:FrameEvent) : void { }
            override protected function start() : void { }
            protected function __bagCloseHandler(event:Event) : void { }
   }}