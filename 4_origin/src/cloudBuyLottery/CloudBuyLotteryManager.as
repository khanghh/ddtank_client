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
      
      public function CloudBuyLotteryManager(param1:PrivateClass)
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
      
      private function __cloudBuyLotteryHandle(param1:CrazyTankSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.pkg;
         var _loc2_:int = param1._cmd;
         var _loc4_:* = _loc2_;
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
                        getReward(_loc3_);
                     }
                  }
                  else
                  {
                     updateInfo(_loc3_);
                  }
               }
               else
               {
                  buyGoods(_loc3_);
               }
            }
            else
            {
               enterGame(_loc3_);
            }
         }
         else
         {
            activityOpen(_loc3_);
         }
      }
      
      private function activityOpen(param1:PackageIn) : void
      {
         _model.isOpen = param1.readBoolean();
         initIcon(_model.isOpen);
         if(!_model.isOpen)
         {
            return;
         }
         _loadXml("BuyItemRewardLogList.ashx?ran=" + Math.random(),6);
      }
      
      private function enterGame(param1:PackageIn) : void
      {
         var _loc2_:int = 0;
         _model.templateId = param1.readInt();
         _model.templatedIdCount = param1.readInt();
         _model.validDate = param1.readInt();
         _model.property = param1.readUTF().split(",");
         _model.count = param1.readInt();
         if(_model.count <= 0)
         {
            return;
         }
         _model.buyGoodsIDArray = [];
         _model.buyGoodsCountArray = [];
         _loc2_ = 0;
         while(_loc2_ < _model.count)
         {
            _model.buyGoodsIDArray[_loc2_] = param1.readInt();
            _model.buyGoodsCountArray[_loc2_] = param1.readInt();
            _loc2_++;
         }
         _model.buyMoney = param1.readInt();
         _model.maxNum = param1.readInt();
         _model.currentNum = param1.readInt();
         _model.luckTime = param1.readDate();
         _model.luckCount = param1.readInt();
         _model.remainTimes = param1.readInt();
         _model.isGame = param1.readBoolean();
         LoaderUIModule.Instance.loadUIModule(initOpenFrame,null,"cloudBuy");
      }
      
      private function buyGoods(param1:PackageIn) : void
      {
      }
      
      public function templateDataSetup(param1:Array) : void
      {
         itemInfoList = param1;
      }
      
      private function updateInfo(param1:PackageIn) : void
      {
         var _loc2_:int = param1.readInt();
         _model.templatedIdCount = param1.readInt();
         _model.validDate = param1.readInt();
         _model.property = param1.readUTF().split(",");
         _model.maxNum = param1.readInt();
         _model.currentNum = param1.readInt();
         _model.luckTime = param1.readDate();
         _model.luckCount = param1.readInt();
         _model.remainTimes = param1.readInt();
         _model.isGame = param1.readBoolean();
         _loadXml("BuyItemRewardLogList.ashx?ran=" + Math.random(),6);
         _model.templateId = _loc2_;
         dispatchEvent(new Event("updateInfo"));
      }
      
      private function getReward(param1:PackageIn) : void
      {
         _model.isGetReward = param1.readBoolean();
         if(_model.isGetReward)
         {
            _model.remainTimes = param1.readInt();
            _model.luckDrawId = param1.readInt();
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
      
      public function initIcon(param1:Boolean) : void
      {
         HallIconManager.instance.updateSwitchHandler("cloudbuylottery",param1);
         if(cloudBuyFrame != null && param1 == false)
         {
            if(cloudBuyFrame)
            {
               ObjectUtils.disposeObject(cloudBuyFrame);
            }
            cloudBuyFrame = null;
         }
      }
      
      public function returnTen(param1:String) : int
      {
         if(param1.length > 1)
         {
            return int(param1.charAt(0)) + 1;
         }
         return 1;
      }
      
      public function returnABit(param1:String) : int
      {
         if(param1.length <= 1)
         {
            return int(param1.charAt(0)) + 1;
         }
         return int(param1.charAt(1)) + 1;
      }
      
      public function refreshTimePlayTxt() : String
      {
         var _loc7_:Number = _model.luckTime.getTime();
         var _loc6_:Number = TimeManager.Instance.Now().getTime();
         var _loc1_:Number = _loc7_ - _loc6_;
         _loc1_ = _loc1_ < 0?0:Number(_loc1_);
         var _loc2_:int = 0;
         var _loc8_:String = "";
         var _loc4_:int = _loc1_ / 3600000;
         var _loc5_:int = (_loc1_ - _loc4_ * 1000 * 60 * 60) / 60000;
         var _loc3_:int = (_loc1_ - _loc4_ * 1000 * 60 * 60 - _loc5_ * 1000 * 60) / 1000;
         _loc8_ = _loc4_ + ":" + _loc5_ + ":" + _loc3_;
         return _loc8_;
      }
      
      private function _loadXml(param1:String, param2:int, param3:String = "") : void
      {
         var _loc4_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath(param1),param2);
         _loc4_.loadErrorMessage = param3;
         _loc4_.analyzer = new CloudBuyAnalyzer(logComplete);
         LoadResourceManager.Instance.startLoad(_loc4_);
      }
      
      private function logComplete(param1:DataAnalyzer) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = null;
         if(param1 is CloudBuyAnalyzer)
         {
            logArr = CloudBuyAnalyzer(param1).dataArr;
         }
         if(logArr == null || logArr.length <= 0)
         {
            return;
         }
         var _loc2_:Vector.<WinningLogItemInfo> = new Vector.<WinningLogItemInfo>();
         _loc4_ = 0;
         while(_loc4_ < logArr.length)
         {
            _loc3_ = new WinningLogItemInfo();
            _loc3_.TemplateID = int(logArr[_loc4_].templateId);
            _loc3_.validate = int(logArr[_loc4_].validate);
            _loc3_.count = int(logArr[_loc4_].count);
            _loc3_.property = logArr[_loc4_].property.split(",");
            _loc3_.nickName = logArr[_loc4_].nickName;
            _loc2_.push(_loc3_);
            _loc4_++;
         }
         _model.myGiftData = _loc2_;
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
