package road7th.utils
{
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.utils.getTimer;
   
   public class AutoDisappear extends Sprite implements Disposeable
   {
       
      
      private var _life:Number;
      
      private var _age:Number;
      
      private var _last:Number;
      
      public function AutoDisappear(param1:DisplayObject, param2:Number = -1)
      {
         super();
         if(param2 == -1 && param1 is MovieClip)
         {
            _life = MovieClip(param1).totalFrames * 40;
         }
         else
         {
            _life = param2 * 1000;
         }
         _age = 0;
         addChild(param1);
         addEventListener("addedToStage",__addToStage);
      }
      
      private function __addToStage(param1:Event) : void
      {
         _last = getTimer();
         addEventListener("enterFrame",__enterFrame);
      }
      
      private function __enterFrame(param1:Event) : void
      {
         if(parent)
         {
            _age = _age + (getTimer() - _last);
            _last = getTimer();
            if(_age > _life)
            {
               parent.removeChild(this);
               removeEventListener("enterFrame",__enterFrame);
               this.dispatchEvent(new Event("complete"));
            }
         }
      }
      
      public function dispose() : void
      {
         removeEventListener("addedToStage",__addToStage);
         removeEventListener("enterFrame",__enterFrame);
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
