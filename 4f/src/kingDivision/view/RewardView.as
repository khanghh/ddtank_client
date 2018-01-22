package kingDivision.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.events.Event;
   import kingDivision.KingDivisionManager;
   
   public class RewardView extends Frame
   {
      
      private static const THISZONE:int = 0;
      
      private static const ALLZONE:int = 1;
       
      
      private var _bg:Bitmap;
      
      private var _thisZoneBtn:SelectedCheckButton;
      
      private var _allZoneBtn:SelectedCheckButton;
      
      private var _selectedBtnGroup:SelectedButtonGroup;
      
      private var _rewardList:RewardList;
      
      private var _rewardPanel:ScrollPanel;
      
      public function RewardView(){super();}
      
      private function initView() : void{}
      
      private function addEvent() : void{}
      
      private function removeEvent() : void{}
      
      private function __typeChange(param1:Event) : void{}
      
      private function defaultShowThisZoneView() : void{}
      
      private function updateRewardList() : void{}
      
      private function __responseHandler(param1:FrameEvent) : void{}
      
      override public function dispose() : void{}
   }
}
