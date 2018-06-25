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
      
      public function CloudBuyLotteryManager(pct:PrivateClass)
      {
         super();
      }
      
      public static function get Instance() : CloudBuyLotteryManager
      {
         if(CloudBuyLotteryManager._instance == null)
         {
            CloudBuyLotteryManager._instance = new CloudBuyLotteryManager(new PrivateClass());
         }
         return CloudBuyLotteryManager._instance;
      }
      
      public function setup() : void
      {
         _model = new CloudBuyLotteryModel();
         SocketManager.Instance.addEventListener("cloudBuy",__cloudBuyLotteryHandle);
      }
      
      private function __cloudBuyLotteryHandle(e:CrazyTankSocketEvent) : void
      {
         var pkg:PackageIn = e.pkg;
         var cmd:int = e._cmd;
         var _loc4_:* = cmd;
         if(CloudBuyLotteryPackageType.OPEN_GAME !== _loc4_)
         {
            if(CloudBuyLotteryPackageType.Enter_GAME !== _loc4_)
            {
               if(CloudBuyLotteryPackageType.BUY_GOODS !== _loc4_)
               {
                  if(CloudBuyLotteryPackageType.UPDATE_INFO !== _loc4_)
                  {
                     if(CloudBuyLotteryPackageType.GET_REWARD === _loc4_)
                     {
                        getReward(pkg);
                     }
                  }
                  else
                  {
                     updateInfo(pkg);
                  }
               }
               else
               {
                  buyGoods(pkg);
               }
            }
            else
            {
               enterGame(pkg);
            }
         }
         else
         {
            activityOpen(pkg);
         }
      }
      
      private function activityOpen(pkg:PackageIn) : void
      {
         _model.isOpen = pkg.readBoolean();
         initIcon(_model.isOpen);
         if(!_model.isOpen)
         {
            return;
         }
         _loadXml("BuyItemRewardLogList.ashx?ran=" + Math.random(),6);
      }
      
      private function enterGame(pkg:PackageIn) : void
      {
         var i:int = 0;
         _model.templateId = pkg.readInt();
         _model.templatedIdCount = pkg.readInt();
         _model.validDate = pkg.readInt();
         _model.property = pkg.readUTF().split(",");
         _model.count = pkg.readInt();
         if(_model.count <= 0)
         {
            return;
         }
         _model.buyGoodsIDArray = [];
         _model.buyGoodsCountArray = [];
         for(i = 0; i < _model.count; )
         {
            _model.buyGoodsIDArray[i] = pkg.readInt();
            _model.buyGoodsCountArray[i] = pkg.readInt();
            i++;
         }
         _model.buyMoney = pkg.readInt();
         _model.maxNum = pkg.readInt();
         _model.currentNum = pkg.readInt();
         _model.luckTime = pkg.readDate();
         _model.luckCount = pkg.readInt();
         _model.remainTimes = pkg.readInt();
         _model.isGame = pkg.readBoolean();
         LoaderUIModule.Instance.loadUIModule(initOpenFrame,null,"cloudBuy");
      }
      
      private function buyGoods(pkg:PackageIn) : void
      {
      }
      
      public function templateDataSetup(dataList:Array) : void
      {
         itemInfoList = dataList;
      }
      
      private function updateInfo(pkg:PackageIn) : void
      {
         var templateId:int = pkg.readInt();
         _model.templatedIdCount = pkg.readInt();
         _model.validDate = pkg.readInt();
         _model.property = pkg.readUTF().split(",");
         _model.maxNum = pkg.readInt();
         _model.currentNum = pkg.readInt();
         _model.luckTime = pkg.readDate();
         _model.luckCount = pkg.readInt();
         _model.remainTimes = pkg.readInt();
         _model.isGame = pkg.readBoolean();
         _loadXml("BuyItemRewardLogList.ashx?ran=" + Math.random(),6);
         _model.templateId = templateId;
         dispatchEvent(new Event("updateInfo"));
      }
      
      private function getReward(pkg:PackageIn) : void
      {
         _model.isGetReward = pkg.readBoolean();
         if(_model.isGetReward)
         {
            _model.remainTimes = pkg.readInt();
            _model.luckDrawId = pkg.readInt();
         }
         dispatchEvent(new Event("Individual"));
         dispatchEvent(new Event("frmeupdate"));
      }
      
      public function loaderCloudBuyFrame() : void
      {
         if(_model.isOpen)
         {
            SocketManager.Instance.out.sendEnterGame();
         }
      }
      
      private function initOpenFrame() : void
      {
         cloudBuyFrame = ComponentFactory.Instance.creatComponentByStylename("cloudBuyFrame");
         LayerManager.Instance.addToLayer(cloudBuyFrame,3,true,2);
      }
      
      public function initIcon(flag:Boolean) : void
      {
         HallIconManager.instance.updateSwitchHandler("cloudbuylottery",flag);
         if(cloudBuyFrame != null && flag == false)
         {
            if(cloudBuyFrame)
            {
               ObjectUtils.disposeObject(cloudBuyFrame);
            }
            cloudBuyFrame = null;
         }
      }
      
      public function returnTen(str:String) : int
      {
         if(str.length > 1)
         {
            return int(str.charAt(0)) + 1;
         }
         return 1;
      }
      
      public function returnABit(str:String) : int
      {
         if(str.length <= 1)
         {
            return int(str.charAt(0)) + 1;
         }
         return int(str.charAt(1)) + 1;
      }
      
      public function refreshTimePlayTxt() : String
      {
         var endTimestamp:Number = _model.luckTime.getTime();
         var nowTimestamp:Number = TimeManager.Instance.Now().getTime();
         var differ:Number = endTimestamp - nowTimestamp;
         differ = differ < 0?0:Number(differ);
         var count:int = 0;
         var timeTxtStr:String = "";
         var hours:int = differ / 3600000;
         var minitues:int = (differ - hours * 1000 * 60 * 60) / 60000;
         var seconds:int = (differ - hours * 1000 * 60 * 60 - minitues * 1000 * 60) / 1000;
         timeTxtStr = hours + ":" + minitues + ":" + seconds;
         return timeTxtStr;
      }
      
      private function _loadXml($url:String, $requestType:int, $loadErrorMessage:String = "") : void
      {
         var loadSelfConsortiaMemberList:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath($url),$requestType);
         loadSelfConsortiaMemberList.loadErrorMessage = $loadErrorMessage;
         loadSelfConsortiaMemberList.analyzer = new CloudBuyAnalyzer(logComplete);
         LoadResourceManager.Instance.startLoad(loadSelfConsortiaMemberList);
      }
      
      private function logComplete(analyzer:DataAnalyzer) : void
      {
         var i:int = 0;
         var cellInfo:* = null;
         if(analyzer is CloudBuyAnalyzer)
         {
            logArr = CloudBuyAnalyzer(analyzer).dataArr;
         }
         if(logArr == null || logArr.length <= 0)
         {
            return;
         }
         var list:Vector.<WinningLogItemInfo> = new Vector.<WinningLogItemInfo>();
         for(i = 0; i < logArr.length; )
         {
            cellInfo = new WinningLogItemInfo();
            cellInfo.TemplateID = int(logArr[i].templateId);
            cellInfo.validate = int(logArr[i].validate);
            cellInfo.count = int(logArr[i].count);
            cellInfo.property = logArr[i].property.split(",");
            cellInfo.nickName = logArr[i].nickName;
            list.push(cellInfo);
            i++;
         }
         _model.myGiftData = list;
      }
      
      public function get model() : CloudBuyLotteryModel
      {
         return _model;
      }
      
      public function get expBar() : ExpBar
      {
         return cloudBuyFrame.expBar;
      }
   }
}

class PrivateClass
{
    
   
   function PrivateClass()
   {
      super();
   }
}
