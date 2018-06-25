package consortion{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.utils.ObjectUtils;   import consortion.rank.RankFrame;   import consortion.view.boss.ConsortiaBossFrame;   import consortion.view.selfConsortia.ConsortionBankFrame;   import consortion.view.selfConsortia.ConsortionQuitFrame;   import consortion.view.selfConsortia.ConsortionShopFrame;   import consortion.view.selfConsortia.EstablishmentFrame;   import consortion.view.selfConsortia.ManagerFrame;   import consortion.view.selfConsortia.TakeInMemberFrame;   import consortion.view.selfConsortia.TaxFrame;   import ddt.events.CEvent;   import ddt.loader.LoaderCreate;   import ddt.manager.PlayerManager;   import ddt.utils.HelperDataModuleLoad;   import flash.events.EventDispatcher;      public class ConsortionModelController extends EventDispatcher   {            private static var _instance:ConsortionModelController;                   private var _manager:ConsortionModelManager;            private var _consortionBankFrame:ConsortionBankFrame;            public var isClickConsortionBuyGiftTask:Boolean;            public function ConsortionModelController() { super(); }
            public static function get Instance() : ConsortionModelController { return null; }
            public function setup() : void { }
            private function addEvent() : void { }
            private function onEventsHandler(e:CEvent) : void { }
            public function alertTaxFrame() : void { }
            public function alertEstablishmentFrame() : void { }
            public function alertManagerFrame() : void { }
            public function rankFrame() : void { }
            public function alertShopFrame() : void { }
            public function alertBankFrame() : void { }
            public function hideBankFrame() : void { }
            public function clearReference() : void { }
            public function alertTakeInFrame() : void { }
            public function alertQuitFrame() : void { }
            public function openBossFrame() : void { }
   }}