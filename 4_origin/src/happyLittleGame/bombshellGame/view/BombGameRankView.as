package happyLittleGame.bombshellGame.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import uiModeManager.bombUI.HappyLittleGameManager;
   
   public class BombGameRankView extends Sprite implements Disposeable
   {
       
      
      private var _bgBottom:ScaleBitmapImage;
      
      private var _selectDayRank:SelectedButton;
      
      private var _selectTotalRank:SelectedButton;
      
      private var _fixRankView:BombGameFixRank;
      
      private var _randomRankView:BombGameRandomRank;
      
      private var _myTotalRank:FilterFrameText;
      
      private var _myDayRank:FilterFrameText;
      
      private var _HistoryMaxPoints:FilterFrameText;
      
      private var _dayMaxPoints:FilterFrameText;
      
      private var _rankBtn:SimpleBitmapButton;
      
      private var _currentSelectRank:int = 2;
      
      public function BombGameRankView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _bgBottom = ComponentFactory.Instance.creatComponentByStylename("bombgame.dayNews.frameBottom");
         _selectDayRank = ComponentFactory.Instance.creatComponentByStylename("bombgame.dayrank.btn");
         _selectTotalRank = ComponentFactory.Instance.creatComponentByStylename("bombgame.totalrank.btn");
         _rankBtn = ComponentFactory.Instance.creatComponentByStylename("simpleGameRank.rankBtn");
         _fixRankView = new BombGameFixRank();
         _randomRankView = new BombGameRandomRank();
         _randomRankView.visible = false;
         _selectDayRank.selected = true;
         _selectDayRank.mouseEnabled = false;
         _selectDayRank.y = _selectDayRank.y - 2;
         _myTotalRank = ComponentFactory.Instance.creatComponentByStylename("bombgame.dayrank.totalrank");
         _myDayRank = ComponentFactory.Instance.creatComponentByStylename("bombgame.dayrank.dayrank");
         _HistoryMaxPoints = ComponentFactory.Instance.creatComponentByStylename("bombgame.dayrank.HMaxScore");
         _dayMaxPoints = ComponentFactory.Instance.creatComponentByStylename("bombgame.dayrank.DMaxScore");
         _myTotalRank.text = "";
         _myDayRank.text = "";
         _HistoryMaxPoints.text = "";
         _dayMaxPoints.text = "";
         addChild(_bgBottom);
         addChild(_selectDayRank);
         addChild(_selectTotalRank);
         addChild(_randomRankView);
         addChild(_fixRankView);
         addChild(_myTotalRank);
         addChild(_myDayRank);
         addChild(_HistoryMaxPoints);
         addChild(_dayMaxPoints);
      }
      
      public function setRankData() : void
      {
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         var _loc5_:int = 0;
         var _loc1_:int = HappyLittleGameManager.instance.currentGameType;
         _loc2_ = HappyLittleGameManager.instance.bombManager.getMyTotalRankByGameType(_loc1_);
         _loc4_ = HappyLittleGameManager.instance.bombManager.getMyDayRankByGameType(_loc1_);
         _loc3_ = HappyLittleGameManager.instance.bombManager.getDayMaxScoreByType(_loc1_);
         _loc5_ = HappyLittleGameManager.instance.bombManager.getHisMaxScoreByType(_loc1_);
         _myTotalRank.text = _loc2_ == 0?LanguageMgr.GetTranslation("bombKing.outOfRank2"):_loc2_ + "";
         _myDayRank.text = _loc4_ == 0?LanguageMgr.GetTranslation("bombKing.outOfRank2"):_loc4_ + "";
         _HistoryMaxPoints.text = _loc5_ + "";
         _dayMaxPoints.text = _loc3_ + "";
      }
      
      private function initEvent() : void
      {
         _selectDayRank.addEventListener("click",__dayclickhandler);
         _selectTotalRank.addEventListener("click",__totalclickhandler);
         this._rankBtn.addEventListener("click",onRankClick);
      }
      
      private function onRankClick(param1:MouseEvent) : void
      {
         HappyLittleGameManager.instance.showRankFrame();
      }
      
      public function reFreshRank() : void
      {
         if(HappyLittleGameManager.instance.currentGameType == 2)
         {
            _fixRankView.visible = true;
            _randomRankView.visible = false;
            _fixRankView.refreshData(_currentSelectRank);
         }
         else if(HappyLittleGameManager.instance.currentGameType == 1 || HappyLittleGameManager.instance.currentGameType == 3)
         {
            _fixRankView.visible = false;
            _randomRankView.visible = true;
            _randomRankView.refreshData(_currentSelectRank);
         }
         setRankData();
      }
      
      private function removeEvent() : void
      {
         _selectDayRank.removeEventListener("click",__dayclickhandler);
         _selectTotalRank.removeEventListener("click",__totalclickhandler);
         this._rankBtn.removeEventListener("click",onRankClick);
      }
      
      private function __dayclickhandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         _selectDayRank.mouseEnabled = false;
         _selectDayRank.y = _selectDayRank.y - 2;
         _selectTotalRank.mouseEnabled = true;
         _selectTotalRank.y = _selectTotalRank.y + 2;
         _currentSelectRank = 2;
         if(_selectTotalRank.selected)
         {
            _selectTotalRank.selected = false;
         }
         if(HappyLittleGameManager.instance.currentGameType == 2)
         {
            _fixRankView.refreshData(_currentSelectRank);
         }
         else if(HappyLittleGameManager.instance.currentGameType == 1 || HappyLittleGameManager.instance.currentGameType == 3)
         {
            _randomRankView.refreshData(_currentSelectRank);
         }
      }
      
      private function __totalclickhandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         _selectDayRank.mouseEnabled = true;
         _selectDayRank.y = _selectDayRank.y + 2;
         _selectTotalRank.mouseEnabled = false;
         _selectTotalRank.y = _selectTotalRank.y - 2;
         _currentSelectRank = 1;
         if(_selectDayRank.selected)
         {
            _selectDayRank.selected = false;
         }
         if(HappyLittleGameManager.instance.currentGameType == 2)
         {
            _fixRankView.refreshData(_currentSelectRank);
         }
         else if(HappyLittleGameManager.instance.currentGameType == 1 || HappyLittleGameManager.instance.currentGameType == 3)
         {
            _randomRankView.refreshData(_currentSelectRank);
         }
      }
      
      public function dispose() : void
      {
         var _loc1_:* = null;
         removeEvent();
         while(this.numChildren > 0)
         {
            _loc1_ = removeChildAt(0);
            ObjectUtils.disposeObject(_loc1_);
            _loc1_ = null;
         }
      }
   }
}
