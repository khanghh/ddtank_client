package starling.display.geom
{
   import starling.geom.Polygon;
   
   public class GraphicsPolygon extends Polygon
   {
       
      
      protected var indices:Vector.<uint>;
      
      public var lastVertexIndex:int = -1;
      
      public var lastIndexIndex:int = -1;
      
      public function GraphicsPolygon(param1:Array = null, param2:Vector.<uint> = null)
      {
         super(param1);
         if(param1)
         {
            lastVertexIndex = param1.length - 1;
         }
         if(param2)
         {
            indices = param2.slice();
            lastIndexIndex = indices.length;
         }
         else
         {
            indices = new Vector.<uint>();
         }
      }
      
      public function append(param1:Array, param2:Vector.<uint>) : void
      {
         var _loc5_:* = 0;
         var _loc3_:int = param1.length;
         if(_loc3_ == 0)
         {
            return;
         }
         if(lastVertexIndex == -1)
         {
            lastVertexIndex = 0;
         }
         _loc5_ = 0;
         while(_loc5_ < _loc3_)
         {
            addVertices(param1[_loc5_]);
            _loc5_++;
         }
         lastVertexIndex = lastVertexIndex + _loc3_ / 2;
         var _loc4_:int = lastIndexIndex == -1?0:lastIndexIndex;
         _loc3_ = param2.length;
         _loc5_ = _loc4_;
         while(_loc5_ < _loc3_)
         {
            indices.push(param2[_loc5_]);
            _loc5_++;
         }
         lastIndexIndex = indices.length;
      }
      
      override public function triangulate(param1:Vector.<uint> = null) : Vector.<uint>
      {
         var _loc3_:int = 0;
         if(param1 == null)
         {
            param1 = new Vector.<uint>(0);
         }
         var _loc2_:int = indices.length;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            param1.push(indices[_loc3_]);
            _loc3_++;
         }
         return param1;
      }
      
      override public function get isSimple() : Boolean
      {
         return true;
      }
   }
}
