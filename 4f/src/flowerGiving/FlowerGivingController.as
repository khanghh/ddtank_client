package flowerGiving{   import com.pickgliss.events.UIModuleEvent;   import com.pickgliss.loader.UIModuleLoader;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import ddt.manager.SoundManager;   import ddt.view.UIModuleSmallLoading;   import flash.events.Event;   import flash.events.EventDispatcher;   import flash.events.TimerEvent;   import flash.utils.Timer;   import flowerGiving.components.FlowerFallMc;   import flowerGiving.components.FlowerSendFrameNameInput;   import flowerGiving.events.FlowerGiveEvent;   import flowerGiving.views.FlowerGivingFrame;   import flowerGiving.views.FlowerMainView;   import flowerGiving.views.FlowerSendFrame;   import flowerGiving.views.FlowerSendRecordFrame;   import wonderfulActivity.data.GiftBagInfo;      public class FlowerGivingController extends EventDispatcher   {            private static var _instance:FlowerGivingController;                   private var _frame:FlowerGivingFrame;            private var flowerMc:FlowerFallMc;            private var delayTimer:Timer;            private var _manager:FlowerGivingManager;            public function FlowerGivingController() { super(null); }
            public static function get instance() : FlowerGivingController { return null; }
            public function onShow() : void { }
            protected function __flowerMcComplete(event:Event) : void { }
            protected function onDelayTimer(event:TimerEvent) : void { }
            public function getDataByRewardMark(mark:int) : Array { return null; }
            protected function onSmallLoadingClose(event:Event) : void { }
            protected function onUIProgress(event:UIModuleEvent) : void { }
            public function setup() : void { }
            protected function onFlowerEventHandler(e:FlowerGiveEvent) : void { }
            private function onFlowerFall() : void { }
            private function onSetup(e:FlowerGiveEvent) : void { }
            protected function createFlowerGivingFrame(event:UIModuleEvent) : void { }
   }}