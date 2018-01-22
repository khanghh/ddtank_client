package cardSystem.view
{
   import cardSystem.elements.CardCell;
   import com.pickgliss.ui.ComponentFactory;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class ResetCardCell extends CardCell
   {
       
      
      public function ResetCardCell()
      {
         super(ComponentFactory.Instance.creatBitmap("asset.cardSystem.reset.CardBack"),-1,null,false,false);
         setContentSize(100,144);
      }
      
      override protected function onMouseOver(param1:MouseEvent) : void
      {
         if(open && !locked)
         {
            this.filters = ComponentFactory.Instance.creatFilters("lightFilter");
         }
      }
      
      override protected function updateSize(param1:Sprite) : void
      {
         if(param1)
         {
            param1.height = _contentHeight;
            param1.width = _contentWidth;
            param1.x = 7;
            param1.y = 6;
         }
      }
   }
}
