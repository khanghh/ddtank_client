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
      
      public function PopupFrameCommand(param1:String, param2:String = "", param3:Function = null, param4:String = "", param5:Function = null, param6:Boolean = true, param7:Boolean = false, param8:Array = null)
      {
         super();
         _frame = ComponentFactory.Instance.creatCustomObject("fightLib.view.FightLibAlertView",[param1,param2,finish,param4,param5,param6,param7,param8]);
         _callBack = param3;
         _okLable = param2;
         _cancelLabel = param4;
         _cancelFunc = param5;
      }
      
      override public function excute() : void
      {
         super.excute();
         _frame.show();
      }
      
      override public function finish() : void
      {
         if(_callBack != null)
         {
            _callBack();
         }
         _frame.hide();
         super.finish();
      }
      
      override public function undo() : void
      {
         _frame.hide();
         super.undo();
      }
      
      override public function dispose() : void
      {
         if(_frame)
         {
            _frame.hide();
            ObjectUtils.disposeObject(_frame);
            _frame = null;
         }
         _callBack = null;
         super.dispose();
      }
   }
}
