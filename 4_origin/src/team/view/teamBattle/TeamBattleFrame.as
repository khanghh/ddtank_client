package team.view.teamBattle
{
   import bagAndInfo.cell.BaseCell;
   import bagAndInfo.cell.CellFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.GameInSocketOut;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import ddt.manager.StateManager;
   import ddt.utils.AssetModuleLoader;
   import ddt.utils.HelpFrameUtils;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.utils.getTimer;
   import morn.core.handlers.Handler;
   import team.TeamManager;
   import team.view.mornui.TeamBattleFrameUI;
   
   public final class TeamBattleFrame extends TeamBattleFrameUI implements Disposeable
   {
      
      private static const TOP_MEMBERS:int = 3;
      
      private static const SEGMENT:Array = [5,4,3,2];
       
      
      private var _topList:Vector.<BaseCell>;
      
      private var _segmentList:Vector.<BaseCell>;
      
      private var _btnHelp:BaseButton;
      
      private var _lastCreatTime:int = 0;
      
      public function TeamBattleFrame()
      {
         super();
         initData();
         initView();
         initEvent();
      }
      
      private function initData() : void
      {
         _topList = new Vector.<BaseCell>();
         _segmentList = new Vector.<BaseCell>();
      }
      
      private function initEvent() : void
      {
         closeBtn.addEventListener("click",onClickHandler);
         battleBtn.addEventListener("click",onBalltleBtnHanlder);
         gotoTeamBtn.clickHandler = new Handler(showTeamFrame);
      }
      
      private function showTeamFrame() : void
      {
         SoundManager.instance.playButtonSound();
         dispose();
         if(PlayerManager.Instance.Self.Grade < 26)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.functionLimitTip",26));
            return;
         }
         TeamManager.instance.showTeamFrame();
      }
      
      private function onBalltleBtnHanlder(e:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(StateManager.currentStateType == "matchRoom" || StateManager.currentStateType == "dungeonRoom" || StateManager.currentStateType == "battleRoom")
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("teamBattle.room.alert"));
            return;
         }
         if(PlayerManager.Instance.Self.teamID <= 0)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("im.IMView.teamText"));
            return;
         }
         if(getTimer() - _lastCreatTime > 2000)
         {
            _lastCreatTime = getTimer();
            AssetModuleLoader.addModelLoader("ddtroom",6);
            AssetModuleLoader.addModelLoader("ddtcorescalebitmap",4);
            AssetModuleLoader.addModelLoader("chatball",4);
            AssetModuleLoader.startLoader(createRoom);
            dispose();
            return;
         }
      }
      
      private function createRoom() : void
      {
         GameInSocketOut.sendCreateRoom(LanguageMgr.GetTranslation("teamBattle.roomName"),58,2);
      }
      
      private function onClickHandler(event:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         dispose();
      }
      
      private function initView() : void
      {
         var i:int = 0;
         var j:int = 0;
         teamBattleTime.text = "S" + String(TeamManager.instance.model.teamBattleSeasonInfo.SeasonId) + LanguageMgr.GetTranslation("teamBattle.seasonCount") + TeamManager.instance.model.teamBattleSeasonInfo.getBeginData() + "-" + TeamManager.instance.model.teamBattleSeasonInfo.getEndData();
         var cell:BaseCell = null;
         var rewardData:ItemTemplateInfo = null;
         var topBox:HBox = new HBox();
         topBox.spacing = 20;
         for(i = 0; i < 3; )
         {
            cell = createItemCell();
            cell.info = TeamManager.instance.model.teamBattleSeasonInfo.getRankGift(i);
            _topList.push(cell);
            topBox.addChild(cell);
            i++;
         }
         topBox.arrange();
         var segmentBox:HBox = new HBox();
         segmentBox.spacing = 17;
         var giftID:int = 0;
         for(j = 0; j < SEGMENT.length; )
         {
            cell = createItemCell();
            giftID = TeamManager.instance.model.getTeamBattleSegmentInfo(SEGMENT[j]).GiftBagId;
            cell.info = ItemManager.Instance.getTemplateById(giftID);
            _segmentList.push(cell);
            segmentBox.addChild(cell);
            j++;
         }
         segmentBox.arrange();
         topBox.x = 197;
         topBox.y = 392;
         addChild(topBox);
         segmentBox.x = 167;
         segmentBox.y = 490;
         addChild(segmentBox);
         _btnHelp = HelpFrameUtils.Instance.simpleHelpButton(this,"team.helpButtonSmall",{
            "x":354,
            "y":356
         },LanguageMgr.GetTranslation("store.view.HelpButtonText"),"asset.teamBattle.helpText",408,488);
         teamText1.text = LanguageMgr.GetTranslation("ddt.team.allView.text57");
      }
      
      private function createItemCell() : BaseCell
      {
         var sp:Sprite = new Sprite();
         sp.graphics.beginFill(16777215,0);
         sp.graphics.drawRect(0,0,56,56);
         sp.graphics.endFill();
         var cell:BaseCell = new BaseCell(sp,null,true,true);
         cell.setContentSize(56,56);
         CellFactory.instance.fillTipProp(cell);
         return cell;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_btnHelp);
         _btnHelp = null;
         var cell:BaseCell = null;
         while(_topList.length > 0)
         {
            cell = _topList.pop();
            cell.dispose();
         }
         _topList = null;
         while(_segmentList.length > 0)
         {
            cell = _segmentList.pop();
            cell.dispose();
         }
         _segmentList = null;
         super.dispose();
      }
      
      private function removeEvent() : void
      {
         closeBtn.removeEventListener("click",onClickHandler);
         battleBtn.removeEventListener("click",onBalltleBtnHanlder);
      }
   }
}
