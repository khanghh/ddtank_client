package game.actions
{
   import ddt.data.BallInfo;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.manager.BallManager;
   import ddt.manager.SoundManager;
   import flash.events.Event;
   import game.objects.GameLiving;
   import game.objects.SimpleBomb;
   import gameCommon.actions.BaseAction;
   import gameCommon.model.Bomb;
   
   public class MonsterShootBombAction extends BaseAction
   {
       
      
      private var _monster:GameLiving;
      
      private var _bombs:Array;
      
      private var _isShoot:Boolean;
      
      private var _prepared:Boolean;
      
      private var _prepareAction:String;
      
      private var _shootInterval:int;
      
      private var _info:BallInfo;
      
      private var _event:CrazyTankSocketEvent;
      
      private var _endAction:String = "";
      
      private var _canShootImp:Boolean;
      
      public function MonsterShootBombAction(param1:GameLiving, param2:Array, param3:CrazyTankSocketEvent, param4:int)
      {
         super();
         _monster = param1;
         _bombs = param2;
         _event = param3;
         _prepared = false;
         _shootInterval = param4 / 40;
      }
      
      override public function prepare() : void
      {
         _info = BallManager.instance.findBall(_bombs[0].Template.ID);
         _monster.map.requestForFocus(_monster,0);
         _monster.actionMovie.addEventListener(GameLiving.SHOOT_PREPARED,onEventPrepared);
         _monster.actionMovie.doAction("shoot",onCallbackPrepared);
      }
      
      protected function onEventPrepared(param1:Event) : void
      {
         canShoot();
      }
      
      protected function onCallbackPrepared() : void
      {
         canShoot();
      }
      
      private function canShoot() : void
      {
         _monster.actionMovie.removeEventListener(GameLiving.SHOOT_PREPARED,onEventPrepared);
         _prepared = true;
         _monster.map.cancelFocus(_monster);
      }
      
      override public function execute() : void
      {
         if(!_prepared)
         {
            return;
         }
         if(!_isShoot)
         {
            executeImp(false);
         }
         else
         {
            _shootInterval = Number(_shootInterval) - 1;
            if(_shootInterval <= 0)
            {
               _isFinished = true;
               _event.executed = true;
            }
         }
      }
      
      private function executeImp(param1:Boolean) : void
      {
         var _loc5_:int = 0;
         var _loc4_:int = 0;
         var _loc3_:* = null;
         if(!_isShoot)
         {
            _isShoot = true;
            SoundManager.instance.play(_info.ShootSound);
            _loc5_ = 0;
            while(_loc5_ < _bombs.length)
            {
               _loc4_ = 0;
               while(_loc4_ < _bombs[_loc5_].Actions.length)
               {
                  if(_bombs[_loc5_].Actions[_loc4_].type == 5)
                  {
                     _bombs.unshift(_bombs.splice(_loc5_,1)[0]);
                     break;
                  }
                  _loc4_++;
               }
               _loc5_++;
            }
            var _loc7_:int = 0;
            var _loc6_:* = _bombs;
            for each(var _loc2_ in _bombs)
            {
               _loc3_ = new SimpleBomb(_loc2_,_monster.info);
               _monster.map.addPhysical(_loc3_);
               if(param1)
               {
                  _loc3_.bombAtOnce();
               }
            }
         }
      }
   }
}
