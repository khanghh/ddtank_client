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
      
      public function MonsterShootBombAction(monster:GameLiving, bombs:Array, event:CrazyTankSocketEvent, interval:int)
      {
         super();
         _monster = monster;
         _bombs = bombs;
         _event = event;
         _prepared = false;
         _shootInterval = interval / 40;
      }
      
      override public function prepare() : void
      {
         _info = BallManager.instance.findBall(_bombs[0].Template.ID);
         _monster.map.requestForFocus(_monster,0);
         _monster.actionMovie.addEventListener(GameLiving.SHOOT_PREPARED,onEventPrepared);
         _monster.actionMovie.doAction("shoot",onCallbackPrepared);
      }
      
      protected function onEventPrepared(evt:Event) : void
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
      
      private function executeImp(fastModel:Boolean) : void
      {
         var i:int = 0;
         var j:int = 0;
         var bomb:* = null;
         if(!_isShoot)
         {
            _isShoot = true;
            SoundManager.instance.play(_info.ShootSound);
            for(i = 0; i < _bombs.length; )
            {
               for(j = 0; j < _bombs[i].Actions.length; )
               {
                  if(_bombs[i].Actions[j].type == 5)
                  {
                     _bombs.unshift(_bombs.splice(i,1)[0]);
                     break;
                  }
                  j++;
               }
               i++;
            }
            var _loc7_:int = 0;
            var _loc6_:* = _bombs;
            for each(var b in _bombs)
            {
               bomb = new SimpleBomb(b,_monster.info);
               _monster.map.addPhysical(bomb);
               if(fastModel)
               {
                  bomb.bombAtOnce();
               }
            }
         }
      }
   }
}
