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
   
   [Event(name="hideTip",type="morn.core.events.UIEvent")]
   [Event(name="showTip",type="morn.core.events.UIEvent")]
   [Event(name="move",type="morn.core.events.UIEvent")]
   [Event(name="resize",type="flash.events.Event")]
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
      
      protected var _changeCount:int = 0;
      
      protected var _tipData:Object;
      
      protected var _tipDirctions:String = "4,5,6,7,0,1,2,3";
      
      protected var _tipGapV:int;
      
      protected var _tipGapH:int;
      
      protected var _tipStyle:String;
      
      protected var _changedPropeties:Dictionary;
      
      public function Component()
      {
         this._changedPropeties = new Dictionary();
         super();
         this.mouseChildren = tabEnabled = tabChildren = false;
         this.preinitialize();
         this.createChildren();
         this.initialize();
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
      
      public function callLater(param1:Function, param2:Array = null) : void
      {
         var _loc3_:Array = [this];
         if(param2 && param2.length > 0)
         {
            _loc3_ = _loc3_.concat(param2);
         }
         App.render.callLater(param1,_loc3_);
      }
      
      public function exeCallLater(param1:Function) : void
      {
         App.render.exeCallLater(param1);
      }
      
      public function sendEvent(param1:String, param2:* = null) : void
      {
         if(hasEventListener(param1))
         {
            dispatchEvent(new UIEvent(param1,param2));
         }
      }
      
      public function remove() : void
      {
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      public function removeChildByName(param1:String) : void
      {
         var _loc2_:DisplayObject = getChildByName(param1);
         if(_loc2_)
         {
            removeChild(_loc2_);
         }
      }
      
      public function setPosition(param1:Number, param2:Number) : void
      {
         this.x = param1;
         this.y = param2;
      }
      
      override public function set x(param1:Number) : void
      {
         super.x = param1;
         this.callLater(this.sendEvent,[UIEvent.MOVE]);
      }
      
      override public function set y(param1:Number) : void
      {
         super.y = param1;
         this.callLater(this.sendEvent,[UIEvent.MOVE]);
      }
      
      override public function get width() : Number
      {
         this.exeCallLater(this.resetPosition);
         if(!isNaN(this._width))
         {
            return this._width;
         }
         if(this._contentWidth != 0)
         {
            return this._contentWidth;
         }
         return this.measureWidth;
      }
      
      public function get displayWidth() : Number
      {
         return this.width * scaleX;
      }
      
      protected function get measureWidth() : Number
      {
         var _loc3_:DisplayObject = null;
         this.commitMeasure();
         var _loc1_:* = 0;
         var _loc2_:int = numChildren - 1;
         while(_loc2_ > -1)
         {
            _loc3_ = getChildAt(_loc2_);
            if(_loc3_.visible)
            {
               _loc1_ = Number(Math.max(_loc3_.x + _loc3_.width * _loc3_.scaleX,_loc1_));
            }
            _loc2_--;
         }
         return _loc1_;
      }
      
      override public function set width(param1:Number) : void
      {
         if(this._width != param1)
         {
            this._width = param1;
            this.callLater(this.changeSize);
            if(this._layOutEabled)
            {
               this.callLater(this.resetPosition);
            }
         }
      }
      
      override public function get height() : Number
      {
         this.exeCallLater(this.resetPosition);
         if(!isNaN(this._height))
         {
            return this._height;
         }
         if(this._contentHeight != 0)
         {
            return this._contentHeight;
         }
         return this.measureHeight;
      }
      
      public function get displayHeight() : Number
      {
         return this.height * scaleY;
      }
      
      protected function get measureHeight() : Number
      {
         var _loc3_:DisplayObject = null;
         this.commitMeasure();
         var _loc1_:* = 0;
         var _loc2_:int = numChildren - 1;
         while(_loc2_ > -1)
         {
            _loc3_ = getChildAt(_loc2_);
            if(_loc3_.visible)
            {
               _loc1_ = Number(Math.max(_loc3_.y + _loc3_.height * _loc3_.scaleY,_loc1_));
            }
            _loc2_--;
         }
         return _loc1_;
      }
      
      override public function set height(param1:Number) : void
      {
         if(this._height != param1)
         {
            this._height = param1;
            this.callLater(this.changeSize);
            if(this._layOutEabled)
            {
               this.callLater(this.resetPosition);
            }
         }
      }
      
      override public function get x() : Number
      {
         this.exeCallLater(this.resetPosition);
         return super.x;
      }
      
      override public function get y() : Number
      {
         this.exeCallLater(this.resetPosition);
         return super.y;
      }
      
      override public function set scaleX(param1:Number) : void
      {
         super.scaleX = param1;
         this.callLater(this.changeSize);
      }
      
      override public function set scaleY(param1:Number) : void
      {
         super.scaleY = param1;
         this.callLater(this.changeSize);
      }
      
      public function commitMeasure() : void
      {
      }
      
      protected function changeSize() : void
      {
         this.sendEvent(Event.RESIZE);
      }
      
      public function setSize(param1:Number, param2:Number) : void
      {
         this.width = param1;
         this.height = param2;
      }
      
      public function set scale(param1:Number) : void
      {
         this.scaleX = this.scaleY = param1;
      }
      
      public function get scale() : Number
      {
         return scaleX;
      }
      
      public function get disabled() : Boolean
      {
         return this._disabled;
      }
      
      public function set disabled(param1:Boolean) : void
      {
         if(this._disabled != param1)
         {
            this._disabled = param1;
            mouseEnabled = !param1;
            super.mouseChildren = !!param1?false:Boolean(this._mouseChildren);
            ObjectUtils.gray(this,this._disabled);
         }
      }
      
      override public function set mouseChildren(param1:Boolean) : void
      {
         this._mouseChildren = super.mouseChildren = param1;
      }
      
      public function get tag() : Object
      {
         return this._tag;
      }
      
      public function set tag(param1:Object) : void
      {
         this._tag = param1;
      }
      
      public function showBorder(param1:uint = 16711680) : void
      {
         this.removeChildByName("border");
         var _loc2_:Shape = new Shape();
         _loc2_.name = "border";
         _loc2_.graphics.lineStyle(1,param1);
         _loc2_.graphics.drawRect(0,0,this.width,this.height);
         this.addChild(_loc2_);
      }
      
      public function get comXml() : XML
      {
         return this._comXml;
      }
      
      public function set comXml(param1:XML) : void
      {
         this._comXml = param1;
      }
      
      public function get comJSON() : Object
      {
         return this._comJSON;
      }
      
      public function set comJSON(param1:Object) : void
      {
         this._comJSON = param1;
      }
      
      public function get dataSource() : Object
      {
         return this._dataSource;
      }
      
      public function set dataSource(param1:Object) : void
      {
         var _loc2_:* = null;
         this._dataSource = param1;
         for(_loc2_ in this._dataSource)
         {
            if(hasOwnProperty(_loc2_))
            {
               this[_loc2_] = this._dataSource[_loc2_];
            }
         }
      }
      
      public function get toolTip() : Object
      {
         return this._toolTip;
      }
      
      public function set toolTip(param1:Object) : void
      {
         if(this._toolTip != param1)
         {
            this._toolTip = param1;
            this.tipData = param1;
         }
      }
      
      private function onRollMouse(param1:MouseEvent) : void
      {
         if(param1.type == MouseEvent.ROLL_OVER)
         {
            this.draw();
         }
      }
      
      public function get top() : Number
      {
         return this._top;
      }
      
      public function set top(param1:Number) : void
      {
         this._top = param1;
         this.layOutEabled = true;
      }
      
      public function get bottom() : Number
      {
         return this._bottom;
      }
      
      public function set bottom(param1:Number) : void
      {
         this._bottom = param1;
         this.layOutEabled = true;
      }
      
      public function get left() : Number
      {
         return this._left;
      }
      
      public function set left(param1:Number) : void
      {
         this._left = param1;
         this.layOutEabled = true;
      }
      
      public function get right() : Number
      {
         return this._right;
      }
      
      public function set right(param1:Number) : void
      {
         this._right = param1;
         this.layOutEabled = true;
      }
      
      public function get centerX() : Number
      {
         return this._centerX;
      }
      
      public function set centerX(param1:Number) : void
      {
         this._centerX = param1;
         this.layOutEabled = true;
      }
      
      public function get centerY() : Number
      {
         return this._centerY;
      }
      
      public function set centerY(param1:Number) : void
      {
         this._centerY = param1;
         this.layOutEabled = true;
      }
      
      private function set layOutEabled(param1:Boolean) : void
      {
         if(this._layOutEabled != param1)
         {
            this._layOutEabled = param1;
            addEventListener(Event.ADDED,this.onAdded);
            addEventListener(Event.REMOVED,this.onRemoved);
         }
         this.callLater(this.resetPosition);
      }
      
      private function onRemoved(param1:Event) : void
      {
         if(param1.target == this)
         {
            parent.removeEventListener(Event.RESIZE,this.onResize);
         }
      }
      
      private function onAdded(param1:Event) : void
      {
         if(param1.target == this)
         {
            parent.addEventListener(Event.RESIZE,this.onResize);
            this.callLater(this.resetPosition);
         }
      }
      
      private function onResize(param1:Event) : void
      {
         this.callLater(this.resetPosition);
      }
      
      protected function resetPosition() : void
      {
         if(parent)
         {
            if(!isNaN(this._centerX))
            {
               this.x = (parent.width - this.displayWidth) * 0.5 + this._centerX;
            }
            else if(!isNaN(this._left))
            {
               this.x = this._left;
               if(!isNaN(this._right))
               {
                  this.width = (parent.width - this._left - this._right) / scaleX;
               }
            }
            else if(!isNaN(this._right))
            {
               this.x = parent.width - this.displayWidth - this._right;
            }
            if(!isNaN(this._centerY))
            {
               this.y = (parent.height - this.displayHeight) * 0.5 + this._centerY;
            }
            else if(!isNaN(this._top))
            {
               this.y = this._top;
               if(!isNaN(this._bottom))
               {
                  this.height = (parent.height - this._top - this._bottom) / scaleY;
               }
            }
            else if(!isNaN(this._bottom))
            {
               this.y = parent.height - this.displayHeight - this._bottom;
            }
         }
      }
      
      override public function set doubleClickEnabled(param1:Boolean) : void
      {
         var _loc3_:InteractiveObject = null;
         super.doubleClickEnabled = param1;
         var _loc2_:int = numChildren - 1;
         while(_loc2_ > -1)
         {
            _loc3_ = getChildAt(_loc2_) as InteractiveObject;
            if(_loc3_)
            {
               _loc3_.doubleClickEnabled = param1;
            }
            _loc2_--;
         }
      }
      
      override public function addChild(param1:DisplayObject) : DisplayObject
      {
         if(doubleClickEnabled && param1 is InteractiveObject)
         {
            InteractiveObject(param1).doubleClickEnabled = true;
         }
         return super.addChild(param1);
      }
      
      override public function addChildAt(param1:DisplayObject, param2:int) : DisplayObject
      {
         if(doubleClickEnabled && param1 is InteractiveObject)
         {
            InteractiveObject(param1).doubleClickEnabled = true;
         }
         return super.addChildAt(param1,param2);
      }
      
      public function get tipData() : Object
      {
         return this._tipData;
      }
      
      public function set tipData(param1:Object) : void
      {
         if(this._tipData == param1)
         {
            return;
         }
         this._tipData = param1;
         this.onPropertiesChanged(P_tipData);
      }
      
      public function get tipDirctions() : String
      {
         return this._tipDirctions;
      }
      
      public function set tipDirctions(param1:String) : void
      {
         if(this._tipDirctions == param1)
         {
            return;
         }
         this._tipDirctions = param1;
         this.onPropertiesChanged(P_tipDirction);
      }
      
      public function get tipGapV() : int
      {
         return this._tipGapV;
      }
      
      public function set tipGapV(param1:int) : void
      {
         if(this._tipGapV == param1)
         {
            return;
         }
         this._tipGapV = param1;
         this.onPropertiesChanged(P_tipGap);
      }
      
      public function get tipGapH() : int
      {
         return this._tipGapH;
      }
      
      public function set tipGapH(param1:int) : void
      {
         if(this._tipGapH == param1)
         {
            return;
         }
         this._tipGapH = param1;
         this.onPropertiesChanged(P_tipGap);
      }
      
      public function get tipStyle() : String
      {
         return this._tipStyle;
      }
      
      public function set tipStyle(param1:String) : void
      {
         if(this._tipStyle == param1)
         {
            return;
         }
         this._tipStyle = param1;
         this.onPropertiesChanged(P_tipStyle);
      }
      
      protected function onPropertiesChanged(param1:String = null) : void
      {
         if(this._changedPropeties[param1])
         {
            return;
         }
         if(param1 != null)
         {
            this._changedPropeties[param1] = true;
         }
         this.invalidate();
      }
      
      protected function invalidate() : void
      {
         if(this._changeCount <= 0)
         {
            this._changeCount = 0;
            this.draw();
         }
      }
      
      public function draw() : void
      {
         this.onProppertiesUpdate();
         this._changedPropeties = new Dictionary(true);
      }
      
      protected function onProppertiesUpdate() : void
      {
         if(this._changedPropeties)
         {
            if(this._changedPropeties[P_tipDirction] || this._changedPropeties[P_tipGap] || this._changedPropeties[P_tipStyle] || this._changedPropeties[P_tipData])
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
         return this._tipWidth;
      }
      
      public function set tipWidth(param1:int) : void
      {
         if(this._tipWidth != param1)
         {
            this._tipWidth = param1;
            this.updateTransform();
         }
      }
      
      public function get tipHeight() : int
      {
         return this._tipHeight;
      }
      
      public function set tipHeight(param1:int) : void
      {
         if(this._tipHeight != param1)
         {
            this._tipHeight = param1;
            this.updateTransform();
         }
      }
      
      protected function updateTransform() : void
      {
      }
      
      public function get disposeHandler() : Handler
      {
         return this._disposeHandler;
      }
      
      public function set disposeHandler(param1:Handler) : void
      {
         this._disposeHandler = param1;
      }
      
      public function dispose() : void
      {
         ShowTipManager.Instance.removeTip(this);
         App.render.removeCallLaterByObj(this);
         this._tag = null;
         this._comXml = null;
         this._comJSON = null;
         this._dataSource = null;
         this._toolTip = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
         if(this._disposeHandler)
         {
            this._disposeHandler.execute();
         }
         this._disposeHandler = null;
      }
   }
}
