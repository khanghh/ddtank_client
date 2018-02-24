package starling.display
{
   import flash.geom.Matrix;
   import flash.geom.Matrix3D;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.geom.Vector3D;
   import starling.core.RenderSupport;
   import starling.utils.VertexData;
   
   public class Quad extends DisplayObject
   {
      
      private static var sHelperPoint:Point = new Point();
      
      private static var sHelperPoint3D:Vector3D = new Vector3D();
      
      private static var sHelperMatrix:Matrix = new Matrix();
      
      private static var sHelperMatrix3D:Matrix3D = new Matrix3D();
       
      
      private var mTinted:Boolean;
      
      protected var mVertexData:VertexData;
      
      public function Quad(param1:Number, param2:Number, param3:uint = 16777215, param4:Boolean = true){super();}
      
      protected function onVertexDataChanged() : void{}
      
      override public function getBounds(param1:DisplayObject, param2:Rectangle = null) : Rectangle{return null;}
      
      public function getVertexColor(param1:int) : uint{return null;}
      
      public function setVertexColor(param1:int, param2:uint) : void{}
      
      public function getVertexAlpha(param1:int) : Number{return 0;}
      
      public function setVertexAlpha(param1:int, param2:Number) : void{}
      
      public function get color() : uint{return null;}
      
      public function set color(param1:uint) : void{}
      
      override public function set alpha(param1:Number) : void{}
      
      public function copyVertexDataTo(param1:VertexData, param2:int = 0) : void{}
      
      public function copyVertexDataTransformedTo(param1:VertexData, param2:int = 0, param3:Matrix = null) : void{}
      
      override public function render(param1:RenderSupport, param2:Number) : void{}
      
      public function get tinted() : Boolean{return false;}
      
      public function get premultipliedAlpha() : Boolean{return false;}
   }
}
