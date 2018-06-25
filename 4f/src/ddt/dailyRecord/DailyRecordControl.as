package ddt.dailyRecord{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.utils.handler;   import ddt.events.PkgEvent;   import ddt.manager.ChatManager;   import ddt.manager.LanguageMgr;   import ddt.manager.ServerManager;   import ddt.manager.SocketManager;   import ddt.view.chat.ChatData;   import flash.events.Event;   import flash.events.EventDispatcher;   import flash.utils.setTimeout;   import road7th.comm.PackageIn;      public class DailyRecordControl extends EventDispatcher   {            public static const RECORDLIST_IS_READY:String = "recordListIsReady";            private static var _instance:DailyRecordControl;                   public var recordList:Vector.<DailiyRecordInfo>;            public function DailyRecordControl() { super(); }
            public static function get Instance() : DailyRecordControl { return null; }
            public function setup() : void { }
            private function SingleLogHandler(evt:PkgEvent) : void { }
            private function __changeServerHandler(event:Event) : void { }
            private function daily(event:PkgEvent) : void { }
            private function sortPos(info:DailiyRecordInfo) : void { }
            private function isUpdate(type:int) : Boolean { return false; }
            public function alertDailyFrame() : void { }
   }}