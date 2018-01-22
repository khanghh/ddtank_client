package cloudBuyLottery
{
   import cloudBuyLottery.data.CloudBuyAnalyzer;
   import cloudBuyLottery.loader.LoaderUIModule;
   import cloudBuyLottery.model.CloudBuyLotteryModel;
   import cloudBuyLottery.model.CloudBuyLotteryPackageType;
   import cloudBuyLottery.view.CloudBuyLotteryFrame;
   import cloudBuyLottery.view.ExpBar;
   import cloudBuyLottery.view.WinningLogItemInfo;
   import com.pickgliss.loader.BaseLoader;
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.manager.PathManager;
   import ddt.manager.SocketManager;
   import ddt.manager.TimeManager;
   import flash.display.Sprite;
   import flash.events.Event;
   import hallIcon.HallIconManager;
   import road7th.comm.PackageIn;
   
   public class CloudBuyLotteryManager extends Sprite
   {
      
      private static var _instance:CloudBuyLotteryManager;
      
      public static const UPDATE_INFO:String = "updateInfo";
      
      public static const INDIVIDUAL:String = "Individual";
      
      public static const FRAMEUPDATE:String = "frmeupdate";
       
      
      private var _model:CloudBuyLotteryModel;
      
      private var cloudBuyFrame:CloudBuyLotteryFrame;
      
      public var itemInfoList:Array;
      
      public var logArr:Array;
      
      public function CloudBuyLotteryManager(param1:PrivateClass){super();}
      
      public static function get Instance() : CloudBuyLotteryManager{return null;}
      
      public function setup() : void{}
      
      private function __cloudBuyLotteryHandle(param1:CrazyTankSocketEvent) : void{}
      
      private function activityOpen(param1:PackageIn) : void{}
      
      private function enterGame(param1:PackageIn) : void{}
      
      private function buyGoods(param1:PackageIn) : void{}
      
      public function templateDataSetup(param1:Array) : void{}
      
      private function updateInfo(param1:PackageIn) : void{}
      
      private function getReward(param1:PackageIn) : void{}
      
      public function loaderCloudBuyFrame() : void{}
      
      private function initOpenFrame() : void{}
      
      public function initIcon(param1:Boolean) : void{}
      
      public function returnTen(param1:String) : int{return 0;}
      
      public function returnABit(param1:String) : int{return 0;}
      
      public function refreshTimePlayTxt() : String{return null;}
      
      private function _loadXml(param1:String, param2:int, param3:String = "") : void{}
      
      private function logComplete(param1:DataAnalyzer) : void{}
      
      public function get model() : CloudBuyLotteryModel{return null;}
      
      public function get expBar() : ExpBar{return null;}
   }
}

class PrivateClass
{
    
   
   function PrivateClass(){super();}
}
