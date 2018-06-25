package angelInvestment{   import angelInvestment.data.AngelInvestmentDataAnalyzer;   import angelInvestment.data.AngelInvestmentModel;   import ddt.loader.LoaderCreate;   import ddt.utils.AssetModuleLoader;   import flash.events.Event;   import flash.events.EventDispatcher;   import hallIcon.HallIconManager;      public class AngelInvestmentManager extends EventDispatcher   {            private static var _instance:AngelInvestmentManager;                   private var _model:AngelInvestmentModel;            public function AngelInvestmentManager($inner:inner) { super(null); }
            public static function get instance() : AngelInvestmentManager { return null; }
            public function initHall($isOpen:Boolean) : void { }
            public function onClickIcon() : void { }
            private function showFrame() : void { }
            public function onDataComplete(analyzer:AngelInvestmentDataAnalyzer) : void { }
            public function get model() : AngelInvestmentModel { return null; }
   }}class inner{          function inner() { super(); }
}