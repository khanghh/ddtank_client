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
         var _loc2_:int = 0;
         var _loc1_:int = 0;
         if(mFlattenedContents)
         {
            _loc2_ = 0;
            _loc1_ = mFlattenedContents.length;
            while(_loc2_ < _loc1_)
            {
               mFlattenedContents[_loc2_].dispose();
               _loc2_++;
            }
            mFlattenedContents = null;
         }
      }
      
      public function flatten(param1:Boolean = false) : void
      {
         mFlattenRequested = true;
         mFlattenOptimized = param1;
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
      
      public function set clipRect(param1:Rectangle) : void
      {
         if(mClipRect && param1)
         {
            mClipRect.copyFrom(param1);
         }
         else
         {
            mClipRect = !!param1?param1.clone():null;
         }
      }
      
      public function getClipRect(param1:DisplayObject, param2:Rectangle = null) : Rectangle
      {
         var _loc8_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc9_:int = 0;
         var _loc4_:* = null;
         if(mClipRect == null)
         {
            return null;
         }
         if(param2 == null)
         {
            param2 = new Rectangle();
         }
         var _loc7_:* = 1.79769313486232e308;
         var _loc6_:* = -1.79769313486232e308;
         var _loc10_:* = 1.79769313486232e308;
         var _loc5_:* = -1.79769313486232e308;
         var _loc3_:Matrix = getTransformationMatrix(param1,sHelperMatrix);
         _loc9_ = 0;
         while(_loc9_ < 4)
         {
            switch(int(_loc9_))
            {
               case 0:
                  _loc11_ = mClipRect.left;
                  _loc8_ = mClipRect.top;
                  break;
               case 1:
                  _loc11_ = mClipRect.left;
                  _loc8_ = mClipRect.bottom;
                  break;
               case 2:
                  _loc11_ = mClipRect.right;
                  _loc8_ = mClipRect.top;
                  break;
               case 3:
                  _loc11_ = mClipRect.right;
                  _loc8_ = mClipRect.bottom;
            }
            _loc4_ = MatrixUtil.transformCoords(_loc3_,_loc11_,_loc8_,sHelperPoint);
            if(_loc7_ > _loc4_.x)
            {
               _loc7_ = Number(_loc4_.x);
            }
            if(_loc6_ < _loc4_.x)
            {
               _loc6_ = Number(_loc4_.x);
            }
            if(_loc10_ > _loc4_.y)
            {
               _loc10_ = Number(_loc4_.y);
            }
            if(_loc5_ < _loc4_.y)
            {
               _loc5_ = Number(_loc4_.y);
            }
            _loc9_++;
         }
         param2.setTo(_loc7_,_loc10_,_loc6_ - _loc7_,_loc5_ - _loc10_);
         return param2;
      }
      
      override public function getBounds(param1:DisplayObject, param2:Rectangle = null) : Rectangle
      {
         var _loc3_:Rectangle = super.getBounds(param1,param2);
         if(mClipRect)
         {
            RectangleUtil.intersect(_loc3_,getClipRect(param1,sHelperRect),_loc3_);
         }
         return _loc3_;
      }
      
      override public function hitTest(param1:Point, param2:Boolean = false) : DisplayObject
      {
         if(mClipRect != null && !mClipRect.containsPoint(param1))
         {
            return null;
         }
         return super.hitTest(param1,param2);
      }
      
      override public function render(param1:RenderSupport, param2:Number) : void
      {
         var _loc7_:* = null;
         var _loc5_:Number = NaN;
         var _loc8_:int = 0;
         var _loc4_:* = null;
         var _loc9_:int = 0;
         var _loc6_:* = null;
         var _loc3_:* = null;
         if(mClipRect)
         {
            _loc7_ = param1.pushClipRect(getClipRect(stage,sHelperRect));
            if(_loc7_.isEmpty())
            {
               param1.popClipRect();
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
               param1.applyClipRect();
               mFlattenRequested = false;
            }
            _loc5_ = param2 * this.alpha;
            _loc8_ = mFlattenedContents.length;
            _loc4_ = param1.mvpMatrix3D;
            param1.finishQuadBatch();
            param1.raiseDrawCount(_loc8_);
            _loc9_ = 0;
            while(_loc9_ < _loc8_)
            {
               _loc6_ = mFlattenedContents[_loc9_];
               _loc3_ = _loc6_.blendMode == "auto"?param1.blendMode:_loc6_.blendMode;
               _loc6_.renderCustom(_loc4_,_loc5_,_loc3_);
               _loc9_++;
            }
         }
         else
         {
            super.render(param1,param2);
         }
         if(mClipRect)
         {
            param1.popClipRect();
         }
      }
   }
}
