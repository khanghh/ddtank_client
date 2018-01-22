package sevenDouble.player
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   
   public class SevenDoubleGameItem extends Sprite implements Disposeable
   {
       
      
      private var _itemMc:MovieClip;
      
      public function SevenDoubleGameItem(param1:int, param2:int, param3:int)
      {
         super();
         this.x = 280 + param3;
         this.y = 170 + 65 * param1;
         _itemMc = ComponentFactory.Instance.creat("asset.sevenDouble.itemMc" + param2);
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
