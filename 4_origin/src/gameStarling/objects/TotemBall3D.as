package gameStarling.objects
{
   import ddt.manager.SoundManager;
   import gameCommon.GameControl;
   import gameCommon.model.Bomb;
   import gameCommon.model.Living;
   
   public class TotemBall3D extends SimpleBomb3D
   {
       
      
      public function TotemBall3D(param1:Bomb, param2:Living, param3:int = 0, param4:Boolean = false)
      {
         super(param1,param2,param3,param4);
      }
      
      override public function bomb() : void
      {
         var _loc3_:int = 0;
         var _loc1_:* = null;
         var _loc2_:Array = map.physicalChilds[info.Id];
         if(_loc2_)
         {
            _loc3_ = 0;
            while(_loc3_ < _loc2_.length)
            {
               _loc1_ = _loc2_[_loc3_][0];
               trace("gameLiving.angle:" + _loc1_.angle);
               if(_loc1_.actionMovie)
               {
                  var _loc4_:* = 0.7;
                  _loc1_.actionMovie.scaleY = _loc4_;
                  _loc1_.actionMovie.scaleX = _loc4_;
               }
               GameControl.Instance.gameView.addGameLivingToMap(_loc2_[_loc3_]);
               _loc3_++;
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
