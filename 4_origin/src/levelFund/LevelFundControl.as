package levelFund
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import ddt.utils.AssetModuleLoader;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import levelFund.event.LevelFundEvent;
   import levelFund.view.LevelFundFrame;
   
   public class LevelFundControl extends EventDispatcher
   {
      
      private static var _instance:LevelFundControl;
       
      
      private var _frame:LevelFundFrame;
      
      private var _isLoaded:Boolean = false;
      
      public function LevelFundControl(target:IEventDispatcher = null)
      {
         super(target);
      }
      
      public static function get instance() : LevelFundControl
      {
         if(_instance == null)
         {
            _instance = new LevelFundControl();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         LevelFundManager.instance.addEventListener("levelFundOpenView",__onOpenView);
      }
      
      protected function __onOpenView(event:LevelFundEvent) : void
      {
         if(_isLoaded)
         {
            _frame = ComponentFactory.Instance.creatComponentByStylename("levelFund.LevelFundFrame");
            LayerManager.Instance.addToLayer(_frame,3,true,1);
         }
         else
         {
            AssetModuleLoader.addModelLoader("levelFund",6);
            AssetModuleLoader.startCodeLoader(loadCompleteHandler);
         }
      }
      
      private function loadCompleteHandler() : void
      {
         _isLoaded = true;
         _frame = ComponentFactory.Instance.creatComponentByStylename("levelFund.LevelFundFrame");
         LayerManager.Instance.addToLayer(_frame,3,true,1);
      }
   }
}
