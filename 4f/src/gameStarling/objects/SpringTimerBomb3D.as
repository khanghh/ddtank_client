package gameStarling.objects
{
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import gameCommon.GameControl;
   import gameCommon.model.Bomb;
   import gameCommon.model.Living;
   import starling.events.Event;
   import starlingPhy.object.PhysicalObj3D;
   
   public class SpringTimerBomb3D extends SimpleBomb3D
   {
       
      
      private var _currentBombTimer:int = -1;
      
      public function SpringTimerBomb3D(param1:Bomb, param2:Living, param3:int = 0){super(null,null,null);}
      
      override protected function updatePosition(param1:Number) : void{}
      
      override public function moveTo(param1:Point) : void{}
      
      override protected function isPillarCollide() : Boolean{return false;}
      
      protected function isLastPosSpring() : Boolean{return false;}
      
      private function removeEmitters() : void{}
      
      override public function dispose() : void{}
   }
}
