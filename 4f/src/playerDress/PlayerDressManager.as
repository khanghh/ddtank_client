package playerDress{   import ddt.CoreManager;   import ddt.data.goods.InventoryItemInfo;   import ddt.events.PkgEvent;   import ddt.manager.PlayerManager;   import ddt.manager.ServerConfigManager;   import ddt.manager.SocketManager;   import flash.events.Event;   import playerDress.components.DressModel;   import playerDress.components.DressUtils;   import playerDress.data.DressVo;   import playerDress.event.PlayerDressEvent;   import road7th.comm.PackageIn;   import road7th.data.DictionaryData;      public class PlayerDressManager extends CoreManager   {            public static const CURRENTMODEL_SET:String = "currentmodel_set";            private static var _instance:PlayerDressManager;                   public var currentIndex:int;            public var modelArr:Array;            public var currentModel:DressModel;            public var currentModelNum:int = 3;            public var additionModel:Array;            private var _viewTypeArr:Array;            public function PlayerDressManager() { super(); }
            public static function get instance() : PlayerDressManager { return null; }
            public function setup() : void { }
            protected function setCurrentModel(event:PkgEvent) : void { }
            protected function setDressModelArr(event:PkgEvent) : void { }
            public function showView(type:int) : void { }
            public function disposeView(type:int) : void { }
            override protected function start() : void { }
   }}