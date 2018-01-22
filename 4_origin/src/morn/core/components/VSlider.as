package morn.core.components
{
   public class VSlider extends Slider
   {
       
      
      public function VSlider(param1:String = null)
      {
         super(param1);
      }
      
      override protected function preinitialize() : void
      {
         super.preinitialize();
         direction = VERTICAL;
      }
   }
}
