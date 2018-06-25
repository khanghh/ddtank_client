package cardSystem
{
   import cardSystem.analyze.CardAchievementAnalyze;
   import cardSystem.analyze.CardPropIncreaseRuleAnalyzer;
   import cardSystem.analyze.SetsPropertiesAnalyzer;
   import cardSystem.analyze.SetsSortRuleAnalyzer;
   import cardSystem.analyze.UpgradeRuleAnalyzer;
   import cardSystem.data.CardAchievementInfo;
   import cardSystem.data.SetsInfo;
   import cardSystem.model.CardModel;
   import cardSystem.view.CardAchievementCompleteView;
   import ddt.events.PkgEvent;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.utils.AssetModuleLoader;
   import flash.events.EventDispatcher;
   
   public class CardManager extends EventDispatcher
   {
      
      private static var _instance:CardManager;
       
      
      private var _viewTypeArr:Array;
      
      private var _model:CardModel;
      
      public var signLockedCard:int;
      
      public var isPlayerInfoFrameOpen:Boolean = false;
      
      public var isOpenCardAchievementsView:Boolean = false;
      
      public function CardManager()
      {
         super();
         _model = new CardModel();
         _viewTypeArr = [];
         SocketManager.Instance.addEventListener(PkgEvent.format(362),__onAchievementProgress);
      }
      
      public static function get Instance() : CardManager
      {
         if(_instance == null)
         {
            _instance = new CardManager();
         }
         return _instance;
      }
      
      public function setSignLockedCardNone() : void
      {
         signLockedCard = -1;
      }
      
      public function showView(type:int) : void
      {
         if(_viewTypeArr.indexOf(type) == -1)
         {
            _viewTypeArr.push(type);
         }
         AssetModuleLoader.addModelLoader("ddtcardsystem",6);
         AssetModuleLoader.startCodeLoader(show);
      }
      
      public function show() : void
      {
         var event:* = null;
         while(_viewTypeArr.length > 0)
         {
            event = new CardSystemEvent("bagViewOpen");
            event.info = _viewTypeArr.shift();
            dispatchEvent(event);
         }
      }
      
      public function disposeView(type:int) : void
      {
         var event:CardSystemEvent = new CardSystemEvent("viewDispose");
         event.info = type;
         dispatchEvent(event);
      }
      
      public function get model() : CardModel
      {
         return _model;
      }
      
      public function initSetsProperties(analyzer:SetsPropertiesAnalyzer) : void
      {
         _model.setsList = analyzer.setsList;
      }
      
      public function initSetsSortRule(analyzer:SetsSortRuleAnalyzer) : void
      {
         _model.setsSortRuleVector = analyzer.setsVector;
      }
      
      public function initSetsUpgradeRule(analyzer:UpgradeRuleAnalyzer) : void
      {
         _model.upgradeRuleVec = analyzer.upgradeRuleVec;
      }
      
      public function initPropIncreaseRule(analyzer:CardPropIncreaseRuleAnalyzer) : void
      {
         _model.propIncreaseDic = analyzer.propIncreaseDic;
      }
      
      public function initCardAchievement(analyzer:CardAchievementAnalyze) : void
      {
         _model.achievementData = analyzer.data;
      }
      
      private function __onAchievementProgress(e:PkgEvent) : void
      {
         var i:int = 0;
         var type:int = 0;
         var completeID:int = 0;
         _model.achievementProperty[0] = e.pkg.readInt();
         _model.achievementProperty[1] = e.pkg.readInt();
         _model.achievementProperty[2] = e.pkg.readInt();
         _model.achievementProperty[3] = e.pkg.readInt();
         _model.achievementProperty[4] = e.pkg.readInt();
         _model.achievementProperty[5] = e.pkg.readInt();
         _model.achievementProperty[6] = e.pkg.readInt();
         _model.achievementProperty[7] = e.pkg.readInt();
         _model.achievementProgress.clear();
         var count:int = e.pkg.readInt();
         for(i = 0; i < count; )
         {
            type = e.pkg.readInt();
            completeID = e.pkg.readInt();
            _model.achievementProgress.add(type,completeID);
            i++;
         }
         checkCardAchievementComplete();
         dispatchEvent(new CardSystemEvent("cardachievementupdate"));
      }
      
      public function checkCardAchievementComplete() : void
      {
         if(isOpenCardAchievementsView)
         {
            return;
         }
         var _loc3_:int = 0;
         var _loc2_:* = _model.achievementData;
         for each(var info in _model.achievementData)
         {
            if(cardAchievementComplete(info.AchievementID))
            {
               new CardAchievementCompleteView(info).show();
               return;
            }
         }
      }
      
      public function cardAchievementComplete(id:int) : Boolean
      {
         var info:* = null;
         var count:int = 0;
         if(!cardAchievementGet(id))
         {
            info = _model.achievementData[id];
            if(info.RequireNum > 0 && PlayerManager.Instance.Self.getCardNumByType(info.RequireType) >= info.RequireNum)
            {
               return true;
            }
            if(info.RequireGroupid > 0 && PlayerManager.Instance.Self.checkCurrentCardSets(info.RequireGroupid,info.RequireType))
            {
               return true;
            }
            if(info.RequireGroupNum > 0)
            {
               count = 0;
               var _loc6_:int = 0;
               var _loc5_:* = _model.setsSortRuleVector;
               for each(var item in _model.setsSortRuleVector)
               {
                  if(PlayerManager.Instance.Self.checkCurrentCardSets(int(item.ID),info.RequireType))
                  {
                     count++;
                     if(count >= info.RequireGroupNum)
                     {
                        return true;
                     }
                  }
               }
            }
         }
         return false;
      }
      
      public function cardAchievementGet(id:int) : Boolean
      {
         var info:CardAchievementInfo = _model.achievementData[id];
         if(_model.achievementProgress.hasKey(info.Type) && info.AchievementID <= _model.achievementProgress[info.Type])
         {
            return true;
         }
         return false;
      }
      
      public function getCardSuitByID(id:int) : SetsInfo
      {
         var _loc4_:int = 0;
         var _loc3_:* = _model.setsSortRuleVector;
         for each(var item in _model.setsSortRuleVector)
         {
            if(int(item.ID) == id)
            {
               return item;
            }
         }
         return null;
      }
   }
}
