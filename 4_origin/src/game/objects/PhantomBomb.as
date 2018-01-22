package game.objects
{
   import com.pickgliss.utils.ObjectUtils;
   import flash.geom.Point;
   import gameCommon.model.Bomb;
   import gameCommon.model.Living;
   
   public class PhantomBomb extends SimpleBomb
   {
       
      
      private var _phantomCount:int;
      
      private var _currentBombAction:BombAction;
      
      public function PhantomBomb(param1:Bomb, param2:Living, param3:int = 0)
      {
         var _loc5_:int = 0;
         var _loc4_:* = null;
         super(param1,param2,param3);
         _loc5_ = 0;
         while(_loc5_ < _info.Actions.length)
         {
            _loc4_ = _info.Actions[_loc5_] as BombAction;
            if(_loc4_.type == 2 || _loc4_.type == 4)
            {
               _currentBombAction = _loc4_;
               break;
            }
            _loc5_++;
         }
         if(_currentBombAction)
         {
            _phantomCount = int((_currentBombAction.time - 2500) / 500);
         }
      }
      
      override public function moveTo(param1:Point) : void
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         super.moveTo(param1);
         if(_lifeTime % 80 == 0)
         {
            if(_phantomCount > 0)
            {
               _loc2_ = new Bomb();
               ObjectUtils.copyProperties(_loc2_,_info);
               _loc2_.Template = _info.Template;
               _loc2_.Actions = [_currentBombAction];
               _loc3_ = new SimpleBomb(_loc2_,_owner,_refineryLevel,true);
               _loc3_.alpha = 0.5;
               this.map.addPhysical(_loc3_);
               if(fastModel)
               {
                  _loc3_.bombAtOnce();
               }
            }
            _phantomCount = Number(_phantomCount) - 1;
         }
      }
   }
}
