package gameStarling.objects
{
   import ddt.manager.SoundManager;
   import gameCommon.GameControl;
   import gameCommon.model.Bomb;
   import gameCommon.model.Living;
   
   public class TotemBall3D extends SimpleBomb3D
   {
       
      
      public function TotemBall3D(param1:Bomb, param2:Living, param3:int = 0, param4:Boolean = false){super(null,null,null,null);}
      
      override public function bomb() : void{}
   }
}
