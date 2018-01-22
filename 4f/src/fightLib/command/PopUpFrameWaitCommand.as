package fightLib.command
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import fightLib.view.FightLibAlertView;
   
   public class PopUpFrameWaitCommand extends WaittingCommand
   {
       
      
      private var _frame:FightLibAlertView;
      
      public function PopUpFrameWaitCommand(param1:String, param2:Function, param3:String = "", param4:Function = null, param5:String = "", param6:Function = null, param7:Boolean = true, param8:Boolean = false){super(null);}
      
      override public function excute() : void{}
      
      override public function undo() : void{}
      
      override public function finish() : void{}
      
      override public function dispose() : void{}
   }
}
