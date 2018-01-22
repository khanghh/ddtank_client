package gameCommon.view.smallMap
{
   import flash.display.Graphics;
   import gameCommon.GameControl;
   
   public class SmallPlayer extends SmallLiving
   {
      
      private static const AttackMaxOffset:int = 4;
      
      private static const triangleCoords:Vector.<Object> = Vector.<Object>([{
         "x":0,
         "y":-8
      },{
         "x":4,
         "y":-12
      },{
         "x":-4,
         "y":-12
      }]);
       
      
      public function SmallPlayer(){super();}
      
      override protected function draw() : void{}
      
      override public function onFrame(param1:int) : void{}
      
      override public function set isAttacking(param1:Boolean) : void{}
      
      public function get isSelf() : Boolean{return false;}
   }
}
