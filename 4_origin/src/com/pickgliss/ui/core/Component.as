package com.pickgliss.ui.core
{
   import com.pickgliss.events.ComponentEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.ShowTipManager;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   
   [Event(name="propertiesChanged",type="com.pickgliss.events.ComponentEvent")]
   [Event(name="dispose",type="com.pickgliss.events.ComponentEvent")]
   public class Component extends Sprite implements Disposeable, ITipedDisplay
   {
      
      public static const P_height:String = "height";
      
      public static const P_tipData:String = "tipData";
      
      public static const P_tipDirction:String = "tipDirction";
      
      public static const P_tipGap:String = "tipGap";
      
      public static const P_tipStyle:String = "tipStyle";
      
      public static const P_width:String = "width";
       
      
      protected var _bitmapdata:BitmapData;
      
      protected var _changeCount:int = 0;
      
      protected var _changedPropeties:Dictionary;
      
      protected var _height:Number = 0;
      
      protected var _id:int = -1;
      
      protected var _tipData:Object;
      
      protected var _tipDirction:String;
      
      protected var _tipGapV:int;
      
      protected var _tipGapH:int;
      
      protected var _tipStyle:String;
      
      protected var _width:Number = 0;
      
      public var stylename:String;
      
      public function Component()
      {
         _changedPropeties = new Dictionary();
         super();
         init();
      }
      
      public function asDisplayObject() : DisplayObject
      {
         return this;
      }
      
      public function beginChanges() : void
      {
         _changeCount = Number(_changeCount) + 1;
      }
      
      public function commitChanges() : void
      {
         _changeCount = Number(_changeCount) - 1;
         invalidate();
      }
      
      public function getMousePosition() : Point
      {
         return new Point(mouseX,mouseY);
      }
      
      public function dispose() : void
      {
         _changedPropeties = null;
         ObjectUtils.disposeObject(_bitmapdata);
         if(parent)
         {
            parent.removeChild(this);
         }
         ShowTipManager.Instance.removeTip(this);
         ComponentFactory.Instance.removeComponent(_id);
         dispatchEvent(new ComponentEvent("dispose"));
      }
      
      public function draw() : void
      {
         onProppertiesUpdate();
         addChildren();
         dispatchEvent(new ComponentEvent("propertiesChanged",_changedPropeties));
         _changedPropeties = new Dictionary(true);
      }
      
      public function getBitmapdata(reflesh:Boolean = false) : BitmapData
      {
         if(_bitmapdata == null || reflesh)
         {
            ObjectUtils.disposeObject(_bitmapdata);
            _bitmapdata = new BitmapData(_width,_height,true,16711680);
            _bitmapdata.draw(this);
         }
         return _bitmapdata;
      }
      
      override public function get height() : Number
      {
         return _height;
      }
      
      override public function set height(h:Number) : void
      {
         if(h == _height)
         {
            return;
         }
         _height = h;
         onPropertiesChanged("height");
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function set id(value:int) : void
      {
         _id = value;
      }
      
      public function move(xpos:Number, ypos:Number) : void
      {
         x = xpos;
         y = ypos;
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
         return _tipDirction;
      }
      
      public function set tipDirctions(value:String) : void
      {
         if(_tipDirction == value)
         {
            return;
         }
         _tipDirction = value;
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
      
      override public function get width() : Number
      {
         return _width;
      }
      
      override public function set width(w:Number) : void
      {
         if(w == _width)
         {
            return;
         }
         _width = w;
         onPropertiesChanged("width");
      }
      
      override public function set x(value:Number) : void
      {
         .super.x = Math.round(value);
         onPosChanged();
      }
      
      override public function set y(value:Number) : void
      {
         .super.y = Math.round(value);
         onPosChanged();
      }
      
      protected function addChildren() : void
      {
      }
      
      protected function init() : void
      {
         addChildren();
      }
      
      protected function invalidate() : void
      {
         if(_changeCount <= 0)
         {
            _changeCount = 0;
            draw();
         }
      }
      
      protected function onPropertiesChanged(propName:String = null) : void
      {
         if(_changedPropeties == null)
         {
            return;
         }
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
      
      protected function onProppertiesUpdate() : void
      {
         if(_changedPropeties["tipDirction"] || _changedPropeties["tipGap"] || _changedPropeties["tipStyle"] || _changedPropeties["tipData"])
         {
            ShowTipManager.Instance.addTip(this);
         }
      }
      
      public function get displayWidth() : Number
      {
         return super.width;
      }
      
      public function get displayHeight() : Number
      {
         return super.height;
      }
      
      protected function onPosChanged() : void
      {
      }
   }
}
