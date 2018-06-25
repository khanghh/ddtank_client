package cloudBuyLottery{   import cloudBuyLottery.data.CloudBuyAnalyzer;   import cloudBuyLottery.loader.LoaderUIModule;   import cloudBuyLottery.model.CloudBuyLotteryModel;   import cloudBuyLottery.model.CloudBuyLotteryPackageType;   import cloudBuyLottery.view.CloudBuyLotteryFrame;   import cloudBuyLottery.view.ExpBar;   import cloudBuyLottery.view.WinningLogItemInfo;   import com.pickgliss.loader.BaseLoader;   import com.pickgliss.loader.DataAnalyzer;   import com.pickgliss.loader.LoadResourceManager;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.utils.ObjectUtils;   import ddt.events.CrazyTankSocketEvent;   import ddt.manager.PathManager;   import ddt.manager.SocketManager;   import ddt.manager.TimeManager;   import flash.display.Sprite;   import flash.events.Event;   import hallIcon.HallIconManager;   import road7th.comm.PackageIn;      public class CloudBuyLotteryManager extends Sprite   {            private static var _instance:CloudBuyLotteryManager;            public static const UPDATE_INFO:String = "updateInfo";            public static const INDIVIDUAL:String = "Individual";            public static const FRAMEUPDATE:String = "frmeupdate";                   private var _model:CloudBuyLotteryModel;            private var cloudBuyFrame:CloudBuyLotteryFrame;            public var itemInfoList:Array;            public var logArr:Array;            public function CloudBuyLotteryManager(pct:PrivateClass) { super(); }
            public static function get Instance() : CloudBuyLotteryManager { return null; }
            public function setup() : void { }
            private function __cloudBuyLotteryHandle(e:CrazyTankSocketEvent) : void { }
            private function activityOpen(pkg:PackageIn) : void { }
            private function enterGame(pkg:PackageIn) : void { }
            private function buyGoods(pkg:PackageIn) : void { }
            public function templateDataSetup(dataList:Array) : void { }
            private function updateInfo(pkg:PackageIn) : void { }
            private function getReward(pkg:PackageIn) : void { }
            public function loaderCloudBuyFrame() : void { }
            private function initOpenFrame() : void { }
            public function initIcon(flag:Boolean) : void { }
            public function returnTen(str:String) : int { return 0; }
            public function returnABit(str:String) : int { return 0; }
            public function refreshTimePlayTxt() : String { return null; }
            private function _loadXml($url:String, $requestType:int, $loadErrorMessage:String = "") : void { }
            private function logComplete(analyzer:DataAnalyzer) : void { }
            public function get model() : CloudBuyLotteryModel { return null; }
            public function get expBar() : ExpBar { return null; }
   }}class PrivateClass{          function PrivateClass() { super(); }
}