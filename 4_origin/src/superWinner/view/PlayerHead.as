package superWinner.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class PlayerHead extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      public function PlayerHead()
      {
         super();
         init();
      }
      
      private function init() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.game.smallplayer.back");
         addChild(_bg);
      }
      
      public function dispose() : void
      {
         ObjectUtils.removeChildAllChildren(this);
      }
   }
}
