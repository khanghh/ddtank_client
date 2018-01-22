package guildMemberWeek.view
{
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.player.SelfInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import guildMemberWeek.manager.GuildMemberWeekManager;
   import guildMemberWeek.view.mainFrame.GuildMemberWeekFrameLeft;
   import guildMemberWeek.view.mainFrame.GuildMemberWeekFrameRight;
   
   public class GuildMemberWeekFrame extends Frame
   {
       
      
      private var _helpBtn:BaseButton;
      
      private var _AddRankingBtn:BaseButton;
      
      private var _AddRankingSprite:Sprite;
      
      private var _AddRankingBg:Bitmap;
      
      private var _AddRankingReadyShow:DisplayObject;
      
      private var _runkingBG:ScaleFrameImage;
      
      private var _runkingSG:ScaleFrameImage;
      
      private var _AddRecordBG:ScaleFrameImage;
      
      private var _TenMBG:ScaleFrameImage;
      
      private var _panel:ScrollPanel;
      
      private var _upDataTimeTxt:FilterFrameText;
      
      private var _upExplainText:FilterFrameText;
      
      private var _dataTitleRankingText:FilterFrameText;
      
      private var _dataTitleNameText:FilterFrameText;
      
      private var _dataTitleContributeText:FilterFrameText;
      
      private var _dataTitleRankingGiftText:FilterFrameText;
      
      private var _dataTitleAddRankingGiftText:FilterFrameText;
      
      private var _ActivityStartTimeShowText:FilterFrameText;
      
      private var _ActivityEndTimeShowText:FilterFrameText;
      
      private var _ShowMyRankingText:FilterFrameText;
      
      private var _ShowMyContributeText:FilterFrameText;
      
      private var _AddRanking:GuildMemberWeekFrameRight;
      
      private var _TopTenShowSprite:GuildMemberWeekFrameLeft;
      
      private var _selfInfo:SelfInfo;
      
      public function GuildMemberWeekFrame()
      {
         _selfInfo = PlayerManager.Instance.Self;
         super();
         initView();
         initEvent();
         initText();
      }
      
      public function get TopTenShowSprite() : GuildMemberWeekFrameLeft
      {
         return _TopTenShowSprite;
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("guildMemberWeek.MainFrame.guildMemberWeek.title");
         _runkingBG = ComponentFactory.Instance.creat("asset.guildmemberweek.MainrunkingBG.png");
         _runkingSG = ComponentFactory.Instance.creat("asset.guildmemberweek.MainrunkingSG.png");
         _AddRecordBG = ComponentFactory.Instance.creat("asset.guildmemberweek.MainRecordBG.png");
         _TenMBG = ComponentFactory.Instance.creat("asset.guildmemberweek.MainTenMBG.png");
         _AddRanking = ComponentFactory.Instance.creatCustomObject("guildmemberweek.MainFrame.GuildMemberWeekFrameRight");
         _TopTenShowSprite = ComponentFactory.Instance.creatCustomObject("guildmemberweek.MainFrame.GuildMemberWeekFrameLeft");
         _helpBtn = ComponentFactory.Instance.creat("guildmemberweek.help.btn");
         _AddRankingBg = ComponentFactory.Instance.creatBitmap("asset.guildmemberweek.Main.AddPointBookText.png");
         _AddRankingReadyShow = ComponentFactory.Instance.creat("asset.guildmemberweek.Main.AddPointBookBtnCartoon.png");
         _AddRankingReadyShow.x = -10;
         _AddRankingReadyShow.y = -16;
         if(PlayerManager.Instance.Self.DutyLevel <= 3)
         {
            _AddRankingReadyShow.visible = true;
         }
         else
         {
            _AddRankingReadyShow.visible = false;
         }
         _AddRankingSprite = new Sprite();
         _AddRankingSprite.addChild(_AddRankingBg);
         _AddRankingSprite.addChild(_AddRankingReadyShow);
         _AddRankingBtn = GuildMemberWeekManager.instance.returnComponentBnt(_AddRankingSprite,false);
         _AddRankingBtn.x = 420;
         _AddRankingBtn.y = 410;
         _upDataTimeTxt = ComponentFactory.Instance.creatComponentByStylename("guildmemberweek.mainFrame.upDataTimeTxt");
         _upExplainText = ComponentFactory.Instance.creatComponentByStylename("guildmemberweek.mainFrame.upExplainTxt");
         _ActivityStartTimeShowText = ComponentFactory.Instance.creatComponentByStylename("guildmemberweek.mainFrame.activityStartTimeTxt");
         _ActivityEndTimeShowText = ComponentFactory.Instance.creatComponentByStylename("guildmemberweek.mainFrame.activityEndTimeTxt");
         _dataTitleRankingText = ComponentFactory.Instance.creatComponentByStylename("guildmemberweek.mainFrame.dataTitleRankingTxt");
         _dataTitleNameText = ComponentFactory.Instance.creatComponentByStylename("guildmemberweek.mainFrame.dataTitleNameTxt");
         _dataTitleContributeText = ComponentFactory.Instance.creatComponentByStylename("guildmemberweek.mainFrame.dataTitleContributeTxt");
         _dataTitleRankingGiftText = ComponentFactory.Instance.creatComponentByStylename("guildmemberweek.mainFrame.dataTitleRankingGiftTxt");
         _dataTitleAddRankingGiftText = ComponentFactory.Instance.creatComponentByStylename("guildmemberweek.mainFrame.dataTitleAddRankingGiftTxt");
         _ShowMyRankingText = ComponentFactory.Instance.creatComponentByStylename("guildmemberweek.mainFrame.ShowMyRankingTxt");
         _ShowMyContributeText = ComponentFactory.Instance.creatComponentByStylename("guildmemberweek.mainFrame.ShowMyContributeTxt");
         addToContent(_runkingBG);
         addToContent(_runkingSG);
         addToContent(_AddRecordBG);
         addToContent(_TenMBG);
         addToContent(_AddRanking);
         addToContent(_TopTenShowSprite);
         addToContent(_helpBtn);
         addToContent(_AddRankingBtn);
         addToContent(_upDataTimeTxt);
         addToContent(_upExplainText);
         addToContent(_ActivityStartTimeShowText);
         addToContent(_ActivityEndTimeShowText);
         addToContent(_dataTitleRankingText);
         addToContent(_dataTitleNameText);
         addToContent(_dataTitleContributeText);
         addToContent(_dataTitleRankingGiftText);
         addToContent(_dataTitleAddRankingGiftText);
         addToContent(_ShowMyRankingText);
         addToContent(_ShowMyContributeText);
      }
      
      public function upDataTimeTxt() : void
      {
         if(GuildMemberWeekManager.instance.model.upData != "no record...")
         {
            _upDataTimeTxt.text = LanguageMgr.GetTranslation("guildMemberWeek.MainFrame.upData") + "  " + GuildMemberWeekManager.instance.model.upData;
         }
         else
         {
            _upDataTimeTxt.text = "";
         }
      }
      
      private function initText() : void
      {
         upDataTimeTxt();
         _upExplainText.text = LanguageMgr.GetTranslation("guildMemberWeek.MainFrame.upExplain");
         _dataTitleRankingText.text = LanguageMgr.GetTranslation("guildMemberWeek.MainDataLabel.RankingLabel");
         _dataTitleNameText.text = LanguageMgr.GetTranslation("guildMemberWeek.MainDataLabel.NameLabel");
         _dataTitleContributeText.text = LanguageMgr.GetTranslation("guildMemberWeek.MainDataLabel.ContributeLabel");
         _dataTitleRankingGiftText.text = LanguageMgr.GetTranslation("guildMemberWeek.MainDataLabel.RankingGiftLabel");
         _dataTitleAddRankingGiftText.text = LanguageMgr.GetTranslation("guildMemberWeek.MainDataLabel.AddRankingGiftLabel");
         _ActivityStartTimeShowText.text = LanguageMgr.GetTranslation("guildMemberWeek.ActivityStartTimeShow") + GuildMemberWeekManager.instance.model.ActivityStartTime;
         _ActivityEndTimeShowText.text = LanguageMgr.GetTranslation("guildMemberWeek.ActivityEndTimeShow") + GuildMemberWeekManager.instance.model.ActivityEndTime;
         UpMyRanking();
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__responseHandler);
         _helpBtn.addEventListener("click",__onClickHelpHandler);
         _AddRankingBtn.addEventListener("click",__onClickAddRankingHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__responseHandler);
         if(_helpBtn)
         {
            _helpBtn.removeEventListener("click",__onClickHelpHandler);
         }
         if(_AddRankingBtn)
         {
            _AddRankingBtn.removeEventListener("click",__onClickAddRankingHandler);
         }
      }
      
      private function __onClickHelpHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:DisplayObject = ComponentFactory.Instance.creat("guildmemberweek.HelpPrompt");
         var _loc3_:GuildMemberWeekHelpFrame = ComponentFactory.Instance.creat("guildmemberweek.HelpFrame");
         _loc3_.setView(_loc2_);
         _loc3_.titleText = LanguageMgr.GetTranslation("guildMemberWeek.MainFrame.guildMemberWeek.readme");
         LayerManager.Instance.addToLayer(_loc3_,1,true,1);
      }
      
      private function __onClickAddRankingHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         if(PlayerManager.Instance.Self.Money < 100)
         {
            LeavePageManager.showFillFrame();
            return;
         }
         GuildMemberWeekManager.instance.doOpenaddRankingFrame();
      }
      
      public function UpMyRanking() : void
      {
         _ShowMyRankingText.text = String(GuildMemberWeekManager.instance.model.MyRanking);
         _ShowMyContributeText.text = String(GuildMemberWeekManager.instance.model.MyContribute);
      }
      
      public function ClearRecord() : void
      {
         _AddRanking.ClearRecord();
      }
      
      public function UpRecord() : void
      {
         _AddRanking.UpRecord();
      }
      
      private function __responseHandler(param1:FrameEvent) : void
      {
         if(param1.responseCode == 0 || param1.responseCode == 1)
         {
            SoundManager.instance.play("008");
            GuildMemberWeekManager.instance.disposeAllFrame();
         }
      }
      
      override public function dispose() : void
      {
         if(GuildMemberWeekManager.instance.model)
         {
            GuildMemberWeekManager.instance.model.PlayerAddPointBook = [0,0,0,0,0,0,0,0,0,0];
         }
         removeEvent();
         ObjectUtils.disposeAllChildren(this);
         ObjectUtils.disposeAllChildren(_AddRankingBtn);
         ObjectUtils.disposeObject(_AddRankingBtn);
         _AddRankingBtn = null;
         _AddRankingReadyShow.visible = true;
         if(_AddRankingSprite)
         {
            ObjectUtils.disposeAllChildren(_AddRankingSprite);
         }
         _AddRankingSprite = null;
         _AddRankingBg = null;
         _AddRankingReadyShow = null;
         super.dispose();
         _runkingBG = null;
         _runkingSG = null;
         _AddRecordBG = null;
         _TenMBG = null;
         _helpBtn = null;
         _upDataTimeTxt = null;
         _upExplainText = null;
         _ActivityStartTimeShowText = null;
         _ActivityEndTimeShowText = null;
         _dataTitleRankingText = null;
         _dataTitleNameText = null;
         _dataTitleContributeText = null;
         _dataTitleRankingGiftText = null;
         _dataTitleAddRankingGiftText = null;
         _ShowMyRankingText = null;
         _ShowMyContributeText = null;
         if(_AddRanking)
         {
            ObjectUtils.disposeAllChildren(_AddRanking);
         }
         _AddRanking = null;
         if(_TopTenShowSprite)
         {
            ObjectUtils.disposeAllChildren(_TopTenShowSprite);
         }
         _TopTenShowSprite = null;
      }
   }
}
