package gameStarling.actions
{
   import ddt.data.BallInfo;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.manager.BallManager;
   import ddt.manager.SoundManager;
   import gameCommon.actions.BaseAction;
   import gameCommon.model.Bomb;
   import gameStarling.objects.GameSceneEffect3D;
   import gameStarling.objects.SimpleBomb3D;
   import gameStarling.view.map.MapView3D;
   
   public class SceneEffectShootBombAction extends BaseAction
   {
       
      
      private var _bombs:Array;
      
      private var _isShoot:Boolean;
      
      private var _prepared:Boolean;
      
      private var _prepareAction:String;
      
      private var _shootInterval:int;
      
      private var _info:BallInfo;
      
      private var _event:CrazyTankSocketEvent;
      
      private var _endAction:String = "";
      
      private var _livingId:int;
      
      private var _map:MapView3D;
      
      private var _sceneEffect:GameSceneEffect3D;
      
      private var _canShootImp:Boolean;
      
      public function SceneEffectShootBombAction(livingId:int, map:MapView3D, bombs:Array, event:CrazyTankSocketEvent, interval:int)
      {
         super();
         _livingId = livingId;
         _map = map;
         _bombs = bombs;
         _event = event;
         _prepared = false;
         _shootInterval = interval;
         _sceneEffect = _map.getPhysical(_livingId) as GameSceneEffect3D;
      }
      
      override public function prepare() : void
      {
         _info = BallManager.instance.findBall(_bombs[0].Template.ID);
         if(_sceneEffect)
         {
            _sceneEffect.needFocus(0,0,0);
            if(_sceneEffect.effectMovie)
            {
               _sceneEffect.effectMovie.playAction("shoot",onCallbackPrepared);
            }
            else
            {
               onCallbackPrepared();
            }
         }
         else
         {
            onCallbackPrepared();
         }
      }
      
      protected function onCallbackPrepared() : void
      {
         canShoot();
      }
      
      private function canShoot() : void
      {
         _prepared = true;
         _map.cancelFocus();
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
               bomb = new SimpleBomb3D(b,null);
               _map.addPhysical(bomb);
               if(fastModel)
               {
                  bomb.bombAtOnce();
               }
            }
         }
      }
   }
}
