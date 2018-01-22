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
         var _loc2_:int = 0;
         var _loc1_:int = 0;
         _cards = new Dictionary();
         _loc2_ = 7;
         while(_loc2_ >= 1)
         {
            _cards[_loc2_] = new Dictionary();
            _loc1_ = 8;
            while(_loc1_ >= _loc2_)
            {
               createCard(_loc2_,9 - _loc1_);
               _loc1_--;
            }
            _loc2_--;
         }
         updateSelectItems();
         playShuffleFullMovie();
      }
      
      private function createCard(param1:int, param2:int) : void
      {
         var _loc4_:PyramidCard = new PyramidCard();
         _loc4_.index = param1 + "_" + param2;
         var _loc3_:Point = PositionUtils.creatPoint("pyramid.view.cardPos" + _loc4_.index);
         _loc4_.x = _loc3_.x;
         _loc4_.y = _loc3_.y;
         _cards[param1][param2] = _loc4_;
         _loc4_.addEventListener("click",__cardClickHandler);
         _loc4_.addEventListener("openAndClose_Movie",__cardOpenMovieHandler);
         _cardsSprite.addChild(_loc4_);
      }
      
      public function topBoxMovieMode(param1:int = 0) : void
      {
         _topBox.topBoxMovieMode(param1);
      }
      
      private function __cardClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:* = null;
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
         if(param1.currentTarget == _topBox && _topBox.state == 1)
         {
            openTopBox();
         }
         else if(param1.currentTarget is PyramidCard && !PyramidControl.instance.isAutoOpenCard)
         {
            _loc2_ = PyramidCard(param1.currentTarget);
            openCurrendCard(_loc2_);
         }
      }
      
      private function openTopBox() : void
      {
         _currentCard = null;
         topBoxMovieMode(2);
         GameInSocketOut.sendPyramidTurnCard(8,1,false);
      }
      
      private function openCurrendCard(param1:PyramidCard) : void
      {
         _currentCard = param1;
         if(_currentCard.state != 3)
         {
            return;
         }
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var _loc3_:int = PyramidManager.instance.model.freeCount - PyramidManager.instance.model.currentFreeCount;
         if(_loc3_ <= 0)
         {
            if(PlayerManager.Instance.Self.Money < PyramidManager.instance.model.turnCardPrice)
            {
               LeavePageManager.showFillFrame();
               PyramidControl.instance.isAutoOpenCard = false;
               return;
            }
         }
         var _loc2_:Array = _currentCard.index.split("_");
         if(_loc3_ <= 0 && PyramidControl.instance.isShowBuyFrameSelectedCheck)
         {
            PyramidControl.instance.showFrame(5,_loc2_);
            return;
         }
         PyramidControl.instance.movieLock = true;
         GameInSocketOut.sendPyramidTurnCard(_loc2_[0],_loc2_[1],false);
      }
      
      public function playTurnCardMovie() : void
      {
         PyramidControl.instance.movieLock = true;
         _movieCountArr = [1,0];
         var _loc2_:int = PyramidManager.instance.model.currentLayer;
         var _loc1_:int = PyramidManager.instance.model.templateID;
         var _loc3_:PyramidSystemItemsInfo = PyramidManager.instance.model.getLevelCardItem(_loc2_,_loc1_);
         _currentCard.cardState(2,_loc3_);
         checkAutoOpenCard();
      }
      
      private function __cardOpenMovieHandler(param1:PyramidEvent) : void
      {
         var _loc2_:* = null;
         var _loc6_:int = 0;
         var _loc5_:int = 0;
         if(!_movieCountArr)
         {
            return;
         }
         var _loc4_:int = _movieCountArr[0];
         var _loc3_:int = _movieCountArr[1];
         _loc3_++;
         _movieCountArr[1] = _loc3_;
         if(_loc4_ == _loc3_)
         {
            _movieCountArr = null;
            if(_playLevelMovieStep == 1)
            {
               _loc2_ = PyramidManager.instance.model.getLevelCardItems(_playLevel);
               _loc6_ = 9 - _playLevel;
               _loc5_ = _loc2_.length / (9 - _playLevel);
               if(_loc2_.length % _loc6_ > 0)
               {
                  _loc5_++;
               }
               _shuffleWaitTimer.repeatCount = _loc5_;
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
      
      private function __shuffleWaitTimerHandler(param1:TimerEvent) : void
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
         var _loc2_:* = null;
         var _loc3_:* = null;
         var _loc5_:int = 0;
         var _loc1_:int = 0;
         var _loc4_:* = null;
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
               _loc2_ = [];
               _loc3_ = Dictionary(_cards[_playLevel]);
               _loc5_ = 1;
               while(_loc5_ <= 9 - _playLevel)
               {
                  if(_loc3_[_loc5_].state == 3)
                  {
                     _loc2_.push(_loc5_);
                  }
                  _loc5_++;
               }
               if(_loc2_.length > 0)
               {
                  _loc1_ = Math.random() * _loc2_.length;
                  _loc4_ = _cards[_playLevel][_loc2_[_loc1_]];
                  openCurrendCard(_loc4_);
               }
            }
         }
      }
      
      public function playLevelMovie(param1:int, param2:String) : void
      {
         var _loc9_:* = null;
         var _loc3_:* = null;
         var _loc5_:* = null;
         var _loc8_:int = 0;
         var _loc4_:* = null;
         var _loc7_:* = null;
         _playLevel = param1;
         if(param2 == "shuffle" || param2 == "bg")
         {
            _shuffleMovie.visible = true;
            _shuffleMovie.gotoAndStop(_playLevel);
            _loc9_ = MovieClip(_shuffleMovie["level" + _playLevel]);
            if(_loc9_)
            {
               if(param2 == "shuffle")
               {
                  _loc9_.addFrameScript(_loc9_.totalFrames - 2,shuffleFrameScript);
                  _loc9_.gotoAndPlay(param2);
               }
               else
               {
                  _loc9_.gotoAndStop(param2);
               }
            }
         }
         else if(param2 == "open")
         {
            _loc3_ = PyramidManager.instance.model.getLevelCardItems(_playLevel);
            _loc5_ = Dictionary(_cards[_playLevel]);
            _loc8_ = 1;
            while(_loc8_ <= 9 - _playLevel)
            {
               _loc4_ = _loc3_[_loc8_ - 1];
               _loc5_[_loc8_].cardState(2,_loc4_);
               _loc8_++;
            }
            _movieCountArr = [9 - _playLevel,0];
            PyramidControl.instance.movieLock = true;
         }
         else if(param2 == "close")
         {
            _loc7_ = Dictionary(_cards[_playLevel]);
            var _loc11_:int = 0;
            var _loc10_:* = _loc7_;
            for each(var _loc6_ in _loc7_)
            {
               _loc6_.cardState(4);
            }
            _movieCountArr = [9 - _playLevel,0];
            PyramidControl.instance.movieLock = true;
         }
      }
      
      private function cardLevelVisible(param1:int, param2:Boolean) : void
      {
         var _loc3_:Dictionary = Dictionary(_cards[param1]);
         var _loc6_:int = 0;
         var _loc5_:* = _loc3_;
         for each(var _loc4_ in _loc3_)
         {
            _loc4_.visible = param2;
         }
      }
      
      private function cardLevelState(param1:int, param2:int) : void
      {
         var _loc3_:Dictionary = Dictionary(_cards[param1]);
         var _loc6_:int = 0;
         var _loc5_:* = _loc3_;
         for each(var _loc4_ in _loc3_)
         {
            _loc4_.cardState(param2);
         }
      }
      
      private function cardLevelTimerDataUpdate(param1:int, param2:int) : void
      {
         var _loc7_:int = 0;
         var _loc6_:* = null;
         var _loc3_:int = 0;
         if(param2 > 0)
         {
            _loc3_ = param2 * (9 - param1);
         }
         var _loc4_:Array = PyramidManager.instance.model.getLevelCardItems(param1);
         var _loc5_:Dictionary = Dictionary(_cards[param1]);
         _loc7_ = 1;
         while(_loc7_ <= 9 - param1)
         {
            if(_loc4_.length > _loc3_)
            {
               _loc6_ = _loc4_[_loc3_];
               _loc5_[_loc7_].cardState(5,_loc6_);
               _loc3_++;
               _loc7_++;
               continue;
            }
            break;
         }
      }
      
      public function updateSelectItems() : void
      {
         var _loc6_:* = null;
         var _loc8_:* = null;
         var _loc9_:int = 0;
         var _loc1_:int = 0;
         var _loc3_:* = null;
         var _loc7_:* = null;
         if(PyramidManager.instance.model.isPyramidStart)
         {
            _loc6_ = PyramidManager.instance.model.selectLayerItems;
            var _loc13_:int = 0;
            var _loc12_:* = _loc6_;
            for(var _loc4_ in _loc6_)
            {
               _loc8_ = _loc6_[_loc4_];
               var _loc11_:int = 0;
               var _loc10_:* = _loc8_;
               for(var _loc2_ in _loc8_)
               {
                  _loc9_ = _loc8_[_loc2_];
                  _loc1_ = _loc4_;
                  _loc3_ = PyramidManager.instance.model.getLevelCardItem(_loc1_,_loc9_);
                  PyramidCard(_cards[_loc4_][_loc2_]).cardState(1,_loc3_);
               }
            }
            if(!PyramidManager.instance.model.isShuffleMovie && PyramidManager.instance.model.isPyramidStart && PyramidManager.instance.model.currentLayer < 8)
            {
               playLevelMovie(PyramidManager.instance.model.currentLayer,"bg");
               _loc7_ = Dictionary(_cards[PyramidManager.instance.model.currentLayer]);
               var _loc15_:int = 0;
               var _loc14_:* = _loc7_;
               for each(var _loc5_ in _loc7_)
               {
                  if(_loc5_.state == 0)
                  {
                     _loc5_.cardState(3);
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
      
      private function __delayReset(param1:Event) : void
      {
         if(!PyramidControl.instance.movieLock)
         {
            reset();
            _cardsSprite.removeEventListener("enterFrame",__delayReset);
         }
      }
      
      public function upClear() : void
      {
         var _loc3_:* = null;
         if(!PyramidManager.instance.model.isUp)
         {
            return;
         }
         var _loc1_:int = PyramidManager.instance.model.currentLayer;
         if(_loc1_ - 1 > 0)
         {
            _loc3_ = Dictionary(_cards[_loc1_ - 1]);
            var _loc5_:int = 0;
            var _loc4_:* = _loc3_;
            for each(var _loc2_ in _loc3_)
            {
               if(_loc2_.state == 3)
               {
                  _loc2_.cardState(0);
               }
            }
         }
      }
      
      public function reset() : void
      {
         var _loc6_:int = 0;
         var _loc5_:* = _cards;
         for each(var _loc1_ in _cards)
         {
            var _loc4_:int = 0;
            var _loc3_:* = _loc1_;
            for each(var _loc2_ in _loc1_)
            {
               _loc2_.reset();
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
         for each(var _loc1_ in _cards)
         {
            var _loc4_:int = 0;
            var _loc3_:* = _loc1_;
            for each(var _loc2_ in _loc1_)
            {
               _loc2_.removeEventListener("click",__cardClickHandler);
               _loc2_.removeEventListener("openAndClose_Movie",__cardOpenMovieHandler);
               _loc2_.dispose();
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
