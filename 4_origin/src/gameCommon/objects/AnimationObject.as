package gameCommon.objects
{
   import com.pickgliss.ui.ComponentFactory;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   
   public class AnimationObject extends Sprite
   {
       
      
      private var _id:int;
      
      private var _linkName:String;
      
      private var _animation:MovieClip;
      
      public function AnimationObject(id:int, linkName:String)
      {
         super();
         _id = id;
         _linkName = linkName;
         initView();
      }
      
      private function initView() : void
      {
         _animation = ComponentFactory.Instance.creat(_linkName);
         addChild(_animation);
      }
      
      public function dispose() : void
      {
         _id = -1;
         if(_animation)
         {
            _animation = null;
         }
      }
      
      public function get Id() : int
      {
         return _id;
      }
   }
}
