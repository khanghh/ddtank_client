package mines.view
{
   import flash.display.Shape;
   import morn.core.components.Image;
   import morn.core.components.Label;
   import morn.core.components.ProgressBar;
   
   public class MinesProgress extends ProgressBar
   {
       
      
      public function MinesProgress(skin:String = null)
      {
         super(skin);
      }
      
      override protected function createChildren() : void
      {
         _bar = new Image();
         addChild(new Image());
         _bg = new Image();
         addChild(new Image());
         _mark = new Shape();
         addChild(new Shape());
         _barLabel = new Label();
         addChild(new Label());
      }
   }
}
