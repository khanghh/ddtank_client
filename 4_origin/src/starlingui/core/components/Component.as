package starlingui.core.components
{
   import starling.display.DisplayObject;
   import starling.display.Shape;
   import starling.display.Sprite;
   import starling.events.Event;
   import starlingui.core.events.UIEvent;
   import starlingui.editor.core.IComponent;
   
   [Event(name="resize",type="flash.events.Event")]
   [Event(name="move",type="morn.core.events.UIEvent")]
   public class Component extends Sprite implements IComponent
   {
       
      
      protected var _width:Number;
      
      protected var _height:Number;
      
      protected var _contentWidth:Number = 0;
      
      protected var _contentHeight:Number = 0;
      
      protected var _disabled:Boolean;
      
      protected var _tag:Object;
      
      protected var _comXml:XML;
      
      protected var _dataSource:Object;
      
      protected var _toolTip:Object;
      
      protected var _top:Number;
      
      protected var _bottom:Number;
      
      protected var _left:Number;
      
      protected var _right:Number;
      
      protected var _centerX:Number;
      
      protected var _centerY:Number;
      
      protected var _layOutEabled:Boolean;
      
      private var _border:Shape;
      
      public function Component()
      {
         super();
         touchable = false;
         preinitialize();
         createChildren();
         initialize();
      }
      
      protected function preinitialize() : void
      {
      }
      
      protected function createChildren() : void
      {
      }
      
      protected function initialize() : void
      {
      }
      
      public function setPosition(param1:Number, param2:Number) : void
      {
         this.x = param1;
         this.y = param2;
      }
      
      override public function set x(param1:Number) : void
      {
         .super.x = param1;
         dispatchEvent(new UIEvent("move"));
      }
      
      override public function set y(param1:Number) : void
      {
         .super.y = param1;
         dispatchEvent(new UIEvent("move"));
      }
      
      override public function get width() : Number
      {
         resetPosition();
         if(!isNaN(_width))
         {
            return _width;
         }
         if(_contentWidth != 0)
         {
            return _contentWidth;
         }
         return measureWidth;
      }
      
      public function get displayWidth() : Number
      {
         return width * scaleX;
      }
      
      protected function get measureWidth() : Number
      {
         var _loc3_:int = 0;
         var _loc1_:* = null;
         commitMeasure();
         var _loc2_:* = 0;
         _loc3_ = numChildren - 1;
         while(_loc3_ > -1)
         {
            _loc1_ = getChildAt(_loc3_);
            if(_loc1_.visible)
            {
               _loc2_ = Number(Math.max(_loc1_.x + _loc1_.width * _loc1_.scaleX,_loc2_));
            }
            _loc3_--;
         }
         return _loc2_;
      }
      
      override public function set width(param1:Number) : void
      {
         if(_width != param1)
         {
            _width = param1;
            changeSize();
            if(_layOutEabled)
            {
               resetPosition();
            }
         }
      }
      
      override public function get height() : Number
      {
         resetPosition();
         if(!isNaN(_height))
         {
            return _height;
         }
         if(_contentHeight != 0)
         {
            return _contentHeight;
         }
         return measureHeight;
      }
      
      public function get displayHeight() : Number
      {
         return height * scaleY;
      }
      
      protected function get measureHeight() : Number
      {
         var _loc3_:int = 0;
         var _loc1_:* = null;
         commitMeasure();
         var _loc2_:* = 0;
         _loc3_ = numChildren - 1;
         while(_loc3_ > -1)
         {
            _loc1_ = getChildAt(_loc3_);
            if(_loc1_.visible)
            {
               _loc2_ = Number(Math.max(_loc1_.y + _loc1_.height * _loc1_.scaleY,_loc2_));
            }
            _loc3_--;
         }
         return _loc2_;
      }
      
      override public function set height(param1:Number) : void
      {
         if(_height != param1)
         {
            _height = param1;
            changeSize();
            if(_layOutEabled)
            {
               resetPosition();
            }
         }
      }
      
      override public function get x() : Number
      {
         resetPosition();
         return super.x;
      }
      
      override public function get y() : Number
      {
         resetPosition();
         return super.y;
      }
      
      override public function set scaleX(param1:Number) : void
      {
         .super.scaleX = param1;
         changeSize();
      }
      
      override public function set scaleY(param1:Number) : void
      {
         .super.scaleY = param1;
         changeSize();
      }
      
      public function commitMeasure() : void
      {
      }
      
      protected function changeSize() : void
      {
         dispatchEvent(new Event("resize"));
      }
      
      public function setSize(param1:Number, param2:Number) : void
      {
         this.width = param1;
         this.height = param2;
      }
      
      public function set scale(param1:Number) : void
      {
         scaleY = param1;
         scaleX = param1;
      }
      
      public function get scale() : Number
      {
         return scaleX;
      }
      
      public function get disabled() : Boolean
      {
         return _disabled;
      }
      
      public function set disabled(param1:Boolean) : void
      {
         if(_disabled != param1)
         {
            _disabled = param1;
            touchable = !param1;
         }
      }
      
      public function get tag() : Object
      {
         return _tag;
      }
      
      public function set tag(param1:Object) : void
      {
         _tag = param1;
      }
      
      public function showBorder(param1:uint = 16711680) : void
      {
         _border = _border || new Shape();
         _border.graphics.clear();
         _border.graphics.lineStyle(1,param1);
         _border.graphics.drawRect(0,0,width,height);
         addChild(_border);
      }
      
      public function get comXml() : XML
      {
         return _comXml;
      }
      
      public function set comXml(param1:XML) : void
      {
         _comXml = param1;
      }
      
      public function get dataSource() : Object
      {
         return _dataSource;
      }
      
      public function set dataSource(param1:Object) : void
      {
         _dataSource = param1;
         var _loc4_:int = 0;
         var _loc3_:* = _dataSource;
         for(var _loc2_ in _dataSource)
         {
            if(hasOwnProperty(_loc2_))
            {
               this[_loc2_] = _dataSource[_loc2_];
            }
         }
      }
      
      public function get top() : Number
      {
         return _top;
      }
      
      public function set top(param1:Number) : void
      {
         _top = param1;
         layOutEabled = true;
      }
      
      public function get bottom() : Number
      {
         return _bottom;
      }
      
      public function set bottom(param1:Number) : void
      {
         _bottom = param1;
         layOutEabled = true;
      }
      
      public function get left() : Number
      {
         return _left;
      }
      
      public function set left(param1:Number) : void
      {
         _left = param1;
         layOutEabled = true;
      }
      
      public function get right() : Number
      {
         return _right;
      }
      
      public function set right(param1:Number) : void
      {
         _right = param1;
         layOutEabled = true;
      }
      
      public function get centerX() : Number
      {
         return _centerX;
      }
      
      public function set centerX(param1:Number) : void
      {
         _centerX = param1;
         layOutEabled = true;
      }
      
      public function get centerY() : Number
      {
         return _centerY;
      }
      
      public function set centerY(param1:Number) : void
      {
         _centerY = param1;
         layOutEabled = true;
      }
      
      private function set layOutEabled(param1:Boolean) : void
      {
         if(_layOutEabled != param1)
         {
            _layOutEabled = param1;
            addEventListener("added",onAdded);
            addEventListener("removed",onRemoved);
         }
         resetPosition();
      }
      
      private function onRemoved(param1:Event) : void
      {
         if(param1.target == this)
         {
            parent.removeEventListener("resize",onResize);
         }
      }
      
      private function onAdded(param1:Event) : void
      {
         if(param1.target == this)
         {
            parent.addEventListener("resize",onResize);
            resetPosition();
         }
      }
      
      private function onResize(param1:Event) : void
      {
         resetPosition();
      }
      
      protected function resetPosition() : void
      {
         if(parent)
         {
            if(!isNaN(_centerX))
            {
               x = (parent.width - displayWidth) * 0.5 + _centerX;
            }
            else if(!isNaN(_left))
            {
               x = _left;
               if(!isNaN(_right))
               {
                  width = (parent.width - _left - _right) / scaleX;
               }
            }
            else if(!isNaN(_right))
            {
               x = parent.width - displayWidth - _right;
            }
            if(!isNaN(_centerY))
            {
               y = (parent.height - displayHeight) * 0.5 + _centerY;
            }
            else if(!isNaN(_top))
            {
               y = _top;
               if(!isNaN(_bottom))
               {
                  height = (parent.height - _top - _bottom) / scaleY;
               }
            }
            else if(!isNaN(_bottom))
            {
               y = parent.height - displayHeight - _bottom;
            }
         }
      }
      
      override public function dispose() : void
      {
         super.dispose();
         if(_border)
         {
            _border.removeFromParent(true);
         }
         _border = null;
      }
   }
}
