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
      
      public function GodCardRaiseManager(param1:IEventDispatcher = null)
      {
         _dateEnd = new Date();
         super(param1);
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
         var _loc4_:int = 0;
         var _loc3_:* = null;
         var _loc8_:int = 0;
         var _loc5_:* = null;
         var _loc7_:* = null;
         var _loc2_:int = 0;
         var _loc6_:int = 0;
         var _loc1_:* = null;
         _model.cards[1] = 100;
         _model.chipCount = 500;
         _godCardListInfoList = new Dictionary();
         _loc4_ = 0;
         while(_loc4_ < 10)
         {
            _loc3_ = new GodCardListInfo();
            _loc3_.ID = _loc4_ + 1;
            _loc3_.Name = "卡牌模板" + _loc8_;
            _loc3_.Pic = (_loc4_ % 2 == 0?1:2) + "";
            _loc3_.Composition = 100;
            _loc3_.Decompose = 5;
            _loc3_.Level = 0;
            _godCardListInfoList[_loc3_.ID] = _loc3_;
            _loc4_++;
         }
         _godCardListGroupInfoList = [];
         _loc8_ = 0;
         while(_loc8_ < 20)
         {
            _loc5_ = new GodCardListGroupInfo();
            _loc5_.GroupID = _loc8_ + 1;
            _loc5_.GroupName = "测试卡组" + _loc8_;
            _loc5_.ExchangeTimes = 2;
            _loc7_ = [];
            _loc2_ = _loc8_ % 2 == 0?1:2;
            if(_loc8_ % 2 == 0)
            {
               _loc7_.push({
                  "cardId":_loc2_,
                  "cardCount":5
               });
            }
            else if(_loc8_ % 3 == 0)
            {
               _loc7_.push({
                  "cardId":_loc2_,
                  "cardCount":7
               });
               _loc7_.push({
                  "cardId":_loc2_,
                  "cardCount":9
               });
            }
            else
            {
               _loc7_.push({
                  "cardId":_loc2_,
                  "cardCount":3
               });
               _loc7_.push({
                  "cardId":_loc2_,
                  "cardCount":3
               });
               _loc7_.push({
                  "cardId":_loc2_,
                  "cardCount":3
               });
            }
            _loc5_.Cards = _loc7_;
            _loc5_.GiftID = 1120 + _loc8_;
            _godCardListGroupInfoList.push(_loc5_);
            _loc8_++;
         }
         _godCardPointRewardListList = new Vector.<GodCardPointRewardListInfo>();
         _loc6_ = 0;
         while(_loc6_ < 10)
         {
            _loc1_ = new GodCardPointRewardListInfo();
            _loc1_.ID = _loc6_;
            _loc1_.ItemID = 1120 + _loc8_;
            _loc1_.Count = 2;
            _loc1_.Point = 100 * (_loc8_ + 1);
            _loc1_.Valid = 7;
            _godCardPointRewardListList.push(_loc1_);
            _loc6_++;
         }
         _model.awardIds[1] = 1;
      }
      
      protected function onIsOpen(param1:PkgEvent) : void
      {
         var _loc2_:PackageIn = param1.pkg;
         var _loc3_:Boolean = _loc2_.readBoolean();
         _dateEnd = _loc2_.readDate();
         _isOpen = _loc3_;
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
      
      private function onInit(param1:PkgEvent) : void
      {
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         var _loc6_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc3_:PackageIn = param1.pkg;
         var _loc13_:Dictionary = new Dictionary();
         var _loc11_:int = _loc3_.readInt();
         _loc7_ = 0;
         while(_loc7_ < _loc11_)
         {
            _loc8_ = _loc3_.readInt();
            _loc2_ = _loc3_.readInt();
            _loc13_[_loc8_] = _loc2_;
            _loc7_++;
         }
         _model.cards = _loc13_;
         _model.score = _loc3_.readInt();
         _model.chipCount = _loc3_.readInt();
         _model.freeCount = _loc3_.readInt();
         var _loc5_:int = _loc3_.readInt();
         _loc4_ = 0;
         while(_loc4_ < _loc5_)
         {
            _model.awardIds[_loc3_.readInt()] = 1;
            _loc4_++;
         }
         var _loc12_:int = _loc3_.readInt();
         _loc6_ = 0;
         while(_loc6_ < _loc12_)
         {
            _loc9_ = _loc3_.readInt();
            _loc10_ = _loc3_.readInt();
            _model.groups[_loc9_] = _loc10_;
            _loc6_++;
         }
         _doubleTime = param1.pkg.readDate();
         dispatchEvent(new CEvent("godCardRaise_show_view"));
      }
      
      private function onOpenCard(param1:PkgEvent) : void
      {
         var _loc7_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc5_:PackageIn = param1.pkg;
         var _loc6_:Array = [];
         var _loc4_:int = _loc5_.readInt();
         _loc7_ = 0;
         while(_loc7_ < _loc4_)
         {
            _loc2_ = _loc5_.readInt();
            _loc6_.push(_loc2_);
            _loc3_ = _model.cards[_loc2_];
            _model.cards[_loc2_] = _loc3_ + 1;
            _loc7_++;
         }
         _model.score = _loc5_.readInt();
         _model.freeCount = _loc5_.readInt();
         dispatchEvent(new CEvent("openCard",_loc6_));
      }
      
      private function onOperateCard(param1:PkgEvent) : void
      {
         var _loc5_:PackageIn = param1.pkg;
         var _loc2_:int = _loc5_.readInt();
         var _loc4_:int = _loc5_.readInt();
         var _loc3_:int = _loc5_.readInt();
         _model.cards[_loc2_] = _loc4_;
         _model.chipCount = _loc3_;
         dispatchEvent(new CEvent("operateCard"));
      }
      
      private function onExchange(param1:PkgEvent) : void
      {
         var _loc8_:int = 0;
         var _loc2_:int = 0;
         var _loc5_:int = 0;
         var _loc7_:PackageIn = param1.pkg;
         var _loc4_:int = _loc7_.readInt();
         var _loc6_:int = _loc7_.readInt();
         GodCardRaiseManager.Instance.model.groups[_loc4_] = _loc6_;
         var _loc3_:int = _loc7_.readInt();
         _loc8_ = 0;
         while(_loc8_ < _loc3_)
         {
            _loc2_ = _loc7_.readInt();
            _loc5_ = _loc7_.readInt();
            _model.cards[_loc2_] = _loc5_;
            _loc8_++;
         }
         dispatchEvent(new CEvent("exchange"));
      }
      
      private function onPointAwardAttribute(param1:PkgEvent) : void
      {
      }
      
      public function getMyCardCount(param1:int = 0) : int
      {
         if(_model.cards[param1] != null)
         {
            return _model.cards[param1];
         }
         return 0;
      }
      
      private function onAwardInfo(param1:PkgEvent) : void
      {
         var _loc4_:int = 0;
         var _loc3_:PackageIn = param1.pkg;
         var _loc2_:int = _loc3_.readInt();
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            _model.awardIds[_loc3_.readInt()] = 1;
            _loc4_++;
         }
         dispatchEvent(new CEvent("awardInfo"));
      }
      
      public function loadGodCardListTemplate(param1:GodCardListAnalyzer) : void
      {
         _godCardListInfoList = param1.list;
      }
      
      public function loadGodCardListGroup(param1:GodCardListGroupAnalyzer) : void
      {
         _godCardListGroupInfoList = param1.list;
      }
      
      public function loadGodCardPointRewardList(param1:GodCardPointRewardListAnalyzer) : void
      {
         _godCardPointRewardListList = param1.list;
      }
      
      public function get godCardListInfoList() : Dictionary
      {
         return _godCardListInfoList;
      }
      
      public function getGodCardListInfoListByLevel(param1:int) : Array
      {
         var _loc2_:Array = [];
         var _loc5_:int = 0;
         var _loc4_:* = _godCardListInfoList;
         for each(var _loc3_ in _godCardListInfoList)
         {
            if(param1 == _loc3_.Level)
            {
               _loc2_.push(_loc3_);
            }
         }
         _loc2_.sortOn("ID",16);
         return _loc2_;
      }
      
      public function get godCardListGroupInfoList() : Array
      {
         return _godCardListGroupInfoList;
      }
      
      public function getGodCardListGroupInfo(param1:int) : GodCardListGroupInfo
      {
         var _loc2_:* = null;
         var _loc5_:int = 0;
         var _loc4_:* = _godCardListGroupInfoList;
         for each(var _loc3_ in _godCardListGroupInfoList)
         {
            if(_loc3_.GroupID == param1)
            {
               _loc2_ = _loc3_;
               break;
            }
         }
         return _loc2_;
      }
      
      public function get godCardPointRewardList() : Vector.<GodCardPointRewardListInfo>
      {
         return _godCardPointRewardListList;
      }
      
      public function calculateExchangeCount(param1:GodCardListGroupInfo) : int
      {
         var _loc8_:int = 0;
         var _loc6_:* = null;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc7_:int = 0;
         var _loc4_:int = param1.Cards.length;
         var _loc5_:Dictionary = model.cards;
         _loc8_ = 0;
         while(_loc8_ < param1.Cards.length)
         {
            _loc6_ = param1.Cards[_loc8_];
            _loc2_ = _loc6_["cardId"];
            _loc3_ = _loc6_["cardCount"];
            _loc7_ = _loc5_[_loc2_];
            if(_loc7_ < _loc3_)
            {
               _loc4_--;
            }
            _loc8_++;
         }
         return _loc4_;
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
