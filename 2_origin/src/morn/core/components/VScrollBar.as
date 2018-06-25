package morn.core.components
{
   public class VScrollBar extends ScrollBar
   {
       
      
      public function VScrollBar(skin:String = null)
      {
         super(skin);
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         _slider.direction = "vertical";
      }
   }
}
