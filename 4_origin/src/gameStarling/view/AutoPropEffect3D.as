package gameStarling.view
{
   import com.pickgliss.utils.StarlingObjectUtils;
   import flash.utils.getTimer;
   import starling.display.DisplayObject;
   import starling.display.Sprite;
   import starling.events.Event;
   
   [Event(name="complete",type="starling.events.Event")]
   public class AutoPropEffect3D extends Sprite
   {
       
      
      private var _age:Number;
      
      private var _last:uint;
      
      public function AutoPropEffect3D(movie:DisplayObject)
      {
         super();
         movie.x = -20;
         addChild(movie);
         addEventListener("addedToStage",__addToStage);
      }
      
      private function __addToStage(event:Event) : void
      {
         _age = 0;
         _last = getTimer();
         addEventListener("enterFrame",__enterFrame);
      }
      
      private function __enterFrame(event:Event) : void
      {
         if(parent)
         {
            _age = _age + 0.2;
            _last = getTimer();
            if(_age <= 1)
            {
               this.alpha = _age;
            }
            else if(_age < 4)
            {
               alpha = 1;
            }
            else if(_age < 5)
            {
               if(5 - _age > 0.2)
               {
                  alpha = 5 - _age;
               }
            }
            else if(_age < 6)
            {
               alpha = 1;
            }
            else if(_age > 8)
            {
               alpha = 5 - _age;
               if(alpha < 0.2)
               {
                  removeEventListener("enterFrame",__enterFrame);
                  StarlingObjectUtils.disposeAllChildren(this);
                  parent.removeChild(this,true);
                  this.dispatchEvent(new Event("complete"));
               }
            }
         }
      }
   }
}
