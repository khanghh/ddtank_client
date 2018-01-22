package gameCommon.view.arrow
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class ArrowBg extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      public var arrowSub:ArrowSub;
      
      private var _ruling:Bitmap;
      
      public function ArrowBg()
      {
         super();
         _bg = ComponentFactory.Instance.creatBitmap("asset.game.angle.back");
         addChild(_bg);
         arrowSub = ComponentFactory.Instance.creatCustomObject("asset.game.arrowSub") as ArrowSub;
         addChild(arrowSub);
         _ruling = ComponentFactory.Instance.creatBitmap("asset.game.angle.dail");
         addChild(_ruling);
      }
      
      public function dispose() : void
      {
         removeChild(_bg);
         _bg.bitmapData.dispose();
         _bg = null;
         arrowSub.dispose();
         arrowSub = null;
         removeChild(_ruling);
         _ruling.bitmapData.dispose();
         _ruling = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
