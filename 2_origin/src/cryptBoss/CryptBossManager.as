package cryptBoss
{
   import cryptBoss.data.CryptBossItemInfo;
   import cryptBoss.event.CryptBossEvent;
   import ddt.CoreManager;
   import ddt.events.PkgEvent;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SocketManager;
   import flash.utils.Dictionary;
   import road7th.comm.PackageIn;
   
   public class CryptBossManager extends CoreManager
   {
      
      private static var _instance:CryptBossManager;
      
      public static var loadComplete:Boolean = false;
       
      
      public var RoomType:int = 0;
      
      public var openWeekDaysDic:Dictionary;
      
      public function CryptBossManager()
      {
         super();
      }
      
      public static function get instance() : CryptBossManager
      {
         if(!_instance)
         {
            _instance = new CryptBossManager();
         }
         return _instance;
      }
      
      public function setUp() : void
      {
         openWeekDaysDic = new Dictionary();
         SocketManager.Instance.addEventListener(PkgEvent.format(275),pkgHandler);
      }
      
      protected function pkgHandler(param1:PkgEvent) : void
      {
         var _loc3_:PackageIn = param1.pkg;
         var _loc2_:int = _loc3_.readByte();
         switch(int(_loc2_) - 1)
         {
            case 0:
               initAllData(_loc3_);
               break;
            case 1:
               updateSingleData(_loc3_);
         }
      }
      
      private function updateSingleData(param1:PackageIn) : void
      {
         var _loc2_:int = param1.readInt();
         var _loc4_:int = param1.readInt();
         var _loc3_:int = param1.readInt();
         var _loc5_:CryptBossItemInfo = openWeekDaysDic[_loc2_];
         _loc5_.id = _loc2_;
         _loc5_.star = _loc4_;
         _loc5_.state = _loc3_;
         dispatchEvent(new CryptBossEvent("cryptBossUpdateView"));
      }
      
      private function initAllData(param1:PackageIn) : void
      {
         var _loc7_:int = 0;
         var _loc9_:* = null;
         var _loc8_:int = 0;
         var _loc5_:* = null;
         var _loc2_:* = null;
         var _loc6_:int = 0;
         var _loc3_:int = param1.readInt();
         if(_loc3_ == 0)
         {
            return;
         }
         _loc7_ = 0;
         while(_loc7_ < _loc3_)
         {
            _loc9_ = new CryptBossItemInfo();
            _loc9_.id = param1.readInt();
            _loc9_.star = param1.readInt();
            _loc9_.state = param1.readInt();
            openWeekDaysDic[_loc9_.id] = _loc9_;
            _loc7_++;
         }
         var _loc4_:Array = ServerConfigManager.instance.cryptBossOpenDay;
         _loc8_ = 0;
         while(_loc8_ < _loc4_.length)
         {
            _loc5_ = _loc4_[_loc8_].split(",");
            _loc2_ = [];
            _loc6_ = 1;
            while(_loc6_ < _loc5_.length)
            {
               _loc2_.push(_loc5_[_loc6_]);
               _loc6_++;
            }
            (openWeekDaysDic[_loc5_[0]] as CryptBossItemInfo).openWeekDaysArr = _loc2_;
            _loc8_++;
         }
         dispatchEvent(new CryptBossEvent("cryptBossUpdateView"));
      }
      
      override protected function start() : void
      {
         dispatchEvent(new CryptBossEvent("cryptBossOpenView"));
      }
   }
}
