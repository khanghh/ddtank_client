package kingDivision.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.SoundManager;
   import ddt.manager.StateManager;
   import ddt.manager.TimeManager;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import gameCommon.GameControl;
   import kingDivision.KingDivisionManager;
   import room.RoomManager;
   import room.model.RoomInfo;
   import store.HelpFrame;
   
   public class KingDivisionFrame extends Frame
   {
      
      private static const THISZONE:int = 0;
      
      private static const ALLZONE:int = 1;
       
      
      private var _outSideFrame:Bitmap;
      
      private var _thisZone:SelectedButton;
      
      private var _allZone:SelectedButton;
      
      private var _tabSelectedButtonGroup:SelectedButtonGroup;
      
      private var _titleImg:Bitmap;
      
      private var _helpBtn:BaseButton;
      
      private var _quaFrame:QualificationsFrame;
      
      private var _proBar:ProgressBarView;
      
      private var _ranFrame:RankingRoundView;
      
      private var _stateNo:Boolean;
      
      public function KingDivisionFrame()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _tabSelectedButtonGroup = new SelectedButtonGroup();
         _outSideFrame = ComponentFactory.Instance.creatBitmap("asset.kingdivision.frameImg");
         _titleImg = ComponentFactory.Instance.creatBitmap("asset.kingdivision.title");
         _thisZone = ComponentFactory.Instance.creatComponentByStylename("kingdivision.kingdivisionFrame.thisZoneTabBtn");
         _allZone = ComponentFactory.Instance.creatComponentByStylename("kingdivision.kingdivisionFrame.allZoneTabBtn");
         _helpBtn = ComponentFactory.Instance.creat("kingdivision.kingdivisionFrame.helpBtn");
         _proBar = ComponentFactory.Instance.creatCustomObject("kingDivisionFrame.progressBarView");
         addToContent(_outSideFrame);
         addToContent(_thisZone);
         addToContent(_allZone);
         addToContent(_helpBtn);
         addToContent(_proBar);
         addToContent(_titleImg);
         _tabSelectedButtonGroup.addSelectItem(_thisZone);
         _tabSelectedButtonGroup.addSelectItem(_allZone);
         selectShow();
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__responseHandler);
         _tabSelectedButtonGroup.addEventListener("change",__changeHandler);
         _helpBtn.addEventListener("click",__onHelpClick);
         GameControl.Instance.addEventListener("StartLoading",__onStartLoad);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__responseHandler);
         _tabSelectedButtonGroup.removeEventListener("change",__changeHandler);
         _helpBtn.removeEventListener("click",__onHelpClick);
         GameControl.Instance.removeEventListener("StartLoading",__onStartLoad);
      }
      
      protected function __onStartLoad(param1:Event) : void
      {
         var _loc2_:RoomInfo = RoomManager.Instance.current;
         if(GameControl.Instance.Current == null)
         {
            return;
         }
         dispose();
         StateManager.setState("roomLoading",GameControl.Instance.Current);
      }
      
      private function __changeHandler(param1:Event) : void
      {
         defaultShowThisZoneView();
      }
      
      private function selectShow() : void
      {
         if(KingDivisionManager.Instance.states < 2)
         {
            KingDivisionManager.Instance.zoneIndex = 0;
            timeShowView(KingDivisionManager.Instance.dateArr,0);
            _tabSelectedButtonGroup.selectIndex = 0;
         }
         else
         {
            KingDivisionManager.Instance.isThisZoneWin = false;
            KingDivisionManager.Instance.zoneIndex = 1;
            _proBar.updateZoneImg(1);
            timeShowView(KingDivisionManager.Instance.allDateArr,1);
            _tabSelectedButtonGroup.selectIndex = 1;
         }
      }
      
      private function defaultShowThisZoneView() : void
      {
         switch(int(_tabSelectedButtonGroup.selectIndex))
         {
            case 0:
               if(_stateNo)
               {
                  return;
               }
               if(KingDivisionManager.Instance.model.states == 2)
               {
                  KingDivisionManager.Instance.isThisZoneWin = true;
               }
               KingDivisionManager.Instance.zoneIndex = 0;
               _proBar.updateZoneImg(0);
               timeShowView(KingDivisionManager.Instance.dateArr,0);
               break;
            case 1:
               if(KingDivisionManager.Instance.model.states < 2 && _tabSelectedButtonGroup.selectIndex == 1)
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.kingDivision.allzoneTip"));
                  _stateNo = true;
                  _tabSelectedButtonGroup.selectIndex = 0;
                  return;
               }
               _stateNo = false;
               KingDivisionManager.Instance.isThisZoneWin = false;
               KingDivisionManager.Instance.zoneIndex = 1;
               _proBar.updateZoneImg(1);
               timeShowView(KingDivisionManager.Instance.allDateArr,1);
               break;
         }
      }
      
      private function timeShowView(param1:Array, param2:int) : void
      {
         if(param1 == null)
         {
            return;
         }
         var _loc3_:Date = TimeManager.Instance.Now();
         if(param1[0] == _loc3_.date)
         {
            if(_quaFrame)
            {
               ObjectUtils.disposeObject(_quaFrame);
               _quaFrame = null;
            }
            _quaFrame = ComponentFactory.Instance.creatCustomObject("kingDivisionFrame.qualificationsFrame");
            addToContent(_quaFrame);
            _quaFrame.progressBarView = _proBar;
            _quaFrame.setDateStages(param1);
         }
         else
         {
            if(_ranFrame)
            {
               ObjectUtils.disposeObject(_ranFrame);
               _ranFrame = null;
            }
            _ranFrame = ComponentFactory.Instance.creatCustomObject("kingDivisionFrame.rankingRoundView");
            addToContent(_ranFrame);
            _ranFrame.progressBarView = _proBar;
            _ranFrame.zone = param2;
            _ranFrame.setDateStages(param1);
         }
         if(_titleImg)
         {
            _titleImg.bitmapData.dispose();
            ObjectUtils.disposeObject(_titleImg);
            _titleImg = null;
         }
         _titleImg = ComponentFactory.Instance.creatBitmap("asset.kingdivision.title");
         addToContent(_titleImg);
      }
      
      protected function __onHelpClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:DisplayObject = ComponentFactory.Instance.creat("kingdivision.HelpPrompt");
         var _loc3_:HelpFrame = ComponentFactory.Instance.creat("kingdivision.HelpFrame");
         _loc3_.setView(_loc2_);
         _loc3_.titleText = LanguageMgr.GetTranslation("store.view.HelpButtonText");
         LayerManager.Instance.addToLayer(_loc3_,1,true,1);
      }
      
      private function __responseHandler(param1:FrameEvent) : void
      {
         if(param1.responseCode == 0 || param1.responseCode == 1)
         {
            SoundManager.instance.play("008");
            dispose();
         }
      }
      
      public function get qualificationsFrame() : QualificationsFrame
      {
         return _quaFrame;
      }
      
      public function get rankingRoundView() : RankingRoundView
      {
         return _ranFrame;
      }
      
      override public function dispose() : void
      {
         _stateNo = false;
         KingDivisionManager.Instance.openFrame = false;
         removeEvent();
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
         _titleImg = null;
         _thisZone = null;
         _allZone = null;
         _tabSelectedButtonGroup = null;
         _titleImg = null;
         _helpBtn = null;
         _quaFrame = null;
         _proBar = null;
         _ranFrame = null;
      }
   }
}
