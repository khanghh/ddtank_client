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
      
      public function PhantomBomb(info:Bomb, owner:Living, refineryLevel:int = 0)
      {
         var i:int = 0;
         var bombAction:* = null;
         super(info,owner,refineryLevel);
         for(i = 0; i < _info.Actions.length; )
         {
            bombAction = _info.Actions[i] as BombAction;
            if(bombAction.type == 2 || bombAction.type == 4)
            {
               _currentBombAction = bombAction;
               break;
            }
            i++;
         }
         if(_currentBombAction)
         {
            _phantomCount = int((_currentBombAction.time - 2500) / 500);
         }
      }
      
      override public function moveTo(p:Point) : void
      {
         var newInfo:* = null;
         var simpleBomb:* = null;
         super.moveTo(p);
         if(_lifeTime % 80 == 0)
         {
            if(_phantomCount > 0)
            {
               newInfo = new Bomb();
               ObjectUtils.copyProperties(newInfo,_info);
               newInfo.Template = _info.Template;
               newInfo.Actions = [_currentBombAction];
               simpleBomb = new SimpleBomb(newInfo,_owner,_refineryLevel,true);
               simpleBomb.alpha = 0.5;
               this.map.addPhysical(simpleBomb);
               if(fastModel)
               {
                  simpleBomb.bombAtOnce();
               }
            }
            _phantomCount = Number(_phantomCount) - 1;
         }
      }
   }
}
