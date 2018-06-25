package cardSystem{   import cardSystem.analyze.CardAchievementAnalyze;   import cardSystem.analyze.CardPropIncreaseRuleAnalyzer;   import cardSystem.analyze.SetsPropertiesAnalyzer;   import cardSystem.analyze.SetsSortRuleAnalyzer;   import cardSystem.analyze.UpgradeRuleAnalyzer;   import cardSystem.data.CardAchievementInfo;   import cardSystem.data.SetsInfo;   import cardSystem.model.CardModel;   import cardSystem.view.CardAchievementCompleteView;   import ddt.events.PkgEvent;   import ddt.manager.PlayerManager;   import ddt.manager.SocketManager;   import ddt.utils.AssetModuleLoader;   import flash.events.EventDispatcher;      public class CardManager extends EventDispatcher   {            private static var _instance:CardManager;                   private var _viewTypeArr:Array;            private var _model:CardModel;            public var signLockedCard:int;            public var isPlayerInfoFrameOpen:Boolean = false;            public var isOpenCardAchievementsView:Boolean = false;            public function CardManager() { super(); }
            public static function get Instance() : CardManager { return null; }
            public function setSignLockedCardNone() : void { }
            public function showView(type:int) : void { }
            public function show() : void { }
            public function disposeView(type:int) : void { }
            public function get model() : CardModel { return null; }
            public function initSetsProperties(analyzer:SetsPropertiesAnalyzer) : void { }
            public function initSetsSortRule(analyzer:SetsSortRuleAnalyzer) : void { }
            public function initSetsUpgradeRule(analyzer:UpgradeRuleAnalyzer) : void { }
            public function initPropIncreaseRule(analyzer:CardPropIncreaseRuleAnalyzer) : void { }
            public function initCardAchievement(analyzer:CardAchievementAnalyze) : void { }
            private function __onAchievementProgress(e:PkgEvent) : void { }
            public function checkCardAchievementComplete() : void { }
            public function cardAchievementComplete(id:int) : Boolean { return false; }
            public function cardAchievementGet(id:int) : Boolean { return false; }
            public function getCardSuitByID(id:int) : SetsInfo { return null; }
   }}