package angelInvestment
{
   import angelInvestment.data.AngelInvestmentDataAnalyzer;
   import angelInvestment.data.AngelInvestmentModel;
   import ddt.loader.LoaderCreate;
   import ddt.utils.AssetModuleLoader;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import hallIcon.HallIconManager;
   
   public class AngelInvestmentManager extends EventDispatcher
   {
      
      private static var _instance:AngelInvestmentManager;
       
      
      private var _model:AngelInvestmentModel;
      
      public function AngelInvestmentManager(param1:inner)
      {
         super(null);
         _model = new AngelInvestmentModel();
      }
      
      public static function get instance() : AngelInvestmentManager
      {
         if(_instance == null)
         {
            _instance = new AngelInvestmentManager(new inner());
         }
         return _instance;
      }
      
      public function initHall(param1:Boolean) : void
      {
         HallIconManager.instance.updateSwitchHandler("angelInvestment",param1);
      }
      
      public function onClickIcon() : void
      {
         AssetModuleLoader.addRequestLoader(LoaderCreate.Instance.createAngelInvestmentLoader());
         AssetModuleLoader.addModelLoader("angelInvestment",6);
         AssetModuleLoader.startCodeLoader(showFrame);
      }
      
      private function showFrame() : void
      {
         dispatchEvent(new Event("complete"));
      }
      
      public function onDataComplete(param1:AngelInvestmentDataAnalyzer) : void
      {
         _model.data = param1.data;
      }
      
      public function get model() : AngelInvestmentModel
      {
         return _model;
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
