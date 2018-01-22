package com.pickgliss.ui.image
{
   import com.pickgliss.utils.ClassUtils;
   import flash.display.MovieClip;
   
   public class MovieImage extends Image
   {
       
      
      public function MovieImage(){super();}
      
      public function get movie() : MovieClip{return null;}
      
      override public function setFrame(param1:int) : void{}
      
      override protected function resetDisplay() : void{}
   }
}
