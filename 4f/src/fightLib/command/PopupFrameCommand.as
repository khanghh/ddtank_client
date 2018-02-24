package fightLib.command
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import fightLib.view.FightLibAlertView;
   
   public class PopupFrameCommand extends BaseFightLibCommand
   {
       
      
      private var _frame:FightLibAlertView;
      
      private var _callBack:Function;
      
      private var _okLable:String;
      
      private var _cancelLabel:String;
      
      private var _cancelFunc:Function;
      
      public function PopupFrameCommand(param1:String, param2:String = "", param3:Function = null, param4:String = "", param5:Function = null, param6:Boolean = true, param7:Boolean = false, param8:Array = null){super();}
      
      override public function excute() : void{}
      
      override public function finish() : void{}
      
      override public function undo() : void{}
      
      override public function dispose() : void{}
   }
}
