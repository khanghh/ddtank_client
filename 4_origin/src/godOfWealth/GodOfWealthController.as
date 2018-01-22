package godOfWealth
{
   import com.pickgliss.ui.LayerManager;
   import ddt.CoreController;
   import ddt.events.CEvent;
   import ddt.manager.GameInSocketOut;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import godOfWealth.view.GodOfWealthMainView;
   
   public class GodOfWealthController extends CoreController
   {
      
      private static var instance:GodOfWealthController;
       
      
      private var _godOfWealthView:GodOfWealthMainView;
      
      public function GodOfWealthController(param1:inner)
      {
         super();
      }
      
      public static function getInstance() : GodOfWealthController
      {
         if(!instance)
         {
            instance = new GodOfWealthController(new inner());
         }
         return instance;
      }
      
      public function setup() : void
      {
         GodOfWealthManager.getInstance().addEventListener("gow_open_view",onOpenView);
         GodOfWealthManager.getInstance().addEventListener("gow_update",onUpdate);
         GodOfWealthManager.getInstance().addEventListener("gow_result_suc",onResultSuc);
      }
      
      private function onOpenView(param1:CEvent) : void
      {
         GameInSocketOut.sendGodOfWealthInfo();
         _godOfWealthView = new GodOfWealthMainView();
         LayerManager.Instance.addToLayer(_godOfWealthView,3,true,1);
      }
      
      private function onUpdate(param1:CEvent) : void
      {
         if(_godOfWealthView && _godOfWealthView.parent)
         {
            _godOfWealthView.update();
         }
      }
      
      private function onResultSuc(param1:CEvent) : void
      {
         var _loc2_:String = LanguageMgr.GetTranslation("godOfWealth.detail.rewardAlert",GodOfWealthManager.getInstance().reward);
         MessageTipManager.getInstance().show(_loc2_,0,false,1);
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
