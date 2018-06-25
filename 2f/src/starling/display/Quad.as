package starling.display{   import flash.geom.Matrix;   import flash.geom.Matrix3D;   import flash.geom.Point;   import flash.geom.Rectangle;   import flash.geom.Vector3D;   import starling.core.RenderSupport;   import starling.utils.VertexData;      public class Quad extends DisplayObject   {            private static var sHelperPoint:Point = new Point();            private static var sHelperPoint3D:Vector3D = new Vector3D();            private static var sHelperMatrix:Matrix = new Matrix();            private static var sHelperMatrix3D:Matrix3D = new Matrix3D();                   private var mTinted:Boolean;            protected var mVertexData:VertexData;            public function Quad(width:Number, height:Number, color:uint = 16777215, premultipliedAlpha:Boolean = true) { super(); }
            protected function onVertexDataChanged() : void { }
            override public function getBounds(targetSpace:DisplayObject, resultRect:Rectangle = null) : Rectangle { return null; }
            public function getVertexColor(vertexID:int) : uint { return null; }
            public function setVertexColor(vertexID:int, color:uint) : void { }
            public function getVertexAlpha(vertexID:int) : Number { return 0; }
            public function setVertexAlpha(vertexID:int, alpha:Number) : void { }
            public function get color() : uint { return null; }
            public function set color(value:uint) : void { }
            override public function set alpha(value:Number) : void { }
            public function copyVertexDataTo(targetData:VertexData, targetVertexID:int = 0) : void { }
            public function copyVertexDataTransformedTo(targetData:VertexData, targetVertexID:int = 0, matrix:Matrix = null) : void { }
            override public function render(support:RenderSupport, parentAlpha:Number) : void { }
            public function get tinted() : Boolean { return false; }
            public function get premultipliedAlpha() : Boolean { return false; }
   }}