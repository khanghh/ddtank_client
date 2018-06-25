package starling.display.geom
{
   import starling.geom.Polygon;
   
   public class GraphicsPolygon extends Polygon
   {
       
      
      protected var indices:Vector.<uint>;
      
      public var lastVertexIndex:int = -1;
      
      public var lastIndexIndex:int = -1;
      
      public function GraphicsPolygon(vertices:Array = null, gfxIndices:Vector.<uint> = null)
      {
         super(vertices);
         if(vertices)
         {
            lastVertexIndex = vertices.length - 1;
         }
         if(gfxIndices)
         {
            indices = gfxIndices.slice();
            lastIndexIndex = indices.length;
         }
         else
         {
            indices = new Vector.<uint>();
         }
      }
      
      public function append(vertices:Array, gfxIndices:Vector.<uint>) : void
      {
         var i:* = 0;
         var num:int = vertices.length;
         if(num == 0)
         {
            return;
         }
         if(lastVertexIndex == -1)
         {
            lastVertexIndex = 0;
         }
         i = 0;
         while(i < num)
         {
            addVertices(vertices[i]);
            i++;
         }
         lastVertexIndex = lastVertexIndex + num / 2;
         var startIndex:int = lastIndexIndex == -1?0:lastIndexIndex;
         num = gfxIndices.length;
         for(i = startIndex; i < num; )
         {
            indices.push(gfxIndices[i]);
            i++;
         }
         lastIndexIndex = indices.length;
      }
      
      override public function triangulate(result:Vector.<uint> = null) : Vector.<uint>
      {
         var i:int = 0;
         if(result == null)
         {
            result = new Vector.<uint>(0);
         }
         var numIndices:int = indices.length;
         for(i = 0; i < numIndices; )
         {
            result.push(indices[i]);
            i++;
         }
         return result;
      }
      
      override public function get isSimple() : Boolean
      {
         return true;
      }
   }
}
