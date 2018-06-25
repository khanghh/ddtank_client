package levelFund{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.controls.Frame;   import com.pickgliss.utils.ObjectUtils;   import ddt.events.PkgEvent;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.SocketManager;   import ddt.utils.AssetModuleLoader;   import ddt.view.LevelFundIcon;   import flash.events.EventDispatcher;   import flash.events.IEventDispatcher;   import hall.HallStateView;   import levelFund.event.LevelFundEvent;   import levelFund.model.LevelFundModel;   import road7th.comm.PackageIn;      public class LevelFundManager extends EventDispatcher   {            private static var _instance:LevelFundManager;                   private var _model:LevelFundModel;            private var _frame:Frame;            private var _levelFundActivityIcon:LevelFundIcon;            private var _hallView:HallStateView;            public function LevelFundManager(target:IEventDispatcher = null) { super(null); }
            public static function get instance() : LevelFundManager { return null; }
            public function setup() : void { }
            public function show() : void { }
            private function loadCompleteHandler() : void { }
            public function addLevelFundActivityBtn(hall:HallStateView) : void { }
            private function initBtn() : void { }
            public function deleteBtn() : void { }
            private function __levelFundHandler(evt:PkgEvent) : void { }
            private function getInfoHandler(pkg:PackageIn) : void { }
            private function buyLevelFundHandler(pkg:PackageIn) : void { }
            private function getAwardLevelFundHandler(pkg:PackageIn) : void { }
            public function get levelFundActivityIcon() : LevelFundIcon { return null; }
            public function get model() : LevelFundModel { return null; }
   }}