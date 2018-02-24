package gameStarling.actions
{
   import ddt.data.BallInfo;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.manager.BallManager;
   import ddt.manager.SoundManager;
   import flash.events.Event;
   import gameCommon.actions.BaseAction;
   import gameCommon.model.Bomb;
   import gameStarling.objects.GameLiving3D;
   import gameStarling.objects.SimpleBomb3D;
   
   public class MonsterShootBombAction extends BaseAction
   {
       
      
      private var _monster:GameLiving3D;
      
      private var _bombs:Array;
      
      private var _isShoot:Boolean;
      
      private var _prepared:Boolean;
      
      private var _prepareAction:String;
      
      private var _shootInterval:int;
      
      private var _info:BallInfo;
      
      private var _event:CrazyTankSocketEvent;
      
      private var _endAction:String = "";
      
      private var _canShootImp:Boolean;
      
      public function MonsterShootBombAction(param1:GameLiving3D, param2:Array, param3:CrazyTankSocketEvent, param4:int){super();}
      
      override public function prepare() : void{}
      
      protected function onEventPrepared(param1:Event) : void{}
      
      protected function onCallbackPrepared() : void{}
      
      private function canShoot() : void{}
      
      override public function execute() : void{}
      
      private function executeImp(param1:Boolean) : void{}
   }
}
