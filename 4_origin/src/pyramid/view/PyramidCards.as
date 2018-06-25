package pyramid.view
{
   import baglocked.BaglockedManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.PyramidSystemItemsInfo;
   import ddt.events.PyramidEvent;
   import ddt.manager.GameInSocketOut;
   import ddt.manager.LeavePageManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.PyramidManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   import flash.utils.Timer;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import pyramid.PyramidControl;
   
   public class PyramidCards extends Sprite implements Disposeable
   {
      
      public static const SHUFFLE:String = "shuffle";
      
      public static const OPEN:String = "open";
      
      public static const CLOSE:String = "close";
      
      public static const BG:String = "bg";
       
      
      private var _topBox:PyramidTopBox;
      
      private var _cards:Dictionary;
      
      private var _cardsSprite:Sprite;
      
      private var _currentCard:PyramidCard;
      
      private var _shuffleMovie:MovieClip;
      
      private var _movieCountArr:Array;
      
      private var _playLevel:int;
      
      private var _shuffleWaitTimer:Timer;
      
      private var _timerCurrentCount:int;
      
      private var _playLevelMovieStep:int = 0;
      
      private var _timerOutNum:uint;
      
      public function PyramidCards()
      {
         super();
         initView();
         initEvent();
         initData();
      }
      
      private function initView() : void
      {
         _shuffleMovie = ComponentFactory.Instance.creat("assets.pyramid.shuffle");
         _shuffleMovie.gotoAndStop(1);
         PositionUtils.setPos(_shuffleMovie,"pyramid.view.shufflePos");
         _shuffleMovie.visible = false;
         addChild(_shuffleMovie);
         _cardsSprite = new Sprite();
         addChild(_cardsSprite);
         _topBox = ComponentFactory.Instance.creatCustomObject("pyramid.topBox");
         _topBox.addTopBoxMovie(this);
         addChild(_topBox);
         if(PyramidManager.instance.model.currentLayer >= 8)
         {
            topBoxMovieMode(1);
         }
         else
         {
            topBoxMovieMode();
         }
         _shuffleWaitTimer = new Timer(800,1);
      }
      
      private function initEvent() : void
      {
         _topBox.addEventListener("click",__cardClickHandler);
         _shuffleWaitTimer.addEventListener("timer",__shuffleWaitTimerHandler);
      }
      
      private function initData() : void
      {
         var i:int = 0;
         var j:int = 0;
         _cards = new Dictionary();
         for(i = 7; i >= 1; )
         {
            _cards[i] = new Dictionary();
            for(j = 8; j >= i; )
            {
               createCard(i,9 - j);
               j--;
            }
            i--;
         }
         updateSelectItems();
         playShuffleFullMovie();
      }
      
      private function createCard(i:int, j:int) : void
      {
         var cardSp:PyramidCard = new PyramidCard();
         cardSp.index = i + "_" + j;
         var cardPosition:Point = PositionUtils.creatPoint("pyramid.view.cardPos" + cardSp.index);
         cardSp.x = cardPosition.x;
         cardSp.y = cardPosition.y;
         _cards[i][j] = cardSp;
         cardSp.addEventListener("click",__cardClickHandler);
         cardSp.addEventListener("openAndClose_Movie",__cardOpenMovieHandler);
         _cardsSprite.addChild(cardSp);
      }
      
      public function topBoxMovieMode(modeType:int = 0) : void
      {
         _topBox.topBoxMovieMode(modeType);
      }
      
      private function __cardClickHandler(event:MouseEvent) : void
      {
         var card:* = null;
         SoundManager.instance.play("008");
         if(PyramidControl.instance.clickRateGo)
         {
            return;
         }
         if(PyramidControl.instance.movieLock)
         {
            return;
         }
         if(!PyramidManager.instance.model.isOpen)
         {
            return;
         }
         if(event.currentTarget == _topBox && _topBox.state == 1)
         {
            openTopBox();
         }
         else if(event.currentTarget is PyramidCard && !PyramidControl.instance.isAutoOpenCard)
         {
            card = PyramidCard(event.currentTarget);
            openCurrendCard(card);
         }
      }
      
      private function openTopBox() : void
      {
         _currentCard = null;
         topBoxMovieMode(2);
         GameInSocketOut.sendPyramidTurnCard(8,1,false);
      }
      
      private function openCurrendCard($card:PyramidCard) : void
      {
         _currentCard = $card;
         if(_currentCard.state != 3)
         {
            return;
         }
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var freeCount:int = PyramidManager.instance.model.freeCount - PyramidManager.instance.model.currentFreeCount;
         if(freeCount <= 0)
         {
            if(PlayerManager.Instance.Self.Money < PyramidManager.instance.model.turnCardPrice)
            {
               LeavePageManager.showFillFrame();
               PyramidControl.instance.isAutoOpenCard = false;
               return;
            }
         }
         var arr:Array = _currentCard.index.split("_");
         if(freeCount <= 0 && PyramidControl.instance.isShowBuyFrameSelectedCheck)
         {
            PyramidControl.instance.showFrame(5,arr);
            return;
         }
         PyramidControl.instance.movieLock = true;
         GameInSocketOut.sendPyramidTurnCard(arr[0],arr[1],false);
      }
      
      public function playTurnCardMovie() : void
      {
         PyramidControl.instance.movieLock = true;
         _movieCountArr = [1,0];
         var level:int = PyramidManager.instance.model.currentLayer;
         var templateID:int = PyramidManager.instance.model.templateID;
         var tempItem:PyramidSystemItemsInfo = PyramidManager.instance.model.getLevelCardItem(level,templateID);
         _currentCard.cardState(2,tempItem);
         checkAutoOpenCard();
      }
      
      private function __cardOpenMovieHandler(event:PyramidEvent) : void
      {
         var arr:* = null;
         var currentLevelNum:int = 0;
         var repeatCount:int = 0;
         if(!_movieCountArr)
         {
            return;
         }
         var count1:int = _movieCountArr[0];
         var count2:int = _movieCountArr[1];
         count2++;
         _movieCountArr[1] = count2;
         if(count1 == count2)
         {
            _movieCountArr = null;
            if(_playLevelMovieStep == 1)
            {
               arr = PyramidManager.instance.model.getLevelCardItems(_playLevel);
               currentLevelNum = 9 - _playLevel;
               repeatCount = arr.length / (9 - _playLevel);
               if(arr.length % currentLevelNum > 0)
               {
                  repeatCount++;
               }
               _shuffleWaitTimer.repeatCount = repeatCount;
               _timerCurrentCount = 0;
               _shuffleWaitTimer.reset();
               _shuffleWaitTimer.start();
            }
            else if(_playLevelMovieStep == 2)
            {
               playShuffleMovie();
            }
            else
            {
               PyramidControl.instance.movieLock = false;
               playShuffleFullMovie();
            }
         }
      }
      
      public function playShuffleFullMovie() : void
      {
         if(PyramidManager.instance.model.isShuffleMovie)
         {
            PyramidControl.instance.movieLock = true;
            playLevelMovie(PyramidManager.instance.model.currentLayer,"bg");
            playLevelMovie(PyramidManager.instance.model.currentLayer,"open");
            _playLevelMovieStep = 1;
         }
      }
      
      private function __shuffleWaitTimerHandler(event:TimerEvent) : void
      {
         _timerCurrentCount = Number(_timerCurrentCount) + 1;
         if(_timerCurrentCount >= _shuffleWaitTimer.repeatCount)
         {
            playLevelMovie(_playLevel,"close");
            _shuffleWaitTimer.stop();
            _playLevelMovieStep = 2;
         }
         else
         {
            cardLevelTimerDataUpdate(_playLevel,_timerCurrentCount);
         }
      }
      
      private function playShuffleMovie() : void
      {
         cardLevelVisible(_playLevel,false);
         playLevelMovie(_playLevel,"shuffle");
         _playLevelMovieStep = 3;
      }
      
      private function shuffleFrameScript() : void
      {
         if(_cards)
         {
            cardLevelState(_playLevel,3);
            cardLevelVisible(_playLevel,true);
         }
         _playLevelMovieStep = 0;
         PyramidControl.instance.movieLock = false;
         checkAutoOpenCard();
      }
      
      public function checkAutoOpenCard() : void
      {
         if(_timerOutNum != 0)
         {
            clearTimeout(_timerOutNum);
         }
         _timerOutNum = setTimeout(exeAutoOpenCard,1000);
      }
      
      private function exeAutoOpenCard() : void
      {
         var tempArr:* = null;
         var dic1:* = null;
         var i:int = 0;
         var tempNum:int = 0;
         var tempCard:* = null;
         if(PyramidManager.instance.model.isPyramidStart && PyramidControl.instance.isAutoOpenCard)
         {
            if(PyramidManager.instance.model.currentLayer >= 8)
            {
               openTopBox();
               PyramidControl.instance.autoCount--;
               if(PyramidControl.instance.autoCount > 0)
               {
                  PyramidControl.instance.isAutoOpenCard = true;
               }
               else
               {
                  PyramidControl.instance.isAutoOpenCard = false;
               }
            }
            else
            {
               tempArr = [];
               dic1 = Dictionary(_cards[_playLevel]);
               for(i = 1; i <= 9 - _playLevel; )
               {
                  if(dic1[i].state == 3)
                  {
                     tempArr.push(i);
                  }
                  i++;
               }
               if(tempArr.length > 0)
               {
                  tempNum = Math.random() * tempArr.length;
                  tempCard = _cards[_playLevel][tempArr[tempNum]];
                  openCurrendCard(tempCard);
               }
            }
         }
      }
      
      public function playLevelMovie(level:int, action:String) : void
      {
         var tempMovie:* = null;
         var arr:* = null;
         var dic1:* = null;
         var i:int = 0;
         var itemInfo:* = null;
         var dic2:* = null;
         _playLevel = level;
         if(action == "shuffle" || action == "bg")
         {
            _shuffleMovie.visible = true;
            _shuffleMovie.gotoAndStop(_playLevel);
            tempMovie = MovieClip(_shuffleMovie["level" + _playLevel]);
            if(tempMovie)
            {
               if(action == "shuffle")
               {
                  tempMovie.addFrameScript(tempMovie.totalFrames - 2,shuffleFrameScript);
                  tempMovie.gotoAndPlay(action);
               }
               else
               {
                  tempMovie.gotoAndStop(action);
               }
            }
         }
         else if(action == "open")
         {
            arr = PyramidManager.instance.model.getLevelCardItems(_playLevel);
            dic1 = Dictionary(_cards[_playLevel]);
            for(i = 1; i <= 9 - _playLevel; )
            {
               itemInfo = arr[i - 1];
               dic1[i].cardState(2,itemInfo);
               i++;
            }
            _movieCountArr = [9 - _playLevel,0];
            PyramidControl.instance.movieLock = true;
         }
         else if(action == "close")
         {
            dic2 = Dictionary(_cards[_playLevel]);
            var _loc11_:int = 0;
            var _loc10_:* = dic2;
            for each(var card2 in dic2)
            {
               card2.cardState(4);
            }
            _movieCountArr = [9 - _playLevel,0];
            PyramidControl.instance.movieLock = true;
         }
      }
      
      private function cardLevelVisible(level:int, bool:Boolean) : void
      {
         var dic:Dictionary = Dictionary(_cards[level]);
         var _loc6_:int = 0;
         var _loc5_:* = dic;
         for each(var card in dic)
         {
            card.visible = bool;
         }
      }
      
      private function cardLevelState(level:int, state:int) : void
      {
         var dic:Dictionary = Dictionary(_cards[level]);
         var _loc6_:int = 0;
         var _loc5_:* = dic;
         for each(var card in dic)
         {
            card.cardState(state);
         }
      }
      
      private function cardLevelTimerDataUpdate(level:int, repeatCount:int) : void
      {
         var i:int = 0;
         var itemInfo:* = null;
         var index:int = 0;
         if(repeatCount > 0)
         {
            index = repeatCount * (9 - level);
         }
         var arr:Array = PyramidManager.instance.model.getLevelCardItems(level);
         var dic:Dictionary = Dictionary(_cards[level]);
         for(i = 1; i <= 9 - level; )
         {
            if(arr.length > index)
            {
               itemInfo = arr[index];
               dic[i].cardState(5,itemInfo);
               index++;
               i++;
               continue;
            }
            break;
         }
      }
      
      public function updateSelectItems() : void
      {
         var dic1:* = null;
         var dic2:* = null;
         var tempId:int = 0;
         var level:int = 0;
         var item:* = null;
         var dic3:* = null;
         if(PyramidManager.instance.model.isPyramidStart)
         {
            dic1 = PyramidManager.instance.model.selectLayerItems;
            var _loc13_:int = 0;
            var _loc12_:* = dic1;
            for(var key1 in dic1)
            {
               dic2 = dic1[key1];
               var _loc11_:int = 0;
               var _loc10_:* = dic2;
               for(var key2 in dic2)
               {
                  tempId = dic2[key2];
                  level = key1;
                  item = PyramidManager.instance.model.getLevelCardItem(level,tempId);
                  PyramidCard(_cards[key1][key2]).cardState(1,item);
               }
            }
            if(!PyramidManager.instance.model.isShuffleMovie && PyramidManager.instance.model.isPyramidStart && PyramidManager.instance.model.currentLayer < 8)
            {
               playLevelMovie(PyramidManager.instance.model.currentLayer,"bg");
               dic3 = Dictionary(_cards[PyramidManager.instance.model.currentLayer]);
               var _loc15_:int = 0;
               var _loc14_:* = dic3;
               for each(var card1 in dic3)
               {
                  if(card1.state == 0)
                  {
                     card1.cardState(3);
                  }
               }
            }
         }
         else if(PyramidControl.instance.movieLock && _cardsSprite)
         {
            if(!_cardsSprite.hasEventListener("enterFrame"))
            {
               _cardsSprite.addEventListener("enterFrame",__delayReset);
            }
         }
         else
         {
            reset();
         }
      }
      
      private function __delayReset(event:Event) : void
      {
         if(!PyramidControl.instance.movieLock)
         {
            reset();
            _cardsSprite.removeEventListener("enterFrame",__delayReset);
         }
      }
      
      public function upClear() : void
      {
         var dic1:* = null;
         if(!PyramidManager.instance.model.isUp)
         {
            return;
         }
         var level:int = PyramidManager.instance.model.currentLayer;
         if(level - 1 > 0)
         {
            dic1 = Dictionary(_cards[level - 1]);
            var _loc5_:int = 0;
            var _loc4_:* = dic1;
            for each(var card1 in dic1)
            {
               if(card1.state == 3)
               {
                  card1.cardState(0);
               }
            }
         }
      }
      
      public function reset() : void
      {
         var _loc6_:int = 0;
         var _loc5_:* = _cards;
         for each(var obj1 in _cards)
         {
            var _loc4_:int = 0;
            var _loc3_:* = obj1;
            for each(var obj2 in obj1)
            {
               obj2.reset();
            }
         }
         _playLevelMovieStep = 0;
         _timerCurrentCount = 0;
         _shuffleMovie.gotoAndStop(1);
         _shuffleMovie.visible = false;
         topBoxMovieMode();
      }
      
      public function dispose() : void
      {
         if(_timerOutNum != 0)
         {
            clearTimeout(_timerOutNum);
         }
         PyramidControl.instance.isAutoOpenCard = false;
         _topBox.removeEventListener("click",__cardClickHandler);
         _shuffleWaitTimer.stop();
         _shuffleWaitTimer.removeEventListener("timer",__shuffleWaitTimerHandler);
         _shuffleWaitTimer = null;
         var _loc6_:int = 0;
         var _loc5_:* = _cards;
         for each(var obj1 in _cards)
         {
            var _loc4_:int = 0;
            var _loc3_:* = obj1;
            for each(var obj2 in obj1)
            {
               obj2.removeEventListener("click",__cardClickHandler);
               obj2.removeEventListener("openAndClose_Movie",__cardOpenMovieHandler);
               obj2.dispose();
            }
         }
         _cards = null;
         _currentCard = null;
         _movieCountArr = null;
         if(_cardsSprite)
         {
            _cardsSprite.removeEventListener("enterFrame",__delayReset);
            ObjectUtils.disposeAllChildren(_cardsSprite);
            ObjectUtils.disposeObject(_cardsSprite);
            _cardsSprite = null;
         }
         ObjectUtils.disposeObject(_topBox);
         _topBox = null;
         ObjectUtils.disposeObject(_shuffleMovie);
         _shuffleMovie = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
