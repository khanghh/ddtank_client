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
      
      public function AnimationObject(param1:int, param2:String){super();}
      
      private function initView() : void{}
      
      public function dispose() : void{}
      
      public function get Id() : int{return 0;}
   }
}
