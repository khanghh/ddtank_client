package road7th.utils
{
   import bones.display.BoneMovieStarling;
   import com.pickgliss.utils.StarlingObjectUtils;
   import dragonBones.events.AnimationEvent;
   import flash.utils.getTimer;
   import starling.display.DisplayObject;
   import starling.display.Sprite;
   import starling.events.Event;
   
   [Event(name="complete",type="starling.events.Event")]
   public class AutoDisappearStarling extends Sprite
   {
       
      
      private var _life:Number;
      
      private var _age:Number;
      
      private var _last:Number;
      
      public function AutoDisappearStarling(movie:DisplayObject, life:Number = -1)
      {
         super();
         if(life == -1 && movie is BoneMovieStarling)
         {
            BoneMovieStarling(movie).armature.addEventListener("complete",__onComplete);
            BoneMovieStarling(movie).play();
         }
         else
         {
            _life = life * 1000;
            _age = 0;
            addEventListener("addedToStage",__addToStage);
         }
         addChild(movie);
      }
      
      private function __onComplete(e:AnimationEvent) : void
      {
         e.currentTarget.removeEventListener("complete",__onComplete);
         StarlingObjectUtils.disposeObject(this);
      }
      
      private function __addToStage(event:Event) : void
      {
         _last = getTimer();
         addEventListener("enterFrame",__enterFrame);
      }
      
      private function __enterFrame(event:Event) : void
      {
         if(parent)
         {
            _age = _age + (getTimer() - _last);
            _last = getTimer();
            if(_age > _life)
            {
               removeEventListener("enterFrame",__enterFrame);
               StarlingObjectUtils.disposeObject(this);
            }
         }
      }
      
      override public function dispose() : void
      {
         this.dispatchEvent(new Event("complete"));
         removeEventListener("addedToStage",__addToStage);
         removeEventListener("enterFrame",__enterFrame);
         StarlingObjectUtils.disposeAllChildren(this);
         super.dispose();
      }
   }
}
