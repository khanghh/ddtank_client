package morn.core.components
{
   public class HSlider extends Slider
   {
       
      
      public function HSlider(skin:String = null)
      {
         super(skin);
      }
      
      override protected function preinitialize() : void
      {
         super.preinitialize();
         direction = "horizontal";
      }
   }
}
