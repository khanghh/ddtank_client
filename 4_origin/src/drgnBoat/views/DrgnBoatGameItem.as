package drgnBoat.views
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   
   public class DrgnBoatGameItem extends Sprite implements Disposeable
   {
       
      
      private var _itemMc:MovieClip;
      
      public function DrgnBoatGameItem(index:int, type:int, posX:int)
      {
         super();
         this.x = 280 + posX;
         var t:int = index >= 2?index + 1:index;
         this.y = 195 + 75 * t;
         _itemMc = ComponentFactory.Instance.creat("drgnBoat.itemMc" + type);
         _itemMc.gotoAndStop(1);
         addChild(_itemMc);
      }
      
      public function dispose() : void
      {
         if(_itemMc)
         {
            _itemMc.gotoAndStop(2);
            removeChild(_itemMc);
         }
         _itemMc = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
