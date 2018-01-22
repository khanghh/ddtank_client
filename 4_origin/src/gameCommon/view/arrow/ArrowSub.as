package gameCommon.view.arrow
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class ArrowSub extends Sprite implements Disposeable
   {
       
      
      private var _center:Bitmap;
      
      public var arrowChonghe_mc:Bitmap;
      
      public var arrow:Bitmap;
      
      public var arrowClone_mc:Bitmap;
      
      private var _halfRound:Bitmap;
      
      public var green_mc:Bitmap;
      
      public var circle_mc:Bitmap;
      
      public function ArrowSub()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         circle_mc = ComponentFactory.Instance.creatBitmap("asset.game.circleAsset");
         addChild(circle_mc);
         green_mc = ComponentFactory.Instance.creatBitmap("asset.game.greenAsset");
         addChild(green_mc);
         _halfRound = ComponentFactory.Instance.creatBitmap("asset.game.angle.halfround");
         addChild(_halfRound);
         arrowClone_mc = ComponentFactory.Instance.creatBitmap("asset.game.arrowCloneAsset");
         addChild(arrowClone_mc);
         arrow = ComponentFactory.Instance.creatBitmap("asset.game.handAsset");
         addChild(arrow);
         arrowChonghe_mc = ComponentFactory.Instance.creatBitmap("asset.game.chonghexianAsset");
         addChild(arrowChonghe_mc);
         _center = ComponentFactory.Instance.creatBitmap("asset.game.arrowCenterAsset");
         addChild(_center);
      }
      
      public function dispose() : void
      {
         removeChild(circle_mc);
         circle_mc.bitmapData.dispose();
         circle_mc = null;
         removeChild(green_mc);
         green_mc.bitmapData.dispose();
         green_mc = null;
         removeChild(_halfRound);
         _halfRound.bitmapData.dispose();
         _halfRound = null;
         removeChild(arrowClone_mc);
         arrowClone_mc.bitmapData.dispose();
         arrowClone_mc = null;
         removeChild(arrow);
         arrow.bitmapData.dispose();
         arrow = null;
         removeChild(arrowChonghe_mc);
         arrowChonghe_mc.bitmapData.dispose();
         arrowChonghe_mc = null;
         removeChild(_center);
         _center.bitmapData.dispose();
         _center = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
