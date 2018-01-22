package quest
{
   import ddt.data.quest.QuestInfo;
   import ddt.events.PkgEvent;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SocketManager;
   import ddt.manager.TimeManager;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import road7th.comm.PackageIn;
   
   public class TrusteeshipManager extends EventDispatcher
   {
      
      public static const UPDATE_ALL_DATA:String = "update_all_data";
      
      public static const UPDATE_SPIRIT_VALUE:String = "update_spirit_value";
      
      private static var _instance:TrusteeshipManager;
       
      
      private var _spiritValue:int;
      
      private var _list:Vector.<TrusteeshipDataVo>;
      
      private var _maxCanStartCount:int = -1;
      
      private var _maxSpiritValue:int = -1;
      
      private var _buyOnceSpiritValue:int = -1;
      
      private var _buyOnceNeedMoney:int = -1;
      
      private var _speedUpOneMinNeedMoney:int = -1;
      
      public function TrusteeshipManager()
      {
         _list = new Vector.<TrusteeshipDataVo>();
         super(null);
      }
      
      public static function get instance() : TrusteeshipManager
      {
         if(_instance == null)
         {
            _instance = new TrusteeshipManager();
         }
         return _instance;
      }
      
      public function get list() : Vector.<TrusteeshipDataVo>
      {
         return _list;
      }
      
      public function get spiritValue() : int
      {
         return _spiritValue;
      }
      
      public function get speedUpOneMinNeedMoney() : int
      {
         if(_speedUpOneMinNeedMoney == -1)
         {
            _speedUpOneMinNeedMoney = int(ServerConfigManager.instance.serverConfigInfo["QuestCollocationAdvanceMinuteCost"].Value);
         }
         return _speedUpOneMinNeedMoney;
      }
      
      public function get buyOnceNeedMoney() : int
      {
         if(_buyOnceNeedMoney == -1)
         {
            _buyOnceNeedMoney = int(ServerConfigManager.instance.serverConfigInfo["QuestCollocationEnergyBuyCost"].Value);
         }
         return _buyOnceNeedMoney;
      }
      
      public function get buyOnceSpiritValue() : int
      {
         if(_buyOnceSpiritValue == -1)
         {
            _buyOnceSpiritValue = int(ServerConfigManager.instance.serverConfigInfo["QuestCollocationEnergyBuyCount"].Value);
         }
         return _buyOnceSpiritValue;
      }
      
      public function get maxSpiritValue() : int
      {
         if(_maxSpiritValue == -1)
         {
            _maxSpiritValue = int(ServerConfigManager.instance.serverConfigInfo["QuestCollocationEnergyMaxCount"].Value);
         }
         return _maxSpiritValue;
      }
      
      public function isCanStart() : Boolean
      {
         if(_maxCanStartCount == -1)
         {
            _maxCanStartCount = int(ServerConfigManager.instance.serverConfigInfo["QuestCollocationCount"].Value);
         }
         if(_list.length < _maxCanStartCount)
         {
            return true;
         }
         return false;
      }
      
      public function setup() : void
      {
         SocketManager.Instance.addEventListener(PkgEvent.format(140,1),updateData);
         SocketManager.Instance.addEventListener(PkgEvent.format(140,4),updateSpiritValue);
      }
      
      private function updateSpiritValue(param1:PkgEvent) : void
      {
         var _loc2_:PackageIn = param1.pkg;
         _spiritValue = _loc2_.readInt();
         dispatchEvent(new Event("update_spirit_value"));
      }
      
      private function updateData(param1:PkgEvent) : void
      {
         var _loc5_:int = 0;
         var _loc4_:* = null;
         var _loc3_:PackageIn = param1.pkg;
         _spiritValue = _loc3_.readInt();
         _list = new Vector.<TrusteeshipDataVo>();
         var _loc2_:int = _loc3_.readInt();
         _loc5_ = 0;
         while(_loc5_ < _loc2_)
         {
            _loc4_ = new TrusteeshipDataVo();
            _loc4_.id = _loc3_.readInt();
            _loc4_.endTime = _loc3_.readDate();
            _list.push(_loc4_);
            _loc5_++;
         }
         dispatchEvent(new Event("update_all_data"));
         isHasTrusteeshipQuestUnaviable();
      }
      
      public function isHasTrusteeshipQuestUnaviable() : Boolean
      {
         var _loc3_:* = null;
         var _loc2_:Boolean = false;
         var _loc5_:int = 0;
         var _loc4_:* = _list;
         for each(var _loc1_ in _list)
         {
            _loc3_ = TaskManager.instance.getQuestByID(_loc1_.id);
            if(!_loc3_ || !TaskManager.instance.isAvailableQuest(_loc3_,true))
            {
               SocketManager.Instance.out.sendTrusteeshipCancel(_loc1_.id);
               _loc2_ = true;
            }
         }
         TaskManager.instance.checkSendRequestAddQuestDic();
         return _loc2_;
      }
      
      public function isTrusteeshipQuestEnd(param1:int) : Boolean
      {
         var _loc4_:TrusteeshipDataVo = getTrusteeshipInfo(param1);
         if(!_loc4_)
         {
            return false;
         }
         var _loc3_:Number = _loc4_.endTime.getTime();
         var _loc2_:Number = TimeManager.Instance.Now().getTime();
         if(int((_loc3_ - _loc2_) / 1000) > 0)
         {
            return false;
         }
         return true;
      }
      
      public function getTrusteeshipInfo(param1:int) : TrusteeshipDataVo
      {
         var _loc3_:* = null;
         var _loc5_:int = 0;
         var _loc4_:* = _list;
         for each(var _loc2_ in _list)
         {
            if(_loc2_.id == param1)
            {
               _loc3_ = _loc2_;
               break;
            }
         }
         return _loc3_;
      }
   }
}
