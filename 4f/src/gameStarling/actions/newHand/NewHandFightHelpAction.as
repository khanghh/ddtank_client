package gameStarling.actions.newHand
{
   import gameCommon.GameControl;
   import gameCommon.model.Bomb;
   import gameCommon.model.Living;
   import gameCommon.model.LocalPlayer;
   import gameCommon.model.Player;
   import gameStarling.view.map.MapView3D;
   
   public class NewHandFightHelpAction extends BaseNewHandFightHelpAction
   {
       
      
      private var _player:LocalPlayer;
      
      private var _enemyPlayer:Player;
      
      private var _bombs:Array;
      
      private var _shootOverCount:int;
      
      private var _map:MapView3D;
      
      public function NewHandFightHelpAction(param1:LocalPlayer, param2:int, param3:MapView3D){super();}
      
      override public function prepare() : void{}
      
      override public function executeAtOnce() : void{}
      
      override public function execute() : void{}
      
      private function getNewHandEnemy() : Player{return null;}
      
      private function checkShootDirection() : Boolean{return false;}
      
      private function checkShootOutMap() : Boolean{return false;}
      
      private function checkHurtSelf() : Boolean{return false;}
      
      private function getRecentBomb() : Bomb{return null;}
      
      private function checkHurtEnemy(param1:Boolean = true) : Boolean{return false;}
   }
}
