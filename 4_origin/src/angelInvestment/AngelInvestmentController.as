package angelInvestment
{
   import angelInvestment.view.AngelInvestmentMainView;
   import com.pickgliss.ui.ComponentFactory;
   import ddt.manager.ServerConfigManager;
   import flash.events.Event;
   
   public class AngelInvestmentController
   {
      
      private static var _instance:AngelInvestmentController;
       
      
      public function AngelInvestmentController($inner:inner)
      {
         super();
      }
      
      public static function get instance() : AngelInvestmentController
      {
         if(_instance == null)
         {
            _instance = new AngelInvestmentController(new inner());
         }
         return _instance;
      }
      
      public function setup() : void
      {
         AngelInvestmentManager.instance.addEventListener("complete",__onComplete);
      }
      
      private function __onComplete(e:Event) : void
      {
         var frame:AngelInvestmentMainView = ComponentFactory.Instance.creatComponentByStylename("angelInvestment.mainView");
         frame.show();
      }
      
      public function get buyAllDay() : int
      {
         return ServerConfigManager.instance.angelInvestmentDay;
      }
      
      public function get buyAllDiscount() : int
      {
         return ServerConfigManager.instance.angelInvestmentDiscount;
      }
      
      public function get buyAllPrice() : int
      {
         return ServerConfigManager.instance.angelInvestmentAllPrice;
      }
   }
}

class inner
{
    
   
   function inner()
   {
      super();
   }
}
