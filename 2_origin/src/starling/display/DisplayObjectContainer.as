package starling.display
{
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.system.Capabilities;
   import flash.utils.getQualifiedClassName;
   import starling.core.RenderSupport;
   import starling.errors.AbstractClassError;
   import starling.events.Event;
   import starling.filters.FragmentFilter;
   import starling.utils.MatrixUtil;
   
   public class DisplayObjectContainer extends DisplayObject
   {
      
      private static var sHelperMatrix:Matrix = new Matrix();
      
      private static var sHelperPoint:Point = new Point();
      
      private static var sBroadcastListeners:Vector.<DisplayObject> = new Vector.<DisplayObject>(0);
      
      private static var sSortBuffer:Vector.<DisplayObject> = new Vector.<DisplayObject>(0);
       
      
      private var mChildren:Vector.<DisplayObject>;
      
      private var mTouchGroup:Boolean;
      
      public function DisplayObjectContainer()
      {
         super();
         if(Capabilities.isDebugger && getQualifiedClassName(this) == "starling.display::DisplayObjectContainer")
         {
            throw new AbstractClassError();
         }
         mChildren = new Vector.<DisplayObject>(0);
      }
      
      private static function mergeSort(param1:Vector.<DisplayObject>, param2:Function, param3:int, param4:int, param5:Vector.<DisplayObject>) : void
      {
         var _loc10_:* = 0;
         var _loc9_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:* = 0;
         var _loc6_:int = 0;
         if(param4 <= 1)
         {
            return;
         }
         _loc10_ = 0;
         _loc9_ = param3 + param4;
         _loc7_ = param4 / 2;
         _loc8_ = param3;
         _loc6_ = param3 + _loc7_;
         mergeSort(param1,param2,param3,_loc7_,param5);
         mergeSort(param1,param2,param3 + _loc7_,param4 - _loc7_,param5);
         _loc10_ = 0;
         while(_loc10_ < param4)
         {
            if(_loc8_ < param3 + _loc7_ && (_loc6_ == _loc9_ || param2(param1[_loc8_],param1[_loc6_]) <= 0))
            {
               param5[_loc10_] = param1[_loc8_];
               _loc8_++;
            }
            else
            {
               param5[_loc10_] = param1[_loc6_];
               _loc6_++;
            }
            _loc10_++;
         }
         _loc10_ = param3;
         while(_loc10_ < _loc9_)
         {
            param1[_loc10_] = param5[int(_loc10_ - param3)];
            _loc10_++;
         }
      }
      
      override public function dispose() : void
      {
         var _loc1_:int = 0;
         _loc1_ = mChildren.length - 1;
         while(_loc1_ >= 0)
         {
            mChildren[_loc1_].dispose();
            _loc1_--;
         }
         super.dispose();
      }
      
      public function addChild(param1:DisplayObject) : DisplayObject
      {
         return addChildAt(param1,mChildren.length);
      }
      
      public function addChildAt(param1:DisplayObject, param2:int) : DisplayObject
      {
         var _loc3_:* = null;
         var _loc4_:int = mChildren.length;
         if(param2 >= 0 && param2 <= _loc4_)
         {
            if(param1.parent == this)
            {
               setChildIndex(param1,param2);
            }
            else
            {
               param1.removeFromParent();
               if(param2 == _loc4_)
               {
                  mChildren[_loc4_] = param1;
               }
               else
               {
                  spliceChildren(param2,0,param1);
               }
               param1.setParent(this);
               param1.dispatchEventWith("added",true);
               if(stage)
               {
                  _loc3_ = param1 as DisplayObjectContainer;
                  if(_loc3_)
                  {
                     _loc3_.broadcastEventWith("addedToStage");
                  }
                  else
                  {
                     param1.dispatchEventWith("addedToStage");
                  }
               }
            }
            return param1;
         }
         throw new RangeError("Invalid child index");
      }
      
      public function removeChild(param1:DisplayObject, param2:Boolean = false) : DisplayObject
      {
         var _loc3_:int = getChildIndex(param1);
         if(_loc3_ != -1)
         {
            removeChildAt(_loc3_,param2);
         }
         return param1;
      }
      
      public function removeChildAt(param1:int, param2:Boolean = false) : DisplayObject
      {
         var _loc3_:* = null;
         var _loc4_:* = null;
         if(param1 >= 0 && param1 < mChildren.length)
         {
            _loc3_ = mChildren[param1];
            _loc3_.dispatchEventWith("removed",true);
            if(stage)
            {
               _loc4_ = _loc3_ as DisplayObjectContainer;
               if(_loc4_)
               {
                  _loc4_.broadcastEventWith("removedFromStage");
               }
               else
               {
                  _loc3_.dispatchEventWith("removedFromStage");
               }
            }
            _loc3_.setParent(null);
            param1 = mChildren.indexOf(_loc3_);
            if(param1 >= 0)
            {
               spliceChildren(param1,1);
            }
            if(param2)
            {
               _loc3_.dispose();
            }
            return _loc3_;
         }
         throw new RangeError("Invalid child index");
      }
      
      public function removeChildren(param1:int = 0, param2:int = -1, param3:Boolean = false) : void
      {
         var _loc4_:* = 0;
         if(param2 < 0 || param2 >= numChildren)
         {
            param2 = numChildren - 1;
         }
         _loc4_ = param1;
         while(_loc4_ <= param2)
         {
            removeChildAt(param1,param3);
            _loc4_++;
         }
      }
      
      public function getChildAt(param1:int) : DisplayObject
      {
         var _loc2_:int = mChildren.length;
         if(param1 < 0)
         {
            param1 = _loc2_ + param1;
         }
         if(param1 >= 0 && param1 < _loc2_)
         {
            return mChildren[param1];
         }
         throw new RangeError("Invalid child index");
      }
      
      public function getChildByName(param1:String) : DisplayObject
      {
         var _loc3_:int = 0;
         var _loc2_:int = mChildren.length;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            if(mChildren[_loc3_].name == param1)
            {
               return mChildren[_loc3_];
            }
            _loc3_++;
         }
         return null;
      }
      
      public function getChildIndex(param1:DisplayObject) : int
      {
         return mChildren.indexOf(param1);
      }
      
      public function setChildIndex(param1:DisplayObject, param2:int) : void
      {
         var _loc3_:int = getChildIndex(param1);
         if(_loc3_ == param2)
         {
            return;
         }
         if(_loc3_ == -1)
         {
            throw new ArgumentError("Not a child of this container");
         }
         spliceChildren(_loc3_,1);
         spliceChildren(param2,0,param1);
      }
      
      public function swapChildren(param1:DisplayObject, param2:DisplayObject) : void
      {
         var _loc3_:int = getChildIndex(param1);
         var _loc4_:int = getChildIndex(param2);
         if(_loc3_ == -1 || _loc4_ == -1)
         {
            throw new ArgumentError("Not a child of this container");
         }
         swapChildrenAt(_loc3_,_loc4_);
      }
      
      public function swapChildrenAt(param1:int, param2:int) : void
      {
         var _loc3_:DisplayObject = getChildAt(param1);
         var _loc4_:DisplayObject = getChildAt(param2);
         mChildren[param1] = _loc4_;
         mChildren[param2] = _loc3_;
      }
      
      public function sortChildren(param1:Function) : void
      {
         sSortBuffer.length = mChildren.length;
         mergeSort(mChildren,param1,0,mChildren.length,sSortBuffer);
         sSortBuffer.length = 0;
      }
      
      public function contains(param1:DisplayObject) : Boolean
      {
         while(param1)
         {
            if(param1 == this)
            {
               return true;
            }
            param1 = param1.parent;
         }
         return false;
      }
      
      override public function getBounds(param1:DisplayObject, param2:Rectangle = null) : Rectangle
      {
         var _loc6_:* = NaN;
         var _loc8_:* = NaN;
         var _loc7_:int = 0;
         if(param2 == null)
         {
            param2 = new Rectangle();
         }
         var _loc4_:int = mChildren.length;
         if(_loc4_ == 0)
         {
            getTransformationMatrix(param1,sHelperMatrix);
            MatrixUtil.transformCoords(sHelperMatrix,0,0,sHelperPoint);
            param2.setTo(sHelperPoint.x,sHelperPoint.y,0,0);
         }
         else if(_loc4_ == 1)
         {
            mChildren[0].getBounds(param1,param2);
         }
         else
         {
            _loc6_ = 1.79769313486232e308;
            var _loc5_:* = -1.79769313486232e308;
            _loc8_ = 1.79769313486232e308;
            var _loc3_:* = -1.79769313486232e308;
            _loc7_ = 0;
            while(_loc7_ < _loc4_)
            {
               mChildren[_loc7_].getBounds(param1,param2);
               if(_loc6_ > param2.x)
               {
                  _loc6_ = Number(param2.x);
               }
               if(_loc5_ < param2.right)
               {
                  _loc5_ = Number(param2.right);
               }
               if(_loc8_ > param2.y)
               {
                  _loc8_ = Number(param2.y);
               }
               if(_loc3_ < param2.bottom)
               {
                  _loc3_ = Number(param2.bottom);
               }
               _loc7_++;
            }
            param2.setTo(_loc6_,_loc8_,_loc5_ - _loc6_,_loc3_ - _loc8_);
         }
         return param2;
      }
      
      override public function hitTest(param1:Point, param2:Boolean = false) : DisplayObject
      {
         var _loc8_:int = 0;
         var _loc3_:* = null;
         if(param2 && (!visible || !touchable))
         {
            return null;
         }
         if(!hitTestMask(param1))
         {
            return null;
         }
         var _loc6_:DisplayObject = null;
         var _loc4_:Number = param1.x;
         var _loc5_:Number = param1.y;
         var _loc7_:int = mChildren.length;
         _loc8_ = _loc7_ - 1;
         while(_loc8_ >= 0)
         {
            _loc3_ = mChildren[_loc8_];
            if(!_loc3_.isMask)
            {
               sHelperMatrix.copyFrom(_loc3_.transformationMatrix);
               sHelperMatrix.invert();
               MatrixUtil.transformCoords(sHelperMatrix,_loc4_,_loc5_,sHelperPoint);
               _loc6_ = _loc3_.hitTest(sHelperPoint,param2);
               if(_loc6_)
               {
                  return param2 && mTouchGroup?this:_loc6_;
               }
            }
            _loc8_--;
         }
         return null;
      }
      
      override public function render(param1:RenderSupport, param2:Number) : void
      {
         var _loc9_:int = 0;
         var _loc3_:* = null;
         var _loc8_:* = null;
         var _loc6_:* = null;
         var _loc5_:Number = param2 * this.alpha;
         var _loc7_:int = mChildren.length;
         var _loc4_:String = param1.blendMode;
         _loc9_ = 0;
         while(_loc9_ < _loc7_)
         {
            _loc3_ = mChildren[_loc9_];
            if(_loc3_.hasVisibleArea)
            {
               _loc8_ = _loc3_.filter;
               _loc6_ = _loc3_.mask;
               param1.pushMatrix();
               param1.transformMatrix(_loc3_);
               param1.blendMode = _loc3_.blendMode;
               if(_loc6_)
               {
                  param1.pushMask(_loc6_);
               }
               if(_loc8_)
               {
                  _loc8_.render(_loc3_,param1,_loc5_);
               }
               else
               {
                  _loc3_.render(param1,_loc5_);
               }
               if(_loc6_)
               {
                  param1.popMask();
               }
               param1.blendMode = _loc4_;
               param1.popMatrix();
            }
            _loc9_++;
         }
      }
      
      public function broadcastEvent(param1:Event) : void
      {
         var _loc4_:* = 0;
         if(param1.bubbles)
         {
            throw new ArgumentError("Broadcast of bubbling events is prohibited");
         }
         var _loc2_:int = sBroadcastListeners.length;
         getChildEventListeners(this,param1.type,sBroadcastListeners);
         var _loc3_:int = sBroadcastListeners.length;
         _loc4_ = _loc2_;
         while(_loc4_ < _loc3_)
         {
            sBroadcastListeners[_loc4_].dispatchEvent(param1);
            _loc4_++;
         }
         sBroadcastListeners.length = _loc2_;
      }
      
      public function broadcastEventWith(param1:String, param2:Object = null) : void
      {
         var _loc3_:Event = Event.fromPool(param1,false,param2);
         broadcastEvent(_loc3_);
         Event.toPool(_loc3_);
      }
      
      public function get numChildren() : int
      {
         return mChildren.length;
      }
      
      public function get touchGroup() : Boolean
      {
         return mTouchGroup;
      }
      
      public function set touchGroup(param1:Boolean) : void
      {
         mTouchGroup = param1;
      }
      
      private function spliceChildren(param1:int, param2:uint = 4294967295, param3:DisplayObject = null) : void
      {
         var _loc10_:int = 0;
         var _loc6_:Vector.<DisplayObject> = mChildren;
         var _loc8_:uint = _loc6_.length;
         if(param1 < 0)
         {
            param1 = param1 + _loc8_;
         }
         if(param1 < 0)
         {
            param1 = 0;
         }
         else if(param1 > _loc8_)
         {
            param1 = _loc8_;
         }
         if(param1 + param2 > _loc8_)
         {
            param2 = _loc8_ - param1;
         }
         var _loc7_:int = !!param3?1:0;
         var _loc9_:int = _loc7_ - param2;
         var _loc5_:uint = _loc8_ + _loc9_;
         var _loc4_:int = _loc8_ - param1 - param2;
         if(_loc9_ < 0)
         {
            _loc10_ = param1 + _loc7_;
            while(_loc4_)
            {
               _loc6_[_loc10_] = _loc6_[int(_loc10_ - _loc9_)];
               _loc4_--;
               _loc10_++;
            }
            _loc6_.length = _loc5_;
         }
         else if(_loc9_ > 0)
         {
            _loc10_ = 1;
            while(_loc4_)
            {
               _loc6_[int(_loc5_ - _loc10_)] = _loc6_[int(_loc8_ - _loc10_)];
               _loc4_--;
               _loc10_++;
            }
            _loc6_.length = _loc5_;
         }
         if(param3)
         {
            _loc6_[param1] = param3;
         }
      }
      
      function getChildEventListeners(param1:DisplayObject, param2:String, param3:Vector.<DisplayObject>) : void
      {
         var _loc5_:* = undefined;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc4_:DisplayObjectContainer = param1 as DisplayObjectContainer;
         if(param1.hasEventListener(param2))
         {
            param3[param3.length] = param1;
         }
         if(_loc4_)
         {
            _loc5_ = _loc4_.mChildren;
            _loc6_ = _loc5_.length;
            _loc7_ = 0;
            while(_loc7_ < _loc6_)
            {
               getChildEventListeners(_loc5_[_loc7_],param2,param3);
               _loc7_++;
            }
         }
      }
   }
}
