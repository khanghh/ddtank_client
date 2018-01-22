package superWinner.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.ChatManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.StateManager;
   import ddt.manager.TimeManager;
   import ddt.utils.PositionUtils;
   import ddt.view.chat.ChatView;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.Timer;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import superWinner.controller.SuperWinnerController;
   import superWinner.data.SuperWinnerAwardsMode;
   import superWinner.event.SuperWinnerEvent;
   import superWinner.manager.SuperWinnerManager;
   import superWinner.model.SuperWinnerModel;
   import superWinner.view.bigAwards.SuperWinnerBigAwardView;
   import superWinner.view.smallAwards.SuperWinnerSmallAwardView;
   
   public class SuperWinnerView extends Sprite implements Disposeable
   {
       
      
      private var _model:SuperWinnerModel;
      
      private var _contro:SuperWinnerController;
      
      private var _dicesbanner:DicesBanner;
      
      private var _championDicesbanner:DicesBanner;
      
      private var _dicesMovie:DicesMovieSprite;
      
      private var _progressBar:SuperWinnerProgressBar;
      
      private var _rollDiceBtn:BaseButton;
      
      private var _playerList:SuperWinnerPlayerListView;
      
      private var _awardView:SuperWinnerBigAwardView;
      
      private var _myAwardView:SuperWinnerSmallAwardView;
      
      private var returnBtn:SuperWinnerReturn;
      
      private var _champion:SuperWinnerPlayerItem;
      
      private var _chatView:ChatView;
      
      private var _endTimeTxt:FilterFrameText;
      
      private var _time:Timer;
      
      private var _remainTime:uint = 0;
      
      private var _helpBtn:BaseButton;
      
      private var championBg:Bitmap;
      
      private var noChampionBg:Bitmap;
      
      private var cot:uint;
      
      private var _awardsTip:SuperWinnerAwardsTip;
      
      public function SuperWinnerView(param1:SuperWinnerController){super();}
      
      private function init() : void{}
      
      private function count(param1:Event) : void{}
      
      public function endGame() : void{}
      
      private function count30s(param1:BaseAlerFrame) : void{}
      
      private function outRoom(param1:FrameEvent) : void{}
      
      private function initEvent() : void{}
      
      public function removeEvent() : void{}
      
      private function __showTip(param1:SuperWinnerEvent) : void{}
      
      private function __hideTip(param1:SuperWinnerEvent) : void{}
      
      private function __startRollDices(param1:SuperWinnerEvent) : void{}
      
      public function updateTime(param1:int) : void{}
      
      protected function __openHelpFrame(param1:MouseEvent) : void{}
      
      protected function __frameEvent(param1:FrameEvent) : void{}
      
      private function __rollDiceFunc(param1:MouseEvent) : void{}
      
      private function __progressTimesUp(param1:SuperWinnerEvent) : void{}
      
      private function __sendNotice(param1:SuperWinnerEvent) : void{}
      
      private function __championChange(param1:SuperWinnerEvent) : void{}
      
      private function __returnDices(param1:SuperWinnerEvent) : void{}
      
      private function showLastDices() : void{}
      
      private function showSystemMsg() : void{}
      
      private function showChampionMsg(param1:Boolean) : void{}
      
      private function __onReturn(param1:SuperWinnerEvent) : void{}
      
      public function dispose() : void{}
   }
}
