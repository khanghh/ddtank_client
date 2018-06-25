package demonChiYou{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import demonChiYou.view.DemonChiYouRewardBuyCardFrame;   import demonChiYou.view.DemonChiYouRewardResultFrame;   import demonChiYou.view.DemonChiYouRewardSelectFrame;   import flash.events.Event;   import flash.events.EventDispatcher;   import flash.events.IEventDispatcher;      public class DemonChiYouController extends EventDispatcher   {            private static var _instance:DemonChiYouController;                   private var _mgr:DemonChiYouManager;            private var _rewardSelectFrame:DemonChiYouRewardSelectFrame;            private var _rewardResultFrame:DemonChiYouRewardResultFrame;            private var _rewardBuyCardFrame:DemonChiYouRewardBuyCardFrame;            public function DemonChiYouController(target:IEventDispatcher = null) { super(null); }
            public static function get instance() : DemonChiYouController { return null; }
            public function setup() : void { }
            protected function onComplete(event:Event) : void { }
            public function disposeRewardSelectFrame() : void { }
            public function disposeRewardResultFrame() : void { }
            public function disposeRewardBuyCardFrame() : void { }
   }}