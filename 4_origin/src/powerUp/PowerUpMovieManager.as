package powerUp
{
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.PkgEvent;
   import ddt.manager.SocketManager;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   
   public class PowerUpMovieManager extends EventDispatcher
   {
      
      public static const POWER_UP:String = "powerUp";
      
      public static const POWER_UP_MOVIE_OVER:String = "powerUpMovieOver";
      
      private static var _instance:PowerUpMovieManager;
      
      public static var powerNum:int;
      
      public static var addedPowerNum:int;
      
      public static var isInPlayerInfoView:Boolean;
      
      public static var isCanPlayMovie:Boolean;
       
      
      private var _powerMovie:PowerSprite;
      
      public function PowerUpMovieManager()
      {
         super();
      }
      
      public static function get Instance() : PowerUpMovieManager
      {
         if(_instance == null)
         {
            _instance = new PowerUpMovieManager();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         SocketManager.Instance.addEventListener(PkgEvent.format(115),__fightPowerHandler);
         addEventListener("powerUp",__powerUpHandler);
      }
      
      protected function __fightPowerHandler(event:PkgEvent) : void
      {
         powerNum = event.pkg.readInt();
         isCanPlayMovie = true;
      }
      
      protected function __powerUpMovieOverHandler(event:Event) : void
      {
         if(_powerMovie)
         {
            _powerMovie.removeEventListener("powerUpMovieOver",__powerUpMovieOverHandler);
         }
         if(_powerMovie)
         {
            ObjectUtils.disposeObject(_powerMovie);
         }
         _powerMovie = null;
         powerNum = powerNum + addedPowerNum;
      }
      
      protected function __powerUpHandler(event:Event) : void
      {
         if(_powerMovie)
         {
            return;
         }
         _powerMovie = new PowerSprite(powerNum,addedPowerNum);
         _powerMovie.x = 220;
         _powerMovie.y = 250;
         _powerMovie.addEventListener("powerUpMovieOver",__powerUpMovieOverHandler);
         LayerManager.Instance.addToLayer(_powerMovie,0,false,0);
      }
   }
}
