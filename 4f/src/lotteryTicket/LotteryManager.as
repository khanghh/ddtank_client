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
      
      public function LotteryManager(){super();}
      
      public static function get instance() : LotteryManager{return null;}
      
      public function setup() : void{}
      
      public function templateDataSetup(param1:Array) : void{}
      
      private function lotteryHandler(param1:CrazyTankSocketEvent) : void{}
      
      public function closeFrame() : void{}
      
      override protected function start() : void{}
      
      private function onLoaded() : void{}
      
      public function updataEnterIcon() : void{}
   }
}
