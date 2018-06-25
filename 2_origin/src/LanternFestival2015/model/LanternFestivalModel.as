package LanternFestival2015.model
{
   import ddt.data.BagInfo;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   
   public class LanternFestivalModel
   {
       
      
      private var _isActivityOpen:Boolean = false;
      
      private var _numSendRemain:int;
      
      private var _numReceiveRemain:int;
      
      public var tpIDFilling:int = 12504;
      
      public var tpIDRice:int = 12505;
      
      public var tpIDLantern:int = 12506;
      
      public var tpIDCookedLantern:int = 1120321;
      
      private var _maxVisitTimes:int;
      
      private var _maxBeVisitedTimes:int;
      
      private var _cookPrice:int;
      
      private var _inited:Boolean = false;
      
      public function LanternFestivalModel()
      {
         super();
      }
      
      public function get isActivityOpen() : Boolean
      {
         return _isActivityOpen;
      }
      
      public function set isActivityOpen(value:Boolean) : void
      {
         _isActivityOpen = value;
      }
      
      public function set numSendRemain(value:int) : void
      {
         _numSendRemain = value;
      }
      
      public function get numSendRemain() : int
      {
         return _numSendRemain;
      }
      
      public function set numReceiveRemain(value:int) : void
      {
         _numReceiveRemain = value;
      }
      
      public function get numReceiveRemain() : int
      {
         return _numReceiveRemain;
      }
      
      public function maxLanternCanMake() : int
      {
         var bagInfo:BagInfo = PlayerManager.Instance.Self.getBag(1);
         var countRice:int = bagInfo.getItemCountByTemplateId(tpIDRice);
         var countFilling:int = bagInfo.getItemCountByTemplateId(tpIDFilling);
         return Math.min(countFilling,countRice);
      }
      
      public function get maxVisitTimes() : int
      {
         return _maxVisitTimes;
      }
      
      public function get maxBeVisitedTimes() : int
      {
         return _maxBeVisitedTimes;
      }
      
      public function get cookPrice() : int
      {
         return _cookPrice;
      }
      
      public function initData() : void
      {
         if(_inited == false)
         {
            _inited = true;
            _maxVisitTimes = ServerConfigManager.instance.lanternMaxHomeVisits;
            _maxBeVisitedTimes = ServerConfigManager.instance.lanternMaxHomeVisited;
            _cookPrice = ServerConfigManager.instance.lanternCookLanternGold;
            return;
         }
      }
   }
}
