package conRecharge{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import conRecharge.view.ConRechargeFrame;   import ddt.CoreManager;   import ddt.utils.HelperUIModuleLoad;   import flash.events.IEventDispatcher;   import hallIcon.HallIconManager;   import wonderfulActivity.data.GiftBagInfo;      public class ConRechargeManager extends CoreManager   {            private static var _instance:ConRechargeManager;                   public var isOpen:Boolean;            private var _frame:ConRechargeFrame;            private var _giftbagArray:Array;            public var dayGiftbagArray:Array;            public var longGiftbagArray:Array;            public var beginTime:String;            public var endTime:String;            public var actId:String;            public function ConRechargeManager(target:IEventDispatcher = null) { super(null); }
            public static function get instance() : ConRechargeManager { return null; }
            public function setup() : void { }
            override protected function start() : void { }
            private function onLoaded() : void { }
            public function showIcon() : void { }
            public function set giftbagArray(value:Array) : void { }
   }}