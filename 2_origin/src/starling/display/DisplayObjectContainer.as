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
      
      private static function mergeSort(input:Vector.<DisplayObject>, compareFunc:Function, startIndex:int, length:int, buffer:Vector.<DisplayObject>) : void
      {
         var i:* = 0;
         var endIndex:int = 0;
         var halfLength:int = 0;
         var l:* = 0;
         var r:int = 0;
         if(length <= 1)
         {
            return;
         }
         i = 0;
         endIndex = startIndex + length;
         halfLength = length / 2;
         l = startIndex;
         r = startIndex + halfLength;
         mergeSort(input,compareFunc,startIndex,halfLength,buffer);
         mergeSort(input,compareFunc,startIndex + halfLength,length - halfLength,buffer);
         for(i = 0; i < length; )
         {
            if(l < startIndex + halfLength && (r == endIndex || compareFunc(input[l],input[r]) <= 0))
            {
               buffer[i] = input[l];
               l++;
            }
            else
            {
               buffer[i] = input[r];
               r++;
            }
            i++;
         }
         for(i = startIndex; i < endIndex; )
         {
            input[i] = buffer[int(i - startIndex)];
            i++;
         }
      }
      
      override public function dispose() : void
      {
         var i:int = 0;
         for(i = mChildren.length - 1; i >= 0; )
         {
            mChildren[i].dispose();
            i--;
         }
         super.dispose();
      }
      
      public function addChild(child:DisplayObject) : DisplayObject
      {
         return addChildAt(child,mChildren.length);
      }
      
      public function addChildAt(child:DisplayObject, index:int) : DisplayObject
      {
         var container:* = null;
         var numChildren:int = mChildren.length;
         if(index >= 0 && index <= numChildren)
         {
            if(child.parent == this)
            {
               setChildIndex(child,index);
            }
            else
            {
               child.removeFromParent();
               if(index == numChildren)
               {
                  mChildren[numChildren] = child;
               }
               else
               {
                  spliceChildren(index,0,child);
               }
               child.setParent(this);
               child.dispatchEventWith("added",true);
               if(stage)
               {
                  container = child as DisplayObjectContainer;
                  if(container)
                  {
                     container.broadcastEventWith("addedToStage");
                  }
                  else
                  {
                     child.dispatchEventWith("addedToStage");
                  }
               }
            }
            return child;
         }
         throw new RangeError("Invalid child index");
      }
      
      public function removeChild(child:DisplayObject, dispose:Boolean = false) : DisplayObject
      {
         var childIndex:int = getChildIndex(child);
         if(childIndex != -1)
         {
            removeChildAt(childIndex,dispose);
         }
         return child;
      }
      
      public function removeChildAt(index:int, dispose:Boolean = false) : DisplayObject
      {
         var child:* = null;
         var container:* = null;
         if(index >= 0 && index < mChildren.length)
         {
            child = mChildren[index];
            child.dispatchEventWith("removed",true);
            if(stage)
            {
               container = child as DisplayObjectContainer;
               if(container)
               {
                  container.broadcastEventWith("removedFromStage");
               }
               else
               {
                  child.dispatchEventWith("removedFromStage");
               }
            }
            child.setParent(null);
            index = mChildren.indexOf(child);
            if(index >= 0)
            {
               spliceChildren(index,1);
            }
            if(dispose)
            {
               child.dispose();
            }
            return child;
         }
         throw new RangeError("Invalid child index");
      }
      
      public function removeChildren(beginIndex:int = 0, endIndex:int = -1, dispose:Boolean = false) : void
      {
         var i:* = 0;
         if(endIndex < 0 || endIndex >= numChildren)
         {
            endIndex = numChildren - 1;
         }
         for(i = beginIndex; i <= endIndex; )
         {
            removeChildAt(beginIndex,dispose);
            i++;
         }
      }
      
      public function getChildAt(index:int) : DisplayObject
      {
         var numChildren:int = mChildren.length;
         if(index < 0)
         {
            index = numChildren + index;
         }
         if(index >= 0 && index < numChildren)
         {
            return mChildren[index];
         }
         throw new RangeError("Invalid child index");
      }
      
      public function getChildByName(name:String) : DisplayObject
      {
         var i:int = 0;
         var numChildren:int = mChildren.length;
         for(i = 0; i < numChildren; )
         {
            if(mChildren[i].name == name)
            {
               return mChildren[i];
            }
            i++;
         }
         return null;
      }
      
      public function getChildIndex(child:DisplayObject) : int
      {
         return mChildren.indexOf(child);
      }
      
      public function setChildIndex(child:DisplayObject, index:int) : void
      {
         var oldIndex:int = getChildIndex(child);
         if(oldIndex == index)
         {
            return;
         }
         if(oldIndex == -1)
         {
            throw new ArgumentError("Not a child of this container");
         }
         spliceChildren(oldIndex,1);
         spliceChildren(index,0,child);
      }
      
      public function swapChildren(child1:DisplayObject, child2:DisplayObject) : void
      {
         var index1:int = getChildIndex(child1);
         var index2:int = getChildIndex(child2);
         if(index1 == -1 || index2 == -1)
         {
            throw new ArgumentError("Not a child of this container");
         }
         swapChildrenAt(index1,index2);
      }
      
      public function swapChildrenAt(index1:int, index2:int) : void
      {
         var child1:DisplayObject = getChildAt(index1);
         var child2:DisplayObject = getChildAt(index2);
         mChildren[index1] = child2;
         mChildren[index2] = child1;
      }
      
      public function sortChildren(compareFunction:Function) : void
      {
         sSortBuffer.length = mChildren.length;
         mergeSort(mChildren,compareFunction,0,mChildren.length,sSortBuffer);
         sSortBuffer.length = 0;
      }
      
      public function contains(child:DisplayObject) : Boolean
      {
         while(child)
         {
            if(child == this)
            {
               return true;
            }
            child = child.parent;
         }
         return false;
      }
      
      override public function getBounds(targetSpace:DisplayObject, resultRect:Rectangle = null) : Rectangle
      {
         var minX:* = NaN;
         var minY:* = NaN;
         var i:int = 0;
         if(resultRect == null)
         {
            resultRect = new Rectangle();
         }
         var numChildren:int = mChildren.length;
         if(numChildren == 0)
         {
            getTransformationMatrix(targetSpace,sHelperMatrix);
            MatrixUtil.transformCoords(sHelperMatrix,0,0,sHelperPoint);
            resultRect.setTo(sHelperPoint.x,sHelperPoint.y,0,0);
         }
         else if(numChildren == 1)
         {
            mChildren[0].getBounds(targetSpace,resultRect);
         }
         else
         {
            minX = 1.79769313486232e308;
            var maxX:* = -1.79769313486232e308;
            minY = 1.79769313486232e308;
            var maxY:* = -1.79769313486232e308;
            for(i = 0; i < numChildren; )
            {
               mChildren[i].getBounds(targetSpace,resultRect);
               if(minX > resultRect.x)
               {
                  minX = Number(resultRect.x);
               }
               if(maxX < resultRect.right)
               {
                  maxX = Number(resultRect.right);
               }
               if(minY > resultRect.y)
               {
                  minY = Number(resultRect.y);
               }
               if(maxY < resultRect.bottom)
               {
                  maxY = Number(resultRect.bottom);
               }
               i++;
            }
            resultRect.setTo(minX,minY,maxX - minX,maxY - minY);
         }
         return resultRect;
      }
      
      override public function hitTest(localPoint:Point, forTouch:Boolean = false) : DisplayObject
      {
         var i:int = 0;
         var child:* = null;
         if(forTouch && (!visible || !touchable))
         {
            return null;
         }
         if(!hitTestMask(localPoint))
         {
            return null;
         }
         var target:DisplayObject = null;
         var localX:Number = localPoint.x;
         var localY:Number = localPoint.y;
         var numChildren:int = mChildren.length;
         for(i = numChildren - 1; i >= 0; )
         {
            child = mChildren[i];
            if(!child.isMask)
            {
               sHelperMatrix.copyFrom(child.transformationMatrix);
               sHelperMatrix.invert();
               MatrixUtil.transformCoords(sHelperMatrix,localX,localY,sHelperPoint);
               target = child.hitTest(sHelperPoint,forTouch);
               if(target)
               {
                  return forTouch && mTouchGroup?this:target;
               }
            }
            i--;
         }
         return null;
      }
      
      override public function render(support:RenderSupport, parentAlpha:Number) : void
      {
         var i:int = 0;
         var child:* = null;
         var filter:* = null;
         var mask:* = null;
         var alpha:Number = parentAlpha * this.alpha;
         var numChildren:int = mChildren.length;
         var blendMode:String = support.blendMode;
         for(i = 0; i < numChildren; )
         {
            child = mChildren[i];
            if(child.hasVisibleArea)
            {
               filter = child.filter;
               mask = child.mask;
               support.pushMatrix();
               support.transformMatrix(child);
               support.blendMode = child.blendMode;
               if(mask)
               {
                  support.pushMask(mask);
               }
               if(filter)
               {
                  filter.render(child,support,alpha);
               }
               else
               {
                  child.render(support,alpha);
               }
               if(mask)
               {
                  support.popMask();
               }
               support.blendMode = blendMode;
               support.popMatrix();
            }
            i++;
         }
      }
      
      public function broadcastEvent(event:Event) : void
      {
         var i:* = 0;
         if(event.bubbles)
         {
            throw new ArgumentError("Broadcast of bubbling events is prohibited");
         }
         var fromIndex:int = sBroadcastListeners.length;
         getChildEventListeners(this,event.type,sBroadcastListeners);
         var toIndex:int = sBroadcastListeners.length;
         for(i = fromIndex; i < toIndex; )
         {
            sBroadcastListeners[i].dispatchEvent(event);
            i++;
         }
         sBroadcastListeners.length = fromIndex;
      }
      
      public function broadcastEventWith(type:String, data:Object = null) : void
      {
         var event:Event = Event.fromPool(type,false,data);
         broadcastEvent(event);
         Event.toPool(event);
      }
      
      public function get numChildren() : int
      {
         return mChildren.length;
      }
      
      public function get touchGroup() : Boolean
      {
         return mTouchGroup;
      }
      
      public function set touchGroup(value:Boolean) : void
      {
         mTouchGroup = value;
      }
      
      private function spliceChildren(startIndex:int, deleteCount:uint = 4294967295, insertee:DisplayObject = null) : void
      {
         var i:int = 0;
         var vector:Vector.<DisplayObject> = mChildren;
         var oldLength:uint = vector.length;
         if(startIndex < 0)
         {
            startIndex = startIndex + oldLength;
         }
         if(startIndex < 0)
         {
            startIndex = 0;
         }
         else if(startIndex > oldLength)
         {
            startIndex = oldLength;
         }
         if(startIndex + deleteCount > oldLength)
         {
            deleteCount = oldLength - startIndex;
         }
         var insertCount:int = !!insertee?1:0;
         var deltaLength:int = insertCount - deleteCount;
         var newLength:uint = oldLength + deltaLength;
         var shiftCount:int = oldLength - startIndex - deleteCount;
         if(deltaLength < 0)
         {
            i = startIndex + insertCount;
            while(shiftCount)
            {
               vector[i] = vector[int(i - deltaLength)];
               shiftCount--;
               i++;
            }
            vector.length = newLength;
         }
         else if(deltaLength > 0)
         {
            i = 1;
            while(shiftCount)
            {
               vector[int(newLength - i)] = vector[int(oldLength - i)];
               shiftCount--;
               i++;
            }
            vector.length = newLength;
         }
         if(insertee)
         {
            vector[startIndex] = insertee;
         }
      }
      
      function getChildEventListeners(object:DisplayObject, eventType:String, listeners:Vector.<DisplayObject>) : void
      {
         var children:* = undefined;
         var numChildren:int = 0;
         var i:int = 0;
         var container:DisplayObjectContainer = object as DisplayObjectContainer;
         if(object.hasEventListener(eventType))
         {
            listeners[listeners.length] = object;
         }
         if(container)
         {
            children = container.mChildren;
            numChildren = children.length;
            for(i = 0; i < numChildren; )
            {
               getChildEventListeners(children[i],eventType,listeners);
               i++;
            }
         }
      }
   }
}
