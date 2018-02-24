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
      
      public function RegressManager(){super();}
      
      public static function recvPacksInfo(param1:PackageIn) : void{}
      
      public static function get instance() : RegressManager{return null;}
      
      override protected function start() : void{}
   }
}
