package DDPlay
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.NumberSelecter;
   
   public class DDPlayExchangeNumberSekecter extends NumberSelecter
   {
       
      
      public function DDPlayExchangeNumberSekecter()
      {
         super();
      }
      
      override public function set currentValue(param1:Number) : void
      {
         .super.currentValue = param1;
         refreshBtnState();
      }
      
      private function refreshBtnState() : void
      {
         if(upDisplay)
         {
            if(currentValue <= _valueLimit.x)
            {
               (upDisplay as BaseButton).enable = false;
               upDisplay.filters = ComponentFactory.Instance.creatFilters("grayFilter");
            }
            else
            {
               (upDisplay as BaseButton).enable = true;
               upDisplay.filters = null;
            }
         }
         if(downDisplay)
         {
            if(currentValue >= _valueLimit.y)
            {
               (downDisplay as BaseButton).enable = false;
               downDisplay.filters = ComponentFactory.Instance.creatFilters("grayFilter");
            }
            else
            {
               (downDisplay as BaseButton).enable = true;
               downDisplay.filters = null;
            }
         }
      }
   }
}
