package com.pickgliss.ui.image
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import flash.geom.Rectangle;
   
   public class Image extends Component
   {
      
      public static const BITMAP_IMAGE:int = 1;
      
      public static const COMPONENT_IMAGE:int = 0;
      
      public static const P_frameFilters:String = "frameFilters";
      
      public static const P_reourceLink:String = "resourceLink";
      
      public static const P_scale9Grid:String = "scale9Grid";
       
      
      protected var _display:DisplayObject;
      
      protected var _filterString:String;
      
      protected var _frameFilter:Array;
      
      protected var _resourceLink:String;
      
      protected var _scaleGridArgs:Array;
      
      protected var _scaleGridString:String;
      
      public function Image()
      {
         super();
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_display);
         _display = null;
         _frameFilter = null;
         super.dispose();
      }
      
      public function set filterString(param1:String) : void
      {
         if(_filterString == param1)
         {
            return;
         }
         _filterString = param1;
         frameFilters = ComponentFactory.Instance.creatFrameFilters(_filterString);
      }
      
      public function set frameFilters(param1:Array) : void
      {
         if(_frameFilter == param1)
         {
            return;
         }
         _frameFilter = param1;
         onPropertiesChanged("frameFilters");
      }
      
      public function get resourceLink() : String
      {
         return _resourceLink;
      }
      
      public function set resourceLink(param1:String) : void
      {
         if(param1 == _resourceLink)
         {
            return;
         }
         _resourceLink = param1;
         onPropertiesChanged("resourceLink");
      }
      
      public function get scaleGridString() : String
      {
         return _scaleGridString;
      }
      
      public function set scaleGridString(param1:String) : void
      {
         if(param1 == _scaleGridString)
         {
            return;
         }
         _scaleGridString = param1;
         _scaleGridArgs = ComponentFactory.parasArgs(_scaleGridString);
         onPropertiesChanged("scale9Grid");
      }
      
      public function setFrame(param1:int) : void
      {
         if(_frameFilter == null || param1 <= 0 || param1 > _frameFilter.length)
         {
            return;
         }
         filters = _frameFilter[param1 - 1];
      }
      
      override protected function addChildren() : void
      {
         if(_display)
         {
            addChild(_display);
         }
      }
      
      public function get display() : DisplayObject
      {
         return _display;
      }
      
      override protected function onProppertiesUpdate() : void
      {
         super.onProppertiesUpdate();
         if(_changedPropeties["resourceLink"])
         {
            resetDisplay();
         }
         updateSize();
         if(_changedPropeties["scale9Grid"])
         {
            updateScale9Grid();
         }
         if(_changedPropeties["frameFilters"] || _changedPropeties["resourceLink"])
         {
            setFilters();
         }
      }
      
      protected function resetDisplay() : void
      {
         if(_display)
         {
            removeChild(_display);
         }
         _display = ComponentFactory.Instance.creat(_resourceLink);
         _width = _display.width;
         _height = _display.height;
         _changedPropeties["height"] = true;
         _changedPropeties["width"] = true;
      }
      
      protected function setFilters() : void
      {
         if(_frameFilter && _display)
         {
            _display.filters = _frameFilter[0];
         }
      }
      
      protected function updateScale9Grid() : void
      {
         var _loc1_:Rectangle = new Rectangle(0,0,_display.width,_display.height);
         _loc1_.left = _scaleGridArgs[0];
         _loc1_.top = _scaleGridArgs[1];
         _loc1_.right = _scaleGridArgs[2];
         _loc1_.bottom = _scaleGridArgs[3];
         _display.scale9Grid = _loc1_;
      }
      
      protected function updateSize() : void
      {
         if(_changedPropeties["width"])
         {
            _display.width = _width;
         }
         if(_changedPropeties["height"])
         {
            _display.height = _height;
         }
      }
   }
}
