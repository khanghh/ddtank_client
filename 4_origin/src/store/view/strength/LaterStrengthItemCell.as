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
       
      
      public function LaterStrengthItemCell(param1:int)
      {
         var _loc2_:Sprite = new Sprite();
         var _loc3_:Bitmap = ComponentFactory.Instance.creatBitmap("asset.ddtstore.EquipCellBG");
         _loc2_.addChild(_loc3_);
         super(_loc2_,param1);
         setContentSize(68,68);
         this.PicPos = new Point(-4,-2);
      }
      
      override protected function __clickHandler(param1:InteractiveEvent) : void
      {
      }
      
      override protected function __doubleClickHandler(param1:InteractiveEvent) : void
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
