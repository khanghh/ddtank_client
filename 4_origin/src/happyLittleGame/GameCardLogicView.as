package happyLittleGame
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import funnyGames.FunnyGamesManager;
   import uiModeManager.bombUI.HappyLittleGameManager;
   
   public class GameCardLogicView extends Sprite implements Disposeable
   {
       
      
      private var cards:Array;
      
      private var gametypes:Array;
      
      public var callBack:Function;
      
      private var _currentCard:GameCard;
      
      private var _rightBtn:SimpleBitmapButton;
      
      private var _leftBtn:SimpleBitmapButton;
      
      public function GameCardLogicView()
      {
         cards = [];
         gametypes = [];
         super();
         _rightBtn = ComponentFactory.Instance.creatComponentByStylename("bombgame.right.btn");
         _rightBtn.mouseEnabled = false;
         _leftBtn = ComponentFactory.Instance.creatComponentByStylename("bombgame.left.btn");
         _leftBtn.mouseEnabled = false;
         addChild(_rightBtn);
         addChild(_leftBtn);
         initCardView();
      }
      
      private function initCardView() : void
      {
         var temp:* = null;
         var card:* = null;
         var games:Array = ServerConfigManager.instance.HappyLittleGameOpenList.split(",");
         var len:int = games.length;
         var i:int = 0;
         i;
         while(i < len)
         {
            temp = games[i].split("|");
            if(temp[1] == 1)
            {
               gametypes.push(temp[0]);
            }
            i++;
         }
         len = gametypes.length;
         i = 0;
         i;
         while(i < len)
         {
            card = new GameCard();
            PositionUtils.setPos(card,"happygame.card.pos" + (i + 1));
            card.gameType = gametypes[i];
            card.addEventListener("click",__clickHandler);
            cards.push(card);
            addChild(card);
            i++;
         }
      }
      
      private function __clickHandler(evt:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         var card:GameCard = evt.currentTarget as GameCard;
         card.select = true;
         if(_currentCard != null)
         {
            if(card == _currentCard)
            {
               return;
            }
            _currentCard.select = false;
            _currentCard.x = _currentCard.x - 4;
            _currentCard.y = _currentCard.y + 4;
         }
         _currentCard = card;
         card.x = card.x + 4;
         card.y = card.y - 4;
         HappyLittleGameManager.instance.currentGameType = card.gameType;
         switch(int(HappyLittleGameManager.instance.currentGameType) - 1)
         {
            case 0:
            case 1:
               if(card.gameType == 2 && HappyLittleGameManager.instance.fixed_refresh)
               {
                  HappyLittleGameManager.instance.startTimerByType(2);
                  HappyLittleGameManager.instance.bombManager.clearRankDataByType(card.gameType);
                  SocketManager.Instance.out.sendBombEnterRoom(HappyLittleGameManager.instance.currentGameType);
                  FunnyGamesManager.getInstance().requestRankInfo(2,2);
                  FunnyGamesManager.getInstance().requestRankInfo(2,1);
               }
               if(card.gameType == 1 && HappyLittleGameManager.instance.random_refresh)
               {
                  HappyLittleGameManager.instance.startTimerByType(1);
                  HappyLittleGameManager.instance.bombManager.clearRankDataByType(card.gameType);
                  SocketManager.Instance.out.sendBombEnterRoom(HappyLittleGameManager.instance.currentGameType);
                  FunnyGamesManager.getInstance().requestRankInfo(1,2);
                  FunnyGamesManager.getInstance().requestRankInfo(1,1);
               }
               break;
            case 2:
               HappyLittleGameManager.instance.bombManager.clearRankDataByType(card.gameType);
               SocketManager.Instance.out.sendBombEnterRoom(HappyLittleGameManager.instance.currentGameType);
               FunnyGamesManager.getInstance().requestRankInfo(3,2);
               FunnyGamesManager.getInstance().requestRankInfo(3,1);
         }
         if(callBack)
         {
            callBack();
         }
      }
      
      public function dispose() : void
      {
         var card:* = null;
         var i:int = 0;
         var len:int = cards.length;
         for(i = 0; i < len; )
         {
            card = cards[i];
            if(cards)
            {
               card.removeEventListener("click",__clickHandler);
               ObjectUtils.disposeObject(card);
               card = null;
            }
            i++;
         }
         cards = null;
         ObjectUtils.disposeObject(_rightBtn);
         _rightBtn = null;
         ObjectUtils.disposeObject(_leftBtn);
         _leftBtn = null;
         callBack = null;
      }
   }
}
