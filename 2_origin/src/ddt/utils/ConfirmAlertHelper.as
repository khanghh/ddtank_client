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
      
      public function ConfirmAlertHelper(param1:ConfirmAlertData)
      {
         super();
         _data = param1;
      }
      
      public function get frame() : BaseAlerFrame
      {
         return _frame;
      }
      
      public function alertQuick(param1:String, param2:String = "SimpleAlert") : void
      {
         alert("Cảnh cáo：",param1,"O K","Hủy",true,false,false,2,null,param2,30,true,0);
      }
      
      public function alert(param1:String, param2:String, param3:String = "", param4:String = "", param5:Boolean = false, param6:Boolean = false, param7:Boolean = false, param8:int = 2, param9:String = null, param10:String = "SimpleAlert", param11:int = 30, param12:Boolean = true, param13:int = 0, param14:int = 0) : void
      {
         _frameStyle = param10;
         if(_data.notShowAlertAgain == true)
         {
            CheckMoneyUtils.instance.checkMoney(_data.isBind,_data.moneyNeeded,onCheckComplete,onCheckCancel);
            return;
         }
         _frame = AlertManager.Instance.simpleAlert(param1,param2,param3,param4,param5,param6,param7,param8,param9,param10,param11,param12,param13,param14);
         _frame.addEventListener("response",confirmResponse);
      }
      
      protected function confirmResponse(param1:FrameEvent) : void
      {
         _frame.removeEventListener("response",confirmResponse);
         if(_frame is SimpleAlertWithNotShowAgain)
         {
            _data.notShowAlertAgain = (_frame as SimpleAlertWithNotShowAgain).isNoPrompt;
         }
         _data.isBind = _frame.isBand;
         if(param1.responseCode == 2 || param1.responseCode == 3)
         {
            onConfirm && onConfirm(_frame);
            onConfirm = null;
            dispatchEvent(new CEvent("confirm_to_pay"));
            CheckMoneyUtils.instance.checkMoney(_data.isBind,_data.moneyNeeded,onCheckComplete,onCheckCancel);
         }
         else if(param1.responseCode == 4 || param1.responseCode == 0 || param1.responseCode == 1)
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
