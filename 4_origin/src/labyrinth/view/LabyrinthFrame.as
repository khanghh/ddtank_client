package labyrinth.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.vo.AlertInfo;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.CheckWeaponManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.HelpFrameUtils;
   import ddt.utils.PositionUtils;
   import ddtBuried.BuriedManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import labyrinth.LabyrinthManager;
   import labyrinth.model.LabyrinthModel;
   import shop.view.BuySingleGoodsView;
   import trainer.view.NewHandContainer;
   
   public class LabyrinthFrame extends BaseAlerFrame
   {
       
      
      private var _bg:ScaleBitmapImage;
      
      private var _rightBg:Bitmap;
      
      private var _leftBg:ScaleFrameImage;
      
      private var _btnGroup:SelectedButtonGroup;
      
      private var _warriorBtn:SelectedButton;
      
      private var _nightmareBtn:SelectedButton;
      
      private var _content:Sprite;
      
      private var _startGameBtn:SimpleBitmapButton;
      
      private var _continueBtn:SimpleBitmapButton;
      
      private var _cleanOutBtn:SimpleBitmapButton;
      
      private var _continueCleanOutBtn:SimpleBitmapButton;
      
      private var _resetBtn:SimpleBitmapButton;
      
      private var _rankingBtn:SimpleBitmapButton;
      
      private var _shopBtn:SimpleBitmapButton;
      
      private var _helpBtn:SimpleBitmapButton;
      
      private var _myRanking:Bitmap;
      
      private var _myRankingText:FilterFrameText;
      
      private var _myProgress:Bitmap;
      
      private var _myProgressText:FilterFrameText;
      
      private var _titleList:SimpleTileList;
      
      private var _doubleAward:SelectedCheckButton;
      
      private var _todayNum:Bitmap;
      
      private var _todayNumText:FilterFrameText;
      
      private var _explain:FilterFrameText;
      
      private var _explainII:FilterFrameText;
      
      private var _currentFloor:FilterFrameText;
      
      private var _currentFloorNum:FilterFrameText;
      
      private var _accumulateExp:FilterFrameText;
      
      private var _accumulateExpNum:FilterFrameText;
      
      private var _buySingleGoodsView:BuySingleGoodsView;
      
      private var _isDoubleAward:Boolean = true;
      
      private var _cleanOutContainer:Sprite;
      
      private var _startContainer:Sprite;
      
      private var _serverDoubleIcon:Bitmap;
      
      private var _clickDate:Number = 0;
      
      public function LabyrinthFrame()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         var _loc1_:AlertInfo = new AlertInfo(LanguageMgr.GetTranslation("ddt.labyrinth.LabyrinthFrame.title"));
         _loc1_.moveEnable = false;
         info = _loc1_;
         _warriorBtn = ComponentFactory.Instance.creatComponentByStylename("labyrinth.warriorBtn");
         addToContent(_warriorBtn);
         _nightmareBtn = ComponentFactory.Instance.creatComponentByStylename("labyrinth.nightmareBtn");
         addToContent(_nightmareBtn);
         _btnGroup = new SelectedButtonGroup();
         _btnGroup.addSelectItem(_warriorBtn);
         _btnGroup.addSelectItem(_nightmareBtn);
         _content = new Sprite();
         PositionUtils.setPos(_content,"ddt.labyrinth.contentPos");
         addToContent(_content);
         _bg = ComponentFactory.Instance.creatComponentByStylename("ddt.view.labyrinth.ScaleBG");
         _content.addChild(_bg);
         _rightBg = ComponentFactory.Instance.creatBitmap("ddt.labyrinth.rightBG");
         _content.addChild(_rightBg);
         _leftBg = ComponentFactory.Instance.creatComponentByStylename("ddt.labyrinth.leftBG");
         _leftBg.setFrame(1);
         _content.addChild(_leftBg);
         _startGameBtn = ComponentFactory.Instance.creatComponentByStylename("ddt.view.labyrinth.StartGmaeBtn");
         _content.addChild(_startGameBtn);
         _cleanOutBtn = ComponentFactory.Instance.creatComponentByStylename("ddt.view.LabyrinthFrame.CleanOutBtn");
         _content.addChild(_cleanOutBtn);
         _continueBtn = ComponentFactory.Instance.creatComponentByStylename("ddt.view.LabyrinthFrame.continueGameBtn");
         _content.addChild(_continueBtn);
         _continueCleanOutBtn = ComponentFactory.Instance.creatComponentByStylename("ddt.view.LabyrinthFrame.continueCleabOut");
         _content.addChild(_continueCleanOutBtn);
         _resetBtn = ComponentFactory.Instance.creatComponentByStylename("ddt.view.LabyrinthFrame.resetBtn");
         _content.addChild(_resetBtn);
         _cleanOutContainer = ComponentFactory.Instance.creatCustomObject("labyrinth.LabyrinthFrame.cleanOutContainer");
         _content.addChild(_cleanOutContainer);
         _startContainer = ComponentFactory.Instance.creatCustomObject("labyrinth.LabyrinthFrame.startContainer");
         _content.addChild(_startContainer);
         _rankingBtn = ComponentFactory.Instance.creatComponentByStylename("ddt.view.labyrinth.RankingBtn");
         _content.addChild(_rankingBtn);
         _shopBtn = ComponentFactory.Instance.creatComponentByStylename("ddt.view.labyrinth.shopBtn");
         _content.addChild(_shopBtn);
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("ddt.view.labyrinth.helpBtn");
         addToContent(_helpBtn);
         _myProgress = ComponentFactory.Instance.creatBitmap("ddt.labyrinth.myProgress");
         _content.addChild(_myProgress);
         _myProgressText = ComponentFactory.Instance.creatComponentByStylename("ddt.labyrinth.LabyrinthFrame.text1");
         _myProgressText.text = "0";
         _content.addChild(_myProgressText);
         _myRanking = ComponentFactory.Instance.creatBitmap("ddt.labyrinth.myRankingBG");
         _content.addChild(_myRanking);
         _myRankingText = ComponentFactory.Instance.creatComponentByStylename("ddt.labyrinth.LabyrinthFrame.text2");
         _myRankingText.text = "0";
         _content.addChild(_myRankingText);
         _todayNum = ComponentFactory.Instance.creatBitmap("ddt.labyrinth.todayNum");
         _startContainer.addChild(_todayNum);
         _todayNumText = ComponentFactory.Instance.creatComponentByStylename("ddt.labyrinth.LabyrinthFrame.text3");
         _todayNumText.text = "0";
         _startContainer.addChild(_todayNumText);
         _explain = ComponentFactory.Instance.creatComponentByStylename("ddt.labyrinth.LabyrinthFrame.text4");
         _explain.text = LanguageMgr.GetTranslation("ddt.labyrinth.LabyrinthFrame.text1");
         _content.addChild(_explain);
         _currentFloor = ComponentFactory.Instance.creatComponentByStylename("ddt.labyrinth.LabyrinthFrame.currentFloor");
         _currentFloor.text = LanguageMgr.GetTranslation("dt.labyrinth.LabyrinthFrame.text4");
         _cleanOutContainer.addChild(_currentFloor);
         _currentFloorNum = ComponentFactory.Instance.creatComponentByStylename("ddt.labyrinth.LabyrinthFrame.currentFloorNum");
         _cleanOutContainer.addChild(_currentFloorNum);
         _accumulateExp = ComponentFactory.Instance.creatComponentByStylename("ddt.labyrinth.LabyrinthFrame.accumulateExp");
         _accumulateExp.text = LanguageMgr.GetTranslation("dt.labyrinth.LabyrinthFrame.text5");
         _cleanOutContainer.addChild(_accumulateExp);
         _accumulateExpNum = ComponentFactory.Instance.creatComponentByStylename("ddt.labyrinth.LabyrinthFrame.accumulateExpNum");
         _cleanOutContainer.addChild(_accumulateExpNum);
         _doubleAward = ComponentFactory.Instance.creatComponentByStylename("ddt.labyrinth.LabyrinthFrame.CheckButton");
         _doubleAward.text = LanguageMgr.GetTranslation("ddt.labyrinth.LabyrinthFrame.text2");
         _startContainer.addChild(_doubleAward);
         _titleList = ComponentFactory.Instance.creat("ddt.labyrinth.BoxTextList",[2]);
         _content.addChild(_titleList);
         if(LabyrinthManager.Instance.model.serverMultiplyingPower)
         {
            _serverDoubleIcon = ComponentFactory.Instance.creatBitmap("ddt.ddtcore.doubleAwardIcon");
            PositionUtils.setPos(_serverDoubleIcon,"ddt.labyrinth.doubleAwardIconPos");
            _content.addChild(_serverDoubleIcon);
         }
         creatBox();
         if(!PlayerManager.Instance.Self.IsWeakGuildFinish(136))
         {
            NewHandContainer.Instance.showGuideCover("circle",[765,485,40]);
            NewHandContainer.Instance.showArrow(148,0,new Point(770,547),"","",LayerManager.Instance.getLayerByType(2));
            _doubleAward.selected = false;
         }
         else
         {
            _doubleAward.selected = true;
         }
         doubleChange();
         initEvent();
         btnState = true;
         SocketManager.Instance.out.labyrinthRequestUpdate(0);
         _btnGroup.selectIndex = 0;
      }
      
      private function initEvent() : void
      {
         _startGameBtn.addEventListener("click",__onBtnClick);
         _rankingBtn.addEventListener("click",__onBtnClick);
         _shopBtn.addEventListener("click",__onBtnClick);
         _continueBtn.addEventListener("click",__onBtnClick);
         _cleanOutBtn.addEventListener("click",__onBtnClick);
         _continueCleanOutBtn.addEventListener("click",__onBtnClick);
         _resetBtn.addEventListener("click",__onBtnClick);
         _doubleAward.addEventListener("click",__onBtnClick);
         LabyrinthManager.Instance.addEventListener("updateInfo",__updateInfo);
         _btnGroup.addEventListener("change",__changeHandler);
         _helpBtn.addEventListener("click",__helpClick);
      }
      
      private function removeEvent() : void
      {
         _startGameBtn.removeEventListener("click",__onBtnClick);
         _rankingBtn.removeEventListener("click",__onBtnClick);
         _shopBtn.removeEventListener("click",__onBtnClick);
         _continueBtn.removeEventListener("click",__onBtnClick);
         _cleanOutBtn.removeEventListener("click",__onBtnClick);
         _continueCleanOutBtn.removeEventListener("click",__onBtnClick);
         _resetBtn.removeEventListener("click",__onBtnClick);
         _doubleAward.removeEventListener("click",__onBtnClick);
         LabyrinthManager.Instance.removeEventListener("updateInfo",__updateInfo);
         _btnGroup.removeEventListener("change",__changeHandler);
         _helpBtn.removeEventListener("click",__helpClick);
      }
      
      private function creatBox() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         _loc2_ = 0;
         while(_loc2_ < 10)
         {
            _loc1_ = new LabyrinthBoxIcon(_loc2_ + 1);
            _titleList.addChild(_loc1_);
            _loc2_++;
         }
      }
      
      protected function __updateInfo(param1:Event) : void
      {
         _myProgressText.text = LabyrinthManager.Instance.model.myProgress.toString();
         _myRankingText.text = LabyrinthManager.Instance.model.myRanking.toString();
         _todayNumText.text = !!LabyrinthManager.Instance.model.completeChallenge?"1/1":"0/1";
         _currentFloorNum.text = LabyrinthManager.Instance.model.currentFloor.toString();
         _accumulateExpNum.text = LabyrinthManager.Instance.model.accumulateExp.toString();
         if(LabyrinthManager.Instance.model.serverMultiplyingPower)
         {
            _serverDoubleIcon = ComponentFactory.Instance.creatBitmap("ddt.ddtcore.doubleAwardIcon");
            PositionUtils.setPos(_serverDoubleIcon,"ddt.labyrinth.doubleAwardIconPos");
            _content.addChild(_serverDoubleIcon);
         }
         updataState();
      }
      
      private function updataState() : void
      {
         var _loc1_:LabyrinthModel = LabyrinthManager.Instance.model;
         _isDoubleAward = _loc1_.isDoubleAward;
         _doubleAward.selected = _isDoubleAward;
         if(!_loc1_.isInGame && !_loc1_.isCleanOut)
         {
            btnState = true;
         }
         else
         {
            btnState = false;
         }
         if(_loc1_.currentFloor == _loc1_.myProgress + 1)
         {
            var _loc2_:Boolean = false;
            _continueCleanOutBtn.enable = _loc2_;
            _cleanOutBtn.enable = _loc2_;
         }
         else if(_loc1_.currentFloor >= LabyrinthManager.Instance.model.getMaxLevel())
         {
            _loc2_ = false;
            _continueCleanOutBtn.enable = _loc2_;
            _cleanOutBtn.enable = _loc2_;
         }
         else
         {
            _loc2_ = true;
            _continueCleanOutBtn.enable = _loc2_;
            _cleanOutBtn.enable = _loc2_;
         }
      }
      
      protected function openShop() : void
      {
         var _loc2_:* = null;
         var _loc1_:* = null;
         if(isNightmare())
         {
            _loc2_ = ComponentFactory.Instance.creatCustomObject("labyrinth.view.labyrinthNightmareShopFrame");
            _loc2_.addEventListener("response",__frameEvent);
            _loc2_.show();
         }
         else
         {
            _loc1_ = ComponentFactory.Instance.creatCustomObject("labyrinth.view.labyrinthShopFrame");
            _loc1_.addEventListener("response",__frameEvent);
            _loc1_.show();
         }
      }
      
      protected function openRanking() : void
      {
         var _loc1_:RankingListFrame = ComponentFactory.Instance.creatCustomObject("labyrinth.rankingListFrame",[_btnGroup.selectIndex]);
         _loc1_.addEventListener("response",__frameEvent);
         _loc1_.show();
      }
      
      protected function __frameEvent(param1:FrameEvent) : void
      {
         SoundManager.instance.playButtonSound();
         var _loc2_:Disposeable = param1.target as Disposeable;
         _loc2_.dispose();
         _loc2_ = null;
      }
      
      protected function set btnState(param1:Boolean) : void
      {
         _startGameBtn.visible = param1;
         _cleanOutBtn.visible = param1;
         _continueBtn.visible = !param1;
         _continueCleanOutBtn.visible = !param1;
         _resetBtn.visible = !param1;
         _startContainer.visible = param1;
         _cleanOutContainer.visible = !param1;
      }
      
      protected function startGame() : void
      {
         CheckWeaponManager.instance.setFunction(this,startGame);
         if(CheckWeaponManager.instance.isNoWeapon())
         {
            CheckWeaponManager.instance.showAlert();
            return;
         }
         if(isNightmare())
         {
            if(PlayerManager.Instance.Self.getBag(1).getItemByTemplateId(11178) == null && _doubleAward.selected)
            {
               buy();
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.labyrinth.LabyrinthFrame.warningIII"));
               return;
            }
         }
         else if(PlayerManager.Instance.Self.getBag(1).getItemByTemplateId(11916) == null && _doubleAward.selected)
         {
            buy();
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.labyrinth.LabyrinthFrame.warningII"));
            return;
         }
         if(_doubleAward.selected)
         {
            SocketManager.Instance.out.labyrinthDouble(LabyrinthManager.Instance.model.sType,_doubleAward.selected);
         }
         SocketManager.Instance.out.createUserGuide(15);
      }
      
      protected function continueGame() : void
      {
         CheckWeaponManager.instance.setFunction(this,continueGame);
         if(CheckWeaponManager.instance.isNoWeapon())
         {
            CheckWeaponManager.instance.showAlert();
            return;
         }
         SocketManager.Instance.out.createUserGuide(15);
      }
      
      private function openCleanOutFrame() : void
      {
         var _loc1_:LabyrinthModel = LabyrinthManager.Instance.model;
         if(!_loc1_.isCleanOut)
         {
            cleanOut();
         }
         else
         {
            continueCleanOut();
         }
      }
      
      protected function cleanOut() : void
      {
         var _loc1_:LabyrinthModel = LabyrinthManager.Instance.model;
         if(!LabyrinthManager.Instance.model.completeChallenge)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.labyrinth.CleanOutFrame.warningI"));
            return;
         }
         if(isNightmare())
         {
            if(PlayerManager.Instance.Self.getBag(1).getItemByTemplateId(11178) == null && _doubleAward.selected && !_loc1_.isInGame && !_loc1_.isCleanOut)
            {
               buy();
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.labyrinth.LabyrinthFrame.warningIII"));
               return;
            }
         }
         else if(PlayerManager.Instance.Self.getBag(1).getItemByTemplateId(11916) == null && _doubleAward.selected && !_loc1_.isInGame && !_loc1_.isCleanOut)
         {
            buy();
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.labyrinth.LabyrinthFrame.warningII"));
            return;
         }
         var _loc2_:CleanOutFrame = ComponentFactory.Instance.creatCustomObject("labyrinth.view.cleanOutFrame");
         _loc2_.addEventListener("response",__frameEvent);
         _loc2_.show();
      }
      
      protected function continueCleanOut() : void
      {
         if(!LabyrinthManager.Instance.model.completeChallenge)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.labyrinth.CleanOutFrame.warningI"));
            return;
         }
         var _loc1_:CleanOutFrame = ComponentFactory.Instance.creatCustomObject("labyrinth.view.cleanOutFrame");
         _loc1_.continueCleanOut();
         _loc1_.addEventListener("response",__frameEvent);
         _loc1_.show();
      }
      
      protected function doubleChange() : void
      {
         LabyrinthManager.Instance.model.useDoubleAward(_doubleAward.selected);
      }
      
      private function buy() : void
      {
         _buySingleGoodsView = new BuySingleGoodsView(-1);
         LayerManager.Instance.addToLayer(_buySingleGoodsView,3,true,1);
         if(isNightmare())
         {
            _buySingleGoodsView.goodsID = 1117801;
         }
         else
         {
            _buySingleGoodsView.goodsID = 1191601;
         }
      }
      
      protected function reset() : void
      {
         var _loc1_:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("dt.labyrinth.LabyrinthFrame.text6"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,false,false,2);
         _loc1_.addEventListener("response",__onAlertResponse);
      }
      
      protected function __onAlertResponse(param1:FrameEvent) : void
      {
         param1.currentTarget.removeEventListener("response",__onAlertResponse);
         ObjectUtils.disposeObject(param1.currentTarget);
         if(param1.responseCode == 3 || param1.responseCode == 2)
         {
            SocketManager.Instance.out.labyrinthReset(LabyrinthManager.Instance.model.sType);
         }
      }
      
      protected function __onBtnClick(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         BuriedManager.Instance.isOpening = false;
         var _loc2_:* = param1.target;
         if(_startGameBtn !== _loc2_)
         {
            if(_continueBtn !== _loc2_)
            {
               if(_shopBtn !== _loc2_)
               {
                  if(_rankingBtn !== _loc2_)
                  {
                     if(_resetBtn !== _loc2_)
                     {
                        if(_continueCleanOutBtn !== _loc2_)
                        {
                           if(_cleanOutBtn !== _loc2_)
                           {
                              if(_doubleAward === _loc2_)
                              {
                                 doubleChange();
                              }
                           }
                        }
                        openCleanOutFrame();
                     }
                     else
                     {
                        reset();
                     }
                  }
                  else
                  {
                     openRanking();
                  }
               }
               else
               {
                  openShop();
               }
            }
            else if(new Date().time - _clickDate > 1000)
            {
               _clickDate = new Date().time;
               continueGame();
            }
         }
         else
         {
            if(!PlayerManager.Instance.Self.IsWeakGuildFinish(137))
            {
               if(PlayerManager.Instance.Self.Grade >= 30)
               {
                  SocketManager.Instance.out.syncWeakStep(137);
                  NewHandContainer.Instance.hideGuideCover();
                  NewHandContainer.Instance.clearArrowByID(148);
               }
            }
            if(new Date().time - _clickDate > 1000)
            {
               _clickDate = new Date().time;
               startGame();
            }
         }
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,2);
      }
      
      private function __changeHandler(param1:Event) : void
      {
         SocketManager.Instance.out.labyrinthRequestUpdate(_btnGroup.selectIndex);
         switch(int(_btnGroup.selectIndex))
         {
            case 0:
               _leftBg.setFrame(1);
               _explain.text = LanguageMgr.GetTranslation("ddt.labyrinth.LabyrinthFrame.text1");
               _doubleAward.text = LanguageMgr.GetTranslation("ddt.labyrinth.LabyrinthFrame.text2");
               break;
            case 1:
               _leftBg.setFrame(2);
               _explain.text = LanguageMgr.GetTranslation("ddt.labyrinth.LabyrinthFrame.nightmareText1");
               _doubleAward.text = LanguageMgr.GetTranslation("ddt.labyrinth.LabyrinthFrame.nightmareText2");
         }
      }
      
      private function isNightmare() : Boolean
      {
         if(_btnGroup.selectIndex == 1)
         {
            return true;
         }
         return false;
      }
      
      private function __helpClick(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         if(isNightmare())
         {
            HelpFrameUtils.Instance.simpleHelpFrame(LanguageMgr.GetTranslation("store.view.HelpButtonText"),"ddt.labyrinth.LabyrinthFrame.help2",410,490,false);
         }
         else
         {
            HelpFrameUtils.Instance.simpleHelpFrame(LanguageMgr.GetTranslation("store.view.HelpButtonText"),"ddt.labyrinth.LabyrinthFrame.help",410,490,false);
         }
      }
      
      override public function dispose() : void
      {
         NewHandContainer.Instance.hideGuideCover();
         NewHandContainer.Instance.clearArrowByID(148);
         super.dispose();
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_startGameBtn);
         _startGameBtn = null;
         ObjectUtils.disposeObject(_rankingBtn);
         _rankingBtn = null;
         ObjectUtils.disposeObject(_shopBtn);
         _shopBtn = null;
         ObjectUtils.disposeObject(_rightBg);
         _rightBg = null;
         ObjectUtils.disposeObject(_leftBg);
         _leftBg = null;
         ObjectUtils.disposeObject(_shopBtn);
         _shopBtn = null;
         ObjectUtils.disposeObject(_titleList);
         _titleList = null;
         ObjectUtils.disposeObject(_doubleAward);
         _doubleAward = null;
         ObjectUtils.disposeObject(_todayNum);
         _todayNum = null;
         ObjectUtils.disposeObject(_todayNumText);
         _todayNumText = null;
         ObjectUtils.disposeObject(_explain);
         _explain = null;
         ObjectUtils.disposeObject(_explainII);
         _explainII = null;
         ObjectUtils.disposeObject(_helpBtn);
         _helpBtn = null;
         ObjectUtils.disposeObject(_myRanking);
         _myRanking = null;
         ObjectUtils.disposeObject(_myRankingText);
         _myRankingText = null;
         ObjectUtils.disposeObject(_myProgress);
         _myProgress = null;
         ObjectUtils.disposeObject(_myProgressText);
         _myProgressText = null;
         ObjectUtils.disposeObject(_resetBtn);
         _resetBtn = null;
         ObjectUtils.disposeObject(_continueCleanOutBtn);
         _continueCleanOutBtn = null;
         ObjectUtils.disposeObject(_continueBtn);
         _continueBtn = null;
         ObjectUtils.disposeObject(_currentFloor);
         _currentFloor = null;
         ObjectUtils.disposeObject(_currentFloorNum);
         _currentFloorNum = null;
         ObjectUtils.disposeObject(_accumulateExp);
         _accumulateExp = null;
         ObjectUtils.disposeObject(_accumulateExpNum);
         _accumulateExpNum = null;
         ObjectUtils.disposeObject(_cleanOutContainer);
         _cleanOutContainer = null;
         ObjectUtils.disposeObject(_startContainer);
         _startContainer = null;
         ObjectUtils.disposeObject(_buySingleGoodsView);
         _buySingleGoodsView = null;
         ObjectUtils.disposeObject(_serverDoubleIcon);
         _serverDoubleIcon = null;
         ObjectUtils.disposeObject(_content);
         _content = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
