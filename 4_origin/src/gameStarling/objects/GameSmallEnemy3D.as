package gameStarling.objects
{
   import ddt.events.LivingEvent;
   import gameCommon.model.SmallEnemy;
   import gameStarling.actions.MonsterShootBombAction;
   import road7th.data.StringObject;
   import starlingPhy.maps.Map3D;
   import starlingPhy.object.PhysicalObj3D;
   
   public class GameSmallEnemy3D extends GameLiving3D
   {
       
      
      private var _bombEvent:LivingEvent;
      
      private var _noDispose:Boolean = false;
      
      private var _disposedOverTurns:Boolean = true;
      
      public function GameSmallEnemy3D(info:SmallEnemy)
      {
         super(info);
         info.defaultAction = "stand";
      }
      
      override protected function initView() : void
      {
         super.initView();
         initMovie();
      }
      
      override public function setMap(map:Map3D) : void
      {
         super.setMap(map);
         if(map)
         {
            __posChanged(null);
         }
      }
      
      public function get smallEnemy() : SmallEnemy
      {
         return info as SmallEnemy;
      }
      
      override protected function __bloodChanged(event:LivingEvent) : void
      {
         super.__bloodChanged(event);
         if(event.value - event.old < 0)
         {
            doAction("cry");
         }
      }
      
      override protected function __die(event:LivingEvent) : void
      {
         if(isMoving())
         {
            stopMoving();
         }
         super.__die(event);
         if(event.paras[0])
         {
            if(_info.typeLiving == 2)
            {
               actionMovie.doAction("die",clearEnemy);
            }
            else if(_noDispose)
            {
               actionMovie.doAction("die");
            }
            else
            {
               actionMovie.doAction("die",dispose);
            }
         }
         else if(_info.typeLiving == 2)
         {
            clearEnemy();
         }
         else
         {
            dispose();
         }
         _isDie = true;
      }
      
      override public function collidedByObject(obj:PhysicalObj3D) : void
      {
         if(obj is SimpleBomb3D)
         {
            info.isHidden = false;
         }
      }
      
      private function clearEnemy() : void
      {
         removeEvents(true);
         deleteSmallView();
      }
      
      private function removeEvents(flag:Boolean = false) : void
      {
         super.removeListener();
         if(flag)
         {
            _info.addEventListener("beginNewTurn",__beginNewTurn);
         }
      }
      
      override protected function __shoot(event:LivingEvent) : void
      {
         map.act(new MonsterShootBombAction(this,event.paras[0],event.paras[1],24));
      }
      
      override protected function __beginNewTurn(event:LivingEvent) : void
      {
         if(!_disposedOverTurns)
         {
            return;
         }
         if(_isDie)
         {
            _turns = Number(_turns) + 1;
         }
         if(_turns >= 5)
         {
            dispose();
         }
      }
      
      override public function dispose() : void
      {
         if(_info)
         {
            _info.dispose();
         }
         super.dispose();
      }
      
      override public function setProperty(property:String, value:String) : void
      {
         var vo:StringObject = new StringObject(value);
         super.setProperty(property,value);
         var _loc4_:* = property;
         if("disposedOverTurns" !== _loc4_)
         {
            if("noDispose" === _loc4_)
            {
               _noDispose = vo.getBoolean();
            }
         }
         else
         {
            _disposedOverTurns = vo.getBoolean();
         }
      }
   }
}
