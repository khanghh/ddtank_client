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
      
      public function PhantomBomb(param1:Bomb, param2:Living, param3:int = 0){super(null,null,null);}
      
      override public function moveTo(param1:Point) : void{}
   }
}
