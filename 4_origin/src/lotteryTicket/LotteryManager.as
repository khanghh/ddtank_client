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
      
      public function templateDataSetup(param1:Array) : void
      {
         model.itemInfoList = param1;
      }
      
      private function lotteryHandler(param1:CrazyTankSocketEvent) : void
      {
         var _loc7_:int = 0;
         var _loc6_:* = null;
         var _loc5_:* = null;
         var _loc3_:* = null;
         var _loc4_:PackageIn = param1.pkg;
         var _loc2_:int = _loc4_.readInt();
         switch(int(_loc2_) - 1)
         {
            case 0:
               model.isopen = _loc4_.readBoolean();
               model.isCanBuyBall = _loc4_.readBoolean();
               model.gameIndex = _loc4_.readInt();
               model.dataList = [];
               _loc7_ = 0;
               while(_loc7_ < 8)
               {
                  _loc6_ = _loc4_.readUTF();
                  if(_loc6_ != "")
                  {
                     _loc5_ = new LotteryTicketInfo();
                     _loc5_.ifBuy = true;
                     _loc5_.ticketArr = [_loc6_.substr(0,1),_loc6_.substr(1,1),_loc6_.substr(2,1),_loc6_.substr(3,1)];
                     model.dataList.push(_loc5_);
                  }
                  _loc7_++;
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
               model.poolCount = _loc4_.readInt();
               model.displayResults = _loc4_.readUTF();
               model.firstCount = _loc4_.readInt();
               model.firstMoney = _loc4_.readInt();
               _loc3_ = _loc4_.readUTF();
               if(_loc3_.length > 0)
               {
                  model.firstPlayerInfo = _loc3_.split("|");
               }
               else
               {
                  model.firstPlayerInfo = [];
               }
               model.secondCount = _loc4_.readInt();
               model.secondMoney = _loc4_.readInt();
               model.thirdCount = _loc4_.readInt();
               model.thirdMoney = _loc4_.readInt();
               model.fourthCount = _loc4_.readInt();
               model.fourthMoney = _loc4_.readInt();
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
