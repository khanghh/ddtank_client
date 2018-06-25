package gotopage.view
{
   import bagAndInfo.cell.BaseCell;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedTextButton;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.DailyLeagueManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import ddt.view.common.DailyLeagueLevel;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.Event;
   
   public class LeagueShowFrame extends Frame
   {
       
      
      private var _leftBack:MutipleImage;
      
      private var _leagueRank:DailyLeagueLevel;
      
      private var _leagueTitle:FilterFrameText;
      
      private var _todayNumberTitle:Bitmap;
      
      private var _todayNumberBg:Scale9CornerImage;
      
      private var _todayNumberField:FilterFrameText;
      
      private var _todayScoreTitle:Bitmap;
      
      private var _todayScoreBg:Scale9CornerImage;
      
      private var _todayScoreField:FilterFrameText;
      
      private var _weekRankingTitle:Bitmap;
      
      private var _weekRankingBg:Scale9CornerImage;
      
      private var _weekRankingField:FilterFrameText;
      
      private var _weekScoreTitle:Bitmap;
      
      private var _weekScoreBg:Scale9CornerImage;
      
      private var _weekScoreField:FilterFrameText;
      
      private var _lv20_29Btn:SelectedButton;
      
      private var _lv30_39Btn:SelectedButton;
      
      private var _lv40_49Btn:SelectedButton;
      
      private var _levelSelGroup:SelectedButtonGroup;
      
      private var _awardScoreBg:Scale9CornerImage;
      
      private var _scoreBtnI:SelectedTextButton;
      
      private var _scoreBtnII:SelectedTextButton;
      
      private var _scoreBtnIII:SelectedTextButton;
      
      private var _scoreBtnIV:SelectedTextButton;
      
      private var _scoreSelGroup:SelectedButtonGroup;
      
      private var _awardBox:SimpleTileList;
      
      private var _explanationPanel:ScrollPanel;
      
      private var _rightBack:MutipleImage;
      
      private var _explanationBg:ScaleBitmapImage;
      
      public function LeagueShowFrame()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("gotopage.view.LeagueShowFrame.title");
         _leftBack = ComponentFactory.Instance.creatComponentByStylename("leagueShow.leftBack");
         addToContent(_leftBack);
         var score:Number = PlayerManager.Instance.Self.DailyLeagueLastScore;
         var leagueFirst:Boolean = PlayerManager.Instance.Self.DailyLeagueFirst;
         _leagueRank = new DailyLeagueLevel();
         _leagueRank.leagueFirst = leagueFirst;
         _leagueRank.score = score;
         PositionUtils.setPos(_leagueRank,"leagueShow.view.leagueRankPos");
         addToContent(_leagueRank);
         _leagueTitle = ComponentFactory.Instance.creatComponentByStylename("leagueShow.view.leagueTitle");
         _leagueTitle.text = DailyLeagueManager.Instance.getLeagueLevelByScore(score,leagueFirst).Name;
         addToContent(_leagueTitle);
         _todayNumberTitle = ComponentFactory.Instance.creatBitmap("asset.leagueShow.todayNumberTxt");
         addToContent(_todayNumberTitle);
         _todayNumberBg = ComponentFactory.Instance.creatComponentByStylename("asset.leagueShow.TextFieldBg");
         addToContent(_todayNumberBg);
         _todayNumberBg.y = _todayNumberTitle.y + 1;
         _todayNumberField = ComponentFactory.Instance.creatComponentByStylename("leagueShow.view.todayNumberField");
         addToContent(_todayNumberField);
         _todayScoreTitle = ComponentFactory.Instance.creatBitmap("asset.leagueShow.todayScoreTxt");
         addToContent(_todayScoreTitle);
         _todayScoreBg = ComponentFactory.Instance.creatComponentByStylename("asset.leagueShow.TextFieldBg");
         addToContent(_todayScoreBg);
         _todayScoreBg.y = _todayScoreTitle.y + 1;
         _todayScoreField = ComponentFactory.Instance.creatComponentByStylename("leagueShow.view.todayScoreField");
         addToContent(_todayScoreField);
         _weekRankingTitle = ComponentFactory.Instance.creatBitmap("asset.leagueShow.weekRankingTxt");
         addToContent(_weekRankingTitle);
         _weekRankingBg = ComponentFactory.Instance.creatComponentByStylename("asset.leagueShow.TextFieldBg");
         addToContent(_weekRankingBg);
         _weekRankingBg.y = _weekRankingTitle.y + 1;
         _weekRankingField = ComponentFactory.Instance.creatComponentByStylename("leagueShow.view.weekRankingField");
         addToContent(_weekRankingField);
         _weekScoreTitle = ComponentFactory.Instance.creatBitmap("asset.leagueShow.weekScoreTxt");
         addToContent(_weekScoreTitle);
         _weekScoreBg = ComponentFactory.Instance.creatComponentByStylename("asset.leagueShow.TextFieldBg");
         addToContent(_weekScoreBg);
         _weekScoreBg.y = _weekScoreTitle.y + 1;
         _weekScoreField = ComponentFactory.Instance.creatComponentByStylename("leagueShow.view.weekScoreField");
         addToContent(_weekScoreField);
         _weekRankingField.text = String(PlayerManager.Instance.Self.matchInfo.weeklyRanking);
         _weekScoreField.text = String(PlayerManager.Instance.Self.matchInfo.weeklyScore);
         _todayNumberField.text = String(PlayerManager.Instance.Self.matchInfo.dailyGameCount);
         _todayScoreField.text = String(PlayerManager.Instance.Self.matchInfo.dailyScore);
         _rightBack = ComponentFactory.Instance.creatComponentByStylename("leagueShow.rightBack");
         addToContent(_rightBack);
         _explanationBg = ComponentFactory.Instance.creatComponentByStylename("leagueShow.explanationContentBg");
         addToContent(_explanationBg);
         _explanationPanel = ComponentFactory.Instance.creatComponentByStylename("leagueShow.view.explanationPanel");
         _explanationPanel.setView(ClassUtils.CreatInstance("asset.leagueShow.explanationContentAsset") as MovieClip);
         addToContent(_explanationPanel);
         _lv20_29Btn = ComponentFactory.Instance.creatComponentByStylename("leagueShow.view.lv20_29selectBtn");
         addToContent(_lv20_29Btn);
         _lv20_29Btn.autoSelect = true;
         _lv30_39Btn = ComponentFactory.Instance.creatComponentByStylename("leagueShow.view.lv30_39selectBtn");
         addToContent(_lv30_39Btn);
         _lv40_49Btn = ComponentFactory.Instance.creatComponentByStylename("leagueShow.view.lv40_49selectBtn");
         addToContent(_lv40_49Btn);
         _levelSelGroup = new SelectedButtonGroup();
         _levelSelGroup.addSelectItem(_lv20_29Btn);
         _levelSelGroup.addSelectItem(_lv30_39Btn);
         _levelSelGroup.addSelectItem(_lv40_49Btn);
         _levelSelGroup.selectIndex = 0;
         _scoreBtnI = ComponentFactory.Instance.creatComponentByStylename("leagueShow.view.awardScoreBtnI");
         _scoreBtnII = ComponentFactory.Instance.creatComponentByStylename("leagueShow.view.awardScoreBtnII");
         _scoreBtnIII = ComponentFactory.Instance.creatComponentByStylename("leagueShow.view.awardScoreBtnIII");
         _scoreBtnIV = ComponentFactory.Instance.creatComponentByStylename("leagueShow.view.awardScoreBtnIV");
         addToContent(_scoreBtnI);
         addToContent(_scoreBtnII);
         addToContent(_scoreBtnIII);
         addToContent(_scoreBtnIV);
         _scoreBtnI.text = LanguageMgr.GetTranslation("gotopage.view.LeagueShowFrame.scoreBtnText","10000");
         _scoreBtnII.text = LanguageMgr.GetTranslation("gotopage.view.LeagueShowFrame.scoreBtnText","20000");
         _scoreBtnIII.text = LanguageMgr.GetTranslation("gotopage.view.LeagueShowFrame.scoreBtnText","35000");
         _scoreBtnIV.text = LanguageMgr.GetTranslation("gotopage.view.LeagueShowFrame.scoreBtnText","60000");
         _scoreSelGroup = new SelectedButtonGroup();
         _scoreSelGroup.addSelectItem(_scoreBtnI);
         _scoreSelGroup.addSelectItem(_scoreBtnII);
         _scoreSelGroup.addSelectItem(_scoreBtnIII);
         _scoreSelGroup.addSelectItem(_scoreBtnIV);
         _scoreSelGroup.selectIndex = 0;
         _awardScoreBg = ComponentFactory.Instance.creatComponentByStylename("asset.leagueShow.awardScoreBg");
         addToContent(_awardScoreBg);
         _awardBox = ComponentFactory.Instance.creatCustomObject("leagueShow.view.awardBox",[7]);
         addToContent(_awardBox);
         __onItemChanaged(null);
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__onResponse);
         _levelSelGroup.addEventListener("change",__onItemChanaged);
         _scoreSelGroup.addEventListener("change",__onItemChanaged);
      }
      
      private function __onResponse(event:FrameEvent) : void
      {
         SoundManager.instance.playButtonSound();
         dispose();
      }
      
      private function __onItemChanaged(event:Event) : void
      {
         var i:int = 0;
         var j:* = 0;
         if(event)
         {
            SoundManager.instance.playButtonSound();
         }
         _awardBox.disposeAllChildren();
         ObjectUtils.removeChildAllChildren(_awardBox);
         var list:Array = DailyLeagueManager.Instance.filterLeagueAwardList(_levelSelGroup.selectIndex,_scoreSelGroup.selectIndex);
         var count:int = Math.min(list.length,14);
         for(i = 0; i < count; )
         {
            _awardBox.addChild(new LeagueAwardCell(list[i]));
            i++;
         }
         for(j = count; j < 14; )
         {
            _awardBox.addChild(new BaseCell(ComponentFactory.Instance.creatComponentByStylename("leagueShow.view.awardcellBg")));
            j++;
         }
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__onResponse);
         _levelSelGroup.removeEventListener("change",__onItemChanaged);
         _scoreSelGroup.removeEventListener("change",__onItemChanaged);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         super.dispose();
         if(_leftBack)
         {
            ObjectUtils.disposeObject(_leftBack);
         }
         _leftBack = null;
         if(_leagueRank)
         {
            ObjectUtils.disposeObject(_leagueRank);
         }
         _leagueRank = null;
         if(_leagueTitle)
         {
            ObjectUtils.disposeObject(_leagueTitle);
         }
         _leagueTitle = null;
         if(_todayNumberTitle)
         {
            ObjectUtils.disposeObject(_todayNumberTitle);
         }
         _todayNumberTitle = null;
         if(_todayNumberBg)
         {
            ObjectUtils.disposeObject(_todayNumberBg);
         }
         _todayNumberBg = null;
         if(_todayNumberField)
         {
            ObjectUtils.disposeObject(_todayNumberField);
         }
         _todayNumberField = null;
         if(_todayScoreTitle)
         {
            ObjectUtils.disposeObject(_todayScoreTitle);
         }
         _todayScoreTitle = null;
         if(_todayScoreBg)
         {
            ObjectUtils.disposeObject(_todayScoreBg);
         }
         _todayScoreBg = null;
         if(_todayScoreField)
         {
            ObjectUtils.disposeObject(_todayScoreField);
         }
         _todayScoreField = null;
         if(_weekRankingTitle)
         {
            ObjectUtils.disposeObject(_weekRankingTitle);
         }
         _weekRankingTitle = null;
         if(_weekRankingBg)
         {
            ObjectUtils.disposeObject(_weekRankingBg);
         }
         _weekRankingBg = null;
         if(_weekRankingField)
         {
            ObjectUtils.disposeObject(_weekRankingField);
         }
         _weekRankingField = null;
         if(_weekScoreTitle)
         {
            ObjectUtils.disposeObject(_weekScoreTitle);
         }
         _weekScoreTitle = null;
         if(_weekScoreBg)
         {
            ObjectUtils.disposeObject(_weekScoreBg);
         }
         _weekScoreBg = null;
         if(_weekScoreField)
         {
            ObjectUtils.disposeObject(_weekScoreField);
         }
         _weekScoreField = null;
         if(_lv20_29Btn)
         {
            ObjectUtils.disposeObject(_lv20_29Btn);
         }
         _lv20_29Btn = null;
         if(_lv30_39Btn)
         {
            ObjectUtils.disposeObject(_lv30_39Btn);
         }
         _lv30_39Btn = null;
         if(_lv40_49Btn)
         {
            ObjectUtils.disposeObject(_lv40_49Btn);
         }
         _lv40_49Btn = null;
         if(_levelSelGroup)
         {
            ObjectUtils.disposeObject(_levelSelGroup);
         }
         _levelSelGroup = null;
         if(_scoreBtnI)
         {
            ObjectUtils.disposeObject(_scoreBtnI);
         }
         _scoreBtnI = null;
         if(_scoreBtnII)
         {
            ObjectUtils.disposeObject(_scoreBtnII);
         }
         _scoreBtnII = null;
         if(_scoreBtnIII)
         {
            ObjectUtils.disposeObject(_scoreBtnIII);
         }
         _scoreBtnIII = null;
         if(_scoreBtnIV)
         {
            ObjectUtils.disposeObject(_scoreBtnIV);
         }
         _scoreBtnIV = null;
         if(_scoreSelGroup)
         {
            ObjectUtils.disposeObject(_scoreSelGroup);
         }
         _scoreSelGroup = null;
         if(_awardBox)
         {
            ObjectUtils.disposeObject(_awardBox);
         }
         _awardBox = null;
         if(_explanationPanel)
         {
            ObjectUtils.disposeObject(_explanationPanel);
         }
         _explanationPanel = null;
         if(_rightBack)
         {
            ObjectUtils.disposeObject(_rightBack);
         }
         _rightBack = null;
         if(_explanationBg)
         {
            ObjectUtils.disposeObject(_explanationBg);
         }
         _explanationBg = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

import bagAndInfo.cell.BaseCell;
import com.pickgliss.ui.ComponentFactory;
import com.pickgliss.ui.text.FilterFrameText;
import com.pickgliss.utils.ObjectUtils;
import ddt.data.DailyLeagueAwardInfo;
import ddt.manager.ItemManager;

class LeagueAwardCell extends BaseCell
{
    
   
   private var _awardInfo:DailyLeagueAwardInfo;
   
   private var _countTxt:FilterFrameText;
   
   function LeagueAwardCell(awardInfo:DailyLeagueAwardInfo)
   {
      _awardInfo = awardInfo;
      super(ComponentFactory.Instance.creatBitmap("asset.leagueAward.cellBackAsset"),ItemManager.Instance.getTemplateById(_awardInfo.TemplateID));
      initII();
   }
   
   protected function initII() : void
   {
      _countTxt = ComponentFactory.Instance.creat("bossbox.boxCellCount");
      _countTxt.text = String(_awardInfo.Count);
      addChild(_countTxt);
   }
   
   override public function dispose() : void
   {
      super.dispose();
      if(_countTxt)
      {
         ObjectUtils.disposeObject(_countTxt);
      }
      _countTxt = null;
      ObjectUtils.disposeAllChildren(this);
      if(parent)
      {
         parent.removeChild(this);
      }
   }
}
