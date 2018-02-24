package game.objects
{
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.BallManager;
   import ddt.manager.SoundManager;
   import flash.events.Event;
   import gameCommon.model.Bomb;
   import gameCommon.model.Living;
   import road7th.utils.MovieClipWrapper;
   
   public class ThroughWallBomb extends SimpleBomb
   {
       
      
      public function ThroughWallBomb(param1:Bomb, param2:Living, param3:int = 0, param4:Boolean = false){super(null,null,null,null);}
      
      override public function bomb() : void{}
   }
}
