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
      
      private function onBalltleBtnHanlder(param1:MouseEvent) : void
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
      
      private function onClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         dispose();
      }
      
      private function initView() : void
      {
         var _loc7_:int = 0;
         var _loc5_:int = 0;
         teamBattleTime.text = "S" + String(TeamManager.instance.model.teamBattleSeasonInfo.SeasonId) + LanguageMgr.GetTranslation("teamBattle.seasonCount") + TeamManager.instance.model.teamBattleSeasonInfo.getBeginData() + "-" + TeamManager.instance.model.teamBattleSeasonInfo.getEndData();
         var _loc1_:BaseCell = null;
         var _loc4_:ItemTemplateInfo = null;
         var _loc3_:HBox = new HBox();
         _loc3_.spacing = 20;
         _loc7_ = 0;
         while(_loc7_ < 3)
         {
            _loc1_ = createItemCell();
            _loc1_.info = TeamManager.instance.model.teamBattleSeasonInfo.getRankGift(_loc7_);
            _topList.push(_loc1_);
            _loc3_.addChild(_loc1_);
            _loc7_++;
         }
         _loc3_.arrange();
         var _loc6_:HBox = new HBox();
         _loc6_.spacing = 17;
         var _loc2_:int = 0;
         _loc5_ = 0;
         while(_loc5_ < SEGMENT.length)
         {
            _loc1_ = createItemCell();
            _loc2_ = TeamManager.instance.model.getTeamBattleSegmentInfo(SEGMENT[_loc5_]).GiftBagId;
            _loc1_.info = ItemManager.Instance.getTemplateById(_loc2_);
            _segmentList.push(_loc1_);
            _loc6_.addChild(_loc1_);
            _loc5_++;
         }
         _loc6_.arrange();
         _loc3_.x = 197;
         _loc3_.y = 392;
         addChild(_loc3_);
         _loc6_.x = 167;
         _loc6_.y = 490;
         addChild(_loc6_);
         _btnHelp = HelpFrameUtils.Instance.simpleHelpButton(this,"team.helpButtonSmall",{
            "x":354,
            "y":356
         },LanguageMgr.GetTranslation("store.view.HelpButtonText"),"asset.teamBattle.helpText",408,488);
         teamText1.text = LanguageMgr.GetTranslation("ddt.team.allView.text57");
      }
      
      private function createItemCell() : BaseCell
      {
         var _loc1_:Sprite = new Sprite();
         _loc1_.graphics.beginFill(16777215,0);
         _loc1_.graphics.drawRect(0,0,56,56);
         _loc1_.graphics.endFill();
         var _loc2_:BaseCell = new BaseCell(_loc1_,null,true,true);
         _loc2_.setContentSize(56,56);
         CellFactory.instance.fillTipProp(_loc2_);
         return _loc2_;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_btnHelp);
         _btnHelp = null;
         var _loc1_:BaseCell = null;
         while(_topList.length > 0)
         {
            _loc1_ = _topList.pop();
            _loc1_.dispose();
         }
         _topList = null;
         while(_segmentList.length > 0)
         {
            _loc1_ = _segmentList.pop();
            _loc1_.dispose();
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
