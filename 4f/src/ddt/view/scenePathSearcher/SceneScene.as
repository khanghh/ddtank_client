package ddt.view.scenePathSearcher
{
   import flash.events.EventDispatcher;
   import flash.geom.Point;
   
   public class SceneScene extends EventDispatcher
   {
       
      
      private var _hitTester:PathIHitTester;
      
      private var _pathSearcher:PathIPathSearcher;
      
      private var _x:Number;
      
      private var _y:Number;
      
      public function SceneScene(){super();}
      
      public function get HitTester() : PathIHitTester{return null;}
      
      public function get x() : Number{return 0;}
      
      public function get y() : Number{return 0;}
      
      public function set position(param1:Point) : void{}
      
      public function get position() : Point{return null;}
      
      public function setPathSearcher(param1:PathIPathSearcher) : void{}
      
      public function setHitTester(param1:PathIHitTester) : void{}
      
      public function hit(param1:Point) : Boolean{return false;}
      
      public function searchPath(param1:Point, param2:Point) : Array{return null;}
      
      public function localToGlobal(param1:Point) : Point{return null;}
      
      public function globalToLocal(param1:Point) : Point{return null;}
      
      public function dispose() : void{}
   }
}
