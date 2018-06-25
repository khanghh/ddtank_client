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
      
      public function Sprite()
      {
         super();
         _graphics = new Graphics(this);
      }
      
      override public function dispose() : void
      {
         disposeFlattenedContents();
         super.dispose();
      }
      
      public function get graphics() : Graphics
      {
         return _graphics;
      }
      
      private function disposeFlattenedContents() : void
      {
         var i:int = 0;
         var max:int = 0;
         if(mFlattenedContents)
         {
            for(i = 0,max = mFlattenedContents.length; i < max; )
            {
               mFlattenedContents[i].dispose();
               i++;
            }
            mFlattenedContents = null;
         }
      }
      
      public function flatten(ignoreChildOrder:Boolean = false) : void
      {
         mFlattenRequested = true;
         mFlattenOptimized = ignoreChildOrder;
         broadcastEventWith("flatten");
      }
      
      public function unflatten() : void
      {
         mFlattenRequested = false;
         disposeFlattenedContents();
      }
      
      public function get isFlattened() : Boolean
      {
         return mFlattenedContents != null || mFlattenRequested;
      }
      
      public function get clipRect() : Rectangle
      {
         return mClipRect;
      }
      
      public function set clipRect(value:Rectangle) : void
      {
         if(mClipRect && value)
         {
            mClipRect.copyFrom(value);
         }
         else
         {
            mClipRect = !!value?value.clone():null;
         }
      }
      
      public function getClipRect(targetSpace:DisplayObject, resultRect:Rectangle = null) : Rectangle
      {
         var y:Number = NaN;
         var x:Number = NaN;
         var i:int = 0;
         var transformedPoint:* = null;
         if(mClipRect == null)
         {
            return null;
         }
         if(resultRect == null)
         {
            resultRect = new Rectangle();
         }
         var minX:* = 1.79769313486232e308;
         var maxX:* = -1.79769313486232e308;
         var minY:* = 1.79769313486232e308;
         var maxY:* = -1.79769313486232e308;
         var transMatrix:Matrix = getTransformationMatrix(targetSpace,sHelperMatrix);
         for(i = 0; i < 4; )
         {
            switch(int(i))
            {
               case 0:
                  x = mClipRect.left;
                  y = mClipRect.top;
                  break;
               case 1:
                  x = mClipRect.left;
                  y = mClipRect.bottom;
                  break;
               case 2:
                  x = mClipRect.right;
                  y = mClipRect.top;
                  break;
               case 3:
                  x = mClipRect.right;
                  y = mClipRect.bottom;
            }
            transformedPoint = MatrixUtil.transformCoords(transMatrix,x,y,sHelperPoint);
            if(minX > transformedPoint.x)
            {
               minX = Number(transformedPoint.x);
            }
            if(maxX < transformedPoint.x)
            {
               maxX = Number(transformedPoint.x);
            }
            if(minY > transformedPoint.y)
            {
               minY = Number(transformedPoint.y);
            }
            if(maxY < transformedPoint.y)
            {
               maxY = Number(transformedPoint.y);
            }
            i++;
         }
         resultRect.setTo(minX,minY,maxX - minX,maxY - minY);
         return resultRect;
      }
      
      override public function getBounds(targetSpace:DisplayObject, resultRect:Rectangle = null) : Rectangle
      {
         var bounds:Rectangle = super.getBounds(targetSpace,resultRect);
         if(mClipRect)
         {
            RectangleUtil.intersect(bounds,getClipRect(targetSpace,sHelperRect),bounds);
         }
         return bounds;
      }
      
      override public function hitTest(localPoint:Point, forTouch:Boolean = false) : DisplayObject
      {
         if(mClipRect != null && !mClipRect.containsPoint(localPoint))
         {
            return null;
         }
         return super.hitTest(localPoint,forTouch);
      }
      
      override public function render(support:RenderSupport, parentAlpha:Number) : void
      {
         var clipRect:* = null;
         var alpha:Number = NaN;
         var numBatches:int = 0;
         var mvpMatrix:* = null;
         var i:int = 0;
         var quadBatch:* = null;
         var blendMode:* = null;
         if(mClipRect)
         {
            clipRect = support.pushClipRect(getClipRect(stage,sHelperRect));
            if(clipRect.isEmpty())
            {
               support.popClipRect();
               return;
            }
         }
         if(mFlattenedContents || mFlattenRequested)
         {
            if(mFlattenedContents == null)
            {
               mFlattenedContents = new Vector.<QuadBatch>(0);
            }
            if(mFlattenRequested)
            {
               QuadBatch.compile(this,mFlattenedContents);
               if(mFlattenOptimized)
               {
                  QuadBatch.optimize(mFlattenedContents);
               }
               support.applyClipRect();
               mFlattenRequested = false;
            }
            alpha = parentAlpha * this.alpha;
            numBatches = mFlattenedContents.length;
            mvpMatrix = support.mvpMatrix3D;
            support.finishQuadBatch();
            support.raiseDrawCount(numBatches);
            for(i = 0; i < numBatches; )
            {
               quadBatch = mFlattenedContents[i];
               blendMode = quadBatch.blendMode == "auto"?support.blendMode:quadBatch.blendMode;
               quadBatch.renderCustom(mvpMatrix,alpha,blendMode);
               i++;
            }
         }
         else
         {
            super.render(support,parentAlpha);
         }
         if(mClipRect)
         {
            support.popClipRect();
         }
      }
   }
}
