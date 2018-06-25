package magicHouse{   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.controls.alert.BaseAlerFrame;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.ui.vo.AlertInfo;   import ddt.data.BagInfo;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.PlayerManager;   import ddt.manager.ServerConfigManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.manager.TimeManager;   import ddt.view.bossbox.AwardsView;   import flash.events.Event;   import flash.events.EventDispatcher;      public class MagicHouseControl extends EventDispatcher   {            private static var _instance:MagicHouseControl;                   private var _magicHouseMainView:MagicHouseMainView;            public function MagicHouseControl($instance:MagicHouseInstance) { super(); }
            public static function get instance() : MagicHouseControl { return null; }
            public function setup() : void { }
            private function __showHandler(e:Event) : void { }
            private function __hideHandler(e:Event) : void { }
            private function __freeBoxReturnHandler(e:Event) : void { }
            private function __chargeBoxReturnHandler(e:Event) : void { }
            private function __frameClose(e:FrameEvent) : void { }
            public function initServerConfig() : void { }
            public function selectEquipFromBag() : void { }
            public function checkGetFreeBoxTime() : Boolean { return false; }
            public function chechGetChargeBoxTime() : Boolean { return false; }
            public function closeMagicHouseView() : void { }
   }}class MagicHouseInstance{          function MagicHouseInstance() { super(); }
}