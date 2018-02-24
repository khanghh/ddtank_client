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
      
      public function ConfirmAlertHelper(param1:ConfirmAlertData){super();}
      
      public function get frame() : BaseAlerFrame{return null;}
      
      public function alertQuick(param1:String, param2:String = "SimpleAlert") : void{}
      
      public function alert(param1:String, param2:String, param3:String = "", param4:String = "", param5:Boolean = false, param6:Boolean = false, param7:Boolean = false, param8:int = 2, param9:String = null, param10:String = "SimpleAlert", param11:int = 30, param12:Boolean = true, param13:int = 0, param14:int = 0) : void{}
      
      protected function confirmResponse(param1:FrameEvent) : void{}
      
      private function onCheckCancel() : void{}
      
      protected function onCheckComplete() : void{}
   }
}
