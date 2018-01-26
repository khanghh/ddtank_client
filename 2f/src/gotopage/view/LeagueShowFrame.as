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
      
      public function LeagueShowFrame(){super();}
      
      private function initView() : void{}
      
      private function addEvent() : void{}
      
      private function __onResponse(param1:FrameEvent) : void{}
      
      private function __onItemChanaged(param1:Event) : void{}
      
      private function removeEvent() : void{}
      
      override public function dispose() : void{}
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
   
   function LeagueAwardCell(param1:DailyLeagueAwardInfo){super(null);}
   
   protected function initII() : void{}
   
   override public function dispose() : void{}
}
