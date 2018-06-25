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
      
      protected function pkgHandler(event:PkgEvent) : void
      {
         var pkg:PackageIn = event.pkg;
         var cmd:int = pkg.readByte();
         switch(int(cmd) - 1)
         {
            case 0:
               initAllData(pkg);
               break;
            case 1:
               updateSingleData(pkg);
         }
      }
      
      private function updateSingleData(pkg:PackageIn) : void
      {
         var id:int = pkg.readInt();
         var star:int = pkg.readInt();
         var state:int = pkg.readInt();
         var itemInfo:CryptBossItemInfo = openWeekDaysDic[id];
         itemInfo.id = id;
         itemInfo.star = star;
         itemInfo.state = state;
         dispatchEvent(new CryptBossEvent("cryptBossUpdateView"));
      }
      
      private function initAllData(pkg:PackageIn) : void
      {
         var k:int = 0;
         var info:* = null;
         var i:int = 0;
         var temp:* = null;
         var openArr:* = null;
         var j:int = 0;
         var count:int = pkg.readInt();
         if(count == 0)
         {
            return;
         }
         k = 0;
         while(k < count)
         {
            info = new CryptBossItemInfo();
            info.id = pkg.readInt();
            info.star = pkg.readInt();
            info.state = pkg.readInt();
            openWeekDaysDic[info.id] = info;
            k++;
         }
         var arr:Array = ServerConfigManager.instance.cryptBossOpenDay;
         for(i = 0; i < arr.length; )
         {
            temp = arr[i].split(",");
            openArr = [];
            for(j = 1; j < temp.length; )
            {
               openArr.push(temp[j]);
               j++;
            }
            (openWeekDaysDic[temp[0]] as CryptBossItemInfo).openWeekDaysArr = openArr;
            i++;
         }
         dispatchEvent(new CryptBossEvent("cryptBossUpdateView"));
      }
      
      override protected function start() : void
      {
         dispatchEvent(new CryptBossEvent("cryptBossOpenView"));
      }
   }
}
