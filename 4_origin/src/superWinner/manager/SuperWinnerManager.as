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
      
      public function SuperWinnerManager(param1:PrivateClass)
      {
         super();
      }
      
      public static function get instance() : SuperWinnerManager
      {
         if(SuperWinnerManager._instance == null)
         {
            SuperWinnerManager._instance = new SuperWinnerManager(new PrivateClass());
         }
         return SuperWinnerManager._instance;
      }
      
      public function get isOpen() : Boolean
      {
         return _isOpen;
      }
      
      public function setup() : void
      {
         SocketManager.Instance.addEventListener("super_winner",pkgHandler);
      }
      
      private function pkgHandler(param1:CrazyTankSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.pkg;
         var _loc2_:int = param1._cmd;
         switch(int(_loc2_) - 48)
         {
            case 0:
               _isOpen = _loc3_.readBoolean();
               if(_isOpen)
               {
                  showSuperWinner();
                  if(!isFirstOpen)
                  {
                     dispatchEvent(new Event("roomIsOpen"));
                  }
               }
               else
               {
                  hideSuperWinnerIcon();
               }
               isFirstOpen = _isOpen;
               break;
            case 1:
               StateManager.setState("superWinner");
               SuperWinnerController.instance.enterSuperWinnerRoom(_loc3_);
               break;
            default:
               StateManager.setState("superWinner");
               SuperWinnerController.instance.enterSuperWinnerRoom(_loc3_);
               break;
            default:
               StateManager.setState("superWinner");
               SuperWinnerController.instance.enterSuperWinnerRoom(_loc3_);
               break;
            case 4:
               SuperWinnerController.instance.returnDices(_loc3_);
               break;
            case 5:
               SuperWinnerController.instance.endGame();
               break;
            case 6:
               SuperWinnerController.instance.timesUp(_loc3_);
               break;
            case 7:
               SuperWinnerController.instance.startRollDices();
               break;
            default:
               SuperWinnerController.instance.startRollDices();
               break;
            case 9:
               SuperWinnerController.instance.joinRoom(_loc3_);
         }
      }
      
      public function showSuperWinner() : void
      {
         if(PlayerManager.Instance.Self.Grade >= 20)
         {
            HallIconManager.instance.updateSwitchHandler("superWinner",true);
         }
         else
         {
            HallIconManager.instance.executeCacheRightIconLevelLimit("superWinner",true,20);
         }
      }
      
      public function openSuperWinner(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         SocketManager.Instance.out.enterSuperWinner();
      }
      
      public function hideSuperWinnerIcon() : void
      {
         HallIconManager.instance.updateSwitchHandler("superWinner",false);
         HallIconManager.instance.executeCacheRightIconLevelLimit("superWinner",false);
      }
      
      public function awardsLoadCompleted(param1:SuperWinnerAnalyze) : void
      {
         _awardsVector = param1.awards;
      }
      
      public function get awardsVector() : Vector.<Object>
      {
         return _awardsVector;
      }
      
      public function enterGameSuperWinner() : void
      {
         dispatchEvent(new Event("entergamesuperwinner"));
      }
      
      public function endGameSuperWinner() : void
      {
         dispatchEvent(new Event("endgamesuperwinner"));
      }
      
      public function disposeSuperWinner() : void
      {
         dispatchEvent(new Event("disposesuperwinner"));
      }
   }
}

class PrivateClass
{
    
   
   function PrivateClass()
   {
      super();
   }
}
