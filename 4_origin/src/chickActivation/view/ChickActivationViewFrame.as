package chickActivation.view
{
   import bagAndInfo.cell.CellFactory;
   import baglocked.BaglockedManager;
   import battleGroud.BattleGroudControl;
   import chickActivation.ChickActivationManager;
   import chickActivation.data.ChickActivationInfo;
   import chickActivation.event.ChickActivationEvent;
   import chickActivation.model.ChickActivationModel;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedTextButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.vo.AlertInfo;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ShopItemInfo;
   import ddt.manager.DropGoodsManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.ShopManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.TimeManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   import shop.view.ShopPlayerCell;
   
   public class ChickActivationViewFrame extends Frame
   {
       
      
      private var _mainBg:Bitmap;
      
      private var _mainTitle:Bitmap;
      
      private var _helpTitle:Bitmap;
      
      private var _helpPanel:ScrollPanel;
      
      private var _helpTxt:FilterFrameText;
      
      private var _remainingTimeTxt:FilterFrameText;
      
      private var _group:SelectedButtonGroup;
      
      private var _selectBtn1:SelectedTextButton;
      
      private var _selectBtn2:SelectedTextButton;
      
      private var _groupTwo:SelectedButtonGroup;
      
      private var _selectEveryDay:SelectedButton;
      
      private var _selectWeekly:SelectedButton;
      
      private var _selectAfterThreeDays:SelectedButton;
      
      private var _selectLevelPacks:SelectedButton;
      
      private var _promptMovies:Array;
      
      private var _priceBitmap:Bitmap;
      
      private var _priceView:ChickActivationCoinsView;
      
      private var _moneyIcon:Bitmap;
      
      private var _lineBitmap1:Bitmap;
      
      private var _inputBg:Bitmap;
      
      private var _inputTxt:FilterFrameText;
      
      private var _activationBtn:BaseButton;
      
      private var _lineBitmap2:Bitmap;
      
      private var _receiveBtn:BaseButton;
      
      private var _levelPacks:ChickActivationLevelPacks;
      
      private var _ativationItems:ChickActivationItems;
      
      private var _clickRate:Number = 0;
      
      private var CHICKACTIVATION_CARDID:int = 201316;
      
      private var buyItemInfo:ShopItemInfo;
      
      public function ChickActivationViewFrame()
      {
         super();
         initView();
         updateView();
         tabHandler();
         initEvent();
      }
      
      private function initView() : void
      {
         var _loc1_:int = 0;
         var _loc2_:* = null;
         _mainBg = ComponentFactory.Instance.creatBitmap("assets.chickActivation.mainBg");
         addToContent(_mainBg);
         _mainTitle = ComponentFactory.Instance.creatBitmap("assets.chickActivation.mainTitle");
         addToContent(_mainTitle);
         _helpTitle = ComponentFactory.Instance.creatBitmap("assets.chickActivation.helpTitle");
         addToContent(_helpTitle);
         _helpPanel = ComponentFactory.Instance.creatComponentByStylename("chickActivationFrame.helpScroll");
         addToContent(_helpPanel);
         _helpTxt = ComponentFactory.Instance.creatComponentByStylename("chickActivationFrame.helpTxt");
         _helpTxt.text = LanguageMgr.GetTranslation("tank.chickActivationFrame.helpTxtMsg");
         _helpPanel.setView(_helpTxt);
         _helpPanel.invalidateViewport();
         _remainingTimeTxt = ComponentFactory.Instance.creatComponentByStylename("chickActivationFrame.remainingTimeTxt");
         _remainingTimeTxt.htmlText = LanguageMgr.GetTranslation("tank.chickActivationFrame.remainingTimeTxtMsg",0);
         addToContent(_remainingTimeTxt);
         _selectBtn1 = ComponentFactory.Instance.creatComponentByStylename("chickActivationFrame.selectBtn1");
         _selectBtn1.text = LanguageMgr.GetTranslation("tank.chickActivationFrame.selectBtn1Txt");
         addToContent(_selectBtn1);
         _selectBtn2 = ComponentFactory.Instance.creatComponentByStylename("chickActivationFrame.selectBtn2");
         _selectBtn2.text = LanguageMgr.GetTranslation("tank.chickActivationFrame.selectBtn2Txt");
         addToContent(_selectBtn2);
         _group = new SelectedButtonGroup();
         _group.addSelectItem(_selectBtn1);
         _group.addSelectItem(_selectBtn2);
         _group.selectIndex = 0;
         _selectEveryDay = ComponentFactory.Instance.creatComponentByStylename("chickActivationFrame.selectEveryDay");
         addToContent(_selectEveryDay);
         _selectWeekly = ComponentFactory.Instance.creatComponentByStylename("chickActivationFrame.selectWeekly");
         addToContent(_selectWeekly);
         _selectAfterThreeDays = ComponentFactory.Instance.creatComponentByStylename("chickActivationFrame.selectAfterThreeDays");
         addToContent(_selectAfterThreeDays);
         _selectLevelPacks = ComponentFactory.Instance.creatComponentByStylename("chickActivationFrame.selectLevelPacks");
         addToContent(_selectLevelPacks);
         _groupTwo = new SelectedButtonGroup();
         _groupTwo.addSelectItem(_selectEveryDay);
         _groupTwo.addSelectItem(_selectWeekly);
         _groupTwo.addSelectItem(_selectAfterThreeDays);
         _groupTwo.addSelectItem(_selectLevelPacks);
         _groupTwo.selectIndex = 0;
         _promptMovies = [];
         _loc1_ = 0;
         while(_loc1_ < 4)
         {
            _loc2_ = ClassUtils.CreatInstance("assets.chickActivation.promptMovie");
            PositionUtils.setPos(_loc2_,"chickActivation.promptMoviePos" + _loc1_);
            _loc2_.mouseChildren = false;
            _loc2_.mouseEnabled = false;
            _loc2_.visible = false;
            addToContent(_loc2_);
            _promptMovies.push(_loc2_);
            _loc1_++;
         }
         _priceBitmap = ComponentFactory.Instance.creatBitmap("assets.chickActivation.priceBitmap");
         addToContent(_priceBitmap);
         _priceView = ComponentFactory.Instance.creatCustomObject("chickActivation.ChickActivationCoinsView");
         _priceView.count = 0;
         addToContent(_priceView);
         _moneyIcon = ComponentFactory.Instance.creatBitmap("assets.chickActivation.moneyIcon");
         addToContent(_moneyIcon);
         _lineBitmap1 = ComponentFactory.Instance.creatBitmap("assets.chickActivation.lineBitmap");
         PositionUtils.setPos(_lineBitmap1,"chickActivation.lineBitmapPos1");
         addToContent(_lineBitmap1);
         _inputBg = ComponentFactory.Instance.creatBitmap("assets.chickActivation.inputBg");
         addToContent(_inputBg);
         _inputTxt = ComponentFactory.Instance.creatComponentByStylename("chickActivation.inputTxt");
         _inputTxt.text = LanguageMgr.GetTranslation("tank.chickActivation.inputTxtMsg");
         addToContent(_inputTxt);
         _activationBtn = ComponentFactory.Instance.creatComponentByStylename("chickActivation.activationBtn");
         addToContent(_activationBtn);
         _lineBitmap2 = ComponentFactory.Instance.creatBitmap("assets.chickActivation.lineBitmap");
         PositionUtils.setPos(_lineBitmap2,"chickActivation.lineBitmapPos2");
         addToContent(_lineBitmap2);
         _receiveBtn = ComponentFactory.Instance.creatComponentByStylename("chickActivation.receiveBtn");
         addToContent(_receiveBtn);
         _ativationItems = ComponentFactory.Instance.creatCustomObject("chickActivation.ativationItems");
         addToContent(_ativationItems);
         _levelPacks = ComponentFactory.Instance.creatCustomObject("chickActivation.ChickActivationLevelPacks");
         _levelPacks.visible = false;
         addToContent(_levelPacks);
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__responseHandler);
         _group.addEventListener("change",__selectBtnHandler);
         _groupTwo.addEventListener("change",__selectBtnTwoHandler);
         _inputTxt.addEventListener("click",__inputTxtHandler);
         _activationBtn.addEventListener("click",__activationBtnHandler);
         _receiveBtn.addEventListener("click",__receiveBtnHandler);
         _levelPacks.addEventListener("clickLevelPacks",__clickLevelPacksHandler);
         ChickActivationManager.instance.model.addEventListener("updateData",__updateDataHandler);
         ChickActivationManager.instance.model.addEventListener("getReward",__getRewardHandler);
      }
      
      private function __updateDataHandler(param1:ChickActivationEvent) : void
      {
         updateView();
      }
      
      private function updateView() : void
      {
         var _loc1_:ChickActivationModel = ChickActivationManager.instance.model;
         var _loc2_:int = ChickActivationManager.instance.model.getRemainingDay();
         if(PlayerManager.Instance.Self.Grade > 15 && _loc1_.keyOpenedType != 1 || _loc1_.keyOpenedType == 1 && _loc2_ <= 0)
         {
            _selectBtn1.enable = false;
            _group.selectIndex = 1;
         }
         _remainingTimeTxt.htmlText = LanguageMgr.GetTranslation("tank.chickActivationFrame.remainingTimeTxtMsg",_loc2_);
         updateShine();
         updateGetBtn();
         _levelPacks.update();
         showBottomActivationButton();
      }
      
      private function updateShine() : void
      {
         var _loc1_:int = 0;
         var _loc12_:Boolean = false;
         var _loc14_:int = 0;
         var _loc6_:int = 0;
         var _loc10_:Boolean = false;
         var _loc11_:Boolean = false;
         var _loc7_:int = 0;
         var _loc15_:* = 0;
         var _loc13_:int = 0;
         var _loc8_:int = 0;
         var _loc5_:int = 0;
         var _loc4_:Boolean = false;
         var _loc2_:int = 0;
         var _loc3_:Array = ChickActivationManager.instance.model.gainArr;
         var _loc9_:int = ChickActivationManager.instance.model.getRemainingDay();
         if(ChickActivationManager.instance.model.isKeyOpened > 0 && ChickActivationManager.instance.model.keyOpenedType == _group.selectIndex + 1 && _loc9_ > 0)
         {
            if(_loc3_ && _loc3_.length > 0)
            {
               _loc14_ = TimeManager.Instance.Now().day;
               if(_loc14_ == 0)
               {
                  _loc14_ = 7;
               }
               _loc1_ = _loc14_ - 1;
               _loc6_ = _loc3_[_loc1_];
               if(_loc6_ <= 0)
               {
                  _loc10_ = true;
               }
               MovieClip(_promptMovies[0]).visible = _loc10_;
               MovieClip(_promptMovies[1]).visible = _loc3_[10] <= 0;
               if(_loc14_ == 5)
               {
                  _loc1_ = 7;
               }
               else if(_loc14_ == 6)
               {
                  _loc1_ = 8;
               }
               else if(_loc14_ == 7)
               {
                  _loc1_ = 9;
               }
               if(_loc1_ > 6)
               {
                  _loc7_ = _loc3_[_loc1_];
                  if(_loc7_ <= 0)
                  {
                     _loc11_ = true;
                  }
               }
               MovieClip(_promptMovies[2]).visible = _loc11_;
               if(_group.selectIndex == 0)
               {
                  _loc15_ = -1;
                  _loc13_ = PlayerManager.Instance.Self.Grade;
                  _loc8_ = 0;
                  while(_loc8_ < _levelPacks.packsLevelArr.length)
                  {
                     if(_levelPacks.packsLevelArr[_loc8_].level <= _loc13_)
                     {
                        _loc15_ = _loc8_;
                     }
                     _loc8_++;
                  }
                  if(_loc15_ == -1)
                  {
                     MovieClip(_promptMovies[3]).visible = false;
                  }
                  _loc5_ = 0;
                  while(_loc5_ <= _loc15_)
                  {
                     _loc4_ = ChickActivationManager.instance.model.getGainLevel(_loc5_ + 1);
                     if(!_loc4_)
                     {
                        _loc12_ = true;
                        break;
                     }
                     _loc5_++;
                  }
                  MovieClip(_promptMovies[3]).visible = _loc12_;
               }
               else
               {
                  MovieClip(_promptMovies[3]).visible = false;
               }
            }
         }
         else
         {
            _loc2_ = 0;
            while(_loc2_ < _promptMovies.length)
            {
               MovieClip(_promptMovies[_loc2_]).visible = false;
               _loc2_++;
            }
         }
      }
      
      private function updateGetBtn() : void
      {
         var _loc3_:* = null;
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         var _loc1_:int = ChickActivationManager.instance.model.getRemainingDay();
         if(ChickActivationManager.instance.model.isKeyOpened > 0 && ChickActivationManager.instance.model.keyOpenedType == _group.selectIndex + 1 && _loc1_ > 0)
         {
            _loc3_ = ChickActivationManager.instance.model.gainArr;
            _loc2_ = getNowGainArrIndex();
            if(_loc3_.hasOwnProperty(_loc2_))
            {
               _loc4_ = _loc3_[_loc2_];
               if(_loc4_ > 0)
               {
                  _receiveBtn.enable = false;
               }
               else
               {
                  _receiveBtn.enable = true;
               }
            }
            else
            {
               _receiveBtn.enable = false;
            }
         }
         else
         {
            _receiveBtn.enable = false;
         }
      }
      
      private function getNowGainArrIndex() : int
      {
         var _loc2_:int = TimeManager.Instance.Now().day;
         var _loc1_:int = -1;
         if(_loc2_ == 0)
         {
            _loc2_ = 7;
         }
         if(_groupTwo.selectIndex == 0)
         {
            _loc1_ = _loc2_ - 1;
         }
         else if(_groupTwo.selectIndex == 2)
         {
            if(_loc2_ == 5)
            {
               _loc1_ = 7;
            }
            else if(_loc2_ == 6)
            {
               _loc1_ = 8;
            }
            else if(_loc2_ == 7)
            {
               _loc1_ = 9;
            }
         }
         else if(_groupTwo.selectIndex == 1)
         {
            _loc1_ = 10;
         }
         return _loc1_;
      }
      
      private function __getRewardHandler(param1:ChickActivationEvent) : void
      {
         var _loc5_:int = param1.resultData as int;
         if(_loc5_ == 11)
         {
            return;
         }
         var _loc3_:String = "" + (ChickActivationManager.instance.model.keyOpenedType - 1);
         var _loc2_:int = ChickActivationManager.instance.model.keyOpenedType;
         if(_loc5_ < 7)
         {
            _loc3_ = _loc3_ + ",0,1";
         }
         else if(_loc5_ < 10)
         {
            _loc3_ = _loc3_ + ",2,5";
         }
         else if(_loc5_ < 11)
         {
            _loc3_ = _loc3_ + ",1";
         }
         var _loc6_:int = ChickActivationManager.instance.model.qualityDic[_loc3_];
         var _loc4_:Array = ChickActivationManager.instance.model.itemInfoList[_loc6_];
         if(_loc4_)
         {
            playDropGoodsMovie(_loc4_);
         }
      }
      
      private function __selectBtnHandler(param1:Event) : void
      {
         SoundManager.instance.play("008");
         _groupTwo.selectIndex = 0;
         tabHandler();
         updateShine();
         showBottomActivationButton();
      }
      
      private function __selectBtnTwoHandler(param1:Event) : void
      {
         SoundManager.instance.play("008");
         tabHandler();
      }
      
      private function tabHandler() : void
      {
         _ativationItems.visible = false;
         _levelPacks.visible = false;
         showBottomPriceAndButton(true);
         updateGetBtn();
         _selectLevelPacks.visible = _group.selectIndex == 0;
         var _loc1_:int = _groupTwo.selectIndex;
         if(_loc1_ == 0)
         {
            findDataUpdateActivationItems();
            updatePriceView();
            _ativationItems.visible = true;
         }
         else if(_loc1_ == 1)
         {
            findDataUpdateActivationItems();
            updatePriceView();
            _ativationItems.visible = true;
         }
         else if(_loc1_ == 2)
         {
            findDataUpdateActivationItems();
            updatePriceView();
            _ativationItems.visible = true;
         }
         else if(_loc1_ == 3)
         {
            _levelPacks.update();
            _levelPacks.visible = true;
            updatePriceView();
         }
      }
      
      private function updatePriceView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         var _loc5_:int = 0;
         var _loc4_:* = null;
         var _loc3_:int = ChickActivationManager.instance.model.findQualityValue(getQualityKey());
         if(ChickActivationManager.instance.model.itemInfoList.hasOwnProperty(_loc3_))
         {
            _loc1_ = ChickActivationManager.instance.model.itemInfoList[_loc3_];
            _loc5_ = 0;
            while(_loc5_ < _loc1_.length)
            {
               _loc4_ = ChickActivationInfo(_loc1_[_loc5_]);
               _loc2_ = _loc2_ + _loc4_.Probability;
               _loc5_++;
            }
         }
         if(_priceView)
         {
            _priceView.count = _loc2_;
         }
      }
      
      private function findDataUpdateActivationItems() : void
      {
         var _loc2_:* = null;
         var _loc3_:Array = ChickActivationManager.instance.model.itemInfoList;
         var _loc1_:Dictionary = ChickActivationManager.instance.model.qualityDic;
         var _loc4_:int = ChickActivationManager.instance.model.findQualityValue(getQualityKey());
         if(_loc3_.hasOwnProperty(_loc4_))
         {
            _loc2_ = _loc3_[_loc4_];
            _ativationItems.update(_loc2_);
         }
         else
         {
            _ativationItems.update(null);
         }
      }
      
      private function showBottomPriceAndButton(param1:Boolean) : void
      {
         _priceBitmap.visible = param1;
         _moneyIcon.visible = param1;
         _lineBitmap1.visible = param1;
         _priceView.visible = param1;
         _lineBitmap2.visible = param1;
         _receiveBtn.visible = param1;
      }
      
      private function showBottomActivationButton() : void
      {
         var _loc3_:Boolean = false;
         var _loc2_:ChickActivationModel = ChickActivationManager.instance.model;
         var _loc1_:int = ChickActivationManager.instance.model.getRemainingDay();
         if(_group.selectIndex == 0)
         {
            if(_loc2_.keyOpenedType == 0 && PlayerManager.Instance.Self.Grade <= 15 || _loc2_.keyOpenedType == 1 && _loc1_ <= 0)
            {
               _loc3_ = true;
            }
            else
            {
               _loc3_ = false;
            }
         }
         else if(_group.selectIndex == 1)
         {
            if(_loc2_.keyOpenedType == 0 && PlayerManager.Instance.Self.Grade > 15 || _loc2_.keyOpenedType == 2 && _loc1_ <= 0)
            {
               _loc3_ = true;
            }
            else
            {
               _loc3_ = false;
            }
         }
         _inputBg.visible = _loc3_;
         _inputTxt.visible = _loc3_;
         _activationBtn.visible = _loc3_;
      }
      
      private function __responseHandler(param1:FrameEvent) : void
      {
         if(param1.responseCode == 0 || param1.responseCode == 1)
         {
            SoundManager.instance.play("008");
            dispose();
         }
      }
      
      private function __inputTxtHandler(param1:MouseEvent) : void
      {
         if(_inputTxt.text == LanguageMgr.GetTranslation("tank.chickActivation.inputTxtMsg"))
         {
            _inputTxt.text = "";
         }
      }
      
      private function __activationBtnHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = _inputTxt.text;
         if(_inputTxt.text == "" || _inputTxt.text == LanguageMgr.GetTranslation("tank.chickActivation.inputTxtMsg"))
         {
            showBuyFrame();
            return;
         }
         if(_inputTxt.text.length != 14)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.chickActivation.inputTxtMsg2"));
            return;
         }
         if(clickRateGo())
         {
            return;
         }
         SocketManager.Instance.out.sendChickActivationOpenKey(_loc2_);
      }
      
      private function showBuyFrame() : void
      {
         var _loc5_:* = null;
         var _loc4_:* = null;
         var _loc2_:* = null;
         var _loc3_:* = null;
         var _loc1_:* = null;
         buyItemInfo = ShopManager.Instance.getMoneyShopItemByTemplateID(CHICKACTIVATION_CARDID);
         if(buyItemInfo)
         {
            _loc5_ = buyItemInfo.getItemPrice(1).toString();
            _loc4_ = ComponentFactory.Instance.creatComponentByStylename("chickActivationFrame.buyChickActivationFrame");
            _loc4_.titleText = LanguageMgr.GetTranslation("tips");
            _loc2_ = new AlertInfo(LanguageMgr.GetTranslation("cancel"),LanguageMgr.GetTranslation("ok"));
            _loc4_.info = _loc2_;
            _loc3_ = ComponentFactory.Instance.creatComponentByStylename("chickActivationFrame.contentTxt");
            _loc3_.text = LanguageMgr.GetTranslation("tank.chickActivation.inputTxtMsg3",_loc5_);
            _loc4_.addToContent(_loc3_);
            _loc1_ = CellFactory.instance.createShopCartItemCell() as ShopPlayerCell;
            _loc1_.info = buyItemInfo.TemplateInfo;
            PositionUtils.setPos(_loc1_,"chickActivationFrame.ShopPlayerCellPos");
            _loc4_.addToContent(_loc1_);
            _loc4_.addEventListener("response",__buyFrameResponse);
            LayerManager.Instance.addToLayer(_loc4_,3,true,1);
         }
      }
      
      private function __buyFrameResponse(param1:FrameEvent) : void
      {
         var _loc2_:int = 0;
         SoundManager.instance.play("008");
         param1.currentTarget.removeEventListener("response",__buyFrameResponse);
         ObjectUtils.disposeAllChildren(param1.currentTarget as DisplayObjectContainer);
         ObjectUtils.disposeObject(param1.currentTarget);
         if(param1.responseCode == 2 || param1.responseCode == 3)
         {
            if(PlayerManager.Instance.Self.bagLocked)
            {
               BaglockedManager.Instance.show();
               return;
            }
            _loc2_ = buyItemInfo.getItemPrice(1).bothMoneyValue;
            if(PlayerManager.Instance.Self.Money < _loc2_)
            {
               LeavePageManager.showFillFrame();
               return;
            }
            SocketManager.Instance.out.sendBuyGoods([buyItemInfo.GoodsID],[1],[""],[0],[false],[""],1,null,[false]);
         }
      }
      
      public function clickRateGo() : Boolean
      {
         var _loc1_:Number = new Date().time;
         if(_loc1_ - _clickRate > 1000)
         {
            _clickRate = _loc1_;
            return false;
         }
         MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.chickActivation.clickRateMsg"));
         return true;
      }
      
      private function __receiveBtnHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         if(clickRateGo())
         {
            return;
         }
         if(ChickActivationManager.instance.model.isKeyOpened == 0)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.chickActivation.receiveBtnMsg"));
            return;
         }
         var _loc2_:int = getNowGainArrIndex() + 1;
         SocketManager.Instance.out.sendChickActivationGetAward(_loc2_,0);
      }
      
      private function playDropGoodsMovie(param1:Array) : void
      {
         var _loc6_:int = 0;
         var _loc5_:* = null;
         var _loc4_:Point = ComponentFactory.Instance.creatCustomObject("chickActivation.dropGoodsBeginPos");
         var _loc2_:Point = ComponentFactory.Instance.creatCustomObject("chickActivation.dropGoodsEndPos");
         var _loc3_:Array = [];
         _loc6_ = 0;
         while(_loc6_ < _ativationItems.arrData.length)
         {
            _loc5_ = ChickActivationManager.instance.model.getInventoryItemInfo(_ativationItems.arrData[_loc6_]);
            if(_loc5_)
            {
               _loc3_.push(_loc5_);
            }
            _loc6_++;
         }
         DropGoodsManager.play(_loc3_,_loc4_,_loc2_,true);
      }
      
      private function getQualityKey() : String
      {
         var _loc4_:int = 0;
         var _loc3_:int = _group.selectIndex;
         var _loc1_:int = _groupTwo.selectIndex;
         var _loc2_:String = _loc3_ + "," + _loc1_;
         if(_loc1_ == 0)
         {
            _loc4_ = 1;
            _loc2_ = _loc2_ + ("," + _loc4_);
         }
         else if(_loc1_ == 2)
         {
            _loc4_ = 5;
            _loc2_ = _loc2_ + ("," + _loc4_);
         }
         return _loc2_;
      }
      
      private function __clickLevelPacksHandler(param1:ChickActivationEvent) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         if(clickRateGo())
         {
            return;
         }
         var _loc5_:int = param1.resultData;
         var _loc2_:Array = ServerConfigManager.instance.chickenActiveKeyLvAwardNeedPrestige;
         if(_loc2_ && _loc2_.length > 0)
         {
            _loc3_ = _loc2_[_loc5_ - 1];
            _loc4_ = BattleGroudControl.Instance.orderdata.totalPrestige;
            if(_loc4_ < _loc3_)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.chickActivation.totalPrestigeMsg",_loc3_));
               return;
            }
         }
         SocketManager.Instance.out.sendChickActivationGetAward(12,_loc5_);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__responseHandler);
         _group.removeEventListener("change",__selectBtnHandler);
         _groupTwo.removeEventListener("change",__selectBtnTwoHandler);
         _inputTxt.removeEventListener("click",__inputTxtHandler);
         _activationBtn.removeEventListener("click",__activationBtnHandler);
         _receiveBtn.removeEventListener("click",__receiveBtnHandler);
         _levelPacks.removeEventListener("clickLevelPacks",__clickLevelPacksHandler);
         ChickActivationManager.instance.model.removeEventListener("updateData",__updateDataHandler);
         ChickActivationManager.instance.model.removeEventListener("getReward",__getRewardHandler);
      }
      
      override public function dispose() : void
      {
         var _loc1_:int = 0;
         super.dispose();
         removeEvent();
         ObjectUtils.disposeObject(_mainBg);
         _mainBg = null;
         ObjectUtils.disposeObject(_mainTitle);
         _mainTitle = null;
         ObjectUtils.disposeObject(_helpTitle);
         _helpTitle = null;
         ObjectUtils.disposeObject(_helpPanel);
         _helpPanel = null;
         ObjectUtils.disposeObject(_helpTxt);
         _helpTxt = null;
         ObjectUtils.disposeObject(_remainingTimeTxt);
         _remainingTimeTxt = null;
         ObjectUtils.disposeObject(_group);
         _group = null;
         ObjectUtils.disposeObject(_selectBtn1);
         _selectBtn1 = null;
         ObjectUtils.disposeObject(_selectBtn2);
         _selectBtn2 = null;
         ObjectUtils.disposeObject(_groupTwo);
         _groupTwo = null;
         ObjectUtils.disposeObject(_selectEveryDay);
         _selectEveryDay = null;
         ObjectUtils.disposeObject(_selectWeekly);
         _selectWeekly = null;
         ObjectUtils.disposeObject(_selectAfterThreeDays);
         _selectAfterThreeDays = null;
         ObjectUtils.disposeObject(_selectLevelPacks);
         _selectLevelPacks = null;
         ObjectUtils.disposeObject(_priceBitmap);
         _priceBitmap = null;
         ObjectUtils.disposeObject(_moneyIcon);
         _moneyIcon = null;
         ObjectUtils.disposeObject(_lineBitmap1);
         _lineBitmap1 = null;
         ObjectUtils.disposeObject(_inputBg);
         _inputBg = null;
         ObjectUtils.disposeObject(_inputTxt);
         _inputTxt = null;
         ObjectUtils.disposeObject(_activationBtn);
         _activationBtn = null;
         ObjectUtils.disposeObject(_lineBitmap2);
         _lineBitmap2 = null;
         ObjectUtils.disposeObject(_receiveBtn);
         _receiveBtn = null;
         ObjectUtils.disposeObject(_priceView);
         _priceView = null;
         ObjectUtils.disposeObject(_levelPacks);
         _levelPacks = null;
         if(_promptMovies)
         {
            _loc1_ = 0;
            while(_loc1_ < _promptMovies.length)
            {
               _promptMovies[_loc1_].stop();
               ObjectUtils.disposeObject(_promptMovies[_loc1_]);
               _loc1_++;
            }
            _promptMovies = null;
         }
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
