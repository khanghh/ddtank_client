package game.view
{
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.utils.getTimer;
   
   [Event(name="complete",type="flash.events.Event")]
   public class AutoPropEffect extends Sprite
   {
       
      
      private var _age:Number;
      
      private var _last:uint;
      
      public function AutoPropEffect(param1:DisplayObject)
      {
         super();
         param1.x = -20;
         addChild(param1);
         addEventListener("addedToStage",__addToStage);
      }
      
      private function __addToStage(param1:Event) : void
      {
         _age = 0;
         _last = getTimer();
         addEventListener("enterFrame",__enterFrame);
      }
      
      private function __enterFrame(param1:Event) : void
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
                  ObjectUtils.disposeAllChildren(this);
                  parent.removeChild(this);
                  removeEventListener("enterFrame",__enterFrame);
                  this.dispatchEvent(new Event("complete"));
               }
            }
         }
      }
   }
}
