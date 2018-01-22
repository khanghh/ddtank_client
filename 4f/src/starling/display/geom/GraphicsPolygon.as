package starling.display.geom
{
   import starling.geom.Polygon;
   
   public class GraphicsPolygon extends Polygon
   {
       
      
      protected var indices:Vector.<uint>;
      
      public var lastVertexIndex:int = -1;
      
      public var lastIndexIndex:int = -1;
      
      public function GraphicsPolygon(param1:Array = null, param2:Vector.<uint> = null){super(null);}
      
      public function append(param1:Array, param2:Vector.<uint>) : void{}
      
      override public function triangulate(param1:Vector.<uint> = null) : Vector.<uint>{return null;}
      
      override public function get isSimple() : Boolean{return false;}
   }
}
