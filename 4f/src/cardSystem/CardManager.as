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
      
      public function CardManager(){super();}
      
      public static function get Instance() : CardManager{return null;}
      
      public function setSignLockedCardNone() : void{}
      
      public function showView(param1:int) : void{}
      
      public function show() : void{}
      
      public function disposeView(param1:int) : void{}
      
      public function get model() : CardModel{return null;}
      
      public function initSetsProperties(param1:SetsPropertiesAnalyzer) : void{}
      
      public function initSetsSortRule(param1:SetsSortRuleAnalyzer) : void{}
      
      public function initSetsUpgradeRule(param1:UpgradeRuleAnalyzer) : void{}
      
      public function initPropIncreaseRule(param1:CardPropIncreaseRuleAnalyzer) : void{}
      
      public function initCardAchievement(param1:CardAchievementAnalyze) : void{}
      
      private function __onAchievementProgress(param1:PkgEvent) : void{}
      
      public function checkCardAchievementComplete() : void{}
      
      public function cardAchievementComplete(param1:int) : Boolean{return false;}
      
      public function cardAchievementGet(param1:int) : Boolean{return false;}
      
      public function getCardSuitByID(param1:int) : SetsInfo{return null;}
   }
}
