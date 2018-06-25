package gameStarling.objects
{
   import ddt.manager.SoundManager;
   import gameCommon.model.Bomb;
   import gameCommon.model.Living;
   import road7th.utils.BoneMovieWrapper;
   
   public class ThroughWallBomb3D extends SimpleBomb3D
   {
       
      
      public function ThroughWallBomb3D(info:Bomb, owner:Living, refineryLevel:int = 0, isPhantom:Boolean = false)
      {
         super(info,owner,refineryLevel,isPhantom);
      }
      
      override public function bomb() : void
      {
         if(_isLiving)
         {
            SoundManager.instance.play(_info.Template.BombSound);
         }
         _blastOut.stop();
         _blastOut.visible = false;
         var blastOutEffect:BoneMovieWrapper = new BoneMovieWrapper(_blastOut.styleName,true,true);
         blastOutEffect.asDisplay.x = x;
         blastOutEffect.asDisplay.y = y;
         _map.addToPhyLayer(blastOutEffect.asDisplay);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
