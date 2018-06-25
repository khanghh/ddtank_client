package morn.core.components
{
   import com.pickgliss.ui.ShowTipManager;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.core.ITipedDisplay;
   import com.pickgliss.ui.tip.ITip;
   import flash.display.DisplayObject;
   import flash.display.InteractiveObject;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import morn.core.events.UIEvent;
   import morn.core.handlers.Handler;
   import morn.core.utils.ObjectUtils;
   import morn.editor.core.IComponent;
   
   [Event(name="resize",type="flash.events.Event")]
   [Event(name="move",type="morn.core.events.UIEvent")]
   [Event(name="showTip",type="morn.core.events.UIEvent")]
   [Event(name="hideTip",type="morn.core.events.UIEvent")]
   public class Component extends Sprite implements IComponent, Disposeable, ITipedDisplay, ITip
   {
      
      public static const P_height:String = "height";
      
      public static const P_tipData:String = "tipData";
      
      public static const P_tipDirction:String = "tipDirction";
      
      public static const P_tipGap:String = "tipGap";
      
      public static const P_tipStyle:String = "tipStyle";
      
      public static const P_width:String = "width";
       
      
      protected var _width:Number;
      
      protected var _height:Number;
      
      protected var _contentWidth:Number = 0;
      
      protected var _contentHeight:Number = 0;
      
      protected var _disabled:Boolean;
      
      protected var _tag:Object;
      
      protected var _comXml:XML;
      
      protected var _comJSON:Object;
      
      protected var _dataSource:Object;
      
      protected var _toolTip:Object;
      
      protected var _mouseChildren:Boolean;
      
      protected var _top:Number;
      
      protected var _bottom:Number;
      
      protected var _left:Number;
      
      protected var _right:Number;
      
      protected var _centerX:Number;
      
      protected var _centerY:Number;
      
      protected var _layOutEabled:Boolean;
      
      protected var _tipWidth:int;
      
      protected var _tipHeight:int;
      
      protected var _disposeHandler:Handler;
      
      protected var _stylename:String;
      
      protected var _changeCount:int = 0;
      
      protected var _tipData:Object;
      
      protected var _tipDirctions:String = "4,5,6,7,0,1,2,3";
      
      protected var _tipGapV:int;
      
      protected var _tipGapH:int;
      
      protected var _tipStyle:String;
      
      protected var _changedPropeties:Dictionary;
      
      public function Component()
      {
         _changedPropeties = new Dictionary();
         super();
         tabChildren = false;
         tabEnabled = false;
         mouseChildren = false;
         preinitialize();
         createChildren();
         initialize();
      }
      
      public function get stylename() : String
      {
         return _stylename;
      }
      
      public function set stylename(value:String) : void
      {
         _stylename = value;
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
      
      public function callLater(method:Function, args:Array = null) : void
      {
         var oargs:Array = [this];
         if(args && args.length > 0)
         {
            oargs = oargs.concat(args);
         }
         App.render.callLater(method,oargs);
      }
      
      public function exeCallLater(method:Function) : void
      {
         App.render.exeCallLater(method);
      }
      
      public function sendEvent(type:String, data:* = null) : void
      {
         if(hasEventListener(type))
         {
            dispatchEvent(new UIEvent(type,data));
         }
      }
      
      public function remove() : void
      {
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      public function removeChildByName(name:String) : void
      {
         var display:DisplayObject = getChildByName(name);
         if(display)
         {
            removeChild(display);
         }
      }
      
      public function setPosition(x:Number, y:Number) : void
      {
         this.x = x;
         this.y = y;
      }
      
      override public function set x(value:Number) : void
      {
         .super.x = value;
         callLater(sendEvent,["move"]);
      }
      
      override public function set y(value:Number) : void
      {
         .super.y = value;
         callLater(sendEvent,["move"]);
      }
      
      override public function get width() : Number
      {
         exeCallLater(resetPosition);
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
            callLater(changeSize);
            if(_layOutEabled)
            {
               callLater(resetPosition);
            }
         }
      }
      
      override public function get height() : Number
      {
         exeCallLater(resetPosition);
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
            callLater(changeSize);
            if(_layOutEabled)
            {
               callLater(resetPosition);
            }
         }
      }
      
      override public function get x() : Number
      {
         exeCallLater(resetPosition);
         return super.x;
      }
      
      override public function get y() : Number
      {
         exeCallLater(resetPosition);
         return super.y;
      }
      
      override public function set scaleX(value:Number) : void
      {
         .super.scaleX = value;
         callLater(changeSize);
      }
      
      override public function set scaleY(value:Number) : void
      {
         .super.scaleY = value;
         callLater(changeSize);
      }
      
      public function commitMeasure() : void
      {
      }
      
      protected function changeSize() : void
      {
         sendEvent("resize");
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
            mouseEnabled = !value;
            .super.mouseChildren = !!value?false:Boolean(_mouseChildren);
            ObjectUtils.gray(this,_disabled);
         }
      }
      
      override public function set mouseChildren(value:Boolean) : void
      {
         .super.mouseChildren = value;
         _mouseChildren = value;
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
         removeChildByName("border");
         var border:Shape = new Shape();
         border.name = "border";
         border.graphics.lineStyle(1,color);
         border.graphics.drawRect(0,0,width,height);
         addChild(border);
      }
      
      public function get comXml() : XML
      {
         return _comXml;
      }
      
      public function set comXml(value:XML) : void
      {
         _comXml = value;
      }
      
      public function get comJSON() : Object
      {
         return _comJSON;
      }
      
      public function set comJSON(value:Object) : void
      {
         _comJSON = value;
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
      
      public function get toolTip() : Object
      {
         return _toolTip;
      }
      
      public function set toolTip(value:Object) : void
      {
         if(_toolTip != value)
         {
            _toolTip = value;
            tipData = value;
         }
      }
      
      private function onRollMouse(e:MouseEvent) : void
      {
         if(e.type == "rollOver")
         {
            draw();
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
         callLater(resetPosition);
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
            callLater(resetPosition);
         }
      }
      
      private function onResize(e:Event) : void
      {
         callLater(resetPosition);
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
      
      override public function set doubleClickEnabled(value:Boolean) : void
      {
         var i:int = 0;
         var display:* = null;
         .super.doubleClickEnabled = value;
         for(i = numChildren - 1; i > -1; )
         {
            display = getChildAt(i) as InteractiveObject;
            if(display)
            {
               display.doubleClickEnabled = value;
            }
            i--;
         }
      }
      
      override public function addChild(child:DisplayObject) : DisplayObject
      {
         if(doubleClickEnabled && child is InteractiveObject)
         {
            InteractiveObject(child).doubleClickEnabled = true;
         }
         return super.addChild(child);
      }
      
      override public function addChildAt(child:DisplayObject, index:int) : DisplayObject
      {
         if(doubleClickEnabled && child is InteractiveObject)
         {
            InteractiveObject(child).doubleClickEnabled = true;
         }
         return super.addChildAt(child,index);
      }
      
      public function get tipData() : Object
      {
         return _tipData;
      }
      
      public function set tipData(value:Object) : void
      {
         if(_tipData == value)
         {
            return;
         }
         _tipData = value;
         onPropertiesChanged("tipData");
      }
      
      public function get tipDirctions() : String
      {
         return _tipDirctions;
      }
      
      public function set tipDirctions(value:String) : void
      {
         if(_tipDirctions == value)
         {
            return;
         }
         _tipDirctions = value;
         onPropertiesChanged("tipDirction");
      }
      
      public function get tipGapV() : int
      {
         return _tipGapV;
      }
      
      public function set tipGapV(value:int) : void
      {
         if(_tipGapV == value)
         {
            return;
         }
         _tipGapV = value;
         onPropertiesChanged("tipGap");
      }
      
      public function get tipGapH() : int
      {
         return _tipGapH;
      }
      
      public function set tipGapH(value:int) : void
      {
         if(_tipGapH == value)
         {
            return;
         }
         _tipGapH = value;
         onPropertiesChanged("tipGap");
      }
      
      public function get tipStyle() : String
      {
         return _tipStyle;
      }
      
      public function set tipStyle(value:String) : void
      {
         if(_tipStyle == value)
         {
            return;
         }
         _tipStyle = value;
         onPropertiesChanged("tipStyle");
      }
      
      protected function onPropertiesChanged(propName:String = null) : void
      {
         if(_changedPropeties[propName])
         {
            return;
         }
         if(propName != null)
         {
            _changedPropeties[propName] = true;
         }
         invalidate();
      }
      
      protected function invalidate() : void
      {
         if(_changeCount <= 0)
         {
            _changeCount = 0;
            draw();
         }
      }
      
      public function draw() : void
      {
         onProppertiesUpdate();
         _changedPropeties = new Dictionary(true);
      }
      
      protected function onProppertiesUpdate() : void
      {
         if(_changedPropeties)
         {
            if(_changedPropeties["tipDirction"] || _changedPropeties["tipGap"] || _changedPropeties["tipStyle"] || _changedPropeties["tipData"])
            {
               ShowTipManager.Instance.addTip(this);
            }
         }
      }
      
      public function asDisplayObject() : DisplayObject
      {
         return this;
      }
      
      public function get tipWidth() : int
      {
         return _tipWidth;
      }
      
      public function set tipWidth(w:int) : void
      {
         if(_tipWidth != w)
         {
            _tipWidth = w;
            updateTransform();
         }
      }
      
      public function get tipHeight() : int
      {
         return _tipHeight;
      }
      
      public function set tipHeight(h:int) : void
      {
         if(_tipHeight != h)
         {
            _tipHeight = h;
            updateTransform();
         }
      }
      
      protected function updateTransform() : void
      {
      }
      
      public function get disposeHandler() : Handler
      {
         return _disposeHandler;
      }
      
      public function set disposeHandler(value:Handler) : void
      {
         _disposeHandler = value;
      }
      
      public function dispose() : void
      {
         ShowTipManager.Instance.removeTip(this);
         App.render.removeCallLaterByObj(this);
         _tag = null;
         _comXml = null;
         _comJSON = null;
         _dataSource = null;
         _toolTip = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
         if(_disposeHandler)
         {
            _disposeHandler.execute();
         }
         _disposeHandler = null;
      }
   }
}
