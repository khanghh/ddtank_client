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
      
      override protected function onMouseOver(evt:MouseEvent) : void
      {
         if(open && !locked)
         {
            this.filters = ComponentFactory.Instance.creatFilters("lightFilter");
         }
      }
      
      override protected function updateSize(sp:Sprite) : void
      {
         if(sp)
         {
            sp.height = _contentHeight;
            sp.width = _contentWidth;
            sp.x = 7;
            sp.y = 6;
         }
      }
   }
}
