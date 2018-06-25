package ddt.action
{
   import com.pickgliss.action.BaseAction;
   
   public class FrameShowAction extends BaseAction
   {
       
      
      private var _frame:Object;
      
      private var _showFun:Function;
      
      public function FrameShowAction(frame:Object, showFun:Function = null, timeOut:uint = 0)
      {
         _frame = frame;
         _showFun = showFun;
         super(timeOut);
      }
      
      override public function act() : void
      {
         if(_showFun is Function)
         {
            _showFun();
         }
         else
         {
            _frame.show();
         }
         super.act();
      }
   }
}
