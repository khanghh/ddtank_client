package starling.display
{
   import flash.geom.Matrix;
   import flash.geom.Matrix3D;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import starling.core.RenderSupport;
   import starling.utils.MatrixUtil;
   import starling.utils.RectangleUtil;
   
   [Event(name="flatten",type="starling.events.Event")]
   public class Sprite extends DisplayObjectContainer
   {
      
      private static var sHelperMatrix:Matrix = new Matrix();
      
      private static var sHelperPoint:Point = new Point();
      
      private static var sHelperRect:Rectangle = new Rectangle();
       
      
      private var mFlattenedContents:Vector.<QuadBatch>;
      
      private var mFlattenRequested:Boolean;
      
      private var mFlattenOptimized:Boolean;
      
      private var mClipRect:Rectangle;
      
      private var _graphics:Graphics;
      
      public function Sprite(){super();}
      
      override public function dispose() : void{}
      
      public function get graphics() : Graphics{return null;}
      
      private function disposeFlattenedContents() : void{}
      
      public function flatten(param1:Boolean = false) : void{}
      
      public function unflatten() : void{}
      
      public function get isFlattened() : Boolean{return false;}
      
      public function get clipRect() : Rectangle{return null;}
      
      public function set clipRect(param1:Rectangle) : void{}
      
      public function getClipRect(param1:DisplayObject, param2:Rectangle = null) : Rectangle{return null;}
      
      override public function getBounds(param1:DisplayObject, param2:Rectangle = null) : Rectangle{return null;}
      
      override public function hitTest(param1:Point, param2:Boolean = false) : DisplayObject{return null;}
      
      override public function render(param1:RenderSupport, param2:Number) : void{}
   }
}
