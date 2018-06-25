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
      
      override public function enter(prev:BaseStateView, data:Object = null) : void
      {
         super.enter(prev,data);
         init();
         initSocket();
      }
      
      private function initSocket() : void
      {
         _model.setRoomInfo(_pkg);
      }
      
      public function enterSuperWinnerRoom(pkg:PackageIn) : void
      {
         _pkg = pkg;
      }
      
      public function timesUp(pkg:PackageIn) : void
      {
         var cmd:int = pkg.readByte();
         switch(int(cmd))
         {
            case 0:
               _model.dispatchEvent(new SuperWinnerEvent("progress_time_up"));
               break;
            case 1:
               _model.formatMyAwards(pkg);
               break;
            case 2:
               _model.sendGetAwardsMsg(pkg);
               _model.formatAwards(pkg);
               break;
            case 3:
               _model.flushChampion(pkg,true);
         }
      }
      
      public function returnDices(pkg:PackageIn) : void
      {
         var i:int = 0;
         _model.isCurrentDiceGetAward = pkg.readBoolean();
         _model.currentAwardLevel = pkg.readByte();
         var vt:Vector.<int> = new Vector.<int>(6,true);
         for(i = 0; i < 6; )
         {
            vt[i] = pkg.readByte();
            i++;
         }
         _model.currentDicePoints = vt;
         _model.dispatchEvent(new SuperWinnerEvent("return_dices"));
      }
      
      public function startRollDices() : void
      {
         _model.dispatchEvent(new SuperWinnerEvent("start_roll_dices"));
      }
      
      public function joinRoom(pkg:PackageIn) : void
      {
         _model.joinRoom(pkg);
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
      
      override public function leaving(next:BaseStateView) : void
      {
         dispose();
         super.leaving(next);
      }
      
      public function returnThis() : SuperWinnerController
      {
         return this;
      }
   }
}
