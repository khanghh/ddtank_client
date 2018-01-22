package team.view.main
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.PkgEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.HelpFrameUtils;
   import ddt.utils.PositionUtils;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import team.TeamManager;
   
   public class TeamMainFrame extends Frame
   {
       
      
      private var _infoBtn:SelectedButton;
      
      private var _recordBtn:SelectedButton;
      
      private var _governBtn:SelectedButton;
      
      private var _activeBtn:SelectedButton;
      
      private var _shopBtn:SelectedButton;
      
      private var _memberBtn:SelectedButton;
      
      private var _btnGroup:SelectedButtonGroup;
      
      private var _hBox:HBox;
      
      private var _btnHelp:BaseButton;
      
      private var _rankBtn:BaseButton;
      
      private var _viewList:Array;
      
      public function TeamMainFrame()
      {
         super();
         _btnGroup.selectIndex = 0;
         SocketManager.Instance.addEventListener(PkgEvent.format(390,7),__onExitTeam);
      }
      
      override protected function init() : void
      {
         var _loc4_:SelectedButton = ComponentFactory.Instance.creatComponentByStylename("team.mainTab.infoBtn");
         var _loc2_:SelectedButton = ComponentFactory.Instance.creatComponentByStylename("team.mainTab.recordBtn");
         var _loc5_:SelectedButton = ComponentFactory.Instance.creatComponentByStylename("team.mainTab.governBtn");
         var _loc3_:SelectedButton = ComponentFactory.Instance.creatComponentByStylename("team.mainTab.activeBtn");
         var _loc6_:SelectedButton = ComponentFactory.Instance.creatComponentByStylename("team.mainTab.shopBtn");
         var _loc1_:SelectedButton = ComponentFactory.Instance.creatComponentByStylename("team.mainTab.memberBtn");
         _rankBtn = ComponentFactory.Instance.creatComponentByStylename("team.main.rankBtn");
         _rankBtn.addEventListener("click",__onClickRank);
         _hBox = ComponentFactory.Instance.creatComponentByStylename("team.mainTab.hBox");
         _hBox.addChild(_loc4_);
         _hBox.addChild(_loc2_);
         _hBox.addChild(_loc5_);
         _hBox.addChild(_loc3_);
         _hBox.addChild(_loc6_);
         _hBox.addChild(_loc1_);
         _btnGroup = new SelectedButtonGroup();
         _btnGroup.addSelectItem(_loc4_);
         _btnGroup.addSelectItem(_loc2_);
         _btnGroup.addSelectItem(_loc5_);
         _btnGroup.addSelectItem(_loc3_);
         _btnGroup.addSelectItem(_loc6_);
         _btnGroup.addSelectItem(_loc1_);
         _btnGroup.addEventListener("change",__changeHandler);
         _viewList = [];
         super.init();
         _btnHelp = HelpFrameUtils.Instance.simpleHelpButton(this,"core.helpButtonSmall",{
            "x":696,
            "y":4
         },LanguageMgr.GetTranslation("store.view.HelpButtonText"),"asset.team.mainHelp",408,590);
      }
      
      protected function __onClickRank(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         TeamManager.instance.showTeamRankFrame();
      }
      
      private function __changeHandler(param1:Event) : void
      {
         SoundManager.instance.playButtonSound();
         hideTabAllView();
         if(_viewList[_btnGroup.selectIndex] == undefined)
         {
            _viewList[_btnGroup.selectIndex] = createView(_btnGroup.selectIndex);
            PositionUtils.setPos(_viewList[_btnGroup.selectIndex],"team.main.viewPos");
            addToContent(_viewList[_btnGroup.selectIndex]);
         }
         _viewList[_btnGroup.selectIndex].visible = true;
         _viewList[_btnGroup.selectIndex].update();
      }
      
      override protected function addChildren() : void
      {
         super.addChildren();
         if(_hBox)
         {
            addToContent(_hBox);
         }
         if(_rankBtn)
         {
            addToContent(_rankBtn);
         }
      }
      
      private function hideTabAllView() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < _viewList.length)
         {
            if(_viewList[_loc1_])
            {
               _viewList[_loc1_].visible = false;
            }
            _loc1_++;
         }
      }
      
      private function createView(param1:int) : DisplayObject
      {
         var _loc2_:* = null;
         switch(int(param1))
         {
            case 0:
               _loc2_ = new TeamInfoView();
               break;
            case 1:
               _loc2_ = new TeamRecordView();
               break;
            case 2:
               _loc2_ = new TeamGovernView();
               break;
            case 3:
               _loc2_ = new TeamActiveView();
               break;
            case 4:
               _loc2_ = new TeamShopView();
               break;
            case 5:
               _loc2_ = new TeamMemberView();
         }
         return _loc2_;
      }
      
      override protected function onResponse(param1:int) : void
      {
         if(param1 == 0 || param1 == 4 || param1 == 1)
         {
            SoundManager.instance.playButtonSound();
            dispose();
         }
      }
      
      private function __onExitTeam(param1:PkgEvent) : void
      {
         dispose();
      }
      
      override public function dispose() : void
      {
         SocketManager.Instance.removeEventListener(PkgEvent.format(390,7),__onExitTeam);
         _btnGroup.removeEventListener("change",__changeHandler);
         _rankBtn.removeEventListener("click",__onClickRank);
         _viewList.splice(0,_viewList.length);
         _viewList = null;
         ObjectUtils.disposeObject(_hBox);
         _hBox = null;
         ObjectUtils.disposeObject(_btnGroup);
         _btnGroup = null;
         ObjectUtils.disposeObject(_rankBtn);
         _rankBtn = null;
         ObjectUtils.disposeObject(_btnHelp);
         _btnHelp = null;
         super.dispose();
      }
   }
}
