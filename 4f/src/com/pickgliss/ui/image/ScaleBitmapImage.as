package com.pickgliss.ui.image
{
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.BitmapData;
   import org.bytearray.display.ScaleBitmap;
   
   public class ScaleBitmapImage extends Image
   {
       
      
      private var _resource:BitmapData;
      
      public function ScaleBitmapImage(){super();}
      
      public function set resource(param1:BitmapData) : void{}
      
      public function get resource() : BitmapData{return null;}
      
      override protected function resetDisplay() : void{}
   }
}
