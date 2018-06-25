package devilTurn.view{   import ddt.manager.LanguageMgr;   import ddt.manager.ServerConfigManager;   import ddt.manager.TimeManager;   import devilTurn.DevilTurnManager;   import devilTurn.event.DevilTurnEvent;   import devilTurn.model.DevilTurnModel;   import devilTurn.model.DevilTurnPointShopItem;   import devilTurn.view.mornui.DevilTurnMallViewUI;   import flash.events.TimerEvent;   import flash.utils.Timer;   import morn.core.components.Box;   import morn.core.handlers.Handler;   import road7th.utils.DateUtils;      public class DevilTurnMallView extends DevilTurnMallViewUI   {                   private var _model:DevilTurnModel;            private var _timer:Timer;            private var _endTime:Number;            public function DevilTurnMallView() { super(); }
            override protected function preinitialize() : void { }
            override protected function initialize() : void { }
            private function __onTimer(e:TimerEvent) : void { }
            private function onRenderAwardList(item:Box, index:int) : void { }
            private function __onUpdateInfo(e:DevilTurnEvent) : void { }
            override public function dispose() : void { }
   }}