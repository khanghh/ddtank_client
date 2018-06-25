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
      
      public function Quad(width:Number, height:Number, color:uint = 16777215, premultipliedAlpha:Boolean = true)
      {
         super();
         if(width == 0 || height == 0)
         {
            throw new ArgumentError("Invalid size: width and height must not be zero");
         }
         mTinted = color != 16777215;
         mVertexData = new VertexData(4,premultipliedAlpha);
         mVertexData.setPosition(0,0,0);
         mVertexData.setPosition(1,width,0);
         mVertexData.setPosition(2,0,height);
         mVertexData.setPosition(3,width,height);
         mVertexData.setUniformColor(color);
         onVertexDataChanged();
      }
      
      protected function onVertexDataChanged() : void
      {
      }
      
      override public function getBounds(targetSpace:DisplayObject, resultRect:Rectangle = null) : Rectangle
      {
         var scaleX:Number = NaN;
         var scaleY:Number = NaN;
         if(resultRect == null)
         {
            resultRect = new Rectangle();
         }
         if(targetSpace == this)
         {
            mVertexData.getPosition(3,sHelperPoint);
            resultRect.setTo(0,0,sHelperPoint.x,sHelperPoint.y);
         }
         else if(targetSpace == parent && rotation == 0)
         {
            scaleX = this.scaleX;
            scaleY = this.scaleY;
            mVertexData.getPosition(3,sHelperPoint);
            resultRect.setTo(x - pivotX * scaleX,y - pivotY * scaleY,sHelperPoint.x * scaleX,sHelperPoint.y * scaleY);
            if(scaleX < 0)
            {
               resultRect.width = resultRect.width * -1;
               resultRect.x = resultRect.x - resultRect.width;
            }
            if(scaleY < 0)
            {
               resultRect.height = resultRect.height * -1;
               resultRect.y = resultRect.y - resultRect.height;
            }
         }
         else if(is3D && stage)
         {
            stage.getCameraPosition(targetSpace,sHelperPoint3D);
            getTransformationMatrix3D(targetSpace,sHelperMatrix3D);
            mVertexData.getBoundsProjected(sHelperMatrix3D,sHelperPoint3D,0,4,resultRect);
         }
         else
         {
            getTransformationMatrix(targetSpace,sHelperMatrix);
            mVertexData.getBounds(sHelperMatrix,0,4,resultRect);
         }
         return resultRect;
      }
      
      public function getVertexColor(vertexID:int) : uint
      {
         return mVertexData.getColor(vertexID);
      }
      
      public function setVertexColor(vertexID:int, color:uint) : void
      {
         mVertexData.setColor(vertexID,color);
         onVertexDataChanged();
         if(color != 16777215)
         {
            mTinted = true;
         }
         else
         {
            mTinted = mVertexData.tinted;
         }
      }
      
      public function getVertexAlpha(vertexID:int) : Number
      {
         return mVertexData.getAlpha(vertexID);
      }
      
      public function setVertexAlpha(vertexID:int, alpha:Number) : void
      {
         mVertexData.setAlpha(vertexID,alpha);
         onVertexDataChanged();
         if(alpha != 1)
         {
            mTinted = true;
         }
         else
         {
            mTinted = mVertexData.tinted;
         }
      }
      
      public function get color() : uint
      {
         return mVertexData.getColor(0);
      }
      
      public function set color(value:uint) : void
      {
         mVertexData.setUniformColor(value);
         onVertexDataChanged();
         if(value != 16777215 || alpha != 1)
         {
            mTinted = true;
         }
         else
         {
            mTinted = mVertexData.tinted;
         }
      }
      
      override public function set alpha(value:Number) : void
      {
         .super.alpha = value;
         if(value < 1)
         {
            mTinted = true;
         }
         else
         {
            mTinted = mVertexData.tinted;
         }
      }
      
      public function copyVertexDataTo(targetData:VertexData, targetVertexID:int = 0) : void
      {
         mVertexData.copyTo(targetData,targetVertexID);
      }
      
      public function copyVertexDataTransformedTo(targetData:VertexData, targetVertexID:int = 0, matrix:Matrix = null) : void
      {
         mVertexData.copyTransformedTo(targetData,targetVertexID,matrix,0,4);
      }
      
      override public function render(support:RenderSupport, parentAlpha:Number) : void
      {
         support.batchQuad(this,parentAlpha);
      }
      
      public function get tinted() : Boolean
      {
         return mTinted;
      }
      
      public function get premultipliedAlpha() : Boolean
      {
         return mVertexData.premultipliedAlpha;
      }
   }
}
