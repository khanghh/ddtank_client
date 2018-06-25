package groupPurchase
{
   import ddt.manager.SoundManager;
   import flash.events.Event;
   import groupPurchase.view.GroupPurchaseMainView;
   import hallIcon.HallIconManager;
   
   public class GroupPurchaseController
   {
      
      private static var _instance:GroupPurchaseController;
       
      
      public function GroupPurchaseController()
      {
         super();
      }
      
      public static function get instance() : GroupPurchaseController
      {
         if(_instance == null)
         {
            _instance = new GroupPurchaseController();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         GroupPurchaseManager.instance.addEventListener("GroupPurchaseShowFrame",__onShowFrame);
      }
      
      private function __onShowFrame(e:Event) : void
      {
         SoundManager.instance.play("008");
         var _view:GroupPurchaseMainView = new GroupPurchaseMainView();
         _view.init();
         HallIconManager.instance.showCommonFrame(_view,"wonderfulActivityManager.btnTxt9",530,565);
      }
   }
}
