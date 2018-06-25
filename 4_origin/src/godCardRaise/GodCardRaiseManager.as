package godCardRaise
{
   import com.pickgliss.ui.controls.BaseButton;
   import ddt.events.CEvent;
   import ddt.events.PkgEvent;
   import ddt.loader.LoaderCreate;
   import ddt.manager.ChatManager;
   import ddt.manager.GameInSocketOut;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SocketManager;
   import ddt.manager.TimeManager;
   import ddt.utils.AssetModuleLoader;
   import ddt.utils.HelperDataModuleLoad;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import flash.utils.Dictionary;
   import godCardRaise.analyzer.GodCardListAnalyzer;
   import godCardRaise.analyzer.GodCardListGroupAnalyzer;
   import godCardRaise.analyzer.GodCardPointRewardListAnalyzer;
   import godCardRaise.info.GodCardListGroupInfo;
   import godCardRaise.info.GodCardListInfo;
   import godCardRaise.info.GodCardPointRewardListInfo;
   import godCardRaise.model.GodCardRaiseModel;
   import hallIcon.HallIconManager;
   import road7th.comm.PackageIn;
   
   public class GodCardRaiseManager extends EventDispatcher
   {
      
      public static const SHOW_VIEW:String = "godCardRaise_show_view";
      
      public static const OPEN_CARD:String = "openCard";
      
      public static const OPERATE_CARD:String = "operateCard";
      
      public static const EXCHANGE:String = "exchange";
      
      public static const AWARD_INFO:String = "awardInfo";
      
      public static const CLOSE_VIEW:String = "closeView";
      
      private static var _instance:GodCardRaiseManager;
       
      
      private var _isOpen:Boolean = false;
      
      private var _icon:BaseButton;
      
      private var _dateEnd:Date;
      
      private var _model:GodCardRaiseModel;
      
      private var _godCardListInfoList:Dictionary;
      
      private var _godCardListGroupInfoList:Array;
      
      private var _godCardPointRewardListList:Vector.<GodCardPointRewardListInfo>;
      
      public var notShowAlertAgain:Boolean;
      
      public var buyIsBind:Boolean = true;
      
      private var _doubleTime:Date;
      
      public function GodCardRaiseManager(target:IEventDispatcher = null)
      {
         _dateEnd = new Date();
         super(target);
      }
      
      public static function get Instance() : GodCardRaiseManager
      {
         if(_instance == null)
         {
            _instance = new GodCardRaiseManager();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         _model = new GodCardRaiseModel();
         initEvent();
      }
      
      private function initEvent() : void
      {
         SocketManager.Instance.addEventListener(PkgEvent.format(329,32),onIsOpen);
         SocketManager.Instance.addEventListener(PkgEvent.format(329,20),onInit);
         SocketManager.Instance.addEventListener(PkgEvent.format(329,21),onOpenCard);
         SocketManager.Instance.addEventListener(PkgEvent.format(329,22),onOperateCard);
         SocketManager.Instance.addEventListener(PkgEvent.format(329,23),onExchange);
         SocketManager.Instance.addEventListener(PkgEvent.format(329,25),onAwardInfo);
      }
      
      private function test() : void
      {
         var a:int = 0;
         var godCardListInfo:* = null;
         var i:int = 0;
         var godCardListGroupInfo:* = null;
         var Cards:* = null;
         var cardId:int = 0;
         var j:int = 0;
         var rewardInfo:* = null;
         _model.cards[1] = 100;
         _model.chipCount = 500;
         _godCardListInfoList = new Dictionary();
         for(a = 0; a < 10; )
         {
            godCardListInfo = new GodCardListInfo();
            godCardListInfo.ID = a + 1;
            godCardListInfo.Name = "卡牌模板" + i;
            godCardListInfo.Pic = (a % 2 == 0?1:2) + "";
            godCardListInfo.Composition = 100;
            godCardListInfo.Decompose = 5;
            godCardListInfo.Level = 0;
            _godCardListInfoList[godCardListInfo.ID] = godCardListInfo;
            a++;
         }
         _godCardListGroupInfoList = [];
         for(i = 0; i < 20; )
         {
            godCardListGroupInfo = new GodCardListGroupInfo();
            godCardListGroupInfo.GroupID = i + 1;
            godCardListGroupInfo.GroupName = "测试卡组" + i;
            godCardListGroupInfo.ExchangeTimes = 2;
            Cards = [];
            cardId = i % 2 == 0?1:2;
            if(i % 2 == 0)
            {
               Cards.push({
                  "cardId":cardId,
                  "cardCount":5
               });
            }
            else if(i % 3 == 0)
            {
               Cards.push({
                  "cardId":cardId,
                  "cardCount":7
               });
               Cards.push({
                  "cardId":cardId,
                  "cardCount":9
               });
            }
            else
            {
               Cards.push({
                  "cardId":cardId,
                  "cardCount":3
               });
               Cards.push({
                  "cardId":cardId,
                  "cardCount":3
               });
               Cards.push({
                  "cardId":cardId,
                  "cardCount":3
               });
            }
            godCardListGroupInfo.Cards = Cards;
            godCardListGroupInfo.GiftID = 1120 + i;
            _godCardListGroupInfoList.push(godCardListGroupInfo);
            i++;
         }
         _godCardPointRewardListList = new Vector.<GodCardPointRewardListInfo>();
         for(j = 0; j < 10; )
         {
            rewardInfo = new GodCardPointRewardListInfo();
            rewardInfo.ID = j;
            rewardInfo.ItemID = 1120 + i;
            rewardInfo.Count = 2;
            rewardInfo.Point = 100 * (i + 1);
            rewardInfo.Valid = 7;
            _godCardPointRewardListList.push(rewardInfo);
            j++;
         }
         _model.awardIds[1] = 1;
      }
      
      protected function onIsOpen(e:PkgEvent) : void
      {
         var pkg:PackageIn = e.pkg;
         var isOpen:Boolean = pkg.readBoolean();
         _dateEnd = pkg.readDate();
         _isOpen = isOpen;
         if(_isOpen)
         {
            ChatManager.Instance.sysChatAmaranth(LanguageMgr.GetTranslation("godCardRaise.beginTips"));
         }
         else
         {
            ChatManager.Instance.sysChatAmaranth(LanguageMgr.GetTranslation("godCardRaise.endTips"));
         }
         checkIcon();
         if(!_isOpen)
         {
            dispatchEvent(new CEvent("closeView"));
         }
      }
      
      private function onInit(e:PkgEvent) : void
      {
         var i:int = 0;
         var id:int = 0;
         var count:int = 0;
         var j:int = 0;
         var h:int = 0;
         var groupId:int = 0;
         var exchangeCount:int = 0;
         var pkg:PackageIn = e.pkg;
         var cards:Dictionary = new Dictionary();
         var length:int = pkg.readInt();
         for(i = 0; i < length; )
         {
            id = pkg.readInt();
            count = pkg.readInt();
            cards[id] = count;
            i++;
         }
         _model.cards = cards;
         _model.score = pkg.readInt();
         _model.chipCount = pkg.readInt();
         _model.freeCount = pkg.readInt();
         var awardIdsLength:int = pkg.readInt();
         for(j = 0; j < awardIdsLength; )
         {
            _model.awardIds[pkg.readInt()] = 1;
            j++;
         }
         var groupsLength:int = pkg.readInt();
         for(h = 0; h < groupsLength; )
         {
            groupId = pkg.readInt();
            exchangeCount = pkg.readInt();
            _model.groups[groupId] = exchangeCount;
            h++;
         }
         _doubleTime = e.pkg.readDate();
         dispatchEvent(new CEvent("godCardRaise_show_view"));
      }
      
      private function onOpenCard(e:PkgEvent) : void
      {
         var i:int = 0;
         var cardId:int = 0;
         var cardCount:int = 0;
         var pkg:PackageIn = e.pkg;
         var cards:Array = [];
         var length:int = pkg.readInt();
         for(i = 0; i < length; )
         {
            cardId = pkg.readInt();
            cards.push(cardId);
            cardCount = _model.cards[cardId];
            _model.cards[cardId] = cardCount + 1;
            i++;
         }
         _model.score = pkg.readInt();
         _model.freeCount = pkg.readInt();
         dispatchEvent(new CEvent("openCard",cards));
      }
      
      private function onOperateCard(e:PkgEvent) : void
      {
         var pkg:PackageIn = e.pkg;
         var cardId:int = pkg.readInt();
         var cardCount:int = pkg.readInt();
         var clipCount:int = pkg.readInt();
         _model.cards[cardId] = cardCount;
         _model.chipCount = clipCount;
         dispatchEvent(new CEvent("operateCard"));
      }
      
      private function onExchange(e:PkgEvent) : void
      {
         var i:int = 0;
         var cardId:int = 0;
         var cardCount:int = 0;
         var pkg:PackageIn = e.pkg;
         var groupId:int = pkg.readInt();
         var exchangeCount:int = pkg.readInt();
         GodCardRaiseManager.Instance.model.groups[groupId] = exchangeCount;
         var cardsLength:int = pkg.readInt();
         for(i = 0; i < cardsLength; )
         {
            cardId = pkg.readInt();
            cardCount = pkg.readInt();
            _model.cards[cardId] = cardCount;
            i++;
         }
         dispatchEvent(new CEvent("exchange"));
      }
      
      private function onPointAwardAttribute(e:PkgEvent) : void
      {
      }
      
      public function getMyCardCount(cardID:int = 0) : int
      {
         if(_model.cards[cardID] != null)
         {
            return _model.cards[cardID];
         }
         return 0;
      }
      
      private function onAwardInfo(e:PkgEvent) : void
      {
         var i:int = 0;
         var pkg:PackageIn = e.pkg;
         var length:int = pkg.readInt();
         for(i = 0; i < length; )
         {
            _model.awardIds[pkg.readInt()] = 1;
            i++;
         }
         dispatchEvent(new CEvent("awardInfo"));
      }
      
      public function loadGodCardListTemplate(anlyzer:GodCardListAnalyzer) : void
      {
         _godCardListInfoList = anlyzer.list;
      }
      
      public function loadGodCardListGroup(anlyzer:GodCardListGroupAnalyzer) : void
      {
         _godCardListGroupInfoList = anlyzer.list;
      }
      
      public function loadGodCardPointRewardList(anlyzer:GodCardPointRewardListAnalyzer) : void
      {
         _godCardPointRewardListList = anlyzer.list;
      }
      
      public function get godCardListInfoList() : Dictionary
      {
         return _godCardListInfoList;
      }
      
      public function getGodCardListInfoListByLevel(level:int) : Array
      {
         var arr:Array = [];
         var _loc5_:int = 0;
         var _loc4_:* = _godCardListInfoList;
         for each(var info in _godCardListInfoList)
         {
            if(level == info.Level)
            {
               arr.push(info);
            }
         }
         arr.sortOn("ID",16);
         return arr;
      }
      
      public function get godCardListGroupInfoList() : Array
      {
         return _godCardListGroupInfoList;
      }
      
      public function getGodCardListGroupInfo(groupId:int) : GodCardListGroupInfo
      {
         var currentInfo:* = null;
         var _loc5_:int = 0;
         var _loc4_:* = _godCardListGroupInfoList;
         for each(var info in _godCardListGroupInfoList)
         {
            if(info.GroupID == groupId)
            {
               currentInfo = info;
               break;
            }
         }
         return currentInfo;
      }
      
      public function get godCardPointRewardList() : Vector.<GodCardPointRewardListInfo>
      {
         return _godCardPointRewardListList;
      }
      
      public function calculateExchangeCount(groupInfo:GodCardListGroupInfo) : int
      {
         var i:int = 0;
         var obj:* = null;
         var cardId:int = 0;
         var cardCount:int = 0;
         var myCardCount:int = 0;
         var exchangeCount:int = groupInfo.Cards.length;
         var myCards:Dictionary = model.cards;
         for(i = 0; i < groupInfo.Cards.length; )
         {
            obj = groupInfo.Cards[i];
            cardId = obj["cardId"];
            cardCount = obj["cardCount"];
            myCardCount = myCards[cardId];
            if(myCardCount < cardCount)
            {
               exchangeCount--;
            }
            i++;
         }
         return exchangeCount;
      }
      
      public function checkIcon() : void
      {
         if(_isOpen)
         {
            showIcon();
         }
         else
         {
            hideIcon();
         }
      }
      
      private function showIcon() : void
      {
         HallIconManager.instance.updateSwitchHandler("godCard",true);
      }
      
      private function hideIcon() : void
      {
         HallIconManager.instance.updateSwitchHandler("godCard",false);
      }
      
      public function show() : void
      {
         AssetModuleLoader.addRequestLoader(LoaderCreate.Instance.creatGodCardListTemplate());
         AssetModuleLoader.addModelLoader("godCardRaise",6);
         AssetModuleLoader.startCodeLoader(loadShowFrameData);
      }
      
      private function loadShowFrameData() : void
      {
         new HelperDataModuleLoad().loadDataModule([LoaderCreate.Instance.creatGodCardListGroup,LoaderCreate.Instance.creatGodCardPointRewardList],function():void
         {
            GameInSocketOut.sendGodCardInfoAttribute();
         },null,true);
      }
      
      public function get dataEnd() : Date
      {
         return _dateEnd;
      }
      
      public function get model() : GodCardRaiseModel
      {
         return _model;
      }
      
      public function get doubleTime() : Number
      {
         return _doubleTime.time - TimeManager.Instance.NowTime();
      }
   }
}
