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
      
      public static function recvPacksInfo(pkg:PackageIn) : void
      {
         var i:int = 0;
         isCallEnable = !!pkg.readInt()?false:true;
         isApplyEnable = !!pkg.readInt()?false:true;
         var dayNum:int = pkg.readInt();
         isFirstLogin = dayNum > 1?false:true;
         var length:int = pkg.readInt();
         for(i = 0; i < length; )
         {
            if(pkg.readByte() == 0)
            {
               isOver = false;
               break;
            }
            i++;
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
