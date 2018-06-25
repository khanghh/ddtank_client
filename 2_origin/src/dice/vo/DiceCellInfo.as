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
      
      public function set centerPosition(value:String) : void
      {
         var arr:Array = value.split(",");
         _centerPosition.x = int(arr[0]);
         _centerPosition.y = int(arr[1]);
      }
      
      public function get Position() : Point
      {
         return _position;
      }
      
      public function set position(value:String) : void
      {
         var arr:Array = value.split(",");
         _position.x = int(arr[0]);
         _position.y = int(arr[1]);
      }
      
      public function set verticesString(value:String) : void
      {
         var arr:Array = value.split(",");
         _vertices1.x = arr[0] == null?0:Number(arr[0]);
         _vertices1.y = arr[1] == null?0:Number(arr[1]);
         _vertices2.x = arr[2] == null?0:Number(arr[2]);
         _vertices2.y = arr[3] == null?0:Number(arr[3]);
         _vertices3.x = arr[4] == null?0:Number(arr[4]);
         _vertices3.y = arr[5] == null?0:Number(arr[5]);
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
