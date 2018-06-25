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
       
      
      public function ThroughWallBomb(info:Bomb, owner:Living, refineryLevel:int = 0, isPhantom:Boolean = false)
      {
         super(info,owner,refineryLevel,isPhantom);
      }
      
      override public function bomb() : void
      {
         if(_isLiving)
         {
            SoundManager.instance.play(_info.Template.BombSound);
         }
         if(!(_blastOut && _blastOut.parent == null))
         {
            _blastOut = BallManager.instance.createBlastOutMovie(info.Template.blastOutID);
         }
         var blastOutEffect:MovieClipWrapper = new MovieClipWrapper(_blastOut,false,true);
         blastOutEffect.movie.x = x;
         blastOutEffect.movie.y = y;
         _map.addToPhyLayer(blastOutEffect.movie);
         blastOutEffect.movie.visible = true;
         blastOutEffect.addEventListener("complete",function(evt:Event):void
         {
            evt.currentTarget.removeEventListener("complete",arguments.callee);
            ObjectUtils.disposeObject(blastOutEffect);
         });
         blastOutEffect.play();
      }
   }
}
