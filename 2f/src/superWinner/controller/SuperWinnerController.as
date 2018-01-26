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
      
      public function SuperWinnerController(){super();}
      
      public static function get instance() : SuperWinnerController{return null;}
      
      public function setup() : void{}
      
      public function get model() : SuperWinnerModel{return null;}
      
      override public function enter(param1:BaseStateView, param2:Object = null) : void{}
      
      private function initSocket() : void{}
      
      public function enterSuperWinnerRoom(param1:PackageIn) : void{}
      
      public function timesUp(param1:PackageIn) : void{}
      
      public function returnDices(param1:PackageIn) : void{}
      
      public function startRollDices() : void{}
      
      public function joinRoom(param1:PackageIn) : void{}
      
      public function endGame() : void{}
      
      private function init() : void{}
      
      override public function getBackType() : String{return null;}
      
      override public function getType() : String{return null;}
      
      override public function dispose() : void{}
      
      override public function leaving(param1:BaseStateView) : void{}
      
      public function returnThis() : SuperWinnerController{return null;}
   }
}
