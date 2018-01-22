package gameCommon.view.experience
{
   import com.greensock.TweenMax;
   import com.greensock.easing.Quint;
   import com.greensock.plugins.MotionBlurPlugin;
   import com.greensock.plugins.TweenPlugin;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.player.SelfInfo;
   import ddt.events.GameEvent;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.filters.BlurFilter;
   import flash.utils.setTimeout;
   import game.GameManager;
   import gameCommon.GameControl;
   import gameCommon.model.GameInfo;
   import gameCommon.model.Living;
   import gameCommon.model.Player;
   import gameCommon.view.card.LargeCardsView;
   import gameCommon.view.card.SmallCardsView;
   import gameCommon.view.card.TakeOutCardController;
   import room.RoomManager;
   
   [Event(name="expshowed",type="ddt.events.GameEvent")]
   public class ExpView extends Sprite implements Disposeable
   {
      
      public static const GAME_OVER_TYPE_0:uint = 0;
      
      public static const GAME_OVER_TYPE_1:uint = 1;
      
      public static const GAME_OVER_TYPE_2:uint = 2;
      
      public static const GAME_OVER_TYPE_3:uint = 3;
      
      public static const GAME_OVER_TYPE_4:uint = 4;
      
      public static const GAME_OVER_TYPE_5:uint = 5;
      
      public static const GAME_OVER_TYPE_6:uint = 6;
       
      
      private var _bg:Bitmap;
      
      private var _leftView:ExpLeftView;
      
      private var _rightView:Sprite;
      
      private var _shape:Shape;
      
      private var _resultSeal:ExpResultSeal;
      
      private var _titleBitmap:Bitmap;
      
      private var _fightView:ExpFightExpItem;
      
      private var _attatchView:ExpAttatchExpItem;
      
      private var _exploitView:ExpExploitItem;
      
      private var _totalView:ExpTotalItem;
      
      private var _cardController:TakeOutCardController;
      
      private var _smallCardsView:SmallCardsView;
      
      private var _largeCardsView:LargeCardsView;
      
      private var _blurStep:int;
      
      private var _blurFilter:BlurFilter;
      
      private var _totalExploit:int;
      
      private var _fightNums:Array;
      
      private var _attatchNums:Array;
      
      private var _exploitNums:Array;
      
      private var _prestigeNums:Array;
      
      private var _gameInfo:GameInfo;
      
      private var _isOnlyLeftOut:Boolean;
      
      private var _isNoCardView:Boolean;
      
      private var _luckyExp:Boolean = false;
      
      private var _luckyOffer:Boolean = false;
      
      private var _expObj:Object;
      
      private var _survivalBg:Bitmap;
      
      private var _survivalArr:Vector.<ExpSurvivalItem>;
      
      public function ExpView(param1:Bitmap = null)
      {
         super();
         MotionBlurPlugin;
         _bg = param1;
      }
      
      public function show() : void
      {
         var _loc2_:* = null;
         _gameInfo = GameControl.Instance.Current;
         var _loc3_:SelfInfo = PlayerManager.Instance.Self;
         _cardController = new TakeOutCardController();
         var _loc1_:Player = _gameInfo.findPlayerByPlayerID(_loc3_.ID);
         if(RoomManager.Instance.current.selfRoomPlayer.isViewer || !_loc1_)
         {
            onAllComplete();
            return;
         }
         GameManager.instance.isPlaying = true;
         LayerManager.Instance.clearnGameDynamic();
         LayerManager.Instance.clearnStageDynamic();
         if(_gameInfo.gameMode == 121)
         {
            creatExpSurvivalView();
            setTimeout(onAllComplete,5000);
         }
         else
         {
            _expObj = _gameInfo.selfGamePlayer.expObj;
            _loc2_ = _gameInfo.selfGamePlayer.expObj;
            if(_loc2_ && _loc2_.hasOwnProperty("luckyExp") && _loc2_.luckyExp > 0)
            {
               _luckyExp = true;
            }
            if(_loc2_ && _loc2_.hasOwnProperty("luckyOffer") && _loc2_.luckyOffer > 0)
            {
               _luckyOffer = true;
            }
            var _loc4_:* = _loc2_.gameOverType;
            if(0 !== _loc4_)
            {
               if(1 !== _loc4_)
               {
                  if(2 !== _loc4_)
                  {
                     if(3 !== _loc4_)
                     {
                        if(4 !== _loc4_)
                        {
                           if(5 !== _loc4_)
                           {
                              if(6 === _loc4_)
                              {
                                 _fightNums = [_loc2_.killGP,_loc2_.hertGP,_loc2_.fightGP,_loc2_.ghostGP];
                                 SoundManager.instance.play(!!_gameInfo.selfGamePlayer.isWin?"063":"064");
                                 _attatchNums = [_loc2_.gpForVIP,_loc2_.gpForSpouse,_loc2_.gpForServer,_loc2_.gpForApprenticeOnline,_loc2_.gpForApprenticeTeam,_loc2_.gpForDoubleCard,_loc2_.consortiaSkill];
                              }
                           }
                           else
                           {
                              if(_gameInfo.roomType == 5)
                              {
                                 onAllComplete();
                                 return;
                              }
                              _isNoCardView = true;
                              SoundManager.instance.play(!!_gameInfo.selfGamePlayer.isWin?"063":"064");
                              _fightNums = [_loc2_.killGP,_loc2_.hertGP,_loc2_.fightGP,_loc2_.ghostGP];
                              _attatchNums = [_loc2_.gpForVIP,_loc2_.gpForSpouse,_loc2_.gpForServer,_loc2_.gpForApprenticeOnline,_loc2_.gpForApprenticeTeam,_loc2_.gpForDoubleCard,_loc2_.consortiaSkill];
                           }
                        }
                        else
                        {
                           SoundManager.instance.play(!!_gameInfo.selfGamePlayer.isWin?"063":"064");
                           _fightNums = [_loc2_.killGP,_loc2_.hertGP,_loc2_.fightGP,_loc2_.ghostGP];
                           _attatchNums = [_loc2_.gpForVIP,_loc2_.gpForSpouse,_loc2_.gpForServer,_loc2_.gpForApprenticeOnline,_loc2_.gpForApprenticeTeam,_loc2_.gpForDoubleCard,_loc2_.consortiaSkill];
                        }
                     }
                     else
                     {
                        SoundManager.instance.play(!!_gameInfo.selfGamePlayer.isWin?"063":"064");
                        if(_bg)
                        {
                           addChild(_bg);
                        }
                        changeDark();
                        onAllComplete();
                        return;
                     }
                  }
                  else
                  {
                     SoundManager.instance.play(!!_gameInfo.selfGamePlayer.isWin?"063":"064");
                     _isOnlyLeftOut = true;
                  }
               }
               else
               {
                  SoundManager.instance.play(!!_gameInfo.selfGamePlayer.isWin?"063":"064");
                  _fightNums = [_loc2_.killGP,_loc2_.hertGP,_loc2_.fightGP,_loc2_.ghostGP];
                  _attatchNums = [_loc2_.gpForVIP,_loc2_.gpForConsortia,_loc2_.gpForSpouse,_loc2_.gpForServer,_loc2_.gpForApprenticeOnline,_loc2_.gpForApprenticeTeam,_loc2_.gpForDoubleCard,_loc2_.gpForPower,_loc2_.consortiaSkill];
                  _exploitNums = [_loc2_.offerFight,_loc2_.offerDoubleCard,_loc2_.offerVIP,_loc2_.offerService,_loc2_.offerBuff,_loc2_.offerConsortia];
                  setDefyInfo();
               }
               validateData(_fightNums);
               validateData(_attatchNums);
               _blurFilter = new BlurFilter();
               TweenPlugin.activate([MotionBlurPlugin]);
               _rightView = new Sprite();
               PositionUtils.setPos(_rightView,"experience.RightViewPos");
               if(_bg)
               {
                  addChild(_bg);
               }
               changeDark();
               addChild(_rightView);
               leftView();
               if(_isOnlyLeftOut)
               {
                  ExpTweenManager.Instance.appendTween(TweenMax.to(this,0.5,{
                     "onComplete":onAllComplete,
                     "onStart":fastComplete
                  }));
               }
               else
               {
                  resultSealView();
                  titleView();
                  fightView();
                  attatchView();
                  exploitView();
                  ExpTweenManager.Instance.appendTween(TweenMax.to(this,2,{
                     "onComplete":onAllComplete,
                     "onStart":fastComplete
                  }));
               }
               ExpTweenManager.Instance.startTweens();
            }
            else
            {
               onAllComplete();
               return;
            }
         }
      }
      
      private function creatExpSurvivalView() : void
      {
         var _loc3_:int = 0;
         var _loc1_:* = null;
         _survivalArr = new Vector.<ExpSurvivalItem>();
         _survivalBg = ComponentFactory.Instance.creat("asset.core.survival.clearing.bg");
         addChild(_survivalBg);
         var _loc2_:Array = sortGameInfoByKillNum();
         _loc3_ = 0;
         while(_loc3_ < _loc2_.length)
         {
            _loc1_ = new ExpSurvivalItem();
            _loc1_.x = 7;
            _loc1_.y = 244 + _loc3_ * _loc1_.height;
            addChild(_loc1_);
            _loc1_.setItemInfo(_loc3_ + 1,_loc2_[_loc3_]);
            _survivalArr.push(_loc1_);
            _loc3_++;
         }
      }
      
      private function sortGameInfoByKillNum() : Array
      {
         var _loc2_:Array = [];
         var _loc4_:int = 0;
         var _loc3_:* = _gameInfo.livings;
         for(var _loc1_ in _gameInfo.livings)
         {
            _loc2_.push(_gameInfo.livings[_loc1_]);
         }
         _loc2_.sortOn("killNum",2);
         return _loc2_;
      }
      
      private function validateData(param1:Array) : void
      {
         var _loc2_:int = 0;
         if(param1 == null)
         {
            return;
         }
         _loc2_ = 0;
         while(_loc2_ < param1.length)
         {
            if(isNaN(param1[_loc2_]))
            {
               param1[_loc2_] = 0;
            }
            _loc2_++;
         }
      }
      
      private function fastComplete() : void
      {
         if(_totalView)
         {
            _totalView.playGreenLight();
         }
         ExpTweenManager.Instance.speedRecover();
      }
      
      private function changeDark() : void
      {
         _shape = new Shape();
         _shape.graphics.beginFill(0,1);
         _shape.graphics.drawRect(-2,-2,1002,602);
         _shape.graphics.endFill();
         _shape.alpha = 0;
         TweenMax.to(_shape,0.5,{"alpha":0.8});
         addChild(_shape);
      }
      
      private function leftView() : void
      {
         _leftView = new ExpLeftView();
         _leftView.alpha = 0;
         addChild(_leftView);
         ExpTweenManager.Instance.appendTween(TweenMax.to(_leftView,0.5,{"alpha":1}));
      }
      
      private function resultSealView() : void
      {
         var _loc1_:String = !!_gameInfo.selfGamePlayer.isWin?"win":"lose";
         _resultSeal = new ExpResultSeal(_loc1_,_luckyExp,_luckyOffer);
         _rightView.addChild(_resultSeal);
         ExpTweenManager.Instance.appendTween(TweenMax.from(_resultSeal,0.5,{
            "x":1000,
            "ease":Quint.easeIn,
            "motionBlur":{
               "strength":2,
               "quality":1
            },
            "onComplete":blurTween
         }),-0.4);
      }
      
      private function titleView() : void
      {
         _titleBitmap = ComponentFactory.Instance.creatBitmap("asset.experience.rightViewTitleBg");
         _rightView.addChildAt(_titleBitmap,0);
         ExpTweenManager.Instance.appendTween(TweenMax.from(_titleBitmap,0.5,{
            "x":1000,
            "ease":Quint.easeIn,
            "motionBlur":{
               "strength":2,
               "quality":1
            }
         }));
      }
      
      private function fightView() : void
      {
         checkZero = function():void
         {
            if(_fightNums.every(equalsZero))
            {
               _totalView.updateTotalExp(0);
            }
         };
         _fightView = new ExpFightExpItem(_fightNums);
         _fightView.addEventListener("change",__updateTotalExp);
         ExpTweenManager.Instance.appendTween(TweenMax.from(_fightView,0.5,{
            "x":1000,
            "ease":Quint.easeIn,
            "motionBlur":{
               "strength":2,
               "quality":1
            }
         }));
         _fightView.createView();
         _rightView.addChildAt(_fightView,0);
         _totalView = new ExpTotalItem();
         _rightView.addChild(_totalView);
         ExpTweenManager.Instance.appendTween(TweenMax.from(_totalView,0.5,{
            "x":1000,
            "ease":Quint.easeIn,
            "motionBlur":{
               "strength":2,
               "quality":1
            },
            "onComplete":checkZero
         }),-1);
      }
      
      private function attatchView() : void
      {
         _attatchView = new ExpAttatchExpItem(_attatchNums);
         _attatchView.addEventListener("change",__updateTotalExp);
         ExpTweenManager.Instance.appendTween(TweenMax.from(_attatchView,0.5,{
            "x":1000,
            "ease":Quint.easeIn,
            "motionBlur":{
               "strength":2,
               "quality":1
            },
            "onStart":_totalView.playRedLight
         }));
         _attatchView.createView();
         _rightView.addChild(_attatchView);
      }
      
      private function exploitView() : void
      {
         checkZero = function():void
         {
            var _loc1_:Number = NaN;
            if(_gameInfo.roomType != 120)
            {
               if(_exploitNums.every(equalsZero))
               {
                  _totalView.updateTotalExploit(0);
               }
            }
            else
            {
               _loc1_ = _gameInfo.selfGamePlayer.expObj.prestige;
               _totalView.updateTotalExploit(_loc1_);
            }
         };
         if(!_exploitNums || _exploitNums.length == 0)
         {
            return;
         }
         _exploitView = new ExpExploitItem(_exploitNums);
         _exploitView.addEventListener("change",__updateTotalExploit);
         ExpTweenManager.Instance.appendTween(TweenMax.from(_exploitView,0.5,{
            "x":1000,
            "ease":Quint.easeIn,
            "motionBlur":{
               "strength":2,
               "quality":1
            },
            "onStart":_totalView.playRedLight,
            "onComplete":checkZero
         }));
         _exploitView.createView();
         _rightView.addChild(_exploitView);
      }
      
      private function __updateTotalExp(param1:Event) : void
      {
         var _loc2_:int = GameControl.Instance.Current.selfGamePlayer.expObj.gainGP;
         _totalView.updateTotalExp(_loc2_);
      }
      
      private function equalsZero(param1:*, param2:int, param3:Array) : Boolean
      {
         return param1 == 0;
      }
      
      private function __updateTotalExploit(param1:Event) : void
      {
         if(_gameInfo.roomType == 120)
         {
            return;
         }
         _totalExploit = _totalExploit + param1.currentTarget.targetValue;
         if(_expObj && _expObj.hasOwnProperty("luckyOffer"))
         {
            _totalView.updateTotalExploit(param1.currentTarget.targetValue + _expObj.luckyOffer);
         }
         else
         {
            _totalView.updateTotalExploit(param1.currentTarget.targetValue);
         }
      }
      
      public function close() : void
      {
         _cardController.setState();
      }
      
      public function showCard() : void
      {
         _cardController.showSmallCardView = showSmallCardView;
         _cardController.showLargeCardView = showLargeCardView;
         _cardController.tryShowCard();
      }
      
      private function onAllComplete() : void
      {
         ExpTweenManager.Instance.completeTweens();
         ExpTweenManager.Instance.deleteTweens();
         _cardController.setup(_gameInfo,RoomManager.Instance.current);
         _cardController.disposeFunc = dispose;
         dispatchEvent(new GameEvent("expshowed",null));
      }
      
      private function showSmallCardView(param1:DisplayObject) : void
      {
         view = param1;
         addCardView = function():void
         {
            TweenMax.killTweensOf(_rightView);
            addChild(view);
         };
         if(_rightView)
         {
            TweenMax.to(_rightView,0.4,{
               "x":"1000",
               "ease":Quint.easeOut,
               "onComplete":addCardView
            });
         }
         else
         {
            addCardView();
         }
      }
      
      private function showLargeCardView(param1:DisplayObject) : void
      {
         view = param1;
         addCardView = function():void
         {
            TweenMax.killTweensOf(_rightView);
            TweenMax.killTweensOf(_leftView);
            addChild(view);
         };
         if(_rightView)
         {
            TweenMax.to(_rightView,0.4,{
               "x":"1000",
               "ease":Quint.easeOut,
               "onComplete":addCardView
            });
         }
         else
         {
            addCardView();
         }
         if(_leftView)
         {
            TweenMax.to(_leftView,0.4,{
               "x":"-1000",
               "ease":Quint.easeOut
            });
         }
      }
      
      private function blurTween(param1:Event = null) : void
      {
         if(_blurStep == 0)
         {
            addEventListener("enterFrame",blurTween);
         }
         switch(int(_blurStep))
         {
            case 0:
               var _loc2_:int = 10;
               _blurFilter.blurY = _loc2_;
               _blurFilter.blurX = _loc2_;
               filters = [_blurFilter];
               x = x - 10;
               y = y - 6;
               scaleX = 1.01;
               scaleY = 1.01;
               break;
            case 1:
               _blurFilter.blurY = 5;
               filters = [_blurFilter];
               y = y + 6;
               scaleY = 1.005;
         }
         _blurStep = Number(_blurStep) + 1;
      }
      
      private function setDefyInfo() : void
      {
         var _loc2_:* = null;
         var _loc1_:Array = [];
         var _loc3_:Array = [];
         var _loc4_:Array = [];
         var _loc7_:int = 0;
         var _loc6_:* = _gameInfo.livings;
         for each(var _loc5_ in _gameInfo.livings)
         {
            _loc2_ = _loc5_ as Player;
            if(_loc2_ == null)
            {
               return;
            }
            if(_loc2_.isWin)
            {
               _loc1_.unshift(_loc2_.playerInfo.NickName);
            }
            else
            {
               _loc3_.unshift(_loc2_.playerInfo.NickName);
            }
         }
         _loc4_[0] = _loc1_;
         _loc4_[1] = _loc3_;
         RoomManager.Instance.setRoomDefyInfo(_loc4_);
      }
      
      public function dispose() : void
      {
         removeEventListener("enterFrame",blurTween);
         if(_fightView)
         {
            _fightView.removeEventListener("change",__updateTotalExp);
         }
         if(_attatchView)
         {
            _attatchView.removeEventListener("change",__updateTotalExp);
         }
         if(_exploitView)
         {
            _exploitView.removeEventListener("change",__updateTotalExploit);
         }
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
            _bg = null;
         }
         if(_leftView)
         {
            _leftView.dispose();
            _leftView = null;
         }
         if(_resultSeal)
         {
            _resultSeal.dispose();
            _resultSeal = null;
         }
         if(_titleBitmap)
         {
            _titleBitmap.parent.removeChild(_titleBitmap);
            _titleBitmap.bitmapData.dispose();
            _titleBitmap = null;
         }
         if(_fightView)
         {
            _fightView.dispose();
            _fightView = null;
         }
         if(_attatchView)
         {
            _attatchView.dispose();
            _attatchView = null;
         }
         if(_exploitView)
         {
            _exploitView.dispose();
            _exploitView = null;
         }
         if(_totalView)
         {
            _totalView.dispose();
            _totalView = null;
         }
         if(_smallCardsView)
         {
            _smallCardsView.dispose();
            _smallCardsView = null;
         }
         if(_rightView)
         {
            removeChild(_rightView);
         }
         _cardController = null;
         _rightView = null;
         _blurFilter = null;
         _fightNums = null;
         _attatchNums = null;
         _exploitNums = null;
         _shape = null;
         _gameInfo = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
