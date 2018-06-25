package game.actions.pet
{
   import flash.geom.Point;
   import game.objects.GamePet;
   import game.objects.GamePlayer;
   import gameCommon.actions.BaseAction;
   import gameCommon.model.Living;
   import gameCommon.model.Player;
   
   public class PetBeatAction extends BaseAction
   {
       
      
      private var _pet:GamePet;
      
      private var _act:String;
      
      private var _pt:Point;
      
      private var _targets:Array;
      
      private var _master:GamePlayer;
      
      private var _updated:Boolean = false;
      
      public function PetBeatAction(pet:GamePet, master:GamePlayer, act:String, pt:Point, targets:Array)
      {
         _pet = pet;
         _act = act;
         _pt = pt;
         _targets = targets;
         _master = master;
         super();
      }
      
      override public function prepare() : void
      {
         super.prepare();
         if(_pet == null || _pet.info == null)
         {
            finish();
            return;
         }
         _pet.show();
         _pet.info.pos = _pt;
         _pet.map.setCenter(_pt.x,_pt.y,true);
         _pet.map.bringToFront(_pet.info);
         _pet.actionMovie.doAction(_act,updateHp);
      }
      
      private function updateHp() : void
      {
         var t:* = null;
         var hp:int = 0;
         var dam:int = 0;
         var dander:int = 0;
         if(_pet == null || _pet.info == null || _master == null || _master.info == null)
         {
            finish();
            return;
         }
         if(!_updated)
         {
            var _loc7_:int = 0;
            var _loc6_:* = _targets;
            for each(var target in _targets)
            {
               t = target.target;
               hp = target.hp;
               dam = target.dam;
               dander = target.dander;
               t.updateBlood(hp,3,dam);
               if(t is Player)
               {
                  Player(t).dander = dander;
               }
            }
            _updated = true;
            _isFinished = true;
            if(_pet)
            {
               _pet.hide();
            }
         }
      }
      
      override public function cancel() : void
      {
         var t:* = null;
         var hp:int = 0;
         var dam:int = 0;
         var dander:int = 0;
         if(_pet == null || _pet.info == null || _master == null || _master.info == null)
         {
            finish();
            return;
         }
         if(!_updated)
         {
            var _loc7_:int = 0;
            var _loc6_:* = _targets;
            for each(var target in _targets)
            {
               t = target.target;
               hp = target.hp;
               dam = target.dam;
               dander = target.dander;
               t.updateBlood(hp,3,dam);
               if(t is Player)
               {
                  Player(t).dander = dander;
               }
            }
            _pet.info.pos = _master.info.pos;
            _updated = true;
         }
      }
      
      private function finish() : void
      {
         _pet = null;
         _targets = null;
         _master = null;
         _isFinished = true;
      }
      
      override public function executeAtOnce() : void
      {
         cancel();
      }
      
      override public function execute() : void
      {
         if(_pet == null || _pet.info == null || _master == null || _master.info == null)
         {
            finish();
            return;
         }
         if(_updated && Point.distance(_pet.info.pos,_master.info.pos) < 1)
         {
            finish();
         }
      }
   }
}
