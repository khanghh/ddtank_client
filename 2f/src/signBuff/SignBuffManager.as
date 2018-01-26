package signBuff
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.CoreManager;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.manager.SocketManager;
   import flash.utils.Dictionary;
   import road7th.comm.PackageIn;
   import signBuff.view.SignBuffView;
   
   public class SignBuffManager extends CoreManager
   {
      
      private static var _instance:SignBuffManager;
       
      
      public var list:Dictionary;
      
      private var _main:SignBuffView;
      
      public var loginDays:int;
      
      public var wellAddRate:int;
      
      public var fightPowerArr:Array;
      
      private var fightPower1:int;
      
      private var fightPower2:int;
      
      private var fightPower3:int;
      
      private var fightPower4:int;
      
      private var fightPower5:int;
      
      private var fightPower6:int;
      
      public var itemInfoList:Array;
      
      public function SignBuffManager(){super();}
      
      public static function get instance() : SignBuffManager{return null;}
      
      override protected function start() : void{}
      
      public function closeFrame() : void{}
      
      public function setup() : void{}
      
      private function __onMessageHandler(param1:CrazyTankSocketEvent) : void{}
      
      public function templateDataSetup(param1:Array) : void{}
   }
}
