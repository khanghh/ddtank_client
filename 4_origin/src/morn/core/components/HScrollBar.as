package morn.core.components
{
   public class HScrollBar extends ScrollBar
   {
       
      
      public function HScrollBar(skin:String = null)
      {
         super(skin);
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         _slider.direction = "horizontal";
      }
   }
}
