package fightLib.command
{
   import fightLib.FightLibCommandEvent;
   
   public class WaittingCommand extends BaseFightLibCommand
   {
       
      
      protected var _finishFun:Function;
      
      public function WaittingCommand(param1:Function)
      {
         super();
         _finishFun = param1;
      }
      
      override public function finish() : void
      {
         if(_finishFun != null)
         {
            _finishFun();
         }
         super.finish();
      }
      
      override public function excute() : void
      {
         super.excute();
         dispatchEvent(new FightLibCommandEvent("wait"));
      }
      
      override public function dispose() : void
      {
         _finishFun = null;
         super.dispose();
      }
   }
}
