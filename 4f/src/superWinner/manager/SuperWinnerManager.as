package superWinner.manager
{
   import ddt.events.CrazyTankSocketEvent;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.StateManager;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.MouseEvent;
   import hallIcon.HallIconManager;
   import road7th.comm.PackageIn;
   import superWinner.analyze.SuperWinnerAnalyze;
   import superWinner.controller.SuperWinnerController;
   import superWinner.model.SuperWinnerModel;
   
   public class SuperWinnerManager extends EventDispatcher
   {
      
      private static var _instance:SuperWinnerManager;
      
      public static const ENDGAME_SUPERWINNER:String = "endgamesuperwinner";
      
      public static const ENTERGAME_SUPERWINNER:String = "entergamesuperwinner";
      
      public static const DISPOSE_SUPERWINNER:String = "disposesuperwinner";
      
      public static const ROOM_IS_OPEN:String = "roomIsOpen";
       
      
      private var _model:SuperWinnerModel;
      
      private var _isOpen:Boolean = false;
      
      private var isFirstOpen:Boolean;
      
      private var _awardsVector:Vector.<Object>;
      
      public function SuperWinnerManager(param1:PrivateClass){super();}
      
      public static function get instance() : SuperWinnerManager{return null;}
      
      public function get isOpen() : Boolean{return false;}
      
      public function setup() : void{}
      
      private function pkgHandler(param1:CrazyTankSocketEvent) : void{}
      
      public function showSuperWinner() : void{}
      
      public function openSuperWinner(param1:MouseEvent) : void{}
      
      public function hideSuperWinnerIcon() : void{}
      
      public function awardsLoadCompleted(param1:SuperWinnerAnalyze) : void{}
      
      public function get awardsVector() : Vector.<Object>{return null;}
      
      public function enterGameSuperWinner() : void{}
      
      public function endGameSuperWinner() : void{}
      
      public function disposeSuperWinner() : void{}
   }
}

class PrivateClass
{
    
   
   function PrivateClass(){super();}
}
