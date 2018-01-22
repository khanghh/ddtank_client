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
         var _loc3_:* = null;
         var _loc2_:* = null;
         var _loc1_:Array = ServerConfigManager.instance.HappyLittleGameOpenList.split(",");
         var _loc4_:int = _loc1_.length;
         var _loc5_:int = 0;
         _loc5_;
         while(_loc5_ < _loc4_)
         {
            _loc3_ = _loc1_[_loc5_].split("|");
            if(_loc3_[1] == 1)
            {
               gametypes.push(_loc3_[0]);
            }
            _loc5_++;
         }
         _loc4_ = gametypes.length;
         _loc5_ = 0;
         _loc5_;
         while(_loc5_ < _loc4_)
         {
            _loc2_ = new GameCard();
            PositionUtils.setPos(_loc2_,"happygame.card.pos" + (_loc5_ + 1));
            _loc2_.gameType = gametypes[_loc5_];
            _loc2_.addEventListener("click",__clickHandler);
            cards.push(_loc2_);
            addChild(_loc2_);
            _loc5_++;
         }
      }
      
      private function __clickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:GameCard = param1.currentTarget as GameCard;
         _loc2_.select = true;
         if(_currentCard != null)
         {
            if(_loc2_ == _currentCard)
            {
               return;
            }
            _currentCard.select = false;
            _currentCard.x = _currentCard.x - 4;
            _currentCard.y = _currentCard.y + 4;
         }
         _currentCard = _loc2_;
         _loc2_.x = _loc2_.x + 4;
         _loc2_.y = _loc2_.y - 4;
         HappyLittleGameManager.instance.currentGameType = _loc2_.gameType;
         switch(int(HappyLittleGameManager.instance.currentGameType) - 1)
         {
            case 0:
            case 1:
               if(_loc2_.gameType == 2 && HappyLittleGameManager.instance.fixed_refresh)
               {
                  HappyLittleGameManager.instance.startTimerByType(2);
                  HappyLittleGameManager.instance.bombManager.clearRankDataByType(_loc2_.gameType);
                  SocketManager.Instance.out.sendBombEnterRoom(HappyLittleGameManager.instance.currentGameType);
                  FunnyGamesManager.getInstance().requestRankInfo(2,2);
                  FunnyGamesManager.getInstance().requestRankInfo(2,1);
               }
               if(_loc2_.gameType == 1 && HappyLittleGameManager.instance.random_refresh)
               {
                  HappyLittleGameManager.instance.startTimerByType(1);
                  HappyLittleGameManager.instance.bombManager.clearRankDataByType(_loc2_.gameType);
                  SocketManager.Instance.out.sendBombEnterRoom(HappyLittleGameManager.instance.currentGameType);
                  FunnyGamesManager.getInstance().requestRankInfo(1,2);
                  FunnyGamesManager.getInstance().requestRankInfo(1,1);
               }
               break;
            case 2:
               HappyLittleGameManager.instance.bombManager.clearRankDataByType(_loc2_.gameType);
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
         var _loc1_:* = null;
         var _loc3_:int = 0;
         var _loc2_:int = cards.length;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc1_ = cards[_loc3_];
            if(cards)
            {
               _loc1_.removeEventListener("click",__clickHandler);
               ObjectUtils.disposeObject(_loc1_);
               _loc1_ = null;
            }
            _loc3_++;
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
