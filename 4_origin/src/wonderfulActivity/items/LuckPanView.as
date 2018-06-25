package wonderfulActivity.items
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import roulette.LeftGunRouletteManager;
   import wonderfulActivity.views.IRightView;
   
   public class LuckPanView extends Sprite implements IRightView
   {
       
      
      private var _btn:SimpleBitmapButton;
      
      public function LuckPanView()
      {
         super();
      }
      
      public function setState(type:int, id:int) : void
      {
      }
      
      public function init() : void
      {
         var back:Bitmap = ComponentFactory.Instance.creat("wonderfulactivity.zhuanpan.back");
         addChild(back);
         LeftGunRouletteManager.instance.createFrame(this);
      }
      
      public function content() : Sprite
      {
         return this;
      }
      
      public function dispose() : void
      {
         while(this.numChildren)
         {
            ObjectUtils.disposeObject(this.getChildAt(0));
         }
         if(parent)
         {
            ObjectUtils.disposeObject(this);
         }
      }
   }
}
