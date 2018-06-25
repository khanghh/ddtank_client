package treasure.controller{   import com.pickgliss.events.UIModuleEvent;   import com.pickgliss.loader.UIModuleLoader;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.goods.ItemTemplateInfo;   import ddt.events.CrazyTankSocketEvent;   import ddt.manager.ItemManager;   import ddt.manager.PathManager;   import ddt.manager.PlayerManager;   import ddt.manager.SocketManager;   import ddt.manager.StateManager;   import ddt.view.UIModuleSmallLoading;   import farm.FarmModelController;   import flash.events.Event;   import flash.events.EventDispatcher;   import treasure.data.TreasureTempInfo;   import treasure.events.TreasureEvents;   import treasure.model.TreasureModel;      public class TreasureManager extends EventDispatcher   {            private static var _instance:TreasureManager = null;                   private var _UILoadComplete:Boolean = false;            public function TreasureManager() { super(); }
            public static function get instance() : TreasureManager { return null; }
            private function initEvent() : void { }
            private function __digHandler(e:CrazyTankSocketEvent) : void { }
            private function __endGameHandler(e:CrazyTankSocketEvent) : void { }
            private function __stratGameHandler(e:CrazyTankSocketEvent) : void { }
            private function __farmBeRepairHandler(e:CrazyTankSocketEvent) : void { }
            private function __onEnterTreasure(e:CrazyTankSocketEvent) : void { }
            private function sortList() : void { }
            private function creatView() : void { }
            private function loadUIModule() : void { }
            protected function __onClose(event:Event) : void { }
            protected function __onUIModuleComplete(event:UIModuleEvent) : void { }
            protected function __onProgress(event:UIModuleEvent) : void { }
            public function show() : void { }
   }}