package groupPurchase
{
   import com.pickgliss.loader.BaseLoader;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.loader.LoaderEvent;
   import ddt.events.PkgEvent;
   import ddt.loader.LoaderCreate;
   import ddt.manager.SocketManager;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import groupPurchase.analyzer.GroupPurchaseAwardAnalyzer;
   import hallIcon.HallIconManager;
   import road7th.comm.PackageIn;
   
   public class GroupPurchaseManager extends EventDispatcher
   {
      
      public static const REFRESH_DATA:String = "GROUP_PURCHASE_REFRESH_DATA";
      
      public static const REFRESH_RANK_DATA:String = "GROUP_PURCHASE_REFRESH_RANK_DATA";
      
      public static const GROUPPURCHASE_SHOWFRAME:String = "GroupPurchaseShowFrame";
      
      private static var _instance:GroupPurchaseManager;
       
      
      private var _awardInfoList:Object;
      
      private var _isOpen:Boolean = false;
      
      private var _curTotalNum:int;
      
      private var _curMyNum:int;
      
      private var _itemId:int;
      
      private var _price:int;
      
      private var _isUseMoney:Boolean;
      
      private var _isUseBandMoney:Boolean;
      
      private var _endTime:Date;
      
      private var _discountList:Array;
      
      private var _miniNeedNum:int;
      
      private var _rankList:Array;
      
      public function GroupPurchaseManager(target:IEventDispatcher = null)
      {
         super(target);
      }
      
      public static function get instance() : GroupPurchaseManager
      {
         if(_instance == null)
         {
            _instance = new GroupPurchaseManager();
         }
         return _instance;
      }
      
      public function get awardInfoList() : Object
      {
         return _awardInfoList;
      }
      
      public function get itemId() : int
      {
         return _itemId;
      }
      
      public function get price() : int
      {
         return _price;
      }
      
      public function get isUseMoney() : Boolean
      {
         return _isUseMoney;
      }
      
      public function get isUseBandMoney() : Boolean
      {
         return _isUseBandMoney;
      }
      
      public function get endTime() : Date
      {
         return _endTime;
      }
      
      public function get miniNeedNum() : int
      {
         return _miniNeedNum;
      }
      
      public function get rankList() : Array
      {
         return _rankList;
      }
      
      public function get viewData() : Array
      {
         var curIndex:* = 0;
         var i:int = 0;
         var nextDiscount:int = 0;
         var nextNeedCount:int = 0;
         var nextReMoney:int = 0;
         var dataArray:Array = [];
         var len:int = _discountList.length;
         for(i = len - 1; i >= 0; )
         {
            if(_curTotalNum >= _discountList[i][0])
            {
               curIndex = i;
               break;
            }
            i--;
         }
         var curDiscount:int = _discountList[curIndex][1];
         if(curIndex == _discountList.length - 1)
         {
            nextDiscount = -1;
            nextNeedCount = -1;
         }
         else
         {
            nextDiscount = _discountList[curIndex + 1][1];
            nextNeedCount = _discountList[curIndex + 1][0];
         }
         var curReMoney:int = _curMyNum * _price * curDiscount / 100;
         if(nextDiscount == -1)
         {
            nextReMoney = _curMyNum * _price * curDiscount / 100;
         }
         else
         {
            nextReMoney = _curMyNum * _price * nextDiscount / 100;
         }
         dataArray.push(curDiscount);
         dataArray.push(nextDiscount);
         dataArray.push(nextNeedCount);
         dataArray.push(_curTotalNum);
         dataArray.push(_curMyNum);
         dataArray.push(curReMoney);
         dataArray.push(nextReMoney);
         return dataArray;
      }
      
      public function awardAnalyComplete(analyzer:GroupPurchaseAwardAnalyzer) : void
      {
         _awardInfoList = analyzer.awardList;
      }
      
      public function setup() : void
      {
         SocketManager.Instance.addEventListener(PkgEvent.format(144),pkgHandler);
      }
      
      private function pkgHandler(event:PkgEvent) : void
      {
         var pkg:PackageIn = event.pkg;
         var cmd:int = pkg.readByte();
         switch(int(cmd) - 1)
         {
            case 0:
               openOrClose(pkg);
               break;
            case 1:
               refreshPurchaseData(pkg);
               break;
            case 2:
               refreshRankData(pkg);
         }
      }
      
      private function refreshRankData(pkg:PackageIn) : void
      {
         var i:int = 0;
         var tmpObj:* = null;
         _rankList = [];
         var count:int = pkg.readInt();
         for(i = 0; i < count; )
         {
            tmpObj = {};
            tmpObj["rank"] = i + 1;
            tmpObj["name"] = pkg.readUTF();
            tmpObj["num"] = pkg.readInt();
            _rankList.push(tmpObj);
            i++;
         }
         dispatchEvent(new Event("GROUP_PURCHASE_REFRESH_RANK_DATA"));
      }
      
      private function refreshPurchaseData(pkg:PackageIn) : void
      {
         _curMyNum = pkg.readInt();
         _curTotalNum = pkg.readInt();
         dispatchEvent(new Event("GROUP_PURCHASE_REFRESH_DATA"));
      }
      
      private function openOrClose(pkg:PackageIn) : void
      {
         var loader:* = null;
         _isOpen = pkg.readBoolean();
         if(_isOpen)
         {
            _itemId = pkg.readInt();
            _price = pkg.readInt();
            _isUseMoney = pkg.readBoolean();
            _isUseBandMoney = pkg.readBoolean();
            _endTime = pkg.readDate();
            analyDiscountInfo(pkg.readUTF());
            _miniNeedNum = pkg.readInt();
            loader = LoaderCreate.Instance.createGroupPurchaseAwardInfoLoader();
            loader.addEventListener("complete",loadAwardInfoComplete);
            LoadResourceManager.Instance.startLoad(loader);
         }
         else
         {
            HallIconManager.instance.updateSwitchHandler("groupPurchase",false);
         }
      }
      
      private function analyDiscountInfo(discountStr:String) : void
      {
         var i:int = 0;
         var tmp:Array = discountStr.split("|");
         _discountList = [];
         _discountList.push([0,0]);
         var len:int = tmp.length;
         for(i = 0; i < len; )
         {
            _discountList.push(tmp[i].split(","));
            i++;
         }
      }
      
      private function loadAwardInfoComplete(event:LoaderEvent) : void
      {
         var loader:BaseLoader = event.loader as BaseLoader;
         loader.removeEventListener("complete",loadAwardInfoComplete);
         if(_isOpen)
         {
            showIcon();
         }
      }
      
      public function showFrame() : void
      {
         dispatchEvent(new Event("GroupPurchaseShowFrame"));
      }
      
      public function get isOpen() : Boolean
      {
         return _isOpen;
      }
      
      public function showIcon() : void
      {
         HallIconManager.instance.updateSwitchHandler("groupPurchase",true);
      }
   }
}
