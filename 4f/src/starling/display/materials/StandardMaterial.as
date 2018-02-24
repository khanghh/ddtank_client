package starling.display.materials
{
   import flash.display3D.Context3D;
   import flash.display3D.IndexBuffer3D;
   import flash.display3D.Program3D;
   import flash.display3D.VertexBuffer3D;
   import flash.geom.Matrix3D;
   import starling.display.shaders.IShader;
   import starling.display.shaders.fragment.VertexColorFragmentShader;
   import starling.display.shaders.vertex.StandardVertexShader;
   import starling.textures.Texture;
   
   public class StandardMaterial implements IMaterial
   {
       
      
      private var program:Program3D;
      
      private var _vertexShader:IShader;
      
      private var _fragmentShader:IShader;
      
      private var _alpha:Number = 1;
      
      private var _color:uint;
      
      private var colorVector:Vector.<Number>;
      
      private var _textures:Vector.<Texture>;
      
      protected var _premultipliedAlpha:Boolean = false;
      
      public function StandardMaterial(param1:IShader = null, param2:IShader = null){super();}
      
      public function dispose() : void{}
      
      public function restoreOnLostContext() : void{}
      
      public function set textures(param1:Vector.<Texture>) : void{}
      
      public function get textures() : Vector.<Texture>{return null;}
      
      public function set vertexShader(param1:IShader) : void{}
      
      public function get vertexShader() : IShader{return null;}
      
      public function set fragmentShader(param1:IShader) : void{}
      
      public function get fragmentShader() : IShader{return null;}
      
      public function get alpha() : Number{return 0;}
      
      public function set alpha(param1:Number) : void{}
      
      public function get color() : uint{return null;}
      
      public function set color(param1:uint) : void{}
      
      public function drawTriangles(param1:Context3D, param2:Matrix3D, param3:VertexBuffer3D, param4:IndexBuffer3D, param5:Number = 1, param6:int = -1) : void{}
      
      public function drawTrianglesEx(param1:Context3D, param2:Matrix3D, param3:VertexBuffer3D, param4:IndexBuffer3D, param5:Number = 1, param6:int = -1, param7:int = 0) : void{}
      
      public function get premultipliedAlpha() : Boolean{return false;}
      
      public function set premultipliedAlpha(param1:Boolean) : void{}
   }
}
