package happyLittleGame.bombshellGame.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.PkgEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import funnyGames.FunnyGamesManager;
   import funnyGames.cubeGame.CubeGameManager;
   import funnyGames.event.FunnyGamesEvent;
   import happyLittleGame.GameCardLogicView;
   import happyLittleGame.LittleGameDayNewsView;
   import uiModeManager.bombUI.HappyLittleGameManager;
   import uiModeManager.bombUI.event.HappyLittleGameEvent;
   
   public class LittleGameEntranceView extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _promptTxt:FilterFrameText;
      
      private var _promptTxtII:FilterFrameText;
      
      private var _createRoomBtn:SimpleBitmapButton;
      
      private var _enterGameBtn:SimpleBitmapButton;
      
      private var _dayNewsView:LittleGameDayNewsView;
      
      private var _rankView:BombGameRankView;
      
      private var _cardlogicView:GameCardLogicView;
      
      public function LittleGameEntranceView()
      {
         super();
         _dayNewsView = new LittleGameDayNewsView();
         _cardlogicView = new GameCardLogicView();
         PositionUtils.setPos(_dayNewsView,"bombgame.daynewsview.point");
         _cardlogicView.callBack = refreshRank;
         PositionUtils.setPos(_cardlogicView,"happygame.cardsview.pos");
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.bombgame.game_bg");
         _promptTxt = ComponentFactory.Instance.creatComponentByStylename("bombgame.prompt.Txt");
         _promptTxt.text = LanguageMgr.GetTranslation("ddt.bombgame.frame.prompt");
         _promptTxtII = ComponentFactory.Instance.creatComponentByStylename("bombgame.prompt.Txt");
         _createRoomBtn = ComponentFactory.Instance.creatComponentByStylename("bombgame.createroom.btn");
         _enterGameBtn = ComponentFactory.Instance.creatComponentByStylename("bombgame.entergame.btn");
         _promptTxtII.text = LanguageMgr.GetTranslation("ddt.bombgame.promptIII");
         PositionUtils.setPos(_promptTxtII,"happygame.enterRoom.prompt.pos");
         addChild(_bg);
         addChild(_promptTxt);
         addChild(_promptTxtII);
         addChild(_enterGameBtn);
         addChild(_dayNewsView);
         addChild(_cardlogicView);
      }
      
      private function initEvent() : void
      {
         _enterGameBtn.addEventListener("click",__enterGameHandler);
         HappyLittleGameManager.instance.addEventListener("refreshranking",__refreshRankHandler);
         SocketManager.Instance.addEventListener(PkgEvent.format(372,1),__enterRoomHandler);
         SocketManager.Instance.addEventListener(PkgEvent.format(372,2),__startGameHandler);
         FunnyGamesManager.getInstance().addEventListener("rankUpdate",__updateView);
      }
      
      private function removeEvent() : void
      {
         if(_enterGameBtn)
         {
            _enterGameBtn.removeEventListener("click",__enterGameHandler);
         }
         HappyLittleGameManager.instance.removeEventListener("refreshranking",__refreshRankHandler);
         SocketManager.Instance.removeEventListener(PkgEvent.format(372,1),__enterRoomHandler);
         SocketManager.Instance.removeEventListener(PkgEvent.format(372,2),__startGameHandler);
         FunnyGamesManager.getInstance().addEventListener("rankUpdate",__updateView);
      }
      
      public function __updateView(param1:FunnyGamesEvent) : void
      {
         if(_rankView == null)
         {
            _rankView = new BombGameRankView();
            PositionUtils.setPos(_rankView,"bombgame.daynewsview.point");
            addChild(_rankView);
            if(_dayNewsView)
            {
               _dayNewsView.visible = false;
            }
         }
         _rankView.reFreshRank();
      }
      
      private function __startGameHandler(param1:PkgEvent) : void
      {
         HappyLittleGameManager.instance.bombManager.currentGameLv = 1;
         HappyLittleGameManager.instance.bombManager.model.CurrentScores = 0;
         HappyLittleGameManager.instance.dispatchEvent(new HappyLittleGameEvent("entergame"));
      }
      
      private function __refreshRankHandler(param1:Event) : void
      {
         if(_rankView)
         {
            _rankView.setRankData();
         }
      }
      
      public function __enterRoomHandler(param1:PkgEvent) : void
      {
         var _loc2_:int = param1.pkg.readInt();
         HappyLittleGameManager.instance.currentGameType = _loc2_;
         switch(int(_loc2_) - 1)
         {
            case 0:
               HappyLittleGameManager.instance.bombManager.model.randomGameDayMaxScore = param1.pkg.readInt();
               HappyLittleGameManager.instance.bombManager.model.randomGameHisMaxScore = param1.pkg.readInt();
               break;
            case 1:
               HappyLittleGameManager.instance.bombManager.model.fixGameDayMaxLevel = param1.pkg.readInt();
               HappyLittleGameManager.instance.bombManager.model.fixGameDayMaxScore = param1.pkg.readInt();
               HappyLittleGameManager.instance.bombManager.model.fixGameHisMaxLevel = param1.pkg.readInt();
               HappyLittleGameManager.instance.bombManager.model.fixGameHisMaxScore = param1.pkg.readInt();
               break;
            case 2:
               CubeGameManager.getInstance().gameInfo.dailyHighScore = param1.pkg.readInt();
               CubeGameManager.getInstance().gameInfo.historyHgihScore = param1.pkg.readInt();
         }
         if(_rankView == null)
         {
            _rankView = new BombGameRankView();
            PositionUtils.setPos(_rankView,"bombgame.daynewsview.point");
            addChild(_rankView);
            if(_dayNewsView)
            {
               _dayNewsView.visible = false;
            }
         }
         _rankView.setRankData();
         HappyLittleGameManager.instance.dispatchEvent(new HappyLittleGameEvent("refreshmymaxscore"));
      }
      
      public function refreshRank() : void
      {
         if(_rankView == null)
         {
            _rankView = new BombGameRankView();
            PositionUtils.setPos(_rankView,"bombgame.daynewsview.point");
            addChild(_rankView);
            if(_dayNewsView)
            {
               _dayNewsView.visible = false;
            }
         }
         _rankView.reFreshRank();
      }
      
      private function __enterGameHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         switch(int(HappyLittleGameManager.instance.currentGameType) - 1)
         {
            case 0:
            case 1:
               HappyLittleGameManager.instance.bombManager.GetCurrentBombMapData();
               SocketManager.Instance.out.sendBombStart(HappyLittleGameManager.instance.currentGameType);
               break;
            case 2:
               if(!CubeGameManager.getInstance().checkEnergyEnough())
               {
                  return;
               }
               CubeGameManager.getInstance().startGame();
               break;
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         ObjectUtils.disposeObject(_promptTxt);
         ObjectUtils.disposeObject(_createRoomBtn);
         ObjectUtils.disposeObject(_enterGameBtn);
         ObjectUtils.disposeObject(_dayNewsView);
         ObjectUtils.disposeObject(_rankView);
         ObjectUtils.disposeObject(_cardlogicView);
         ObjectUtils.disposeObject(_promptTxtII);
         _promptTxtII = null;
         _bg = null;
         _promptTxt = null;
         _createRoomBtn = null;
         _enterGameBtn = null;
         _dayNewsView = null;
         _rankView = null;
         _cardlogicView = null;
      }
   }
}
