package angelInvestment{   import angelInvestment.view.AngelInvestmentMainView;   import com.pickgliss.ui.ComponentFactory;   import ddt.manager.ServerConfigManager;   import flash.events.Event;      public class AngelInvestmentController   {            private static var _instance:AngelInvestmentController;                   public function AngelInvestmentController($inner:inner) { super(); }
            public static function get instance() : AngelInvestmentController { return null; }
            public function setup() : void { }
            private function __onComplete(e:Event) : void { }
            public function get buyAllDay() : int { return 0; }
            public function get buyAllDiscount() : int { return 0; }
            public function get buyAllPrice() : int { return 0; }
   }}class inner{          function inner() { super(); }
}