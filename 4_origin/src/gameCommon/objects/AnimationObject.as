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
      
      public function AnimationObject(param1:int, param2:String)
      {
         super();
         _id = param1;
         _linkName = param2;
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
