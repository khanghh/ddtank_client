package cardSystem
{
   import cardSystem.data.CardInfo;
   import cardSystem.view.PropResetFrame;
   import cardSystem.view.UpGradeFrame;
   import cardSystem.view.achievement.CardAchievementFrame;
   import cardSystem.view.cardCollect.CardCollectView;
   import cardSystem.view.cardEquip.CardEquipView;
   import com.pickgliss.events.ComponentEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.OutMainListPanel;
   import flash.events.EventDispatcher;
   
   public class CardControl extends EventDispatcher
   {
      
      private static var _instance:CardControl;
       
      
      private var _cardEquipView:CardEquipView;
      
      private var _cardBagView:OutMainListPanel;
      
      private var _achievementframe:CardAchievementFrame;
      
      public function CardControl()
      {
         super();
      }
      
      public static function get Instance() : CardControl
      {
         if(_instance == null)
         {
            _instance = new CardControl();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         CardManager.Instance.addEventListener("bagViewOpen",__cardViewOpen);
         CardManager.Instance.addEventListener("viewDispose",__cardViewDispose);
      }
      
      protected function __cardViewDispose(event:CardSystemEvent) : void
      {
         var _loc2_:* = event.info;
         if(0 !== _loc2_)
         {
            if(1 !== _loc2_)
            {
               if(2 !== _loc2_)
               {
               }
            }
            else
            {
               _cardBagView = null;
            }
         }
         else
         {
            _cardEquipView = null;
         }
      }
      
      protected function __cardViewOpen(event:CardSystemEvent) : void
      {
         openCardView(event.info);
      }
      
      protected function openCardView(type:int) : void
      {
         var event:* = null;
         switch(int(type))
         {
            case 0:
               if(!_cardEquipView)
               {
                  _cardEquipView = ComponentFactory.Instance.creatCustomObject("cardEquipView");
               }
               event = new CardSystemEvent("bagEquipViewComplete");
               event.info = _cardEquipView;
               CardManager.Instance.dispatchEvent(event);
               break;
            case 1:
               if(!_cardBagView)
               {
                  _cardBagView = ComponentFactory.Instance.creatComponentByStylename("cardSyste.cardBagList");
               }
               event = new CardSystemEvent("bagBagViewComplete");
               event.info = _cardBagView;
               CardManager.Instance.dispatchEvent(event);
               break;
            case 2:
               showCardAchievementFrame();
         }
      }
      
      public function showUpGradeFrame(cardInfo:CardInfo) : void
      {
         var upGrade:UpGradeFrame = ComponentFactory.Instance.creatComponentByStylename("UpGradeFrame");
         upGrade.cardInfo = cardInfo;
         LayerManager.Instance.addToLayer(upGrade,3,true,1);
      }
      
      public function showPropResetFrame(cardInfo:CardInfo) : void
      {
         var propReset:PropResetFrame = ComponentFactory.Instance.creatComponentByStylename("PropResetFrame");
         propReset.show(cardInfo);
      }
      
      public function showCollectView() : void
      {
         var collectView:CardCollectView = ComponentFactory.Instance.creatComponentByStylename("CardCollectView");
         LayerManager.Instance.addToLayer(collectView,3,true,1);
      }
      
      public function showCardAchievementFrame() : void
      {
         CardManager.Instance.isOpenCardAchievementsView = true;
         if(_achievementframe == null)
         {
            _achievementframe = ComponentFactory.Instance.creatComponentByStylename("CardAchievementFrame");
            _achievementframe.addEventListener("dispose",__onCloseAchievenmentFrame);
            _achievementframe.show();
         }
      }
      
      private function __onCloseAchievenmentFrame(e:ComponentEvent) : void
      {
         CardManager.Instance.isOpenCardAchievementsView = false;
         _achievementframe.removeEventListener("dispose",__onCloseAchievenmentFrame);
         _achievementframe = null;
      }
   }
}
