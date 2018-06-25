package ddt.utils
{
   public class HelperBuyAlert
   {
      
      private static var instance:HelperBuyAlert;
       
      
      public function HelperBuyAlert(single:inner)
      {
         super();
      }
      
      public static function getInstance() : HelperBuyAlert
      {
         if(!instance)
         {
            instance = new HelperBuyAlert(new inner());
         }
         return instance;
      }
      
      public function alert($msg:String, $data:ConfirmAlertData, $frameType:String = null, $onCheckOut:Function = null, $onConfirm:Function = null, $onCancel:Function = null, type:int = 1, selectBtnY:int = 0) : ConfirmAlertHelper
      {
         var frameType:* = null;
         if($frameType == null)
         {
            frameType = "SimpleAlert";
         }
         else
         {
            frameType = $frameType;
         }
         var a:ConfirmAlertHelper = new ConfirmAlertHelper($data);
         a.onConfirm = $onConfirm;
         a.onCheckOut = $onCheckOut;
         a.onCancel = $onCancel;
         a.alert("Cảnh cáo：",$msg,"O K","Hủy",false,true,false,2,null,frameType,30,true,type,selectBtnY);
         return a;
      }
   }
}

class inner
{
    
   
   function inner()
   {
      super();
   }
}
