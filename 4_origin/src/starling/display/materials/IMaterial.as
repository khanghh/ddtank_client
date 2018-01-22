package starling.display.materials
{
   import flash.display3D.Context3D;
   import flash.display3D.IndexBuffer3D;
   import flash.display3D.VertexBuffer3D;
   import flash.geom.Matrix3D;
   import starling.display.shaders.IShader;
   import starling.textures.Texture;
   
   public interface IMaterial
   {
       
      
      function dispose() : void;
      
      function set alpha(param1:Number) : void;
      
      function get alpha() : Number;
      
      function set color(param1:uint) : void;
      
      function get color() : uint;
      
      function set vertexShader(param1:IShader) : void;
      
      function get vertexShader() : IShader;
      
      function set fragmentShader(param1:IShader) : void;
      
      function get fragmentShader() : IShader;
      
      function get textures() : Vector.<Texture>;
      
      function set textures(param1:Vector.<Texture>) : void;
      
      function drawTriangles(param1:Context3D, param2:Matrix3D, param3:VertexBuffer3D, param4:IndexBuffer3D, param5:Number = 1, param6:int = -1) : void;
      
      function drawTrianglesEx(param1:Context3D, param2:Matrix3D, param3:VertexBuffer3D, param4:IndexBuffer3D, param5:Number = 1, param6:int = -1, param7:int = 0) : void;
      
      function restoreOnLostContext() : void;
      
      function get premultipliedAlpha() : Boolean;
   }
}
