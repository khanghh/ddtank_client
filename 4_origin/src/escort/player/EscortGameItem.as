package escort.player
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   
   public class EscortGameItem extends Sprite implements Disposeable
   {
       
      
      private var _itemMc:MovieClip;
      
      public function EscortGameItem(index:int, type:int, posX:int)
      {
         super();
         this.x = 280 + posX;
         this.y = 170 + 65 * index;
         _itemMc = ComponentFactory.Instance.creat("asset.escort.itemMc" + type);
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
