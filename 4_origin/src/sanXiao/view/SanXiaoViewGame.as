package sanXiao.view
{
   import bagAndInfo.bag.RichesButton;
   import bagAndInfo.cell.BagCell;
   import baglocked.BaglockedManager;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.container.GridBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import ddt.manager.TimeManager;
   import ddt.utils.CheckMoneyUtils;
   import ddt.utils.PositionUtils;
   import ddt.view.pageSelector.PageSelector;
   import ddt.view.pageSelector.PageSelectorFactory;
   import ddt.view.tips.SanXiaoPropTip;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.ui.Mouse;
   import road7th.utils.DateUtils;
   import sanXiao.SanXiaoManager;
   import sanXiao.game.SXGame;
   import sanXiao.game.SanXiaoGameMediator;
   import sanXiao.model.SXRewardItemData;
   import times.utils.timerManager.TimerJuggler;
   import times.utils.timerManager.TimerManager;
   
   public class SanXiaoViewGame extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _game:SXGame;
      
      private var _mask:Shape;
      
      private var _btnPropCrossBomb:SimpleBitmapButton;
      
      private var _btnPropSquareBomb:SimpleBitmapButton;
      
      private var _btnPropClearColor:SimpleBitmapButton;
      
      private var _btnPropChangeColor:SimpleBitmapButton;
      
      private var _propCursor:ScaleFrameImage;
      
      private var _btnSelectedProp:Bitmap;
      
      private var _cursorOffsetX:Number;
      
      private var _cursorOffsetY:Number;
      
      private var _scoreTxt:FilterFrameText;
      
      private var _stepRemainTxt:FilterFrameText;
      
      private var _crystalTxt:FilterFrameText;
      
      private var _btnBuyStep:SimpleBitmapButton;
      
      private var _iconBoxBagCell:BagCell;
      
      private var _progress:MovieClip;
      
      private var _progressTips:RichesButton;
      
      private var _progressText:FilterFrameText;
      
      private var _timeRemainBmp:Bitmap;
      
      private var _timeRemainText:FilterFrameText;
      
      private var _timeRemainTimer:TimerJuggler;
      
      private var _bagListView:GridBox;
      
      private var _pageSelector:PageSelector;
      
      private var _rewardItemList:Vector.<SXDropOutItem>;
      
      private var _curPage:int;
      
      private var _propBtnListened:Boolean = false;
      
      public function SanXiaoViewGame()
      {
         super();
         init();
         addEvents();
      }
      
      private function init() : void
      {
         var _loc3_:int = 0;
         var _loc1_:* = null;
         _bg = ComponentFactory.Instance.creatBitmap("ast.sanxiao.bg.game");
         PositionUtils.setPos(_bg,"sanxiao.gameBG.pt");
         addChild(_bg);
         _game = SanXiaoGameMediator.getInstance().getGameView();
         PositionUtils.setPos(_game,"sanxiao.game.pt");
         addChild(_game);
         _mask = new Shape();
         _mask.graphics.beginFill(0);
         _mask.graphics.drawRect(0,0,350,350);
         _mask.graphics.endFill();
         _mask.x = _game.x;
         _mask.y = _game.y;
         addChild(_mask);
         _game.mask = _mask;
         SanXiaoPropTip;
         var _loc2_:SXPropTipDataCreater = new SXPropTipDataCreater();
         _btnPropCrossBomb = ComponentFactory.Instance.creat("sanxiao.prop.CrossBomb.btn");
         _btnPropCrossBomb.tipStyle = "ddt.view.tips.SanXiaoPropTip";
         _btnPropCrossBomb.tipDirctions = "2";
         _btnPropCrossBomb.tipGapV = 4;
         _btnPropCrossBomb.tipData = _loc2_.getTipData(1);
         addChild(_btnPropCrossBomb);
         _btnPropSquareBomb = ComponentFactory.Instance.creat("sanxiao.prop.SquareBomb.btn");
         _btnPropSquareBomb.tipStyle = "ddt.view.tips.SanXiaoPropTip";
         _btnPropSquareBomb.tipDirctions = "2";
         _btnPropSquareBomb.tipGapV = 4;
         _btnPropSquareBomb.tipData = _loc2_.getTipData(2);
         addChild(_btnPropSquareBomb);
         _btnPropClearColor = ComponentFactory.Instance.creat("sanxiao.prop.ClearColor.btn");
         _btnPropClearColor.tipStyle = "ddt.view.tips.SanXiaoPropTip";
         _btnPropClearColor.tipDirctions = "2";
         _btnPropClearColor.tipGapV = 4;
         _btnPropClearColor.tipData = _loc2_.getTipData(3);
         addChild(_btnPropClearColor);
         _btnPropChangeColor = ComponentFactory.Instance.creat("sanxiao.prop.ChangeColor.btn");
         _btnPropChangeColor.tipStyle = "ddt.view.tips.SanXiaoPropTip";
         _btnPropChangeColor.tipDirctions = "2";
         _btnPropChangeColor.tipGapV = 4;
         _btnPropChangeColor.tipData = _loc2_.getTipData(4);
         addChild(_btnPropChangeColor);
         _propCursor = ComponentFactory.Instance.creat("sanxiao.propIcon");
         var _loc4_:Boolean = false;
         _propCursor.mouseEnabled = _loc4_;
         _propCursor.mouseChildren = _loc4_;
         _cursorOffsetX = -_propCursor.width * 0.5;
         _cursorOffsetY = -_propCursor.height * 0.5;
         _btnSelectedProp = ComponentFactory.Instance.creat("ast.sanxiao.selected.prop");
         _scoreTxt = ComponentFactory.Instance.creat("sanxiao.gameTxt");
         _scoreTxt.autoSize = "center";
         PositionUtils.setPos(_scoreTxt,"sanxiao.score.pt");
         _scoreTxt.text = "0";
         addChild(_scoreTxt);
         _stepRemainTxt = ComponentFactory.Instance.creat("sanxiao.gameTxt");
         _stepRemainTxt.autoSize = "center";
         PositionUtils.setPos(_stepRemainTxt,"sanxiao.stepRemain.pt");
         _stepRemainTxt.text = "0";
         addChild(_stepRemainTxt);
         _crystalTxt = ComponentFactory.Instance.creat("sanxiao.gameTxt");
         _crystalTxt.autoSize = "center";
         PositionUtils.setPos(_crystalTxt,"sanxiao.crystal.pt");
         _crystalTxt.text = "0";
         addChild(_crystalTxt);
         _progress = ComponentFactory.Instance.creat("ast.sanxiao.progress");
         _progress.gotoAndStop(1);
         PositionUtils.setPos(_progress,"sanxiao.progress.pt");
         addChild(_progress);
         _progressText = ComponentFactory.Instance.creat("sanxiao.ProgressText");
         PositionUtils.setPos(_progressText,"sanxiao.progressTxt.pt");
         addChild(_progressText);
         _progressTips = ComponentFactory.Instance.creat("sanxiao.progressTips");
         _progressTips.x = _progress.x;
         _progressTips.y = _progress.y;
         _progressTips.tipData = "0/0";
         addChild(_progressTips);
         _iconBoxBagCell = new BagCell(0,null,true);
         PositionUtils.setPos(_iconBoxBagCell,"sanxiao.nextbagcell.pt");
         addChild(_iconBoxBagCell);
         _btnBuyStep = ComponentFactory.Instance.creat("sanxiao.buyStep.btn");
         addChild(_btnBuyStep);
         _bagListView = new GridBox();
         _bagListView.columnNumber = 7;
         _rewardItemList = new Vector.<SXDropOutItem>();
         _loc3_ = 0;
         while(_loc3_ < 49)
         {
            _loc1_ = new SXDropOutItem(0);
            _loc1_.width = 55;
            _loc1_.height = 55;
            _loc1_.x = int(_loc3_ % 7) * 49 + 386;
            _loc1_.y = int(_loc3_ / 7) * 49 + 19;
            addChild(_loc1_);
            _rewardItemList.push(_loc1_);
            _loc3_++;
         }
         PositionUtils.setPos(_bagListView,"sanxiao.bagListView.pt");
         addChild(_bagListView);
         _pageSelector = PageSelectorFactory.getInstance().getPageSelector("normal");
         _pageSelector.itemDataArr = SanXiaoManager.getInstance().dropOutItemList;
         _pageSelector.itemList = _rewardItemList;
         PositionUtils.setPos(_pageSelector,"sanxiao.pageSelectorCount");
         addChild(_pageSelector);
         _timeRemainBmp = ComponentFactory.Instance.creatBitmap("ast.sanxiao.timeRemainBmp");
         addChild(_timeRemainBmp);
         _timeRemainText = ComponentFactory.Instance.creat("sanxiao.timeRemainText.Txt");
         _timeRemainText.text = "";
         addChild(_timeRemainText);
         _timeRemainTimer = TimerManager.getInstance().addTimerJuggler(10000);
         _timeRemainTimer.addEventListener("timer",__timeRemainHandler);
         _timeRemainTimer.start();
      }
      
      private function __timeRemainHandler(param1:Event) : void
      {
         if(_timeRemainText)
         {
            _timeRemainText.text = getTimeRemainStr();
         }
      }
      
      private function getTimeRemainStr() : String
      {
         var _loc2_:Number = (SanXiaoManager.getInstance().endTime.time - TimeManager.Instance.Now().time) / 1000;
         var _loc1_:Array = DateUtils.dateTimeRemainArr(_loc2_);
         return LanguageMgr.GetTranslation("tank.timeRemain.msg1",_loc1_[0],_loc1_[1],_loc1_[2]);
      }
      
      private function addEvents() : void
      {
         _btnBuyStep.addEventListener("click",onClick);
         _propBtnListened || StageReferance.stage.addEventListener("click",onPropBtnClick);
         _propBtnListened = true;
      }
      
      private function removeEvents() : void
      {
         _btnBuyStep.removeEventListener("click",onClick);
         _propBtnListened && StageReferance.stage.removeEventListener("click",onPropBtnClick);
         _propBtnListened = false;
      }
      
      protected function onClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         if(SanXiaoManager.getInstance().dataEnd.time <= TimeManager.Instance.Now().time)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("sanxiao.timesOut"),0,false,1);
            return;
         }
         var _loc2_:SXBuyTimesFrame = ComponentFactory.Instance.creatComponentByStylename("sanxiao.SanxiaoBuyTimesFrame");
         _loc2_.buyFunction = onBuy;
         LayerManager.Instance.addToLayer(_loc2_,3,true,1);
      }
      
      protected function onPropBtnClick(param1:MouseEvent) : void
      {
         var _loc2_:* = param1.target;
         if(_btnPropCrossBomb !== _loc2_)
         {
            if(_btnPropSquareBomb !== _loc2_)
            {
               if(_btnPropClearColor !== _loc2_)
               {
                  if(_btnPropChangeColor !== _loc2_)
                  {
                     if(_curPage == 1 || PlayerManager.Instance.Self.BandMoney < 100 && PlayerManager.Instance.Self.Money < 100)
                     {
                        SanXiaoGameMediator.getInstance().curProp = 0;
                        _btnSelectedProp.parent && removeChild(_btnSelectedProp);
                        hidePropCursor();
                     }
                  }
                  else
                  {
                     SanXiaoGameMediator.getInstance().curProp = 4;
                     _btnSelectedProp.x = _btnPropChangeColor.x;
                     _btnSelectedProp.y = _btnPropChangeColor.y;
                     addChild(_btnSelectedProp);
                     _propCursor.setFrame(4);
                     showPropCursor();
                  }
               }
               else
               {
                  SanXiaoGameMediator.getInstance().curProp = 3;
                  _btnSelectedProp.x = _btnPropClearColor.x;
                  _btnSelectedProp.y = _btnPropClearColor.y;
                  addChild(_btnSelectedProp);
                  _propCursor.setFrame(3);
                  showPropCursor();
               }
            }
            else
            {
               SanXiaoGameMediator.getInstance().curProp = 2;
               _btnSelectedProp.x = _btnPropSquareBomb.x;
               _btnSelectedProp.y = _btnPropSquareBomb.y;
               addChild(_btnSelectedProp);
               _propCursor.setFrame(2);
               showPropCursor();
            }
         }
         else
         {
            SanXiaoGameMediator.getInstance().curProp = 1;
            _btnSelectedProp.x = _btnPropCrossBomb.x;
            _btnSelectedProp.y = _btnPropCrossBomb.y;
            addChild(_btnSelectedProp);
            _propCursor.setFrame(1);
            showPropCursor();
         }
      }
      
      private function showPropCursor() : void
      {
         StageReferance.stage.addChild(_propCursor);
         _propCursor.x = StageReferance.stage.mouseX + _cursorOffsetX;
         _propCursor.y = StageReferance.stage.mouseY + _cursorOffsetY;
         _propCursor.startDrag(false);
         StageReferance.stage.addEventListener("mouseMove",onCursorMove);
         Mouse.hide();
      }
      
      private function hidePropCursor() : void
      {
         _propCursor.parent && StageReferance.stage.removeChild(_propCursor);
         _propCursor.stopDrag();
         StageReferance.stage.removeEventListener("mouseMove",onCursorMove);
         Mouse.show();
      }
      
      protected function onCursorMove(param1:MouseEvent) : void
      {
         Mouse.hide();
      }
      
      private function onBuy(param1:Number, param2:Boolean) : void
      {
         times = param1;
         isBind = param2;
         goBuy = function():void
         {
            SanXiaoGameMediator.getInstance().buyTimes(times,CheckMoneyUtils.instance.isBind);
         };
         CheckMoneyUtils.instance.checkMoney(isBind,100 * times,goBuy);
      }
      
      public function lockProps() : void
      {
         _btnPropCrossBomb.enable = false;
         _btnPropSquareBomb.enable = false;
         _btnPropClearColor.enable = false;
         _btnPropChangeColor.enable = false;
         _curPage = 0;
      }
      
      public function unLockProps() : void
      {
         _btnPropCrossBomb.enable = true;
         _btnPropSquareBomb.enable = true;
         _btnPropClearColor.enable = true;
         _btnPropChangeColor.enable = true;
         _curPage = 1;
      }
      
      public function updateDropOutItem() : void
      {
         var _loc3_:int = 0;
         var _loc1_:Array = SanXiaoManager.getInstance().dropOutItemList;
         var _loc2_:int = SanXiaoManager.getInstance().lengthAddedDropOutItem;
         _pageSelector.updateItemDataArr = _loc1_;
         _loc3_ = _loc2_ - 1;
         while(_loc3_ >= 0)
         {
            _pageSelector.updateByIndex(_loc1_.length - 1 - _loc3_);
            _loc3_--;
         }
      }
      
      public function update() : void
      {
         var _loc4_:* = null;
         var _loc3_:* = null;
         _crystalTxt.text = SanXiaoManager.getInstance().crystalNum.toString();
         _scoreTxt.text = SanXiaoManager.getInstance().score.toString();
         _stepRemainTxt.text = SanXiaoManager.getInstance().stepRemain.toString();
         var _loc1_:Number = SanXiaoManager.getInstance().nextPriseScoreProgress;
         _progress.gotoAndStop(int(_loc1_));
         _progressTips.tipData = SanXiaoManager.getInstance().progressTipsData;
         _progressText.text = _loc1_.toString() + "%";
         var _loc2_:SXRewardItemData = SanXiaoManager.getInstance().nextRewardSXRewardItemData;
         if(_loc2_ == null)
         {
            _loc4_ = null;
         }
         else
         {
            _loc4_ = ItemManager.Instance.getTemplateById(_loc2_.TempleteID);
         }
         if(_loc4_ != null)
         {
            _loc3_ = new InventoryItemInfo();
            ObjectUtils.copyProperties(_loc3_,_loc4_);
            _loc3_.ValidDate = _loc2_.Valid;
            _loc3_.Count = _loc2_.count;
            _loc3_.IsBinds = _loc2_.isBind;
            _loc3_.Property5 = "1";
            _iconBoxBagCell.info = _loc3_;
         }
         else
         {
            _iconBoxBagCell.info = null;
         }
         if(_timeRemainText)
         {
            _timeRemainText.text = getTimeRemainStr();
         }
      }
      
      public function dispose() : void
      {
         removeEvents();
         hidePropCursor();
         _timeRemainTimer.stop();
         _timeRemainTimer.removeEventListener("timer",__timeRemainHandler);
         TimerManager.getInstance().removeJugglerByTimer(_timeRemainTimer);
         _timeRemainTimer = null;
         SanXiaoGameMediator.getInstance().killGame();
         _game.mask = null;
         ObjectUtils.disposeAllChildren(this);
         _rewardItemList.length = 0;
         _rewardItemList = null;
         _btnPropCrossBomb = null;
         _btnPropSquareBomb = null;
         _btnPropClearColor = null;
         _btnPropChangeColor = null;
         _btnSelectedProp = null;
         _propCursor = null;
         _bg = null;
         _game = null;
         _mask = null;
         _scoreTxt = null;
         _stepRemainTxt = null;
         _crystalTxt = null;
         _btnBuyStep = null;
         _iconBoxBagCell = null;
         _progress = null;
         _bagListView = null;
         _progressTips = null;
         _progressText = null;
         _pageSelector = null;
         _timeRemainText = null;
         _timeRemainBmp = null;
      }
   }
}
