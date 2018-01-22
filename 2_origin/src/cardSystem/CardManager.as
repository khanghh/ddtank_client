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
      
      public function showView(param1:int) : void
      {
         if(_viewTypeArr.indexOf(param1) == -1)
         {
            _viewTypeArr.push(param1);
         }
         AssetModuleLoader.addModelLoader("ddtcardsystem",6);
         AssetModuleLoader.startCodeLoader(show);
      }
      
      public function show() : void
      {
         var _loc1_:* = null;
         while(_viewTypeArr.length > 0)
         {
            _loc1_ = new CardSystemEvent("bagViewOpen");
            _loc1_.info = _viewTypeArr.shift();
            dispatchEvent(_loc1_);
         }
      }
      
      public function disposeView(param1:int) : void
      {
         var _loc2_:CardSystemEvent = new CardSystemEvent("viewDispose");
         _loc2_.info = param1;
         dispatchEvent(_loc2_);
      }
      
      public function get model() : CardModel
      {
         return _model;
      }
      
      public function initSetsProperties(param1:SetsPropertiesAnalyzer) : void
      {
         _model.setsList = param1.setsList;
      }
      
      public function initSetsSortRule(param1:SetsSortRuleAnalyzer) : void
      {
         _model.setsSortRuleVector = param1.setsVector;
      }
      
      public function initSetsUpgradeRule(param1:UpgradeRuleAnalyzer) : void
      {
         _model.upgradeRuleVec = param1.upgradeRuleVec;
      }
      
      public function initPropIncreaseRule(param1:CardPropIncreaseRuleAnalyzer) : void
      {
         _model.propIncreaseDic = param1.propIncreaseDic;
      }
      
      public function initCardAchievement(param1:CardAchievementAnalyze) : void
      {
         _model.achievementData = param1.data;
      }
      
      private function __onAchievementProgress(param1:PkgEvent) : void
      {
         var _loc5_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         _model.achievementProperty[0] = param1.pkg.readInt();
         _model.achievementProperty[1] = param1.pkg.readInt();
         _model.achievementProperty[2] = param1.pkg.readInt();
         _model.achievementProperty[3] = param1.pkg.readInt();
         _model.achievementProperty[4] = param1.pkg.readInt();
         _model.achievementProperty[5] = param1.pkg.readInt();
         _model.achievementProperty[6] = param1.pkg.readInt();
         _model.achievementProperty[7] = param1.pkg.readInt();
         _model.achievementProgress.clear();
         var _loc2_:int = param1.pkg.readInt();
         _loc5_ = 0;
         while(_loc5_ < _loc2_)
         {
            _loc3_ = param1.pkg.readInt();
            _loc4_ = param1.pkg.readInt();
            _model.achievementProgress.add(_loc3_,_loc4_);
            _loc5_++;
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
         for each(var _loc1_ in _model.achievementData)
         {
            if(cardAchievementComplete(_loc1_.AchievementID))
            {
               new CardAchievementCompleteView(_loc1_).show();
               return;
            }
         }
      }
      
      public function cardAchievementComplete(param1:int) : Boolean
      {
         var _loc4_:* = null;
         var _loc2_:int = 0;
         if(!cardAchievementGet(param1))
         {
            _loc4_ = _model.achievementData[param1];
            if(_loc4_.RequireNum > 0 && PlayerManager.Instance.Self.getCardNumByType(_loc4_.RequireType) >= _loc4_.RequireNum)
            {
               return true;
            }
            if(_loc4_.RequireGroupid > 0 && PlayerManager.Instance.Self.checkCurrentCardSets(_loc4_.RequireGroupid,_loc4_.RequireType))
            {
               return true;
            }
            if(_loc4_.RequireGroupNum > 0)
            {
               _loc2_ = 0;
               var _loc6_:int = 0;
               var _loc5_:* = _model.setsSortRuleVector;
               for each(var _loc3_ in _model.setsSortRuleVector)
               {
                  if(PlayerManager.Instance.Self.checkCurrentCardSets(int(_loc3_.ID),_loc4_.RequireType))
                  {
                     _loc2_++;
                     if(_loc2_ >= _loc4_.RequireGroupNum)
                     {
                        return true;
                     }
                  }
               }
            }
         }
         return false;
      }
      
      public function cardAchievementGet(param1:int) : Boolean
      {
         var _loc2_:CardAchievementInfo = _model.achievementData[param1];
         if(_model.achievementProgress.hasKey(_loc2_.Type) && _loc2_.AchievementID <= _model.achievementProgress[_loc2_.Type])
         {
            return true;
         }
         return false;
      }
      
      public function getCardSuitByID(param1:int) : SetsInfo
      {
         var _loc4_:int = 0;
         var _loc3_:* = _model.setsSortRuleVector;
         for each(var _loc2_ in _model.setsSortRuleVector)
         {
            if(int(_loc2_.ID) == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
   }
}
