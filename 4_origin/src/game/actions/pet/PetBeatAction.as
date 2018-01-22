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
      
      public function PetBeatAction(param1:GamePet, param2:GamePlayer, param3:String, param4:Point, param5:Array)
      {
         _pet = param1;
         _act = param3;
         _pt = param4;
         _targets = param5;
         _master = param2;
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
         var _loc2_:* = null;
         var _loc1_:int = 0;
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         if(_pet == null || _pet.info == null || _master == null || _master.info == null)
         {
            finish();
            return;
         }
         if(!_updated)
         {
            var _loc7_:int = 0;
            var _loc6_:* = _targets;
            for each(var _loc5_ in _targets)
            {
               _loc2_ = _loc5_.target;
               _loc1_ = _loc5_.hp;
               _loc4_ = _loc5_.dam;
               _loc3_ = _loc5_.dander;
               _loc2_.updateBlood(_loc1_,3,_loc4_);
               if(_loc2_ is Player)
               {
                  Player(_loc2_).dander = _loc3_;
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
         var _loc2_:* = null;
         var _loc1_:int = 0;
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         if(_pet == null || _pet.info == null || _master == null || _master.info == null)
         {
            finish();
            return;
         }
         if(!_updated)
         {
            var _loc7_:int = 0;
            var _loc6_:* = _targets;
            for each(var _loc5_ in _targets)
            {
               _loc2_ = _loc5_.target;
               _loc1_ = _loc5_.hp;
               _loc4_ = _loc5_.dam;
               _loc3_ = _loc5_.dander;
               _loc2_.updateBlood(_loc1_,3,_loc4_);
               if(_loc2_ is Player)
               {
                  Player(_loc2_).dander = _loc3_;
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
