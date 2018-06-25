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
      
      public function PopupFrameCommand(infoString:String, okLabel:String = "", okCallBack:Function = null, cancelLabel:String = "", cancelCallBack:Function = null, showOkBtn:Boolean = true, showCancelBtn:Boolean = false, WeaponArr:Array = null)
      {
         super();
         _frame = ComponentFactory.Instance.creatCustomObject("fightLib.view.FightLibAlertView",[infoString,okLabel,finish,cancelLabel,cancelCallBack,showOkBtn,showCancelBtn,WeaponArr]);
         _callBack = okCallBack;
         _okLable = okLabel;
         _cancelLabel = cancelLabel;
         _cancelFunc = cancelCallBack;
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
