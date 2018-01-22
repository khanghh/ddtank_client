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
      
      public function getBitmapdata(param1:Boolean = false) : BitmapData
      {
         if(_bitmapdata == null || param1)
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
      
      override public function set height(param1:Number) : void
      {
         if(param1 == _height)
         {
            return;
         }
         _height = param1;
         onPropertiesChanged("height");
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function set id(param1:int) : void
      {
         _id = param1;
      }
      
      public function move(param1:Number, param2:Number) : void
      {
         x = param1;
         y = param2;
      }
      
      public function get tipData() : Object
      {
         return _tipData;
      }
      
      public function set tipData(param1:Object) : void
      {
         if(_tipData == param1)
         {
            return;
         }
         _tipData = param1;
         onPropertiesChanged("tipData");
      }
      
      public function get tipDirctions() : String
      {
         return _tipDirction;
      }
      
      public function set tipDirctions(param1:String) : void
      {
         if(_tipDirction == param1)
         {
            return;
         }
         _tipDirction = param1;
         onPropertiesChanged("tipDirction");
      }
      
      public function get tipGapV() : int
      {
         return _tipGapV;
      }
      
      public function set tipGapV(param1:int) : void
      {
         if(_tipGapV == param1)
         {
            return;
         }
         _tipGapV = param1;
         onPropertiesChanged("tipGap");
      }
      
      public function get tipGapH() : int
      {
         return _tipGapH;
      }
      
      public function set tipGapH(param1:int) : void
      {
         if(_tipGapH == param1)
         {
            return;
         }
         _tipGapH = param1;
         onPropertiesChanged("tipGap");
      }
      
      public function get tipStyle() : String
      {
         return _tipStyle;
      }
      
      public function set tipStyle(param1:String) : void
      {
         if(_tipStyle == param1)
         {
            return;
         }
         _tipStyle = param1;
         onPropertiesChanged("tipStyle");
      }
      
      override public function get width() : Number
      {
         return _width;
      }
      
      override public function set width(param1:Number) : void
      {
         if(param1 == _width)
         {
            return;
         }
         _width = param1;
         onPropertiesChanged("width");
      }
      
      override public function set x(param1:Number) : void
      {
         .super.x = Math.round(param1);
         onPosChanged();
      }
      
      override public function set y(param1:Number) : void
      {
         .super.y = Math.round(param1);
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
      
      protected function onPropertiesChanged(param1:String = null) : void
      {
         if(_changedPropeties == null)
         {
            return;
         }
         if(_changedPropeties[param1])
         {
            return;
         }
         if(param1 != null)
         {
            _changedPropeties[param1] = true;
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
