package enchant{   import ddt.events.PkgEvent;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.SocketManager;   import enchant.data.EnchantInfo;   import enchant.data.EnchantModel;   import flash.events.EventDispatcher;   import flash.events.IEventDispatcher;      public class EnchantManager extends EventDispatcher   {            private static var _instance:EnchantManager;                   public var infoVec:Vector.<EnchantInfo>;            public var model:EnchantModel;            public var isUpGrade:Boolean;            public var soulStoneId:int = 11166;            public var soulStoneGoodsId:int = 1116601;            public function EnchantManager(target:IEventDispatcher = null) { super(null); }
            public static function get instance() : EnchantManager { return null; }
            public function setupInfoList(analyzer:EnchantInfoAnalyzer) : void { }
            private function setUp() : void { }
            public function getEnchantInfoByLevel(level:int) : EnchantInfo { return null; }
            protected function __updateHandler(event:PkgEvent) : void { }
   }}class SingleClass{          function SingleClass() { super(); }
}