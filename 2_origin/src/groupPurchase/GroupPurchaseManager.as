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
      
      public function GroupPurchaseManager(param1:IEventDispatcher = null)
      {
         super(param1);
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
         var _loc2_:* = 0;
         var _loc9_:int = 0;
         var _loc1_:int = 0;
         var _loc6_:int = 0;
         var _loc4_:int = 0;
         var _loc3_:Array = [];
         var _loc7_:int = _discountList.length;
         _loc9_ = _loc7_ - 1;
         while(_loc9_ >= 0)
         {
            if(_curTotalNum >= _discountList[_loc9_][0])
            {
               _loc2_ = _loc9_;
               break;
            }
            _loc9_--;
         }
         var _loc5_:int = _discountList[_loc2_][1];
         if(_loc2_ == _discountList.length - 1)
         {
            _loc1_ = -1;
            _loc6_ = -1;
         }
         else
         {
            _loc1_ = _discountList[_loc2_ + 1][1];
            _loc6_ = _discountList[_loc2_ + 1][0];
         }
         var _loc8_:int = _curMyNum * _price * _loc5_ / 100;
         if(_loc1_ == -1)
         {
            _loc4_ = _curMyNum * _price * _loc5_ / 100;
         }
         else
         {
            _loc4_ = _curMyNum * _price * _loc1_ / 100;
         }
         _loc3_.push(_loc5_);
         _loc3_.push(_loc1_);
         _loc3_.push(_loc6_);
         _loc3_.push(_curTotalNum);
         _loc3_.push(_curMyNum);
         _loc3_.push(_loc8_);
         _loc3_.push(_loc4_);
         return _loc3_;
      }
      
      public function awardAnalyComplete(param1:GroupPurchaseAwardAnalyzer) : void
      {
         _awardInfoList = param1.awardList;
      }
      
      public function setup() : void
      {
         SocketManager.Instance.addEventListener(PkgEvent.format(144),pkgHandler);
      }
      
      private function pkgHandler(param1:PkgEvent) : void
      {
         var _loc3_:PackageIn = param1.pkg;
         var _loc2_:int = _loc3_.readByte();
         switch(int(_loc2_) - 1)
         {
            case 0:
               openOrClose(_loc3_);
               break;
            case 1:
               refreshPurchaseData(_loc3_);
               break;
            case 2:
               refreshRankData(_loc3_);
         }
      }
      
      private function refreshRankData(param1:PackageIn) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = null;
         _rankList = [];
         var _loc2_:int = param1.readInt();
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            _loc3_ = {};
            _loc3_["rank"] = _loc4_ + 1;
            _loc3_["name"] = param1.readUTF();
            _loc3_["num"] = param1.readInt();
            _rankList.push(_loc3_);
            _loc4_++;
         }
         dispatchEvent(new Event("GROUP_PURCHASE_REFRESH_RANK_DATA"));
      }
      
      private function refreshPurchaseData(param1:PackageIn) : void
      {
         _curMyNum = param1.readInt();
         _curTotalNum = param1.readInt();
         dispatchEvent(new Event("GROUP_PURCHASE_REFRESH_DATA"));
      }
      
      private function openOrClose(param1:PackageIn) : void
      {
         var _loc2_:* = null;
         _isOpen = param1.readBoolean();
         if(_isOpen)
         {
            _itemId = param1.readInt();
            _price = param1.readInt();
            _isUseMoney = param1.readBoolean();
            _isUseBandMoney = param1.readBoolean();
            _endTime = param1.readDate();
            analyDiscountInfo(param1.readUTF());
            _miniNeedNum = param1.readInt();
            _loc2_ = LoaderCreate.Instance.createGroupPurchaseAwardInfoLoader();
            _loc2_.addEventListener("complete",loadAwardInfoComplete);
            LoadResourceManager.Instance.startLoad(_loc2_);
         }
         else
         {
            HallIconManager.instance.updateSwitchHandler("groupPurchase",false);
         }
      }
      
      private function analyDiscountInfo(param1:String) : void
      {
         var _loc4_:int = 0;
         var _loc2_:Array = param1.split("|");
         _discountList = [];
         _discountList.push([0,0]);
         var _loc3_:int = _loc2_.length;
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _discountList.push(_loc2_[_loc4_].split(","));
            _loc4_++;
         }
      }
      
      private function loadAwardInfoComplete(param1:LoaderEvent) : void
      {
         var _loc2_:BaseLoader = param1.loader as BaseLoader;
         _loc2_.removeEventListener("complete",loadAwardInfoComplete);
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
