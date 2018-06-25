package store.view.strength
{
   import com.pickgliss.events.InteractiveEvent;
   import com.pickgliss.ui.ComponentFactory;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.geom.Point;
   import store.StoreCell;
   
   public class LaterStrengthItemCell extends StoreCell
   {
       
      
      public function LaterStrengthItemCell($index:int)
      {
         var bg:Sprite = new Sprite();
         var bgBit:Bitmap = ComponentFactory.Instance.creatBitmap("asset.ddtstore.EquipCellBG");
         bg.addChild(bgBit);
         super(bg,$index);
         setContentSize(68,68);
         this.PicPos = new Point(-4,-2);
      }
      
      override protected function __clickHandler(evt:InteractiveEvent) : void
      {
      }
      
      override protected function __doubleClickHandler(evt:InteractiveEvent) : void
      {
      }
      
      override public function dispose() : void
      {
         super.dispose();
         removeEventListener("interactive_click",__clickHandler);
         removeEventListener("interactive_double_click",__doubleClickHandler);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
