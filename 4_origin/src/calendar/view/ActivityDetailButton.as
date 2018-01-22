package calendar.view
{
   import com.greensock.TweenMax;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.utils.DisplayUtils;
   
   public class ActivityDetailButton extends BaseButton
   {
       
      
      private var _state:int = 0;
      
      private var _tweenMax:TweenMax;
      
      public function ActivityDetailButton()
      {
         super();
      }
      
      public function set state(param1:int) : void
      {
         if(_state == param1)
         {
            return;
         }
         _state = param1;
         if(backgound)
         {
            DisplayUtils.setFrame(backgound,param1);
            TweenMax.killChildTweensOf(this);
            backgound.filters = null;
            if(_state == 1)
            {
               backgound.x = 0;
               _tweenMax = TweenMax.to(backgound,0.3,{
                  "x":6,
                  "repeat":-1,
                  "yoyo":true
               });
            }
            else
            {
               backgound.x = 6;
               _tweenMax = TweenMax.to(backgound,0.3,{
                  "x":0,
                  "repeat":-1,
                  "yoyo":true
               });
            }
         }
      }
      
      override public function dispose() : void
      {
         TweenMax.killChildTweensOf(this);
         _tweenMax = null;
         super.dispose();
      }
      
      public function get state() : int
      {
         return _state;
      }
      
      override public function setFrame(param1:int) : void
      {
      }
   }
}
