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
      
      public function GameSmallEnemy3D(param1:SmallEnemy)
      {
         super(param1);
         param1.defaultAction = "stand";
      }
      
      override protected function initView() : void
      {
         super.initView();
         initMovie();
      }
      
      override public function setMap(param1:Map3D) : void
      {
         super.setMap(param1);
         if(param1)
         {
            __posChanged(null);
         }
      }
      
      public function get smallEnemy() : SmallEnemy
      {
         return info as SmallEnemy;
      }
      
      override protected function __bloodChanged(param1:LivingEvent) : void
      {
         super.__bloodChanged(param1);
         if(param1.value - param1.old < 0)
         {
            doAction("cry");
         }
      }
      
      override protected function __die(param1:LivingEvent) : void
      {
         if(isMoving())
         {
            stopMoving();
         }
         super.__die(param1);
         if(param1.paras[0])
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
      
      override public function collidedByObject(param1:PhysicalObj3D) : void
      {
         if(param1 is SimpleBomb3D)
         {
            info.isHidden = false;
         }
      }
      
      private function clearEnemy() : void
      {
         removeEvents(true);
         deleteSmallView();
      }
      
      private function removeEvents(param1:Boolean = false) : void
      {
         super.removeListener();
         if(param1)
         {
            _info.addEventListener("beginNewTurn",__beginNewTurn);
         }
      }
      
      override protected function __shoot(param1:LivingEvent) : void
      {
         map.act(new MonsterShootBombAction(this,param1.paras[0],param1.paras[1],24));
      }
      
      override protected function __beginNewTurn(param1:LivingEvent) : void
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
      
      override public function setProperty(param1:String, param2:String) : void
      {
         var _loc3_:StringObject = new StringObject(param2);
         super.setProperty(param1,param2);
         var _loc4_:* = param1;
         if("disposedOverTurns" !== _loc4_)
         {
            if("noDispose" === _loc4_)
            {
               _noDispose = _loc3_.getBoolean();
            }
         }
         else
         {
            _disposedOverTurns = _loc3_.getBoolean();
         }
      }
   }
}
