package cardSystem{   import cardSystem.data.CardInfo;   import cardSystem.view.PropResetFrame;   import cardSystem.view.UpGradeFrame;   import cardSystem.view.achievement.CardAchievementFrame;   import cardSystem.view.cardCollect.CardCollectView;   import cardSystem.view.cardEquip.CardEquipView;   import com.pickgliss.events.ComponentEvent;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.controls.OutMainListPanel;   import flash.events.EventDispatcher;      public class CardControl extends EventDispatcher   {            private static var _instance:CardControl;                   private var _cardEquipView:CardEquipView;            private var _cardBagView:OutMainListPanel;            private var _achievementframe:CardAchievementFrame;            public function CardControl() { super(); }
            public static function get Instance() : CardControl { return null; }
            public function setup() : void { }
            protected function __cardViewDispose(event:CardSystemEvent) : void { }
            protected function __cardViewOpen(event:CardSystemEvent) : void { }
            protected function openCardView(type:int) : void { }
            public function showUpGradeFrame(cardInfo:CardInfo) : void { }
            public function showPropResetFrame(cardInfo:CardInfo) : void { }
            public function showCollectView() : void { }
            public function showCardAchievementFrame() : void { }
            private function __onCloseAchievenmentFrame(e:ComponentEvent) : void { }
   }}