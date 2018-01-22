package morn.core.components
{
   public class VScrollBar extends ScrollBar
   {
       
      
      public function VScrollBar(param1:String = null)
      {
         super(param1);
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         _slider.direction = VERTICAL;
      }
   }
}
