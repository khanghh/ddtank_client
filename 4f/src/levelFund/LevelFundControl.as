package levelFund{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import ddt.utils.AssetModuleLoader;   import flash.events.EventDispatcher;   import flash.events.IEventDispatcher;   import levelFund.event.LevelFundEvent;   import levelFund.view.LevelFundFrame;      public class LevelFundControl extends EventDispatcher   {            private static var _instance:LevelFundControl;                   private var _frame:LevelFundFrame;            private var _isLoaded:Boolean = false;            public function LevelFundControl(target:IEventDispatcher = null) { super(null); }
            public static function get instance() : LevelFundControl { return null; }
            public function setup() : void { }
            protected function __onOpenView(event:LevelFundEvent) : void { }
            private function loadCompleteHandler() : void { }
   }}