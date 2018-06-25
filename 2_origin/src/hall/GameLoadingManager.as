package hall
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.PlayerManager;
   import flash.display.MovieClip;
   import flash.events.EventDispatcher;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class GameLoadingManager extends EventDispatcher
   {
      
      private static var _instance:GameLoadingManager;
       
      
      private var _loadingMc:MovieClip;
      
      private var _timer:Timer;
      
      public function GameLoadingManager()
      {
         super();
      }
      
      public static function get Instance() : GameLoadingManager
      {
         if(_instance == null)
         {
            _instance = new GameLoadingManager();
         }
         return _instance;
      }
      
      public function show() : void
      {
         _loadingMc = ComponentFactory.Instance.creat("ddt.hall.GameLoaingMc");
         LayerManager.Instance.addToLayer(_loadingMc,0,true,1);
         _timer = new Timer(1000,10);
         _timer.addEventListener("timerComplete",__onHide);
         _timer.start();
      }
      
      public function createRoomComplete() : void
      {
         if(_timer)
         {
            _timer.removeEventListener("timerComplete",__onHide);
            _timer.stop();
            _timer = null;
         }
      }
      
      protected function __onHide(event:TimerEvent) : void
      {
         hide();
      }
      
      public function hide() : void
      {
         ObjectUtils.disposeObject(_loadingMc);
         _loadingMc = null;
         if(_timer)
         {
            _timer.removeEventListener("timerComplete",__onHide);
            _timer.stop();
            _timer = null;
         }
         PlayerManager.Instance.Self.LastServerId = -1;
      }
   }
}
