package game.objects
{
   import ddt.manager.SoundManager;
   import gameCommon.model.Bomb;
   import gameCommon.model.Living;
   
   public class FenShenBomb extends SimpleBomb
   {
       
      
      public function FenShenBomb(param1:Bomb, param2:Living, param3:int = 0){super(null,null,null);}
      
      override public function die() : void{}
   }
}
