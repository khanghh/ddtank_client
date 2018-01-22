package luckStar.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import luckStar.LoadingLuckStarUI;
   import luckStar.manager.LuckStarManager;
   import luckStar.model.LuckStarPlayerInfo;
   
   public class LuckStarRankView extends Sprite implements Disposeable
   {
      
      private static const MAX_RANK_VIEW:int = 5;
      
      private static const MAX_PAGE:int = 2;
      
      private static const MAX_AWARD:int = 3;
      
      private static const REQUEST_TIME:int = 300000;
       
      
      private var _rankBG:Bitmap;
      
      private var _awardListBG:Bitmap;
      
      private var _awardBtn:BaseButton;
      
      private var _preBtn:SimpleBitmapButton;
      
      private var _nextBtn:SimpleBitmapButton;
      
      private var _pageBG:Scale9CornerImage;
      
      private var _pageText:FilterFrameText;
      
      private var _updateTimeText:FilterFrameText;
      
      private var _timeText:FilterFrameText;
      
      private var _myRankText:FilterFrameText;
      
      private var _luckyStarNumText:FilterFrameText;
      
      private var _rankInfo:Vector.<LuckStarRankItem>;
      
      private var _currentPage:int = 1;
      
      private var _maxPage:int = 1;
      
      private var _newAward:Sprite;
      
      private var _newAwardList:Vector.<LuckStarNewAwardItem>;
      
      private var _list:Vector.<Array>;
      
      private var _isMove:Boolean = false;
      
      private var _textHeight:int;
      
      private var _awardView:LuckStarAwardView;
      
      private var _index:int;
      
      private var _rankTitle:FilterFrameText;
      
      private var _rankName:FilterFrameText;
      
      private var _rankNum:FilterFrameText;
      
      private var _awardNmae:FilterFrameText;
      
      private var _awardListText:FilterFrameText;
      
      private var _time:Timer;
      
      private var _helpText:FilterFrameText;
      
      public function LuckStarRankView(){super();}
      
      private function init() : void{}
      
      public function updateNewAwardList() : void{}
      
      public function insertNewAwardItem(param1:String, param2:int, param3:int) : void{}
      
      private function __onMove(param1:Event) : void{}
      
      private function check() : void{}
      
      private function moreItemPlay() : void{}
      
      private function __onPreClick(param1:MouseEvent) : void{}
      
      private function __onNextClick(param1:MouseEvent) : void{}
      
      private function __onAwardClick(param1:MouseEvent) : void{}
      
      private function set currentPage(param1:int) : void{}
      
      public function updateRankInfo() : void{}
      
      public function lastUpdateTime() : void{}
      
      public function updateSelfInfo() : void{}
      
      public function updateHelpText() : void{}
      
      public function updateActivityDate() : void{}
      
      private function __onTimer(param1:TimerEvent) : void{}
      
      public function dispose() : void{}
   }
}
