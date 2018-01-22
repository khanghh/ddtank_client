package prayIndiana
{
   import ddt.events.CrazyTankSocketEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SocketManager;
   import ddt.manager.StateManager;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import hallIcon.HallIconManager;
   import prayIndiana.model.PrayIndianaModel;
   import road7th.comm.PackageIn;
   import tool.LoaderClass;
   
   public class PrayIndianaManager extends EventDispatcher
   {
      
      private static var _instance:PrayIndianaManager;
      
      public static const UPDATEGOODS:String = "updateGoods";
      
      public static const PRAYSTART:String = "prayStart";
      
      public static const UPDATE_LOTTERYNUMBER:String = "updateLotterynumber";
      
      public static const UPDATE_LOTTERY:String = "updatelottery";
      
      public static const PRAYINDIANA_OPEN_FRAME:String = "prayindianaOpenFrame";
      
      public static const PRAYINDIANA_DISPOSE:String = "prayindianaDispose";
       
      
      private var _model:PrayIndianaModel;
      
      public var showBuyCountFram:Boolean = true;
      
      public var showBuyCountFram1:Boolean = true;
      
      public var showBuyCountFram2:Boolean = true;
      
      public var showBuyCountFram3:Boolean = true;
      
      public function PrayIndianaManager(param1:PrivateClass){super();}
      
      public static function get Instance() : PrayIndianaManager{return null;}
      
      public function setup() : void{}
      
      private function __pkgHandler(param1:CrazyTankSocketEvent) : void{}
      
      private function activityOpen(param1:PackageIn = null) : void{}
      
      private function prayEnter(param1:PackageIn) : void{}
      
      private function prayExtract(param1:PackageIn) : void{}
      
      private function prayGoodsRefresh(param1:PackageIn) : void{}
      
      private function prayProbabiliy(param1:PackageIn) : void{}
      
      public function showPrayIndianaIcon(param1:Boolean) : void{}
      
      public function onClickIcon() : void{}
      
      private function showPrayIndianaView() : void{}
      
      public function get isOpen() : Boolean{return false;}
      
      public function get model() : PrayIndianaModel{return null;}
      
      public function set model(param1:PrayIndianaModel) : void{}
   }
}

class PrivateClass
{
    
   
   function PrivateClass(){super();}
}
