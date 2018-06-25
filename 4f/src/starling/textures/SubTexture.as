package starling.textures{   import flash.display3D.textures.TextureBase;   import flash.geom.Matrix;   import flash.geom.Point;   import flash.geom.Rectangle;   import starling.utils.MatrixUtil;   import starling.utils.RectangleUtil;   import starling.utils.VertexData;      public class SubTexture extends Texture   {            private static var sTexCoords:Point = new Point();            private static var sMatrix:Matrix = new Matrix();                   private var mParent:Texture;            private var mOwnsParent:Boolean;            private var mRegion:Rectangle;            private var mFrame:Rectangle;            private var mRotated:Boolean;            private var mWidth:Number;            private var mHeight:Number;            private var mTransformationMatrix:Matrix;            public function SubTexture(parent:Texture, region:Rectangle = null, ownsParent:Boolean = false, frame:Rectangle = null, rotated:Boolean = false) { super(); }
            override public function dispose() : void { }
            override public function adjustVertexData(vertexData:VertexData, vertexID:int, count:int) : void { }
            override public function adjustTexCoords(texCoords:Vector.<Number>, startIndex:int = 0, stride:int = 0, count:int = -1) : void { }
            public function get parent() : Texture { return null; }
            public function get ownsParent() : Boolean { return false; }
            public function get rotated() : Boolean { return false; }
            public function get region() : Rectangle { return null; }
            public function get clipping() : Rectangle { return null; }
            public function get transformationMatrix() : Matrix { return null; }
            override public function get base() : TextureBase { return null; }
            override public function get root() : ConcreteTexture { return null; }
            override public function get format() : String { return null; }
            override public function get width() : Number { return 0; }
            override public function get height() : Number { return 0; }
            override public function get nativeWidth() : Number { return 0; }
            override public function get nativeHeight() : Number { return 0; }
            override public function get mipMapping() : Boolean { return false; }
            override public function get premultipliedAlpha() : Boolean { return false; }
            override public function get scale() : Number { return 0; }
            override public function get repeat() : Boolean { return false; }
            override public function get frame() : Rectangle { return null; }
   }}