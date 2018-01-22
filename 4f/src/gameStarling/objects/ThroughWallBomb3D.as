package gameStarling.objects
{
   import ddt.manager.SoundManager;
   import gameCommon.model.Bomb;
   import gameCommon.model.Living;
   import road7th.utils.BoneMovieWrapper;
   
   public class ThroughWallBomb3D extends SimpleBomb3D
   {
       
      
      public function ThroughWallBomb3D(param1:Bomb, param2:Living, param3:int = 0, param4:Boolean = false){super(null,null,null,null);}
      
      override public function bomb() : void{}
   }
}
