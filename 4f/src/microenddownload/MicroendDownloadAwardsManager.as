package microenddownload{   import ddt.data.goods.ItemTemplateInfo;   import ddt.manager.ItemManager;   import flash.events.Event;   import flash.events.EventDispatcher;      public class MicroendDownloadAwardsManager extends EventDispatcher   {            public static const MICROENDDOWNLOAD_OPENVIEW:String = "microendDownloadOpenView";            private static var instance:MicroendDownloadAwardsManager;                   private var info:ItemTemplateInfo;            private var bagCellIdList:Vector.<ItemTemplateInfo>;            private var _list:Array;            public function MicroendDownloadAwardsManager(single:inner) { super(); }
            public static function getInstance() : MicroendDownloadAwardsManager { return null; }
            public function setup(list:Array) : void { }
            public function show() : void { }
            public function getAwardsDetail() : Vector.<ItemTemplateInfo> { return null; }
            public function getCount(index:int) : int { return 0; }
   }}class inner{          function inner() { super(); }
}