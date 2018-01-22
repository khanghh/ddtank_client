package farm.player.vo
{
   import com.pickgliss.ui.ComponentFactory;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   
   public class GiftPacksTips extends Sprite
   {
       
      
      private var _btnBg:Bitmap;
      
      private var _tipMovie:MovieClip;
      
      public function GiftPacksTips()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         this.buttonMode = true;
         _btnBg = ComponentFactory.Instance.creatBitmap("asset.farm.midautumnpacks");
         addChild(_btnBg);
         _tipMovie = ComponentFactory.Instance.creat("asset.farm.midautumnanimation");
         PositionUtils.setPos(_tipMovie,"farm.midautumnanimation");
         addChild(_tipMovie);
      }
      
      public function dispose() : void
      {
         if(_btnBg)
         {
            _btnBg.bitmapData.dispose();
            _btnBg = null;
         }
      }
   }
}
