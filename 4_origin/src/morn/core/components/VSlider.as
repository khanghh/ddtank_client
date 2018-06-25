package morn.core.components
{
   public class VSlider extends Slider
   {
       
      
      public function VSlider(skin:String = null)
      {
         super(skin);
      }
      
      override protected function preinitialize() : void
      {
         super.preinitialize();
         direction = "vertical";
      }
   }
}
