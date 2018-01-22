package oldPlayerRegress
{
   import ddt.CoreManager;
   import road7th.comm.PackageIn;
   
   public class RegressManager extends CoreManager
   {
      
      public static var isApplyEnable:Boolean;
      
      public static var isCallEnable:Boolean;
      
      public static var isAutoPop:Boolean = true;
      
      public static var isFirstLogin:Boolean = true;
      
      public static var isOver:Boolean = true;
      
      private static var _instance:RegressManager;
       
      
      public var autoPopUp:Boolean;
      
      public function RegressManager()
      {
         super();
         autoPopUp = false;
      }
      
      public static function recvPacksInfo(param1:PackageIn) : void
      {
         var _loc4_:int = 0;
         isCallEnable = !!param1.readInt()?false:true;
         isApplyEnable = !!param1.readInt()?false:true;
         var _loc2_:int = param1.readInt();
         isFirstLogin = _loc2_ > 1?false:true;
         var _loc3_:int = param1.readInt();
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            if(param1.readByte() == 0)
            {
               isOver = false;
               break;
            }
            _loc4_++;
         }
         RegressManager.instance.dispatchEvent(new RegressEvent("regress_addbtn"));
      }
      
      public static function get instance() : RegressManager
      {
         if(!_instance)
         {
            _instance = new RegressManager();
         }
         return _instance;
      }
      
      override protected function start() : void
      {
         dispatchEvent(new RegressEvent("regressOpenView"));
      }
   }
}
