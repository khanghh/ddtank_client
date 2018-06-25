package cityBattle.view
{
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   
   public class NumberBitmap extends Sprite implements Disposeable
   {
       
      
      private var _box:Sprite;
      
      public function NumberBitmap()
      {
         super();
         _box = new Sprite();
         addChild(_box);
         var mc:MovieClip = ClassUtils.CreatInstance("asset.cityBattle.Number");
         addChild(mc);
      }
      
      public function dispose() : void
      {
         while(numChildren)
         {
            ObjectUtils.disposeObject(getChildAt(0));
         }
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
