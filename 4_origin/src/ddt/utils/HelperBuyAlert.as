package ddt.utils
{
   public class HelperBuyAlert
   {
      
      private static var instance:HelperBuyAlert;
       
      
      public function HelperBuyAlert(param1:inner)
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
      
      public function alert(param1:String, param2:ConfirmAlertData, param3:String = null, param4:Function = null, param5:Function = null, param6:Function = null, param7:int = 1, param8:int = 0) : ConfirmAlertHelper
      {
         var _loc10_:* = null;
         if(param3 == null)
         {
            _loc10_ = "SimpleAlert";
         }
         else
         {
            _loc10_ = param3;
         }
         var _loc9_:ConfirmAlertHelper = new ConfirmAlertHelper(param2);
         _loc9_.onConfirm = param5;
         _loc9_.onCheckOut = param4;
         _loc9_.onCancel = param6;
         _loc9_.alert("Cảnh cáo：",param1,"O K","Hủy",false,false,false,2,null,_loc10_,30,true,param7,param8);
         return _loc9_;
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
