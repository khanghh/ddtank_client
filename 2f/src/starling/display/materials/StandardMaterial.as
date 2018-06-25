package starling.display.materials{   import flash.display3D.Context3D;   import flash.display3D.IndexBuffer3D;   import flash.display3D.Program3D;   import flash.display3D.VertexBuffer3D;   import flash.geom.Matrix3D;   import starling.display.shaders.IShader;   import starling.display.shaders.fragment.VertexColorFragmentShader;   import starling.display.shaders.vertex.StandardVertexShader;   import starling.textures.Texture;      public class StandardMaterial implements IMaterial   {                   private var program:Program3D;            private var _vertexShader:IShader;            private var _fragmentShader:IShader;            private var _alpha:Number = 1;            private var _color:uint;            private var colorVector:Vector.<Number>;            private var _textures:Vector.<Texture>;            protected var _premultipliedAlpha:Boolean = false;            public function StandardMaterial(vertexShader:IShader = null, fragmentShader:IShader = null) { super(); }
            public function dispose() : void { }
            public function restoreOnLostContext() : void { }
            public function set textures(value:Vector.<Texture>) : void { }
            public function get textures() : Vector.<Texture> { return null; }
            public function set vertexShader(value:IShader) : void { }
            public function get vertexShader() : IShader { return null; }
            public function set fragmentShader(value:IShader) : void { }
            public function get fragmentShader() : IShader { return null; }
            public function get alpha() : Number { return 0; }
            public function set alpha(value:Number) : void { }
            public function get color() : uint { return null; }
            public function set color(value:uint) : void { }
            public function drawTriangles(context:Context3D, matrix:Matrix3D, vertexBuffer:VertexBuffer3D, indexBuffer:IndexBuffer3D, alpha:Number = 1, numTriangles:int = -1) : void { }
            public function drawTrianglesEx(context:Context3D, matrix:Matrix3D, vertexBuffer:VertexBuffer3D, indexBuffer:IndexBuffer3D, alpha:Number = 1, numTriangles:int = -1, startTriangle:int = 0) : void { }
            public function get premultipliedAlpha() : Boolean { return false; }
            public function set premultipliedAlpha(value:Boolean) : void { }
   }}