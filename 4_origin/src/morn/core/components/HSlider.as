package morn.core.components
{
   public class HSlider extends Slider
   {
       
      
      public function HSlider(param1:String = null)
      {
         super(param1);
      }
      
      override protected function preinitialize() : void
      {
         super.preinitialize();
         direction = HORIZONTAL;
      }
   }
}
