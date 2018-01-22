package morn.core.components
{
   public class HScrollBar extends ScrollBar
   {
       
      
      public function HScrollBar(param1:String = null)
      {
         super(param1);
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         _slider.direction = HORIZONTAL;
      }
   }
}
