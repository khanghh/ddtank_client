package lotteryTicket
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.CoreManager;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.utils.HelperUIModuleLoad;
   import hallIcon.HallIconManager;
   import lotteryTicket.data.LotteryTicketInfo;
   import lotteryTicket.model.LotteryModel;
   import lotteryTicket.view.LotteryMainView;
   import road7th.comm.PackageIn;
   
   public class LotteryManager extends CoreManager
   {
      
      private static var _instance:LotteryManager;
       
      
      public var model:LotteryModel;
      
      public var isClick:Boolean = false;
      
      private var _main:LotteryMainView;
      
      public function LotteryManager()
      {
         super();
      }
      
      public static function get instance() : LotteryManager
      {
         if(!_instance)
         {
            _instance = new LotteryManager();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         model = new LotteryModel();
         SocketManager.Instance.addEventListener("lotteryTicket",lotteryHandler);
      }
      
      public function templateDataSetup(dataList:Array) : void
      {
         model.itemInfoList = dataList;
      }
      
      private function lotteryHandler(e:CrazyTankSocketEvent) : void
      {
         var i:int = 0;
         var ballInfo:* = null;
         var ticketInfo:* = null;
         var player:* = null;
         var pkg:PackageIn = e.pkg;
         var cmd:int = pkg.readInt();
         switch(int(cmd) - 1)
         {
            case 0:
               model.isopen = pkg.readBoolean();
               model.isCanBuyBall = pkg.readBoolean();
               model.gameIndex = pkg.readInt();
               model.dataList = [];
               for(i = 0; i < 8; )
               {
                  ballInfo = pkg.readUTF();
                  if(ballInfo != "")
                  {
                     ticketInfo = new LotteryTicketInfo();
                     ticketInfo.ifBuy = true;
                     ticketInfo.ticketArr = [ballInfo.substr(0,1),ballInfo.substr(1,1),ballInfo.substr(2,1),ballInfo.substr(3,1)];
                     model.dataList.push(ticketInfo);
                  }
                  i++;
               }
               if(_main)
               {
                  _main.initData();
               }
               else
               {
                  updataEnterIcon();
               }
               break;
            case 1:
               model.poolCount = pkg.readInt();
               model.displayResults = pkg.readUTF();
               model.firstCount = pkg.readInt();
               model.firstMoney = pkg.readInt();
               player = pkg.readUTF();
               if(player.length > 0)
               {
                  model.firstPlayerInfo = player.split("|");
               }
               else
               {
                  model.firstPlayerInfo = [];
               }
               model.secondCount = pkg.readInt();
               model.secondMoney = pkg.readInt();
               model.thirdCount = pkg.readInt();
               model.thirdMoney = pkg.readInt();
               model.fourthCount = pkg.readInt();
               model.fourthMoney = pkg.readInt();
               if(_main)
               {
                  closeFrame();
                  break;
               }
               if(isClick)
               {
                  show();
                  break;
               }
               break;
         }
      }
      
      public function closeFrame() : void
      {
         ObjectUtils.disposeObject(_main);
         _main = null;
      }
      
      override protected function start() : void
      {
         new HelperUIModuleLoad().loadUIModule(["lotteryTicket"],onLoaded);
      }
      
      private function onLoaded() : void
      {
         _main = ComponentFactory.Instance.creatComponentByStylename("lottery.mainframe");
         LayerManager.Instance.addToLayer(_main,3,true,2);
      }
      
      public function updataEnterIcon() : void
      {
         if(PlayerManager.Instance.Self.Grade >= 10)
         {
            HallIconManager.instance.updateSwitchHandler("lotteryTicket",model.isopen);
         }
      }
   }
}
