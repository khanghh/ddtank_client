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
         var infoBtn:SelectedButton = ComponentFactory.Instance.creatComponentByStylename("team.mainTab.infoBtn");
         var recordBtn:SelectedButton = ComponentFactory.Instance.creatComponentByStylename("team.mainTab.recordBtn");
         var governBtn:SelectedButton = ComponentFactory.Instance.creatComponentByStylename("team.mainTab.governBtn");
         var activeBtn:SelectedButton = ComponentFactory.Instance.creatComponentByStylename("team.mainTab.activeBtn");
         var shopBtn:SelectedButton = ComponentFactory.Instance.creatComponentByStylename("team.mainTab.shopBtn");
         var memberBtn:SelectedButton = ComponentFactory.Instance.creatComponentByStylename("team.mainTab.memberBtn");
         _rankBtn = ComponentFactory.Instance.creatComponentByStylename("team.main.rankBtn");
         _rankBtn.addEventListener("click",__onClickRank);
         _hBox = ComponentFactory.Instance.creatComponentByStylename("team.mainTab.hBox");
         _hBox.addChild(infoBtn);
         _hBox.addChild(recordBtn);
         _hBox.addChild(governBtn);
         _hBox.addChild(activeBtn);
         _hBox.addChild(shopBtn);
         _hBox.addChild(memberBtn);
         _btnGroup = new SelectedButtonGroup();
         _btnGroup.addSelectItem(infoBtn);
         _btnGroup.addSelectItem(recordBtn);
         _btnGroup.addSelectItem(governBtn);
         _btnGroup.addSelectItem(activeBtn);
         _btnGroup.addSelectItem(shopBtn);
         _btnGroup.addSelectItem(memberBtn);
         _btnGroup.addEventListener("change",__changeHandler);
         _viewList = [];
         super.init();
         _btnHelp = HelpFrameUtils.Instance.simpleHelpButton(this,"core.helpButtonSmall",{
            "x":696,
            "y":4
         },LanguageMgr.GetTranslation("store.view.HelpButtonText"),"asset.team.mainHelp",528,590);
      }
      
      protected function __onClickRank(event:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         TeamManager.instance.showTeamRankFrame();
      }
      
      private function __changeHandler(e:Event) : void
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
         var i:int = 0;
         for(i = 0; i < _viewList.length; )
         {
            if(_viewList[i])
            {
               _viewList[i].visible = false;
            }
            i++;
         }
      }
      
      private function createView(index:int) : DisplayObject
      {
         var view:* = null;
         switch(int(index))
         {
            case 0:
               view = new TeamInfoView();
               break;
            case 1:
               view = new TeamRecordView();
               break;
            case 2:
               view = new TeamGovernView();
               break;
            case 3:
               view = new TeamActiveView();
               break;
            case 4:
               view = new TeamShopView();
               break;
            case 5:
               view = new TeamMemberView();
         }
         return view;
      }
      
      override protected function onResponse(type:int) : void
      {
         if(type == 0 || type == 4 || type == 1)
         {
            SoundManager.instance.playButtonSound();
            TeamManager.instance.disposeTeamMainFrame();
         }
      }
      
      private function __onExitTeam(e:PkgEvent) : void
      {
         TeamManager.instance.disposeTeamMainFrame();
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
