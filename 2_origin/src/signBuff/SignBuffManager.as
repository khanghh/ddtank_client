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
      
      private function __onMessageHandler(e:CrazyTankSocketEvent) : void
      {
         var pkg:PackageIn = e.pkg;
         loginDays = pkg.readInt();
         wellAddRate = pkg.readInt();
         fightPowerArr = [];
         fightPower1 = pkg.readInt();
         fightPower2 = pkg.readInt();
         fightPower3 = pkg.readInt();
         fightPower4 = pkg.readInt();
         fightPower5 = pkg.readInt();
         fightPower6 = pkg.readInt();
         fightPowerArr = [fightPower1,fightPower2,fightPower3,fightPower4,fightPower5,fightPower6];
      }
      
      public function templateDataSetup(dataList:Array) : void
      {
         var i:int = 0;
         dataList.sortOn("Quality",16);
         var arr:Array = [];
         for(i = 0; i < dataList.length; )
         {
            if(i == 0)
            {
               arr.push(dataList[i]);
            }
            else
            {
               if(i == dataList.length - 1)
               {
                  arr.push(dataList[i]);
                  itemInfoList.push(arr);
                  break;
               }
               if(dataList[i].Quality == dataList[i - 1].Quality)
               {
                  arr.push(dataList[i]);
               }
               else
               {
                  itemInfoList.push(arr);
                  arr = [];
                  arr.push(dataList[i]);
               }
            }
            i++;
         }
      }
   }
}
