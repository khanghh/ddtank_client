package superWinner.controller
{
   import ddt.states.BaseStateView;
   import road7th.comm.PackageIn;
   import superWinner.event.SuperWinnerEvent;
   import superWinner.manager.SuperWinnerManager;
   import superWinner.model.SuperWinnerModel;
   
   public class SuperWinnerController extends BaseStateView
   {
      
      private static var _instance:SuperWinnerController;
       
      
      private var _model:SuperWinnerModel;
      
      private var _pkg:PackageIn;
      
      public function SuperWinnerController()
      {
         super();
         _model = new SuperWinnerModel();
      }
      
      public static function get instance() : SuperWinnerController
      {
         if(!_instance)
         {
            _instance = new SuperWinnerController();
         }
         return _instance;
      }
      
      public function setup() : void
      {
      }
      
      public function get model() : SuperWinnerModel
      {
         return _model;
      }
      
      override public function enter(param1:BaseStateView, param2:Object = null) : void
      {
         super.enter(param1,param2);
         init();
         initSocket();
      }
      
      private function initSocket() : void
      {
         _model.setRoomInfo(_pkg);
      }
      
      public function enterSuperWinnerRoom(param1:PackageIn) : void
      {
         _pkg = param1;
      }
      
      public function timesUp(param1:PackageIn) : void
      {
         var _loc2_:int = param1.readByte();
         switch(int(_loc2_))
         {
            case 0:
               _model.dispatchEvent(new SuperWinnerEvent("progress_time_up"));
               break;
            case 1:
               _model.formatMyAwards(param1);
               break;
            case 2:
               _model.sendGetAwardsMsg(param1);
               _model.formatAwards(param1);
               break;
            case 3:
               _model.flushChampion(param1,true);
         }
      }
      
      public function returnDices(param1:PackageIn) : void
      {
         var _loc3_:int = 0;
         _model.isCurrentDiceGetAward = param1.readBoolean();
         _model.currentAwardLevel = param1.readByte();
         var _loc2_:Vector.<int> = new Vector.<int>(6,true);
         _loc3_ = 0;
         while(_loc3_ < 6)
         {
            _loc2_[_loc3_] = param1.readByte();
            _loc3_++;
         }
         _model.currentDicePoints = _loc2_;
         _model.dispatchEvent(new SuperWinnerEvent("return_dices"));
      }
      
      public function startRollDices() : void
      {
         _model.dispatchEvent(new SuperWinnerEvent("start_roll_dices"));
      }
      
      public function joinRoom(param1:PackageIn) : void
      {
         _model.joinRoom(param1);
      }
      
      public function endGame() : void
      {
         SuperWinnerManager.instance.endGameSuperWinner();
      }
      
      private function init() : void
      {
         _model = new SuperWinnerModel();
         SuperWinnerManager.instance.enterGameSuperWinner();
      }
      
      override public function getBackType() : String
      {
         return "main";
      }
      
      override public function getType() : String
      {
         return "superWinner";
      }
      
      override public function dispose() : void
      {
         SuperWinnerManager.instance.disposeSuperWinner();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      override public function leaving(param1:BaseStateView) : void
      {
         dispose();
         super.leaving(param1);
      }
      
      public function returnThis() : SuperWinnerController
      {
         return this;
      }
   }
}
