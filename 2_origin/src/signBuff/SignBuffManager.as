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
      
      public function SignBuffManager()
      {
         itemInfoList = [];
         super();
      }
      
      public static function get instance() : SignBuffManager
      {
         if(_instance == null)
         {
            _instance = new SignBuffManager();
         }
         return _instance;
      }
      
      override protected function start() : void
      {
         _main = ComponentFactory.Instance.creatComponentByStylename("signBuff.mainframe");
         LayerManager.Instance.addToLayer(_main,3,true,2);
      }
      
      public function closeFrame() : void
      {
         ObjectUtils.disposeObject(_main);
         _main = null;
      }
      
      public function setup() : void
      {
         SocketManager.Instance.addEventListener("sign_buff",__onMessageHandler);
      }
      
      private function __onMessageHandler(param1:CrazyTankSocketEvent) : void
      {
         var _loc2_:PackageIn = param1.pkg;
         loginDays = _loc2_.readInt();
         wellAddRate = _loc2_.readInt();
         fightPowerArr = [];
         fightPower1 = _loc2_.readInt();
         fightPower2 = _loc2_.readInt();
         fightPower3 = _loc2_.readInt();
         fightPower4 = _loc2_.readInt();
         fightPower5 = _loc2_.readInt();
         fightPower6 = _loc2_.readInt();
         fightPowerArr = [fightPower1,fightPower2,fightPower3,fightPower4,fightPower5,fightPower6];
      }
      
      public function templateDataSetup(param1:Array) : void
      {
         var _loc3_:int = 0;
         param1.sortOn("Quality",16);
         var _loc2_:Array = [];
         _loc3_ = 0;
         while(_loc3_ < param1.length)
         {
            if(_loc3_ == 0)
            {
               _loc2_.push(param1[_loc3_]);
            }
            else
            {
               if(_loc3_ == param1.length - 1)
               {
                  _loc2_.push(param1[_loc3_]);
                  itemInfoList.push(_loc2_);
                  break;
               }
               if(param1[_loc3_].Quality == param1[_loc3_ - 1].Quality)
               {
                  _loc2_.push(param1[_loc3_]);
               }
               else
               {
                  itemInfoList.push(_loc2_);
                  _loc2_ = [];
                  _loc2_.push(param1[_loc3_]);
               }
            }
            _loc3_++;
         }
      }
   }
}
