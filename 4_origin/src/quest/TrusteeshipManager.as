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
      
      private function updateSpiritValue(event:PkgEvent) : void
      {
         var pkg:PackageIn = event.pkg;
         _spiritValue = pkg.readInt();
         dispatchEvent(new Event("update_spirit_value"));
      }
      
      private function updateData(event:PkgEvent) : void
      {
         var i:int = 0;
         var tmpvo:* = null;
         var pkg:PackageIn = event.pkg;
         _spiritValue = pkg.readInt();
         _list = new Vector.<TrusteeshipDataVo>();
         var count:int = pkg.readInt();
         for(i = 0; i < count; )
         {
            tmpvo = new TrusteeshipDataVo();
            tmpvo.id = pkg.readInt();
            tmpvo.endTime = pkg.readDate();
            _list.push(tmpvo);
            i++;
         }
         dispatchEvent(new Event("update_all_data"));
         isHasTrusteeshipQuestUnaviable();
      }
      
      public function isHasTrusteeshipQuestUnaviable() : Boolean
      {
         var tmpInfo:* = null;
         var tmpTag:Boolean = false;
         var _loc5_:int = 0;
         var _loc4_:* = _list;
         for each(var tmpData in _list)
         {
            tmpInfo = TaskManager.instance.getQuestByID(tmpData.id);
            if(!tmpInfo || !TaskManager.instance.isAvailableQuest(tmpInfo,true))
            {
               SocketManager.Instance.out.sendTrusteeshipCancel(tmpData.id);
               tmpTag = true;
            }
         }
         TaskManager.instance.checkSendRequestAddQuestDic();
         return tmpTag;
      }
      
      public function isTrusteeshipQuestEnd(questId:int) : Boolean
      {
         var vo:TrusteeshipDataVo = getTrusteeshipInfo(questId);
         if(!vo)
         {
            return false;
         }
         var endTimestamp:Number = vo.endTime.getTime();
         var nowTimestamp:Number = TimeManager.Instance.Now().getTime();
         if(int((endTimestamp - nowTimestamp) / 1000) > 0)
         {
            return false;
         }
         return true;
      }
      
      public function getTrusteeshipInfo(questId:int) : TrusteeshipDataVo
      {
         var info:* = null;
         var _loc5_:int = 0;
         var _loc4_:* = _list;
         for each(var tmp in _list)
         {
            if(tmp.id == questId)
            {
               info = tmp;
               break;
            }
         }
         return info;
      }
   }
}
