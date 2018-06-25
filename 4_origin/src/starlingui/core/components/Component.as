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
      
      public function setPosition(x:Number, y:Number) : void
      {
         this.x = x;
         this.y = y;
      }
      
      override public function set x(value:Number) : void
      {
         .super.x = value;
         dispatchEvent(new UIEvent("move"));
      }
      
      override public function set y(value:Number) : void
      {
         .super.y = value;
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
         var i:int = 0;
         var comp:* = null;
         commitMeasure();
         var max:* = 0;
         for(i = numChildren - 1; i > -1; )
         {
            comp = getChildAt(i);
            if(comp.visible)
            {
               max = Number(Math.max(comp.x + comp.width * comp.scaleX,max));
            }
            i--;
         }
         return max;
      }
      
      override public function set width(value:Number) : void
      {
         if(_width != value)
         {
            _width = value;
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
         var i:int = 0;
         var comp:* = null;
         commitMeasure();
         var max:* = 0;
         for(i = numChildren - 1; i > -1; )
         {
            comp = getChildAt(i);
            if(comp.visible)
            {
               max = Number(Math.max(comp.y + comp.height * comp.scaleY,max));
            }
            i--;
         }
         return max;
      }
      
      override public function set height(value:Number) : void
      {
         if(_height != value)
         {
            _height = value;
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
      
      override public function set scaleX(value:Number) : void
      {
         .super.scaleX = value;
         changeSize();
      }
      
      override public function set scaleY(value:Number) : void
      {
         .super.scaleY = value;
         changeSize();
      }
      
      public function commitMeasure() : void
      {
      }
      
      protected function changeSize() : void
      {
         dispatchEvent(new Event("resize"));
      }
      
      public function setSize(width:Number, height:Number) : void
      {
         this.width = width;
         this.height = height;
      }
      
      public function set scale(value:Number) : void
      {
         scaleY = value;
         scaleX = value;
      }
      
      public function get scale() : Number
      {
         return scaleX;
      }
      
      public function get disabled() : Boolean
      {
         return _disabled;
      }
      
      public function set disabled(value:Boolean) : void
      {
         if(_disabled != value)
         {
            _disabled = value;
            touchable = !value;
         }
      }
      
      public function get tag() : Object
      {
         return _tag;
      }
      
      public function set tag(value:Object) : void
      {
         _tag = value;
      }
      
      public function showBorder(color:uint = 16711680) : void
      {
         _border = _border || new Shape();
         _border.graphics.clear();
         _border.graphics.lineStyle(1,color);
         _border.graphics.drawRect(0,0,width,height);
         addChild(_border);
      }
      
      public function get comXml() : XML
      {
         return _comXml;
      }
      
      public function set comXml(value:XML) : void
      {
         _comXml = value;
      }
      
      public function get dataSource() : Object
      {
         return _dataSource;
      }
      
      public function set dataSource(value:Object) : void
      {
         _dataSource = value;
         var _loc4_:int = 0;
         var _loc3_:* = _dataSource;
         for(var prop in _dataSource)
         {
            if(hasOwnProperty(prop))
            {
               this[prop] = _dataSource[prop];
            }
         }
      }
      
      public function get top() : Number
      {
         return _top;
      }
      
      public function set top(value:Number) : void
      {
         _top = value;
         layOutEabled = true;
      }
      
      public function get bottom() : Number
      {
         return _bottom;
      }
      
      public function set bottom(value:Number) : void
      {
         _bottom = value;
         layOutEabled = true;
      }
      
      public function get left() : Number
      {
         return _left;
      }
      
      public function set left(value:Number) : void
      {
         _left = value;
         layOutEabled = true;
      }
      
      public function get right() : Number
      {
         return _right;
      }
      
      public function set right(value:Number) : void
      {
         _right = value;
         layOutEabled = true;
      }
      
      public function get centerX() : Number
      {
         return _centerX;
      }
      
      public function set centerX(value:Number) : void
      {
         _centerX = value;
         layOutEabled = true;
      }
      
      public function get centerY() : Number
      {
         return _centerY;
      }
      
      public function set centerY(value:Number) : void
      {
         _centerY = value;
         layOutEabled = true;
      }
      
      private function set layOutEabled(value:Boolean) : void
      {
         if(_layOutEabled != value)
         {
            _layOutEabled = value;
            addEventListener("added",onAdded);
            addEventListener("removed",onRemoved);
         }
         resetPosition();
      }
      
      private function onRemoved(e:Event) : void
      {
         if(e.target == this)
         {
            parent.removeEventListener("resize",onResize);
         }
      }
      
      private function onAdded(e:Event) : void
      {
         if(e.target == this)
         {
            parent.addEventListener("resize",onResize);
            resetPosition();
         }
      }
      
      private function onResize(e:Event) : void
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
