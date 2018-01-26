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
      
      public function GroupPurchaseManager(param1:IEventDispatcher = null){super(null);}
      
      public static function get instance() : GroupPurchaseManager{return null;}
      
      public function get awardInfoList() : Object{return null;}
      
      public function get itemId() : int{return 0;}
      
      public function get price() : int{return 0;}
      
      public function get isUseMoney() : Boolean{return false;}
      
      public function get isUseBandMoney() : Boolean{return false;}
      
      public function get endTime() : Date{return null;}
      
      public function get miniNeedNum() : int{return 0;}
      
      public function get rankList() : Array{return null;}
      
      public function get viewData() : Array{return null;}
      
      public function awardAnalyComplete(param1:GroupPurchaseAwardAnalyzer) : void{}
      
      public function setup() : void{}
      
      private function pkgHandler(param1:PkgEvent) : void{}
      
      private function refreshRankData(param1:PackageIn) : void{}
      
      private function refreshPurchaseData(param1:PackageIn) : void{}
      
      private function openOrClose(param1:PackageIn) : void{}
      
      private function analyDiscountInfo(param1:String) : void{}
      
      private function loadAwardInfoComplete(param1:LoaderEvent) : void{}
      
      public function showFrame() : void{}
      
      public function get isOpen() : Boolean{return false;}
      
      public function showIcon() : void{}
   }
}
