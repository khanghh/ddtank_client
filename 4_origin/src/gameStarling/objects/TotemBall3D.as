package gameStarling.objects
{
   import ddt.manager.SoundManager;
   import gameCommon.GameControl;
   import gameCommon.model.Bomb;
   import gameCommon.model.Living;
   
   public class TotemBall3D extends SimpleBomb3D
   {
       
      
      public function TotemBall3D(info:Bomb, owner:Living, refineryLevel:int = 0, isPhantom:Boolean = false)
      {
         super(info,owner,refineryLevel,isPhantom);
      }
      
      override public function bomb() : void
      {
         var i:int = 0;
         var gameLiving:* = null;
         var childs:Array = map.physicalChilds[info.Id];
         if(childs)
         {
            for(i = 0; i < childs.length; )
            {
               gameLiving = childs[i][0];
               trace("gameLiving.angle:" + gameLiving.angle);
               if(gameLiving.actionMovie)
               {
                  var _loc4_:* = 0.7;
                  gameLiving.actionMovie.scaleY = _loc4_;
                  gameLiving.actionMovie.scaleX = _loc4_;
               }
               GameControl.Instance.gameView.addGameLivingToMap(childs[i]);
               i++;
            }
            delete map.physicalChilds[info.Id];
         }
         if(_isLiving)
         {
            SoundManager.instance.play(_info.Template.BombSound);
         }
         super.bomb();
      }
   }
}
