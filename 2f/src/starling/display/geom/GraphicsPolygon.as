package starling.display.geom{   import starling.geom.Polygon;      public class GraphicsPolygon extends Polygon   {                   protected var indices:Vector.<uint>;            public var lastVertexIndex:int = -1;            public var lastIndexIndex:int = -1;            public function GraphicsPolygon(vertices:Array = null, gfxIndices:Vector.<uint> = null) { super(null); }
            public function append(vertices:Array, gfxIndices:Vector.<uint>) : void { }
            override public function triangulate(result:Vector.<uint> = null) : Vector.<uint> { return null; }
            override public function get isSimple() : Boolean { return false; }
   }}