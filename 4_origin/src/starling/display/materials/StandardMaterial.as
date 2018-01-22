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
      
      public function StandardMaterial(param1:IShader = null, param2:IShader = null)
      {
         super();
         this.vertexShader = param1 || new StandardVertexShader();
         this.fragmentShader = param2 || new VertexColorFragmentShader();
         textures = new Vector.<Texture>();
         colorVector = new Vector.<Number>();
         color = 16777215;
      }
      
      public function dispose() : void
      {
         if(program)
         {
            Program3DCache.releaseProgram3D(program);
            program = null;
         }
         textures = new Vector.<Texture>();
      }
      
      public function restoreOnLostContext() : void
      {
         if(program)
         {
            Program3DCache.releaseProgram3D(program,true);
            program = null;
         }
      }
      
      public function set textures(param1:Vector.<Texture>) : void
      {
         _textures = param1;
      }
      
      public function get textures() : Vector.<Texture>
      {
         return _textures;
      }
      
      public function set vertexShader(param1:IShader) : void
      {
         _vertexShader = param1;
         if(program)
         {
            Program3DCache.releaseProgram3D(program);
            program = null;
         }
      }
      
      public function get vertexShader() : IShader
      {
         return _vertexShader;
      }
      
      public function set fragmentShader(param1:IShader) : void
      {
         _fragmentShader = param1;
         if(program)
         {
            Program3DCache.releaseProgram3D(program);
            program = null;
         }
      }
      
      public function get fragmentShader() : IShader
      {
         return _fragmentShader;
      }
      
      public function get alpha() : Number
      {
         return _alpha;
      }
      
      public function set alpha(param1:Number) : void
      {
         _alpha = param1;
      }
      
      public function get color() : uint
      {
         return _color;
      }
      
      public function set color(param1:uint) : void
      {
         _color = param1;
         colorVector[0] = (_color >> 16) / 255;
         colorVector[1] = ((_color & 65280) >> 8) / 255;
         colorVector[2] = (_color & 255) / 255;
      }
      
      public function drawTriangles(param1:Context3D, param2:Matrix3D, param3:VertexBuffer3D, param4:IndexBuffer3D, param5:Number = 1, param6:int = -1) : void
      {
         drawTrianglesEx(param1,param2,param3,param4,param5,param6,0);
      }
      
      public function drawTrianglesEx(param1:Context3D, param2:Matrix3D, param3:VertexBuffer3D, param4:IndexBuffer3D, param5:Number = 1, param6:int = -1, param7:int = 0) : void
      {
         var _loc8_:int = 0;
         param1.setVertexBufferAt(0,param3,0,"float3");
         param1.setVertexBufferAt(1,param3,3,"float4");
         param1.setVertexBufferAt(2,param3,7,"float2");
         if(program == null && _vertexShader && _fragmentShader)
         {
            program = Program3DCache.getProgram3D(param1,_vertexShader,_fragmentShader);
         }
         param1.setProgram(program);
         _loc8_ = 0;
         while(_loc8_ < 8)
         {
            param1.setTextureAt(_loc8_,_loc8_ < _textures.length?_textures[_loc8_].base:null);
            _loc8_++;
         }
         param1.setProgramConstantsFromMatrix("vertex",0,param2,true);
         _vertexShader.setConstants(param1,4);
         colorVector[3] = _alpha * param5;
         param1.setProgramConstantsFromVector("fragment",0,colorVector);
         _fragmentShader.setConstants(param1,1);
         param1.drawTriangles(param4,param7,param6);
      }
      
      public function get premultipliedAlpha() : Boolean
      {
         return _premultipliedAlpha;
      }
      
      public function set premultipliedAlpha(param1:Boolean) : void
      {
         _premultipliedAlpha = param1;
      }
   }
}
