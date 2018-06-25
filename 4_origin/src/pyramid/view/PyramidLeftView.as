package pyramid.view
{
   import baglocked.BaglockedManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.PyramidEvent;
   import ddt.manager.GameInSocketOut;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.PyramidManager;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import pyramid.PyramidControl;
   
   public class PyramidLeftView extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _startBtn:BaseButton;
      
      private var _endBtn:BaseButton;
      
      private var _myLevelTxt:FilterFrameText;
      
      private var _myScoreTxt:FilterFrameText;
      
      private var _scoreAdd:FilterFrameText;
      
      private var _currentGetScore:FilterFrameText;
      
      private var _countMsgTxt:FilterFrameText;
      
      private var _countTxt:FilterFrameText;
      
      private var _pyramidCards:PyramidCards;
      
      private var _selectedAutoOpenCard:SelectedCheckButton;
      
      public function PyramidLeftView()
      {
         super();
         initView();
         initEvent();
         updateData();
         __movieLockHandler(null);
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("assets.pyramid.leftViewBg");
         _myLevelTxt = ComponentFactory.Instance.creatComponentByStylename("assets.pyramid.myLevelTxt");
         _myScoreTxt = ComponentFactory.Instance.creatComponentByStylename("assets.pyramid.myScoreTxt");
         _scoreAdd = ComponentFactory.Instance.creatComponentByStylename("assets.pyramid.scoreAdd");
         _currentGetScore = ComponentFactory.Instance.creatComponentByStylename("assets.pyramid.currentGetScore");
         _countMsgTxt = ComponentFactory.Instance.creatComponentByStylename("assets.pyramid.countMsgTxt");
         _countTxt = ComponentFactory.Instance.creatComponentByStylename("assets.pyramid.countTxt");
         _startBtn = ComponentFactory.Instance.creatComponentByStylename("asset.pyramid.leftView.startBtn");
         _endBtn = ComponentFactory.Instance.creatComponentByStylename("asset.pyramid.leftView.endBtn");
         _pyramidCards = ComponentFactory.Instance.creatCustomObject("pyramid.view.pyramidCards");
         _selectedAutoOpenCard = ComponentFactory.Instance.creatComponentByStylename("pyramid.selectedCheckAutoOpenCard");
         _selectedAutoOpenCard.autoSelect = false;
         _selectedAutoOpenCard.text = LanguageMgr.GetTranslation("ddt.pyramid.selectedCheckAutoOpenCardTxt");
         addChild(_bg);
         addChild(_pyramidCards);
         addChild(_myLevelTxt);
         addChild(_myScoreTxt);
         addChild(_scoreAdd);
         addChild(_currentGetScore);
         addChild(_countMsgTxt);
         addChild(_countTxt);
         addChild(_startBtn);
         addChild(_endBtn);
         addChild(_selectedAutoOpenCard);
      }
      
      private function __movieLockHandler(event:PyramidEvent) : void
      {
         if(PyramidControl.instance.movieLock)
         {
            _startBtn.mouseEnabled = false;
            _startBtn.mouseChildren = false;
            _endBtn.mouseEnabled = false;
            _endBtn.mouseChildren = false;
         }
         else
         {
            _startBtn.mouseEnabled = true;
            _startBtn.mouseChildren = true;
            _endBtn.mouseEnabled = true;
            _endBtn.mouseChildren = true;
         }
      }
      
      private function initEvent() : void
      {
         _startBtn.addEventListener("click",__startBtnHanlder);
         _endBtn.addEventListener("click",__startBtnHanlder);
         PyramidManager.instance.model.addEventListener("start_or_stop",__startOrStopHandler);
         PyramidManager.instance.model.addEventListener("card_result",__cardResultHandler);
         PyramidManager.instance.model.addEventListener("die_event",__DieEventHandler);
         PyramidManager.instance.model.addEventListener("score_convert",__scoreConvertEventHandler);
         PyramidControl.instance.addEventListener("movie_lock",__movieLockHandler);
         PyramidControl.instance.addEventListener("auto_openCard",__autoOpenCardChangeHandler);
         _selectedAutoOpenCard.addEventListener("click",_selectedAutoOpenCardClickHandler);
      }
      
      private function updateData() : void
      {
         _myLevelTxt.text = LanguageMgr.GetTranslation("ddt.pyramid.myLevelTxt",PyramidManager.instance.model.maxLayer);
         _myScoreTxt.text = PyramidManager.instance.model.totalPoint + "";
         _scoreAdd.text = PyramidManager.instance.model.pointRatio + "%";
         _currentGetScore.text = PyramidManager.instance.model.turnPoint + "";
         _countMsgTxt.text = LanguageMgr.GetTranslation("ddt.pyramid.countMsgTxt");
         var freeCount:int = PyramidManager.instance.model.freeCount - PyramidManager.instance.model.currentFreeCount;
         if(freeCount < 0)
         {
            freeCount = 0;
         }
         _countTxt.text = freeCount + "";
         isStart(PyramidManager.instance.model.isPyramidStart);
      }
      
      private function __startOrStopHandler(event:PyramidEvent) : void
      {
         updateData();
         _pyramidCards.updateSelectItems();
         _pyramidCards.playShuffleFullMovie();
      }
      
      private function __cardResultHandler(event:PyramidEvent) : void
      {
         var revieMoney:int = 0;
         PyramidControl.instance.movieLock = false;
         updateData();
         _pyramidCards.playTurnCardMovie();
         if(PyramidManager.instance.model.currentLayer >= 8)
         {
            _pyramidCards.topBoxMovieMode(1);
         }
         _pyramidCards.upClear();
         if(PyramidManager.instance.model.isPyramidDie)
         {
            revieMoney = PyramidManager.instance.model.revivePrice[PyramidManager.instance.model.currentReviveCount];
            if(PyramidManager.instance.model.currentReviveCount == PyramidManager.instance.model.revivePrice.length)
            {
               PyramidControl.instance.showFrame(2);
               PyramidControl.instance.isAutoOpenCard = false;
            }
            else if(PlayerManager.Instance.Self.Money < revieMoney)
            {
               PyramidControl.instance.showFrame(7);
            }
            else if(PyramidControl.instance.isShowReviveBuyFrameSelectedCheck)
            {
               PyramidControl.instance.showFrame(1);
            }
            else
            {
               GameInSocketOut.sendPyramidRevive(true,true);
            }
         }
      }
      
      private function __DieEventHandler(event:PyramidEvent) : void
      {
         updateData();
         _pyramidCards.updateSelectItems();
         PyramidControl.instance.dispatchEvent(new PyramidEvent("auto_openCard"));
      }
      
      private function __scoreConvertEventHandler(event:PyramidEvent) : void
      {
         _myScoreTxt.text = PyramidManager.instance.model.totalPoint + "";
      }
      
      private function isStart(bool:Boolean) : void
      {
         _endBtn.visible = bool;
         _startBtn.visible = !bool;
      }
      
      public function __startBtnHanlder(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(PyramidControl.instance.clickRateGo)
         {
            return;
         }
         if(PyramidControl.instance.movieLock)
         {
            return;
         }
         if(PyramidManager.instance.model.isScoreExchange)
         {
            PyramidControl.instance.showFrame(6);
         }
         else if(event.currentTarget == _startBtn)
         {
            GameInSocketOut.sendPyramidStartOrstop(true);
         }
         else
         {
            PyramidControl.instance.showFrame(3);
         }
      }
      
      private function _selectedAutoOpenCardClickHandler(evt:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         if(PyramidControl.instance.isShowAutoOpenFrameSelectedCheck && !_selectedAutoOpenCard.selected)
         {
            PyramidControl.instance.showFrame(8);
            return;
         }
         _selectedAutoOpenCard.selected = !_selectedAutoOpenCard.selected;
         PyramidControl.instance.isAutoOpenCard = _selectedAutoOpenCard.selected;
      }
      
      private function __autoOpenCardChangeHandler(evt:PyramidEvent) : void
      {
         if(_selectedAutoOpenCard)
         {
            _selectedAutoOpenCard.selected = PyramidControl.instance.isAutoOpenCard;
            if(PyramidControl.instance.isAutoOpenCard && _pyramidCards)
            {
               _pyramidCards.checkAutoOpenCard();
            }
         }
      }
      
      private function removeEvent() : void
      {
         _startBtn.removeEventListener("click",__startBtnHanlder);
         _endBtn.removeEventListener("click",__startBtnHanlder);
         PyramidManager.instance.model.removeEventListener("start_or_stop",__startOrStopHandler);
         PyramidManager.instance.model.removeEventListener("card_result",__cardResultHandler);
         PyramidManager.instance.model.removeEventListener("die_event",__DieEventHandler);
         PyramidManager.instance.model.removeEventListener("score_convert",__scoreConvertEventHandler);
         PyramidControl.instance.removeEventListener("movie_lock",__movieLockHandler);
         PyramidControl.instance.removeEventListener("auto_openCard",__autoOpenCardChangeHandler);
         _selectedAutoOpenCard.addEventListener("click",_selectedAutoOpenCardClickHandler);
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_startBtn);
         _startBtn = null;
         ObjectUtils.disposeObject(_endBtn);
         _endBtn = null;
         ObjectUtils.disposeObject(_myLevelTxt);
         _myLevelTxt = null;
         ObjectUtils.disposeObject(_myScoreTxt);
         _myScoreTxt = null;
         ObjectUtils.disposeObject(_scoreAdd);
         _scoreAdd = null;
         ObjectUtils.disposeObject(_currentGetScore);
         _currentGetScore = null;
         ObjectUtils.disposeObject(_countTxt);
         _countTxt = null;
         ObjectUtils.disposeObject(_pyramidCards);
         _pyramidCards = null;
         ObjectUtils.disposeObject(_selectedAutoOpenCard);
         _selectedAutoOpenCard = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
