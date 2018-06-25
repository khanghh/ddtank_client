package ddt.utils
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.controls.alert.SimpleAlertWithNotShowAgain;
   import ddt.events.CEvent;
   import flash.events.EventDispatcher;
   
   public class ConfirmAlertHelper extends EventDispatcher
   {
      
      public static const CHECK_OUT:String = "check_out";
      
      public static const CONFIRM_TO_PAY:String = "confirm_to_pay";
      
      public static const CANCEL:String = "cancel";
       
      
      private var _frame:BaseAlerFrame;
      
      private var _frameStyle:String;
      
      public var onConfirm:Function;
      
      public var onCheckOut:Function;
      
      public var onCancel:Function;
      
      private var _data:ConfirmAlertData;
      
      public function ConfirmAlertHelper(data:ConfirmAlertData)
      {
         super();
         _data = data;
      }
      
      public function get frame() : BaseAlerFrame
      {
         return _frame;
      }
      
      public function alertQuick(msg:String, frameStyle:String = "SimpleAlert") : void
      {
         alert("Cảnh cáo：",msg,"O K","Hủy",true,false,false,2,null,frameStyle,30,true,0);
      }
      
      public function alert(title:String, msg:String, submitLabel:String = "", cancelLabel:String = "", autoDispose:Boolean = false, enableHtml:Boolean = false, multiLine:Boolean = false, blockBackgound:int = 2, cacheFlag:String = null, frameStyle:String = "SimpleAlert", buttonGape:int = 30, autoButtonGape:Boolean = true, type:int = 0, selectBtnY:int = 0) : void
      {
         _frameStyle = frameStyle;
         if(_data.notShowAlertAgain == true)
         {
            CheckMoneyUtils.instance.checkMoney(_data.isBind,_data.moneyNeeded,onCheckComplete,onCheckCancel);
            return;
         }
         _frame = AlertManager.Instance.simpleAlert(title,msg,submitLabel,cancelLabel,autoDispose,enableHtml,multiLine,blockBackgound,cacheFlag,frameStyle,buttonGape,autoButtonGape,type,selectBtnY);
         _frame.addEventListener("response",confirmResponse);
      }
      
      protected function confirmResponse(e:FrameEvent) : void
      {
         _frame.removeEventListener("response",confirmResponse);
         if(_frame is SimpleAlertWithNotShowAgain)
         {
            _data.notShowAlertAgain = (_frame as SimpleAlertWithNotShowAgain).isNoPrompt;
         }
         _data.isBind = _frame.isBand;
         if(e.responseCode == 2 || e.responseCode == 3)
         {
            onConfirm && onConfirm(_frame);
            onConfirm = null;
            dispatchEvent(new CEvent("confirm_to_pay"));
            CheckMoneyUtils.instance.checkMoney(_data.isBind,_data.moneyNeeded,onCheckComplete,onCheckCancel);
         }
         else if(e.responseCode == 4 || e.responseCode == 0 || e.responseCode == 1)
         {
            onCheckCancel();
         }
         _frame.dispose();
      }
      
      private function onCheckCancel() : void
      {
         onCancel && onCancel();
         onCancel = null;
         dispatchEvent(new CEvent("cancel"));
      }
      
      protected function onCheckComplete() : void
      {
         _data.isBind = CheckMoneyUtils.instance.isBind;
         onCheckOut && onCheckOut();
         onCheckOut = null;
         dispatchEvent(new CEvent("check_out"));
      }
   }
}
