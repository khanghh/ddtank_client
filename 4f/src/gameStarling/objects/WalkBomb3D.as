package gameStarling.objects
{
   import bones.display.BoneMovieStarling;
   import com.greensock.TweenLite;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import gameCommon.GameControl;
   import gameCommon.model.Bomb;
   import gameCommon.model.Living;
   import road7th.utils.MathUtils;
   import starlingPhy.object.PhysicalObj3D;
   
   public class WalkBomb3D extends SimpleBomb3D
   {
       
      
      private var _isWalk:Boolean = false;
      
      private var _path:Array;
      
      private var _currentPathIndex:int = 0;
      
      private var _isDown:Boolean = false;
      
      private var _isStartWalk:Boolean = false;
      
      private var _minScale:Number = 0.8;
      
      private var _maxScale:Number = 1.2;
      
      public function WalkBomb3D(param1:Bomb, param2:Living, param3:int = 0, param4:Boolean = false){super(null,null,null,null);}
      
      private function actionSort(param1:BombAction3D, param2:BombAction3D) : int{return 0;}
      
      override public function moveTo(param1:Point) : void{}
      
      private function isCurrentActionDown(param1:BombAction3D) : Boolean{return false;}
      
      override protected function computeFallNextXY(param1:Number) : Point{return null;}
      
      override public function get motionAngle() : Number{return 0;}
      
      private function checkWalkBallDown() : void{}
      
      private function checkWalkBall() : void{}
      
      protected function walk(param1:Point) : void{}
      
      private function startWalkMovie() : void{}
      
      public function doAction(param1:String) : void{}
      
      public function doDefaultAction() : void{}
      
      override protected function isPillarCollide() : Boolean{return false;}
      
      override public function dispose() : void{}
   }
}
