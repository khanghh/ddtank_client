package dice.vo
{
   import flash.geom.Point;
   
   public class DiceCellInfo
   {
       
      
      private var _position:Point;
      
      private var _vertices1:Point;
      
      private var _vertices2:Point;
      
      private var _vertices3:Point;
      
      private var _centerPosition:Point;
      
      public function DiceCellInfo()
      {
         super();
         _position = new Point();
         _centerPosition = new Point();
         _vertices1 = new Point(0,0);
         _vertices2 = new Point(0,0);
         _vertices3 = new Point(0,0);
      }
      
      public function get CellCenterPosition() : Point
      {
         return _centerPosition;
      }
      
      public function set centerPosition(param1:String) : void
      {
         var _loc2_:Array = param1.split(",");
         _centerPosition.x = int(_loc2_[0]);
         _centerPosition.y = int(_loc2_[1]);
      }
      
      public function get Position() : Point
      {
         return _position;
      }
      
      public function set position(param1:String) : void
      {
         var _loc2_:Array = param1.split(",");
         _position.x = int(_loc2_[0]);
         _position.y = int(_loc2_[1]);
      }
      
      public function set verticesString(param1:String) : void
      {
         var _loc2_:Array = param1.split(",");
         _vertices1.x = _loc2_[0] == null?0:Number(_loc2_[0]);
         _vertices1.y = _loc2_[1] == null?0:Number(_loc2_[1]);
         _vertices2.x = _loc2_[2] == null?0:Number(_loc2_[2]);
         _vertices2.y = _loc2_[3] == null?0:Number(_loc2_[3]);
         _vertices3.x = _loc2_[4] == null?0:Number(_loc2_[4]);
         _vertices3.y = _loc2_[5] == null?0:Number(_loc2_[5]);
      }
      
      public function get vertices1() : Point
      {
         return _vertices1;
      }
      
      public function get vertices2() : Point
      {
         return _vertices2;
      }
      
      public function get vertices3() : Point
      {
         return _vertices3;
      }
      
      public function dispose() : void
      {
         _position = null;
         _vertices1 = null;
         _vertices2 = null;
         _vertices3 = null;
      }
   }
}
