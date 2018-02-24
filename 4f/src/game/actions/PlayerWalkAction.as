package game.actions
{
   import ddt.manager.SoundManager;
   import ddt.view.character.GameCharacter;
   import flash.geom.Point;
   import game.objects.GameLiving;
   import game.objects.GameLocalPlayer;
   import game.objects.GamePlayer;
   import gameCommon.GameControl;
   import gameCommon.actions.BaseAction;
   import gameCommon.model.LocalPlayer;
   
   public class PlayerWalkAction extends BaseAction
   {
       
      
      private var _living:GameLiving;
      
      private var _action;
      
      private var _target:Point;
      
      private var _dir:Number;
      
      private var _self:LocalPlayer;
      
      private var _finishedFun:Function;
      
      public function PlayerWalkAction(param1:GameLiving, param2:Point, param3:Number, param4:* = null, param5:Function = null){super();}
      
      override public function connect(param1:BaseAction) : Boolean{return false;}
      
      override public function prepare() : void{}
      
      override public function execute() : void{}
      
      private function finish() : void{}
      
      override public function executeAtOnce() : void{}
   }
}
