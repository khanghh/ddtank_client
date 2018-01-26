package gradeAwardsBoxBtn
{
   import bagAndInfo.BagAndInfoManager;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.events.BagEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import flash.events.MouseEvent;
   import gradeAwardsBoxBtn.model.GradeAwardsBoxModel;
   import gradeAwardsBoxBtn.model.RemainingTimeManager;
   import gradeAwardsBoxBtn.view.GradeAwardsBoxSprite;
   import gradeAwardsBoxBtn.view.GradeAwardsFlyIntoBagView;
   import hall.HallStateView;
   
   public class GradeAwardsBoxButtonManager
   {
      
      private static var instance:GradeAwardsBoxButtonManager;
       
      
      private const ON_FRAME_CLOSE:String = "ofc";
      
      private var _gradeAwardsBoxSprite:GradeAwardsBoxSprite;
      
      public function GradeAwardsBoxButtonManager(param1:inner){super();}
      
      public static function getInstance() : GradeAwardsBoxButtonManager{return null;}
      
      public function init() : void{}
      
      private function gradeAwardsFlyIntoBag(param1:Array) : void{}
      
      public function setHall(param1:HallStateView) : void{}
      
      protected function onGradeAwardsClickHandler(param1:MouseEvent) : void{}
      
      protected function onGoodsUpdated(param1:BagEvent) : void{}
      
      private function updateGradeAwardsBtn(param1:InventoryItemInfo = null) : void{}
      
      private function onButtonShown(param1:InventoryItemInfo) : void{}
      
      private function onButtonHide() : void{}
      
      private function onTimer() : void{}
      
      private function checkLast(param1:InventoryItemInfo) : void{}
      
      public function dispose() : void{}
   }
}

class inner
{
    
   
   function inner(){super();}
}
