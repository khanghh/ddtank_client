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
      
      public function BombGameView()
      {
         super();
         _bg = ComponentFactory.Instance.creatBitmap("asset.bombgame.bg");
         _lv = ComponentFactory.Instance.creatBitmap("asset.bombgame.Lv");
         _lvValue = getComponentByStylename("bombgame.NumberA");
         _stepValue = getComponentByStylename("bombgame.NumberB");
         _scoreValue = getComponentByStylename("bombgame.NumberC");
         _wand = ClassUtils.CreatInstance("asset.bombgame.wand");
         _wand.visible = false;
         _reStartBtn = getComponentByStylename("bombgame.bomb.reStartbtn");
         _backBtn = getComponentByStylename("bombgame.bomb.backbtn");
         _dayRankBtn = getComponentByStylename("bombgame.bomb.dayrankbtn");
         _totalRankBtn = getComponentByStylename("bombgame.bomb.totalrankbtn");
         _rankTxt = getComponentByStylename("bombgame.bomb.rankTitle");
         _nameTxt = getComponentByStylename("bombgame.bomb.rankTitle");
         _scoreTxt = getComponentByStylename("bombgame.bomb.rankTitle");
         _mytotalRank = getComponentByStylename("bombgame.bomb.commoneTxt");
         _mydayRank = getComponentByStylename("bombgame.bomb.commoneTxt");
         _historyMax = getComponentByStylename("bombgame.bomb.commoneTxt");
         _dayMax = getComponentByStylename("bombgame.bomb.commoneTxt");
         _pagerightBtn = getComponentByStylename("bombgame.bomb.rightPageBtn");
         _pageleftBtn = getComponentByStylename("bombgame.bomb.leftPageBtn");
         _pageEndBtn = getComponentByStylename("bombgame.bomb.endBtn");
         _pageFirstBtn = getComponentByStylename("bombgame.bomb.firstBtn");
         _pageBg = ComponentFactory.Instance.creatBitmap("asset.bomggame.page");
         _pageTxt = getComponentByStylename("bombgame.bomb.pageTxt");
         _prompII = getComponentByStylename("bombgame.promptII.Txt");
         _prompII.text = LanguageMgr.GetTranslation("ddt.bombgame.promptII");
         _doubleImg = ComponentFactory.Instance.creatBitmap("asset.happygame.doublescore");
         _doubleImg.visible = false;
         _wandBitMap = ComponentFactory.Instance.creatBitmap("asset.bombgame.wandBitmap");
         _wandBitMap.name = "di";
         _wandBitMapGray = ComponentFactory.Instance.creatBitmap("asset.bombgame.wandBitmap");
         _wandBitMapGray.filters = ComponentFactory.Instance.creatFilters("grayFilter");
         _wandBitMapGray.name = "gray";
         _wandBitMapMask = ComponentFactory.Instance.creatBitmap("asset.bombgame.wandBitmap");
         _wandBitMapMask.name = "mask";
         _wandBitMapGray.mask = _wandBitMapMask;
         _maskH = _wandBitMapMask.height;
         _currentStep = HappyLittleGameManager.instance.bombManager.model.CurrentGameCanBeClickTimes;
         _lvValue.count = HappyLittleGameManager.instance.bombManager.currentGameLv;
         _scoreValue.count = 0;
         _stepValue.count = _currentStep;
         _posStep = new Point(_stepValue.x,_stepValue.y);
         adjustmentStepPos();
         _maskBasic = ServerConfigManager.instance.BombGameDoubleScoreBeginCount;
         _wandBitMapMask.height = Math.ceil(_maskH * ((_maskBasic - _currentStep) / _maskBasic));
         _rankTxt.text = LanguageMgr.GetTranslation("gamestick.rank");
         _nameTxt.text = LanguageMgr.GetTranslation("worldboss.ranking.name");
         _scoreTxt.text = LanguageMgr.GetTranslation("ddt.bombgame.rank.score");
         _mytotalRank.text = "";
         _mydayRank.text = "";
         _historyMax.text = "";
         _dayMax.text = "";
         _pageTxt.text = "1/1";
         PositionUtils.setPos(_wand,"bombgame.moviewand.pos");
         PositionUtils.setPos(_nameTxt,"bombgame.bomb.name.pos");
         PositionUtils.setPos(_scoreTxt,"bombgame.bomb.score.pos");
         PositionUtils.setPos(_mydayRank,"bombgame.bomb.myday.pos");
         PositionUtils.setPos(_historyMax,"bombgame.bomb.history.pos");
         PositionUtils.setPos(_dayMax,"bombgame.bomb.daymax.pos");
         _logic = new BombLogic();
         _logic.callBack = wandMc;
         _logic.scoreCallBack = SetScores;
         _logic.showServerScore = showServerScores;
         _logic.gameover = gameOver;
         _logic.gameNext = gameNext;
         _logic.gameStepSub = stepSubduction;
         _logic.gameStepAdd = stepAdd;
         _logic.showPassMc = showPassMc;
         _logic.gameBtnClick = setBtnClickState;
         _mapData = getComponentByStylename("bombgame.bomb.pageTxt");
         _stepdifference = ServerConfigManager.instance.BombGameDoubleScoreKeepCount;
         _mapData.width = 300;
         _mapData.height = 300;
         _mapData.x = 600;
         _mapData.y = 250;
         _mapData.textColor = 16755376;
         var format:TextFormat = _mapData.defaultTextFormat;
         format.size = 24;
         _mapData.defaultTextFormat = format;
         addChild(_bg);
         addChild(_lv);
         addChild(_lvValue);
         addChild(_scoreValue);
         addChild(_stepValue);
         addChild(_wand);
         addChild(_reStartBtn);
         addChild(_backBtn);
         addChild(_dayRankBtn);
         addChild(_totalRankBtn);
         addChild(_rankTxt);
         addChild(_nameTxt);
         addChild(_scoreTxt);
         addChild(_mytotalRank);
         addChild(_mydayRank);
         addChild(_historyMax);
         addChild(_dayMax);
         addChild(_pagerightBtn);
         addChild(_pageleftBtn);
         addChild(_pageEndBtn);
         addChild(_pageFirstBtn);
         addChild(_pageBg);
         addChild(_pageTxt);
         addChild(_logic);
         addChild(_mapData);
         addChild(_wandBitMap);
         addChild(_wandBitMapMask);
         addChild(_wandBitMapGray);
         addChild(_prompII);
         addChild(_doubleImg);
         initRankItem();
         _dayRankBtn.selected = true;
         RankInfos = HappyLittleGameManager.instance.bombManager.CurrentBombGameRankInfo(2);
         initEvent();
         setRankData();
      }
      
      public function setRankData() : void
      {
         var HisRank:int = 0;
         var dayRank:int = 0;
         var dayMax:int = 0;
         var HisMax:int = 0;
         var gameType:int = HappyLittleGameManager.instance.currentGameType;
         HisRank = HappyLittleGameManager.instance.bombManager.getMyTotalRankByGameType(gameType);
         dayRank = HappyLittleGameManager.instance.bombManager.getMyDayRankByGameType(gameType);
         dayMax = HappyLittleGameManager.instance.bombManager.getDayMaxScoreByType(gameType);
         HisMax = HappyLittleGameManager.instance.bombManager.getHisMaxScoreByType(gameType);
         _mytotalRank.text = HisRank == 0?LanguageMgr.GetTranslation("bombKing.outOfRank2"):HisRank + "";
         _mydayRank.text = dayRank == 0?LanguageMgr.GetTranslation("bombKing.outOfRank2"):dayRank + "";
         _historyMax.text = HisMax + "";
         _dayMax.text = dayMax + "";
      }
      
      private function showServerScores() : void
      {
         if(_scoreValue && _scoreValue.count != HappyLittleGameManager.instance.bombManager.model.CurrentScores)
         {
            _scoreValue.count = HappyLittleGameManager.instance.bombManager.model.CurrentScores;
         }
         if(_stepValue && _stepValue.count != HappyLittleGameManager.instance.bombManager.model.CurrentGameCanBeClickTimes)
         {
            _stepValue.count = HappyLittleGameManager.instance.bombManager.model.CurrentGameCanBeClickTimes;
            adjustmentStepPos();
            wandMc();
         }
      }
      
      private function SetScores(score:int) : void
      {
         if(_scoreValue)
         {
            _scoreValue.count = _scoreValue.count + score;
         }
      }
      
      private function dataTxt() : void
      {
         var ii:int = 0;
         var jj:int = 0;
         var arr:Array = HappyLittleGameManager.instance.bombManager.model.BombTrain;
         var temp:String = "";
         for(ii = 0; ii < 10; )
         {
            for(jj = 0; jj < 10; )
            {
               temp = temp + (arr[ii][jj] + " ,");
               jj++;
            }
            trace(temp);
            temp = temp + "\n\n";
            ii++;
         }
         _mapData.text = temp;
      }
      
      private function initEvent() : void
      {
         this.addEventListener("keyDown",__keydownhandler);
         _backBtn.addEventListener("click",__backclickhandle);
         _reStartBtn.addEventListener("click",__restartclickhandler);
         _dayRankBtn.addEventListener("click",__rankDayClickHandler);
         _totalRankBtn.addEventListener("click",_rankTotalClickHandler);
         _pagerightBtn.addEventListener("click",__pageRClickHandler);
         _pageleftBtn.addEventListener("click",__pageLClickHandler);
         _pageFirstBtn.addEventListener("click",__firstPageBtnClickHandler);
         _pageEndBtn.addEventListener("click",__pageEndBtnClickHander);
         HappyLittleGameManager.instance.addEventListener("refreshmymaxscore",__refreshMaxScoreHadler);
         SocketManager.Instance.addEventListener(PkgEvent.format(372,3),__refreshClickHandler);
         SocketManager.Instance.addEventListener(PkgEvent.format(372,6),__gameNextHandler);
      }
      
      private function __refreshMaxScoreHadler(evt:HappyLittleGameEvent) : void
      {
         setRankData();
      }
      
      private function __firstPageBtnClickHandler(evt:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(_currentRankType == 2)
         {
            _dayPageIndex = 1;
            showDayRankByPage(_dayPageIndex);
         }
         if(_currentRankType == 1)
         {
            _totalPageIndex = 1;
            showDayRankByPage(_totalPageIndex);
         }
      }
      
      private function __pageEndBtnClickHander(evt:MouseEvent) : void
      {
         var len:int = 0;
         var lenII:int = 0;
         SoundManager.instance.play("008");
         if(_currentRankType == 2)
         {
            len = Math.ceil(_currentarr.length / 10);
            if(_dayPageIndex < len)
            {
               _dayPageIndex = len;
               showDayRankByPage(_dayPageIndex);
            }
         }
         if(_currentRankType == 1)
         {
            lenII = Math.ceil(_currentarr.length / 10);
            if(_totalPageIndex < lenII)
            {
               _totalPageIndex = lenII;
               showDayRankByPage(_totalPageIndex);
            }
         }
      }
      
      private function __keydownhandler(evt:KeyboardEvent) : void
      {
         if(evt.keyCode == 38)
         {
            _stepValue.count = _stepValue.count + 1;
         }
         if(evt.keyCode == 40)
         {
            _stepValue.count = _stepValue.count - 1;
         }
      }
      
      private function wandMc() : void
      {
         var mcDis:int = 0;
         if(_currentStep != _stepValue.count)
         {
            if(_currentStep > _stepValue.count)
            {
               mcDis = Math.ceil(_maskH * (_maskBasic - _stepValue.count) / _maskBasic);
               if(_wandBitMapMask.height < mcDis)
               {
                  _wandBitMapMask.height++;
               }
               else
               {
                  _currentStep = _stepValue.count;
               }
            }
            else
            {
               mcDis = Math.ceil(_maskH * (_maskBasic - _stepValue.count) / _maskBasic);
               if(_wandBitMapMask.height > mcDis)
               {
                  _wandBitMapMask.height--;
               }
               else
               {
                  _currentStep = _stepValue.count;
               }
            }
         }
         if(_maskBasic <= _stepValue.count)
         {
            _showWandMc = true;
            _wand.visible = true;
            _wand.play();
            _doubleImg.visible = true;
            _wandBitMap.visible = false;
            _wandBitMapGray.visible = false;
            _wandBitMapMask.visible = false;
         }
         else if(_showWandMc && _currentStep <= _maskBasic - _stepdifference)
         {
            _showWandMc = false;
            hideWandMc();
         }
      }
      
      private function hideWandMc() : void
      {
         _wand.visible = false;
         _wand.stop();
         _doubleImg.visible = false;
         _wandBitMap.visible = true;
         _wandBitMapGray.visible = true;
         _wandBitMapMask.visible = true;
      }
      
      private function removeEvent() : void
      {
         if(_backBtn)
         {
            _backBtn.removeEventListener("click",__backclickhandle);
         }
         if(_reStartBtn)
         {
            _reStartBtn.removeEventListener("click",__restartclickhandler);
         }
         if(_dayRankBtn)
         {
            _dayRankBtn.removeEventListener("click",__rankDayClickHandler);
         }
         if(_totalRankBtn)
         {
            _totalRankBtn.removeEventListener("click",_rankTotalClickHandler);
         }
         if(_pagerightBtn)
         {
            _pagerightBtn.removeEventListener("click",__pageRClickHandler);
         }
         if(_pageleftBtn)
         {
            _pageleftBtn.removeEventListener("click",__pageLClickHandler);
         }
         if(_pageFirstBtn)
         {
            _pageFirstBtn.removeEventListener("click",__firstPageBtnClickHandler);
         }
         if(_pageEndBtn)
         {
            _pageEndBtn.removeEventListener("click",__pageEndBtnClickHander);
         }
         if(_gameover)
         {
            _gameover.removeEventListener("complete",__gameoverhandler);
         }
         if(_passAll)
         {
            _passAll.removeEventListener("complete",__passAllHandler);
         }
         if(_pass)
         {
            _pass.removeEventListener("complete",__passHandler);
         }
         if(_oncemoreBtn)
         {
            _oncemoreBtn.removeEventListener("click",__oncemoreClickHandler);
         }
         HappyLittleGameManager.instance.removeEventListener("refreshmymaxscore",__refreshMaxScoreHadler);
         SocketManager.Instance.removeEventListener(PkgEvent.format(372,3),__refreshClickHandler);
         SocketManager.Instance.removeEventListener(PkgEvent.format(372,6),__gameNextHandler);
      }
      
      private function __pageRClickHandler(evt:MouseEvent) : void
      {
         var len:int = 0;
         var lenII:int = 0;
         SoundManager.instance.play("008");
         if(_currentRankType == 2)
         {
            len = Math.ceil(_currentarr.length / 10);
            if(_dayPageIndex < len)
            {
               _dayPageIndex = Number(_dayPageIndex) + 1;
            }
            else
            {
               _dayPageIndex = 1;
            }
            showDayRankByPage(_dayPageIndex);
         }
         if(_currentRankType == 1)
         {
            lenII = Math.ceil(_currentarr.length / 10);
            if(_totalPageIndex < lenII)
            {
               _totalPageIndex = Number(_totalPageIndex) + 1;
            }
            else
            {
               _totalPageIndex = 1;
            }
            showDayRankByPage(_totalPageIndex);
         }
      }
      
      private function __pageLClickHandler(evt:MouseEvent) : void
      {
         var len:int = 0;
         SoundManager.instance.play("008");
         if(_currentRankType == 2)
         {
            if(_dayPageIndex > 1)
            {
               _dayPageIndex = Number(_dayPageIndex) - 1;
            }
            else
            {
               len = Math.ceil(_currentarr.length / 10);
               _dayPageIndex = len;
            }
            showDayRankByPage(_dayPageIndex);
         }
         if(_currentRankType == 1)
         {
            if(_totalPageIndex > 1)
            {
               _totalPageIndex = Number(_totalPageIndex) - 1;
            }
            else
            {
               len = Math.ceil(_currentarr.length / 10);
               _totalPageIndex = len;
            }
            showDayRankByPage(_totalPageIndex);
         }
      }
      
      private function __rankDayClickHandler(evt:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(_dayRankBtn.selected == false)
         {
            _dayRankBtn.selected = true;
            _totalRankBtn.selected = false;
            _currentRankType = 2;
            RankInfos = HappyLittleGameManager.instance.bombManager.CurrentBombGameRankInfo(2);
         }
      }
      
      private function _rankTotalClickHandler(evt:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(_totalRankBtn.selected == false)
         {
            _totalRankBtn.selected = true;
            _dayRankBtn.selected = false;
            _currentRankType = 1;
            RankInfos = HappyLittleGameManager.instance.bombManager.CurrentBombGameRankInfo(1);
         }
      }
      
      private function __gameNextHandler(pkg:PkgEvent) : void
      {
         _lvValue.count = HappyLittleGameManager.instance.bombManager.currentGameLv;
         var _loc2_:* = pkg.pkg.readInt();
         HappyLittleGameManager.instance.bombManager.model.CurrentGameCanBeClickTimes = _loc2_;
         this._stepValue.count = _loc2_;
         showLvMc();
         adjustmentStepPos();
         wandMc();
         _wandBitMapMask.height = Math.ceil(_maskH * ((_maskBasic - _currentStep) / _maskBasic));
         HappyLittleGameManager.instance.dispatchEvent(new HappyLittleGameEvent("entergame"));
      }
      
      private function showLvMc() : void
      {
         var num1:* = null;
         var num2:* = null;
         var num3:* = null;
         if(_lvMc == null)
         {
            _lvMc = ClassUtils.CreatInstance("asset.happygame.lv.mc");
            PositionUtils.setPos(_lvMc,"happygame.lv.pos");
            addChild(_lvMc);
         }
         _lvMc.gotoAndPlay(1);
         var lv:int = HappyLittleGameManager.instance.bombManager.currentGameLv;
         if(lv < 10)
         {
            _lvMc.lv.lv_2.visible = false;
            _lvMc.lv.lv_3.visible = false;
            num1 = _lvMc.lv.lv_1;
            num1.gotoAndStop("s_" + lv);
         }
         if(lv < 99 && lv > 9)
         {
            _lvMc.lv.lv_3.visible = false;
            num1 = _lvMc.lv.lv_1;
            num2 = _lvMc.lv.lv_2;
            num2.visible = true;
            num1.gotoAndStop("s_" + Math.floor(lv / 10));
            num2.gotoAndStop("s_" + lv % 10);
         }
         if(lv > 99)
         {
            num1 = _lvMc.lv.lv_1;
            num2 = _lvMc.lv.lv_2;
            num2.visible = true;
            num3 = _lvMc.lv.lv_3;
            num3.visible = true;
            num1.gotoAndStop("s_" + Math.floor(lv / 100));
            num2.gotoAndStop("s_" + Math.floor(lv / 10) % 10);
            num3.gotoAndStop("s_" + lv % 100 % 10);
         }
      }
      
      private function adjustmentStepPos() : void
      {
         if(_stepValue.count > 9)
         {
            _stepValue.x = _posStep.x - 20;
            _stepValue.y = _posStep.y;
         }
         else
         {
            _stepValue.x = _posStep.x;
            _stepValue.y = _posStep.y;
         }
      }
      
      public function __refreshClickHandler(pkg:PkgEvent) : void
      {
         HappyLittleGameManager.instance.bombManager.model.CurrentScores = HappyLittleGameManager.instance.bombManager.model.CurrentScores + pkg.pkg.readInt();
         HappyLittleGameManager.instance.bombManager.model.CurrentGameCanBeClickTimes = pkg.pkg.readInt();
         refreshStep();
         adjustmentStepPos();
         HappyLittleGameManager.instance.currentGameState = pkg.pkg.readInt();
         if(HappyLittleGameManager.instance.currentGameState == 1)
         {
            if(_logic)
            {
               _logic.checkallBomb = true;
            }
         }
         if(HappyLittleGameManager.instance.currentGameState == 2)
         {
            if(_logic)
            {
               _logic.checkallBomb = true;
            }
         }
         if(HappyLittleGameManager.instance.currentGameState == 4)
         {
            if(_logic)
            {
               _logic.checkallBomb = true;
            }
         }
         if(HappyLittleGameManager.instance.currentGameState == 3)
         {
            if(_logic)
            {
               _logic.checkallBomb = true;
            }
         }
      }
      
      private function stepSubduction() : void
      {
         if(HappyLittleGameManager.instance.bombManager.model.CurrentGameCanBeClickTimes > 0)
         {
            _stepValue.count--;
            adjustmentStepPos();
            wandMc();
         }
      }
      
      private function stepAdd() : void
      {
         if(!checkStepCanAdd())
         {
            _stepValue.count++;
            adjustmentStepPos();
            wandMc();
         }
      }
      
      private function refreshStep() : void
      {
         var step:int = ServerConfigManager.instance.BombGameDoubleScoreBeginCount;
         var distance:int = ServerConfigManager.instance.BombGameDoubleScoreKeepCount;
         var temp:int = HappyLittleGameManager.instance.bombManager.model.CurrentGameCanBeClickTimes;
         if(step <= temp)
         {
            HappyLittleGameManager.instance.bombManager.doubleScore = true;
         }
         else if(HappyLittleGameManager.instance.bombManager.doubleScore && temp <= step - distance)
         {
            HappyLittleGameManager.instance.bombManager.doubleScore = false;
         }
      }
      
      private function checkStepCanAdd() : Boolean
      {
         var step:int = ServerConfigManager.instance.BombGameDoubleScoreBeginCount;
         var distance:int = ServerConfigManager.instance.BombGameDoubleScoreKeepCount;
         var isDouble:Boolean = HappyLittleGameManager.instance.bombManager.doubleScore;
         var serverStep:int = HappyLittleGameManager.instance.bombManager.model.CurrentGameCanBeClickTimes;
         if(_stepValue.count < step && !(isDouble && distance > step - serverStep))
         {
            return false;
         }
         return true;
      }
      
      private function gameNext() : void
      {
         HappyLittleGameManager.instance.bombManager.currentGameLv++;
         HappyLittleGameManager.instance.bombManager.GetCurrentBombMapData();
         SocketManager.Instance.out.sendBombGameNext();
      }
      
      private function showPassMc() : void
      {
         setBtnClickState(false);
         if(_pass == null)
         {
            _pass = ClassUtils.CreatInstance("asset.happygame.pass");
            _pass.mouseEnabled = false;
            _pass.mouseChildren = false;
            _pass.addEventListener("complete",__passHandler);
            PositionUtils.setPos(_pass,"happygame.passall.pos");
            addChild(_pass);
         }
         else
         {
            _pass.gotoAndPlay(1);
         }
      }
      
      private function setBtnClickState(value:Boolean) : void
      {
         if(_backBtn)
         {
            _backBtn.enable = value;
         }
         if(_reStartBtn)
         {
            _reStartBtn.enable = value;
         }
      }
      
      private function __passHandler(evt:Event) : void
      {
         if(_logic)
         {
            _logic.sendCurrenMapdata();
         }
         setBtnClickState(true);
      }
      
      private function gameOver() : void
      {
         if(HappyLittleGameManager.instance.currentGameState == 4)
         {
            _passAll = ClassUtils.CreatInstance("asset.happygame.passAll");
            _passAll.mouseEnabled = false;
            _passAll.mouseChildren = false;
            PositionUtils.setPos(_passAll,"happygame.passall.pos");
            _passAll.addEventListener("complete",__passAllHandler);
            addChild(_passAll);
         }
         if(HappyLittleGameManager.instance.currentGameState == 1)
         {
            if(_gameover == null)
            {
               _gameover = ClassUtils.CreatInstance("asset.happygame.gameover");
               _gameover.addEventListener("complete",__gameoverhandler);
               PositionUtils.setPos(_gameover,"happygame.gameover.pos");
               addChild(_gameover);
            }
            else
            {
               _gameover.visible = true;
               _gameover.gotoAndPlay(1);
            }
         }
      }
      
      private function __passAllHandler(evt:Event) : void
      {
         _passAll.addEventListener("complete",__passAllHandler);
         if(_logic)
         {
            _logic.clear();
         }
         HappyLittleGameManager.instance.bombManager.clearBombData();
         HappyLittleGameManager.instance.dispatchEvent(new HappyLittleGameEvent("cometoback"));
         var gameType:int = HappyLittleGameManager.instance.currentGameType;
         HappyLittleGameManager.instance.bombManager.clearRankDataByType(gameType);
         SocketManager.Instance.out.sendBombEnterRoom(HappyLittleGameManager.instance.currentGameType);
         FunnyGamesManager.getInstance().requestRankInfo(gameType,2);
         FunnyGamesManager.getInstance().requestRankInfo(gameType,1);
      }
      
      private function __gameoverhandler(evt:Event) : void
      {
         if(_oncemoreBtn == null)
         {
            _oncemoreBtn = ComponentFactory.Instance.creatComponentByStylename("happygame.oncemore.btn");
            _oncemoreBtn.addEventListener("click",__oncemoreClickHandler);
            addChild(_oncemoreBtn);
         }
         else
         {
            _oncemoreBtn.visible = true;
         }
      }
      
      private function __oncemoreClickHandler(evt:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(_oncemoreBtn)
         {
            _oncemoreBtn.visible = false;
         }
         if(_gameover)
         {
            _gameover.visible = false;
         }
         SocketManager.Instance.out.sendBombGameOver();
         HappyLittleGameManager.instance.bombManager.currentGameLv = 1;
         _scoreValue.count = 0;
         SocketManager.Instance.out.sendBombEnterRoom(HappyLittleGameManager.instance.currentGameType);
         HappyLittleGameManager.instance.bombManager.GetCurrentBombMapData();
         SocketManager.Instance.out.sendBombStart(HappyLittleGameManager.instance.currentGameType);
      }
      
      public function set RankInfos(infos:Vector.<BombRankInfo>) : void
      {
         if(_currentarr != infos)
         {
            _currentarr = null;
         }
         _currentarr = infos;
         if(_currentRankType == 2)
         {
            showDayRankByPage(_dayPageIndex);
         }
         if(_currentRankType == 1)
         {
            showDayRankByPage(_totalPageIndex);
         }
      }
      
      private function __backclickhandle(evt:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         var alert:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("happyLittleGame.goback"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,false,false,2);
         alert.addEventListener("response",goBackSceneResponse);
      }
      
      private function goBackSceneResponse(e:FrameEvent) : void
      {
         var gameType:int = 0;
         SoundManager.instance.play("008");
         var alert:BaseAlerFrame = e.currentTarget as BaseAlerFrame;
         alert.removeEventListener("response",onEnterSceneResponse);
         switch(int(e.responseCode))
         {
            default:
            default:
            case 2:
            case 3:
               SocketManager.Instance.out.sendBombGameOver();
               if(_logic)
               {
                  _logic.clear();
               }
               HappyLittleGameManager.instance.bombManager.clearBombData();
               HappyLittleGameManager.instance.dispatchEvent(new HappyLittleGameEvent("cometoback"));
               gameType = HappyLittleGameManager.instance.currentGameType;
               SocketManager.Instance.out.sendBombEnterRoom(HappyLittleGameManager.instance.currentGameType);
               if(gameType == 2)
               {
                  if(HappyLittleGameManager.instance.fixed_refresh)
                  {
                     HappyLittleGameManager.instance.bombManager.clearRankDataByType(gameType);
                     FunnyGamesManager.getInstance().requestRankInfo(2,2);
                     FunnyGamesManager.getInstance().requestRankInfo(2,1);
                  }
               }
               if(gameType == 1)
               {
                  if(HappyLittleGameManager.instance.random_refresh)
                  {
                     HappyLittleGameManager.instance.bombManager.clearRankDataByType(gameType);
                     FunnyGamesManager.getInstance().requestRankInfo(1,2);
                     FunnyGamesManager.getInstance().requestRankInfo(1,1);
                  }
               }
            default:
               SocketManager.Instance.out.sendBombGameOver();
               if(_logic)
               {
                  _logic.clear();
               }
               HappyLittleGameManager.instance.bombManager.clearBombData();
               HappyLittleGameManager.instance.dispatchEvent(new HappyLittleGameEvent("cometoback"));
               gameType = HappyLittleGameManager.instance.currentGameType;
               SocketManager.Instance.out.sendBombEnterRoom(HappyLittleGameManager.instance.currentGameType);
               if(gameType == 2)
               {
                  if(HappyLittleGameManager.instance.fixed_refresh)
                  {
                     HappyLittleGameManager.instance.bombManager.clearRankDataByType(gameType);
                     FunnyGamesManager.getInstance().requestRankInfo(2,2);
                     FunnyGamesManager.getInstance().requestRankInfo(2,1);
                  }
               }
               if(gameType == 1)
               {
                  if(HappyLittleGameManager.instance.random_refresh)
                  {
                     HappyLittleGameManager.instance.bombManager.clearRankDataByType(gameType);
                     FunnyGamesManager.getInstance().requestRankInfo(1,2);
                     FunnyGamesManager.getInstance().requestRankInfo(1,1);
                  }
               }
         }
         alert.dispose();
      }
      
      private function __restartclickhandler(evt:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         var alert:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("happyLittleGame.checkRePlay"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,false,false,2);
         alert.addEventListener("response",onEnterSceneResponse);
      }
      
      private function onEnterSceneResponse(e:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         var alert:BaseAlerFrame = e.currentTarget as BaseAlerFrame;
         alert.removeEventListener("response",onEnterSceneResponse);
         switch(int(e.responseCode))
         {
            default:
            default:
            case 2:
            case 3:
               if(_gameover)
               {
                  _gameover.visible = false;
                  _oncemoreBtn.visible = false;
               }
               SocketManager.Instance.out.sendBombGameOver();
               HappyLittleGameManager.instance.bombManager.currentGameLv = 1;
               _scoreValue.count = 0;
               SocketManager.Instance.out.sendBombEnterRoom(HappyLittleGameManager.instance.currentGameType);
               HappyLittleGameManager.instance.bombManager.GetCurrentBombMapData();
               SocketManager.Instance.out.sendBombStart(HappyLittleGameManager.instance.currentGameType);
            default:
               if(_gameover)
               {
                  _gameover.visible = false;
                  _oncemoreBtn.visible = false;
               }
               SocketManager.Instance.out.sendBombGameOver();
               HappyLittleGameManager.instance.bombManager.currentGameLv = 1;
               _scoreValue.count = 0;
               SocketManager.Instance.out.sendBombEnterRoom(HappyLittleGameManager.instance.currentGameType);
               HappyLittleGameManager.instance.bombManager.GetCurrentBombMapData();
               SocketManager.Instance.out.sendBombStart(HappyLittleGameManager.instance.currentGameType);
         }
         alert.dispose();
      }
      
      public function ReStart() : void
      {
         var _loc1_:* = HappyLittleGameManager.instance.bombManager.model.CurrentGameCanBeClickTimes;
         _stepValue.count = _loc1_;
         _currentStep = _loc1_;
         _lvValue.count = HappyLittleGameManager.instance.bombManager.currentGameLv;
         showLvMc();
         adjustmentStepPos();
         if(_logic)
         {
            _logic.ReStart();
         }
         _wandBitMapMask.height = Math.ceil(_maskH * ((_maskBasic - _currentStep) / _maskBasic));
         if(_showWandMc && _lvValue.count == 1)
         {
            hideWandMc();
         }
      }
      
      private function getComponentByStylename(stylename:String) : *
      {
         return ComponentFactory.Instance.creatComponentByStylename(stylename);
      }
      
      private function initRankItem() : void
      {
         var item:* = null;
         var i:int = 0;
         _items = new Vector.<BombRankItemIII>();
         for(i = 0; i < 10; )
         {
            item = new BombRankItemIII();
            item.x = 737;
            item.y = i * 28 + 137;
            addChild(item);
            _items.push(item);
            i++;
         }
      }
      
      public function clearItemInfo() : void
      {
         var i:int = 0;
         var len:int = _items.length;
         for(i = 0; i < len; )
         {
            _items[i].clear();
            i++;
         }
      }
      
      public function showDayRankByPage(page:int) : void
      {
         var index:* = 0;
         clearItemInfo();
         if(_currentarr.length == 0)
         {
            return;
         }
         var len:int = Math.ceil(_currentarr.length / 10);
         var startIndex:int = (page - 1) * 10;
         var endIndex:int = startIndex + 10;
         var infoIndex:int = 0;
         _pageTxt.text = page + "/" + len;
         if(page > len)
         {
            trace("翻页超出");
            return;
         }
         if(page == len)
         {
            endIndex = _currentarr.length;
         }
         for(index = startIndex; index < endIndex; )
         {
            if(index < _currentarr.length)
            {
               _items[infoIndex].Info = _currentarr[index];
               infoIndex++;
            }
            index++;
         }
      }
      
      public function dispose() : void
      {
         var obj:* = null;
         removeEvent();
         while(this.numChildren > 0)
         {
            obj = removeChildAt(0);
            ObjectUtils.disposeObject(obj);
            obj = null;
         }
         _items = null;
         _currentarr = null;
      }
   }
}
