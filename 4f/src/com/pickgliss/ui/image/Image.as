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
      
      public function Image(){super();}
      
      override public function dispose() : void{}
      
      public function set filterString(param1:String) : void{}
      
      public function set frameFilters(param1:Array) : void{}
      
      public function get resourceLink() : String{return null;}
      
      public function set resourceLink(param1:String) : void{}
      
      public function get scaleGridString() : String{return null;}
      
      public function set scaleGridString(param1:String) : void{}
      
      public function setFrame(param1:int) : void{}
      
      override protected function addChildren() : void{}
      
      public function get display() : DisplayObject{return null;}
      
      override protected function onProppertiesUpdate() : void{}
      
      protected function resetDisplay() : void{}
      
      protected function setFilters() : void{}
      
      protected function updateScale9Grid() : void{}
      
      protected function updateSize() : void{}
   }
}
