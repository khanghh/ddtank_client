package cardSystem.model
{
   import cardSystem.CardSocketEvent;
   import cardSystem.data.CardInfo;
   import cardSystem.data.GrooveInfo;
   import cardSystem.data.SetsInfo;
   import cardSystem.data.SetsUpgradeRuleInfo;
   import ddt.manager.PlayerManager;
   import flash.events.EventDispatcher;
   import road7th.data.DictionaryData;
   
   public class CardModel extends EventDispatcher
   {
      
      public static const OPEN_FOUR_NEEDS_TWOSTAR:int = 1;
      
      public static const OPEN_FIVE_NEEDS_THREESTAR:int = 2;
      
      public static const OPEN_FIVE_NEEDS_THREESTARTWO:int = 3;
      
      public static const MONSTER_CARDS:int = 0;
      
      public static const WEQPON_CARDS:int = 1;
      
      public static const PVE_CARDS:int = 2;
      
      public static const CELLS_SUM:int = 15;
      
      public static const EQUIP_CELLS_SUM:int = 5;
       
      
      private var _setsList:DictionaryData;
      
      private var _setsSortRuleVector:Vector.<SetsInfo>;
      
      public var upgradeRuleVec:Vector.<SetsUpgradeRuleInfo>;
      
      public var propIncreaseDic:DictionaryData;
      
      private var _inputSoul:int;
      
      private var _grooveinfo:Vector.<GrooveInfo>;
      
      private var _playerid:int;
      
      public var tempCardGroove:GrooveInfo;
      
      public var achievementProperty:Array;
      
      public var achievementProgress:DictionaryData;
      
      public var achievementData:DictionaryData;
      
      public function CardModel()
      {
         super();
         achievementProperty = [0,0,0,0,0,0,0,0];
         achievementProgress = new DictionaryData();
      }
      
      public function get setsSortRuleVector() : Vector.<SetsInfo>
      {
         return _setsSortRuleVector;
      }
      
      public function set setsSortRuleVector(value:Vector.<SetsInfo>) : void
      {
         _setsSortRuleVector = value;
         dispatchEvent(new CardSocketEvent("setsSortRuleInitComplete",setsSortRuleVector));
      }
      
      public function set GrooveInfoVector(value:Vector.<GrooveInfo>) : void
      {
         _grooveinfo = value;
      }
      
      public function get GrooveInfoVector() : Vector.<GrooveInfo>
      {
         if(_grooveinfo == null)
         {
            return null;
         }
         return _grooveinfo;
      }
      
      public function set PlayerId(value:int) : void
      {
         _playerid = value;
      }
      
      public function get PlayerId() : int
      {
         return _playerid;
      }
      
      public function get setsList() : DictionaryData
      {
         return _setsList;
      }
      
      public function set setsList(value:DictionaryData) : void
      {
         _setsList = value;
         dispatchEvent(new CardSocketEvent("setsPropIntComplete",setsList));
      }
      
      public function get inputSoul() : int
      {
         return _inputSoul;
      }
      
      public function set inputSoul(value:int) : void
      {
         _inputSoul = value;
      }
      
      public function fourIsOpen() : Boolean
      {
         var num:int = 0;
         var _loc4_:int = 0;
         var _loc3_:* = PlayerManager.Instance.Self.cardBagDic;
         for each(var cardInfo in PlayerManager.Instance.Self.cardBagDic)
         {
            if(cardInfo.Level >= 20)
            {
               num++;
            }
         }
         return num >= 1;
      }
      
      public function fiveIsOpen() : Boolean
      {
         var num:int = 0;
         var _loc4_:int = 0;
         var _loc3_:* = PlayerManager.Instance.Self.cardBagDic;
         for each(var cardInfo in PlayerManager.Instance.Self.cardBagDic)
         {
            if(cardInfo.Level == 30)
            {
               num++;
            }
         }
         return num >= 1;
      }
      
      public function fiveIsOpen2() : Boolean
      {
         var num:int = 0;
         var _loc4_:int = 0;
         var _loc3_:* = PlayerManager.Instance.Self.cardBagDic;
         for each(var cardInfo in PlayerManager.Instance.Self.cardBagDic)
         {
            if(cardInfo.Level >= 20)
            {
               num++;
            }
         }
         return num >= 3;
      }
      
      public function get Pages() : int
      {
         return Math.ceil(PlayerManager.Instance.Self.cardBagDic.length / 15);
      }
      
      public function getDataByPage(nowPage:int) : DictionaryData
      {
         var result:DictionaryData = new DictionaryData();
         var data:DictionaryData = PlayerManager.Instance.Self.cardBagDic;
         var up:int = (nowPage - 1) * 15 + 5;
         var down:int = up + 15;
         var _loc8_:int = 0;
         var _loc7_:* = data;
         for each(var info in data)
         {
            if(info.Place >= up && info.Place < down)
            {
               result[info.Place] = info;
            }
         }
         return result;
      }
      
      public function getBagListData() : Array
      {
         var m:int = 0;
         var n:int = 0;
         var i:int = 0;
         var result:Array = [];
         var data:DictionaryData = PlayerManager.Instance.Self.cardBagDic;
         var max:int = 0;
         var _loc9_:int = 0;
         var _loc8_:* = data;
         for each(var info in data)
         {
            m = info.Place % 4 == 0?info.Place / 4 - 2:Number(info.Place / 4 - 1);
            if(result[m] == null)
            {
               result[m] = [];
            }
            n = info.Place % 4 == 0?4:Number(info.Place % 4);
            result[m][0] = m + 1;
            result[m][n] = info;
            if(m + 1 > max)
            {
               max = m + 1;
            }
         }
         if(max < 3)
         {
            max = 3;
         }
         i = 0;
         while(i < max)
         {
            if(result[i] == null)
            {
               result[i] = [];
               result[i][0] = i + 1;
            }
            i++;
         }
         return result;
      }
      
      public function getSetsCardFromCardBag(setsId:String) : Vector.<CardInfo>
      {
         var data:DictionaryData = PlayerManager.Instance.Self.cardBagDic;
         var infoVec:Vector.<CardInfo> = new Vector.<CardInfo>();
         var _loc6_:int = 0;
         var _loc5_:* = data;
         for each(var cardInfo in data)
         {
            if(cardInfo.templateInfo.Property7 == setsId)
            {
               infoVec.push(cardInfo);
            }
         }
         return infoVec;
      }
   }
}
