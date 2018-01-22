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
      
      protected function __cardViewDispose(param1:CardSystemEvent) : void
      {
         var _loc2_:* = param1.info;
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
      
      protected function __cardViewOpen(param1:CardSystemEvent) : void
      {
         openCardView(param1.info);
      }
      
      protected function openCardView(param1:int) : void
      {
         var _loc2_:* = null;
         switch(int(param1))
         {
            case 0:
               if(!_cardEquipView)
               {
                  _cardEquipView = ComponentFactory.Instance.creatCustomObject("cardEquipView");
               }
               _loc2_ = new CardSystemEvent("bagEquipViewComplete");
               _loc2_.info = _cardEquipView;
               CardManager.Instance.dispatchEvent(_loc2_);
               break;
            case 1:
               if(!_cardBagView)
               {
                  _cardBagView = ComponentFactory.Instance.creatComponentByStylename("cardSyste.cardBagList");
               }
               _loc2_ = new CardSystemEvent("bagBagViewComplete");
               _loc2_.info = _cardBagView;
               CardManager.Instance.dispatchEvent(_loc2_);
               break;
            case 2:
               showCardAchievementFrame();
         }
      }
      
      public function showUpGradeFrame(param1:CardInfo) : void
      {
         var _loc2_:UpGradeFrame = ComponentFactory.Instance.creatComponentByStylename("UpGradeFrame");
         _loc2_.cardInfo = param1;
         LayerManager.Instance.addToLayer(_loc2_,3,true,1);
      }
      
      public function showPropResetFrame(param1:CardInfo) : void
      {
         var _loc2_:PropResetFrame = ComponentFactory.Instance.creatComponentByStylename("PropResetFrame");
         _loc2_.show(param1);
      }
      
      public function showCollectView() : void
      {
         var _loc1_:CardCollectView = ComponentFactory.Instance.creatComponentByStylename("CardCollectView");
         LayerManager.Instance.addToLayer(_loc1_,3,true,1);
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
      
      private function __onCloseAchievenmentFrame(param1:ComponentEvent) : void
      {
         CardManager.Instance.isOpenCardAchievementsView = false;
         _achievementframe.removeEventListener("dispose",__onCloseAchievenmentFrame);
         _achievementframe = null;
      }
   }
}
