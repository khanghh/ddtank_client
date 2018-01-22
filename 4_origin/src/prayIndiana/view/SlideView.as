package prayIndiana.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   
   public class SlideView extends Sprite
   {
       
      
      private var _slide:MovieClip;
      
      public function SlideView()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _slide = ComponentFactory.Instance.creat("prayIndiana.slide");
         addChild(_slide);
      }
      
      public function dispose() : void
      {
         if(_slide)
         {
            ObjectUtils.disposeObject(_slide);
         }
         _slide = null;
      }
      
      public function get slide() : MovieClip
      {
         return _slide;
      }
      
      public function set slide(param1:MovieClip) : void
      {
         _slide = param1;
      }
   }
}
