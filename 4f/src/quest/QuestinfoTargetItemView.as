package quest
{
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.quest.QuestCondition;
   import ddt.data.quest.QuestInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.events.MouseEvent;
   
   public class QuestinfoTargetItemView extends QuestInfoItemView
   {
       
      
      private var _targets:VBox;
      
      private var _isOptional:Boolean;
      
      private var _starLevel:QuestStarListView;
      
      private var _completeButton:TextButton;
      
      private var _spand:int;
      
      private var _sLevel:int;
      
      public var isImprove:Boolean;
      
      private var _vipBg:Image;
      
      private var _vipIcon:Image;
      
      private var _vipDescTxt:FilterFrameText;
      
      public function QuestinfoTargetItemView(param1:Boolean){super();}
      
      public function set sLevel(param1:int) : void{}
      
      override public function set info(param1:QuestInfo) : void{}
      
      override protected function initView() : void{}
      
      private function isInLimitTimes() : int{return 0;}
      
      private function _activeGetBtnClick(param1:MouseEvent) : void{}
      
      private function __confirmResponse(param1:FrameEvent) : void{}
      
      public function setStarVipHide() : void{}
      
      override public function dispose() : void{}
   }
}
