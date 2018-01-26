package com.pickgliss.ui.image
{
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.BitmapData;
   import flash.geom.Matrix;
   
   public class CloneImage extends Image
   {
      
      public static const P_direction:String = "direction";
      
      public static const P_gape:String = "gape";
       
      
      protected var _brush:BitmapData;
      
      protected var _direction:int = -1;
      
      protected var _gape:int = 0;
      
      private var _brushHeight:Number;
      
      private var _brushWidth:Number;
      
      public function CloneImage(){super();}
      
      public function set direction(param1:int) : void{}
      
      override public function dispose() : void{}
      
      public function set gape(param1:int) : void{}
      
      override protected function resetDisplay() : void{}
      
      override protected function updateSize() : void{}
   }
}
