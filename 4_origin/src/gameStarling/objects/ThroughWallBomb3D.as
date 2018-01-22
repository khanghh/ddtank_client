package gameStarling.objects
{
   import ddt.manager.SoundManager;
   import gameCommon.model.Bomb;
   import gameCommon.model.Living;
   import road7th.utils.BoneMovieWrapper;
   
   public class ThroughWallBomb3D extends SimpleBomb3D
   {
       
      
      public function ThroughWallBomb3D(param1:Bomb, param2:Living, param3:int = 0, param4:Boolean = false)
      {
         super(param1,param2,param3,param4);
      }
      
      override public function bomb() : void
      {
         if(_isLiving)
         {
            SoundManager.instance.play(_info.Template.BombSound);
         }
         _blastOut.stop();
         _blastOut.visible = false;
         var _loc1_:BoneMovieWrapper = new BoneMovieWrapper(_blastOut.styleName,true,true);
         _loc1_.asDisplay.x = x;
         _loc1_.asDisplay.y = y;
         _map.addToPhyLayer(_loc1_.asDisplay);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
