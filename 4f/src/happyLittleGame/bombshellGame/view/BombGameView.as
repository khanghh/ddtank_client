package happyLittleGame.bombshellGame.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.NumberImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.PkgEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.text.TextFormat;
   import funnyGames.FunnyGamesManager;
   import happyLittleGame.bombshellGame.item.BombRankItemIII;
   import uiModeManager.bombUI.HappyLittleGameManager;
   import uiModeManager.bombUI.event.HappyLittleGameEvent;
   import uiModeManager.bombUI.model.bomb.BombRankInfo;
   
   public class BombGameView extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _lv:Bitmap;
      
      private var _lvValue:NumberImage;
      
      private var _scoreValue:NumberImage;
      
      private var _wand:MovieClip;
      
      private var _wandBitMap:Bitmap;
      
      private var _wandBitMapGray:Bitmap;
      
      private var _wandBitMapMask:Bitmap;
      
      private var _stepValue:NumberImage;
      
      private var _dayRankBtn:SelectedButton;
      
      private var _totalRankBtn:SelectedButton;
      
      private var _rankTxt:FilterFrameText;
      
      private var _nameTxt:FilterFrameText;
      
      private var _scoreTxt:FilterFrameText;
      
      private var _mytotalRank:FilterFrameText;
      
      private var _prompII:FilterFrameText;
      
      private var _mydayRank:FilterFrameText;
      
      private var _historyMax:FilterFrameText;
      
      private var _dayMax:FilterFrameText;
      
      private var _reStartBtn:SimpleBitmapButton;
      
      private var _backBtn:SimpleBitmapButton;
      
      private var _pagerightBtn:BaseButton;
      
      private var _pageleftBtn:BaseButton;
      
      private var _pageBg:Bitmap;
      
      private var _pageTxt:FilterFrameText;
      
      private var _pageEndBtn:BaseButton;
      
      private var _pageFirstBtn:BaseButton;
      
      private var _items:Vector.<BombRankItemIII>;
      
      private var _currentarr:Vector.<BombRankInfo>;
      
      private var _logic:BombLogic;
      
      private var _dayPageIndex:int = 1;
      
      private var _totalPageIndex:int = 1;
      
      private var _currentRankType:int = 2;
      
      private var _mapData:FilterFrameText;
      
      private var _maskBasic:int = 50;
      
      private var _stepdifference:int = 4;
      
      private var _maskH:int;
      
      private var _currentStep:int;
      
      private var _showWandMc:Boolean = false;
      
      private var _passAll:MovieClip;
      
      private var _pass:MovieClip;
      
      private var _gameover:MovieClip;
      
      private var _posStep:Point;
      
      private var _oncemoreBtn:BaseButton;
      
      private var _lvMc:MovieClip;
      
      private var _doubleImg:Bitmap;
      
      public function BombGameView(){super();}
      
      public function setRankData() : void{}
      
      private function showServerScores() : void{}
      
      private function SetScores(param1:int) : void{}
      
      private function dataTxt() : void{}
      
      private function initEvent() : void{}
      
      private function __refreshMaxScoreHadler(param1:HappyLittleGameEvent) : void{}
      
      private function __firstPageBtnClickHandler(param1:MouseEvent) : void{}
      
      private function __pageEndBtnClickHander(param1:MouseEvent) : void{}
      
      private function __keydownhandler(param1:KeyboardEvent) : void{}
      
      private function wandMc() : void{}
      
      private function hideWandMc() : void{}
      
      private function removeEvent() : void{}
      
      private function __pageRClickHandler(param1:MouseEvent) : void{}
      
      private function __pageLClickHandler(param1:MouseEvent) : void{}
      
      private function __rankDayClickHandler(param1:MouseEvent) : void{}
      
      private function _rankTotalClickHandler(param1:MouseEvent) : void{}
      
      private function __gameNextHandler(param1:PkgEvent) : void{}
      
      private function showLvMc() : void{}
      
      private function adjustmentStepPos() : void{}
      
      public function __refreshClickHandler(param1:PkgEvent) : void{}
      
      private function stepSubduction() : void{}
      
      private function stepAdd() : void{}
      
      private function refreshStep() : void{}
      
      private function checkStepCanAdd() : Boolean{return false;}
      
      private function gameNext() : void{}
      
      private function showPassMc() : void{}
      
      private function setBtnClickState(param1:Boolean) : void{}
      
      private function __passHandler(param1:Event) : void{}
      
      private function gameOver() : void{}
      
      private function __passAllHandler(param1:Event) : void{}
      
      private function __gameoverhandler(param1:Event) : void{}
      
      private function __oncemoreClickHandler(param1:MouseEvent) : void{}
      
      public function set RankInfos(param1:Vector.<BombRankInfo>) : void{}
      
      private function __backclickhandle(param1:MouseEvent) : void{}
      
      private function goBackSceneResponse(param1:FrameEvent) : void{}
      
      private function __restartclickhandler(param1:MouseEvent) : void{}
      
      private function onEnterSceneResponse(param1:FrameEvent) : void{}
      
      public function ReStart() : void{}
      
      private function getComponentByStylename(param1:String) : *{return null;}
      
      private function initRankItem() : void{}
      
      public function clearItemInfo() : void{}
      
      public function showDayRankByPage(param1:int) : void{}
      
      public function dispose() : void{}
   }
}
