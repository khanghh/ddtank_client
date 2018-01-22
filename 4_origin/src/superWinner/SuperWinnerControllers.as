package superWinner
{
   import christmas.view.playingSnowman.RoomMenuView;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import superWinner.controller.SuperWinnerController;
   import superWinner.manager.SuperWinnerManager;
   import superWinner.view.SuperWinnerView;
   
   public class SuperWinnerControllers extends EventDispatcher
   {
      
      private static var _instance:SuperWinnerControllers;
       
      
      private var _view:SuperWinnerView;
      
      private var _roomMenuView:RoomMenuView;
      
      public function SuperWinnerControllers()
      {
         super();
      }
      
      public static function get Instance() : SuperWinnerControllers
      {
         if(!_instance)
         {
            _instance = new SuperWinnerControllers();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         SuperWinnerManager.instance.addEventListener("entergamesuperwinner",__onEnterGame);
         SuperWinnerManager.instance.addEventListener("endgamesuperwinner",__onEndGame);
         SuperWinnerManager.instance.addEventListener("disposesuperwinner",__onDisposeSuperWinner);
      }
      
      private function __onEnterGame(param1:Event) : void
      {
         _view = new SuperWinnerView(SuperWinnerController.instance.returnThis());
         LayerManager.Instance.addToLayer(_view,3,true,1);
      }
      
      private function __onEndGame(param1:Event) : void
      {
         if(_view)
         {
            _view.endGame();
         }
      }
      
      private function __onDisposeSuperWinner(param1:Event) : void
      {
         ObjectUtils.disposeObject(_view);
      }
   }
}
