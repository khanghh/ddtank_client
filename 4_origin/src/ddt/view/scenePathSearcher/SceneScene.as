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
      
      public function SceneScene()
      {
         super();
         this._pathSearcher = new PathRoboSearcher(18,1000,8);
         this._x = 0;
         this._y = 0;
      }
      
      public function get HitTester() : PathIHitTester
      {
         return _hitTester;
      }
      
      public function get x() : Number
      {
         return _x;
      }
      
      public function get y() : Number
      {
         return _y;
      }
      
      public function set position(value:Point) : void
      {
         if(value.x != _x || value.y != _y)
         {
            this._x = value.x;
            this._y = value.y;
         }
      }
      
      public function get position() : Point
      {
         return new Point(_x,_y);
      }
      
      public function setPathSearcher(path:PathIPathSearcher) : void
      {
         _pathSearcher = path;
      }
      
      public function setHitTester(tester:PathIHitTester) : void
      {
         _hitTester = tester;
      }
      
      public function hit(local:Point) : Boolean
      {
         return _hitTester.isHit(local);
      }
      
      public function searchPath(from:Point, to:Point) : Array
      {
         return _pathSearcher.search(from,to,_hitTester);
      }
      
      public function localToGlobal(point:Point) : Point
      {
         return new Point(point.x + _x,point.y + _y);
      }
      
      public function globalToLocal(point:Point) : Point
      {
         return new Point(point.x - _x,point.y - _y);
      }
      
      public function dispose() : void
      {
         _hitTester = null;
         _pathSearcher = null;
      }
   }
}
