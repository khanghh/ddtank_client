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
         var k:int = 0;
         var promptMovie:* = null;
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
         for(k = 0; k < 4; )
         {
            promptMovie = ClassUtils.CreatInstance("assets.chickActivation.promptMovie");
            PositionUtils.setPos(promptMovie,"chickActivation.promptMoviePos" + k);
            promptMovie.mouseChildren = false;
            promptMovie.mouseEnabled = false;
            promptMovie.visible = false;
            addToContent(promptMovie);
            _promptMovies.push(promptMovie);
            k++;
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
      
      private function __updateDataHandler(evt:ChickActivationEvent) : void
      {
         updateView();
      }
      
      private function updateView() : void
      {
         var model:ChickActivationModel = ChickActivationManager.instance.model;
         var day:int = ChickActivationManager.instance.model.getRemainingDay();
         if(PlayerManager.Instance.Self.Grade > 15 && model.keyOpenedType != 1 || model.keyOpenedType == 1 && day <= 0)
         {
            _selectBtn1.enable = false;
            _group.selectIndex = 1;
         }
         _remainingTimeTxt.htmlText = LanguageMgr.GetTranslation("tank.chickActivationFrame.remainingTimeTxtMsg",day);
         updateShine();
         updateGetBtn();
         _levelPacks.update();
         showBottomActivationButton();
      }
      
      private function updateShine() : void
      {
         var tempIndex:int = 0;
         var temp3:Boolean = false;
         var day:int = 0;
         var value1:int = 0;
         var temp1:Boolean = false;
         var temp2:Boolean = false;
         var value2:int = 0;
         var levelIndex:* = 0;
         var grade:int = 0;
         var i:int = 0;
         var j:int = 0;
         var value3:Boolean = false;
         var a:int = 0;
         var gainArr:Array = ChickActivationManager.instance.model.gainArr;
         var remainingDay:int = ChickActivationManager.instance.model.getRemainingDay();
         if(ChickActivationManager.instance.model.isKeyOpened > 0 && ChickActivationManager.instance.model.keyOpenedType == _group.selectIndex + 1 && remainingDay > 0)
         {
            if(gainArr && gainArr.length > 0)
            {
               day = TimeManager.Instance.Now().day;
               if(day == 0)
               {
                  day = 7;
               }
               tempIndex = day - 1;
               value1 = gainArr[tempIndex];
               if(value1 <= 0)
               {
                  temp1 = true;
               }
               MovieClip(_promptMovies[0]).visible = temp1;
               MovieClip(_promptMovies[1]).visible = gainArr[10] <= 0;
               if(day == 5)
               {
                  tempIndex = 7;
               }
               else if(day == 6)
               {
                  tempIndex = 8;
               }
               else if(day == 7)
               {
                  tempIndex = 9;
               }
               if(tempIndex > 6)
               {
                  value2 = gainArr[tempIndex];
                  if(value2 <= 0)
                  {
                     temp2 = true;
                  }
               }
               MovieClip(_promptMovies[2]).visible = temp2;
               if(_group.selectIndex == 0)
               {
                  levelIndex = -1;
                  grade = PlayerManager.Instance.Self.Grade;
                  for(i = 0; i < _levelPacks.packsLevelArr.length; )
                  {
                     if(_levelPacks.packsLevelArr[i].level <= grade)
                     {
                        levelIndex = i;
                     }
                     i++;
                  }
                  if(levelIndex == -1)
                  {
                     MovieClip(_promptMovies[3]).visible = false;
                  }
                  j = 0;
                  while(j <= levelIndex)
                  {
                     value3 = ChickActivationManager.instance.model.getGainLevel(j + 1);
                     if(!value3)
                     {
                        temp3 = true;
                        break;
                     }
                     j++;
                  }
                  MovieClip(_promptMovies[3]).visible = temp3;
               }
               else
               {
                  MovieClip(_promptMovies[3]).visible = false;
               }
            }
         }
         else
         {
            a = 0;
            while(a < _promptMovies.length)
            {
               MovieClip(_promptMovies[a]).visible = false;
               a++;
            }
         }
      }
      
      private function updateGetBtn() : void
      {
         var gainArr:* = null;
         var tempIndex:int = 0;
         var temp:int = 0;
         var remainingDay:int = ChickActivationManager.instance.model.getRemainingDay();
         if(ChickActivationManager.instance.model.isKeyOpened > 0 && ChickActivationManager.instance.model.keyOpenedType == _group.selectIndex + 1 && remainingDay > 0)
         {
            gainArr = ChickActivationManager.instance.model.gainArr;
            tempIndex = getNowGainArrIndex();
            if(gainArr.hasOwnProperty(tempIndex))
            {
               temp = gainArr[tempIndex];
               if(temp > 0)
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
         var day:int = TimeManager.Instance.Now().day;
         var tempIndex:int = -1;
         if(day == 0)
         {
            day = 7;
         }
         if(_groupTwo.selectIndex == 0)
         {
            tempIndex = day - 1;
         }
         else if(_groupTwo.selectIndex == 2)
         {
            if(day == 5)
            {
               tempIndex = 7;
            }
            else if(day == 6)
            {
               tempIndex = 8;
            }
            else if(day == 7)
            {
               tempIndex = 9;
            }
         }
         else if(_groupTwo.selectIndex == 1)
         {
            tempIndex = 10;
         }
         return tempIndex;
      }
      
      private function __getRewardHandler(evt:ChickActivationEvent) : void
      {
         var value:int = evt.resultData as int;
         if(value == 11)
         {
            return;
         }
         var qualityKey:String = "" + (ChickActivationManager.instance.model.keyOpenedType - 1);
         var keyOpenedType:int = ChickActivationManager.instance.model.keyOpenedType;
         if(value < 7)
         {
            qualityKey = qualityKey + ",0,1";
         }
         else if(value < 10)
         {
            qualityKey = qualityKey + ",2,5";
         }
         else if(value < 11)
         {
            qualityKey = qualityKey + ",1";
         }
         var qualityValue:int = ChickActivationManager.instance.model.qualityDic[qualityKey];
         var arr:Array = ChickActivationManager.instance.model.itemInfoList[qualityValue];
         if(arr)
         {
            playDropGoodsMovie(arr);
         }
      }
      
      private function __selectBtnHandler(evt:Event) : void
      {
         SoundManager.instance.play("008");
         _groupTwo.selectIndex = 0;
         tabHandler();
         updateShine();
         showBottomActivationButton();
      }
      
      private function __selectBtnTwoHandler(evt:Event) : void
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
         var index:int = _groupTwo.selectIndex;
         if(index == 0)
         {
            findDataUpdateActivationItems();
            updatePriceView();
            _ativationItems.visible = true;
         }
         else if(index == 1)
         {
            findDataUpdateActivationItems();
            updatePriceView();
            _ativationItems.visible = true;
         }
         else if(index == 2)
         {
            findDataUpdateActivationItems();
            updatePriceView();
            _ativationItems.visible = true;
         }
         else if(index == 3)
         {
            _levelPacks.update();
            _levelPacks.visible = true;
            updatePriceView();
         }
      }
      
      private function updatePriceView() : void
      {
         var price:int = 0;
         var dataArr:* = null;
         var i:int = 0;
         var info:* = null;
         var qualityValue:int = ChickActivationManager.instance.model.findQualityValue(getQualityKey());
         if(ChickActivationManager.instance.model.itemInfoList.hasOwnProperty(qualityValue))
         {
            dataArr = ChickActivationManager.instance.model.itemInfoList[qualityValue];
            for(i = 0; i < dataArr.length; )
            {
               info = ChickActivationInfo(dataArr[i]);
               price = price + info.Probability;
               i++;
            }
         }
         if(_priceView)
         {
            _priceView.count = price;
         }
      }
      
      private function findDataUpdateActivationItems() : void
      {
         var dataArr:* = null;
         var itemInfoList:Array = ChickActivationManager.instance.model.itemInfoList;
         var qualityDic:Dictionary = ChickActivationManager.instance.model.qualityDic;
         var qualityValue:int = ChickActivationManager.instance.model.findQualityValue(getQualityKey());
         if(itemInfoList.hasOwnProperty(qualityValue))
         {
            dataArr = itemInfoList[qualityValue];
            _ativationItems.update(dataArr);
         }
         else
         {
            _ativationItems.update(null);
         }
      }
      
      private function showBottomPriceAndButton($isBool:Boolean) : void
      {
         _priceBitmap.visible = $isBool;
         _moneyIcon.visible = $isBool;
         _lineBitmap1.visible = $isBool;
         _priceView.visible = $isBool;
         _lineBitmap2.visible = $isBool;
         _receiveBtn.visible = $isBool;
      }
      
      private function showBottomActivationButton() : void
      {
         var isBool:Boolean = false;
         var model:ChickActivationModel = ChickActivationManager.instance.model;
         var remainingDay:int = ChickActivationManager.instance.model.getRemainingDay();
         if(_group.selectIndex == 0)
         {
            if(model.keyOpenedType == 0 && PlayerManager.Instance.Self.Grade <= 15 || model.keyOpenedType == 1 && remainingDay <= 0)
            {
               isBool = true;
            }
            else
            {
               isBool = false;
            }
         }
         else if(_group.selectIndex == 1)
         {
            if(model.keyOpenedType == 0 && PlayerManager.Instance.Self.Grade > 15 || model.keyOpenedType == 2 && remainingDay <= 0)
            {
               isBool = true;
            }
            else
            {
               isBool = false;
            }
         }
         _inputBg.visible = isBool;
         _inputTxt.visible = isBool;
         _activationBtn.visible = isBool;
      }
      
      private function __responseHandler(evt:FrameEvent) : void
      {
         if(evt.responseCode == 0 || evt.responseCode == 1)
         {
            SoundManager.instance.play("008");
            dispose();
         }
      }
      
      private function __inputTxtHandler(evt:MouseEvent) : void
      {
         if(_inputTxt.text == LanguageMgr.GetTranslation("tank.chickActivation.inputTxtMsg"))
         {
            _inputTxt.text = "";
         }
      }
      
      private function __activationBtnHandler(evt:MouseEvent) : void
      {
         var strKey:String = _inputTxt.text;
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
         SocketManager.Instance.out.sendChickActivationOpenKey(strKey);
      }
      
      private function showBuyFrame() : void
      {
         var moneyStr:* = null;
         var buyChickActivationFrame:* = null;
         var ai:* = null;
         var buyContentTxt:* = null;
         var _cell:* = null;
         buyItemInfo = ShopManager.Instance.getMoneyShopItemByTemplateID(CHICKACTIVATION_CARDID);
         if(buyItemInfo)
         {
            moneyStr = buyItemInfo.getItemPrice(1).toString();
            buyChickActivationFrame = ComponentFactory.Instance.creatComponentByStylename("chickActivationFrame.buyChickActivationFrame");
            buyChickActivationFrame.titleText = LanguageMgr.GetTranslation("tips");
            ai = new AlertInfo(LanguageMgr.GetTranslation("cancel"),LanguageMgr.GetTranslation("ok"));
            buyChickActivationFrame.info = ai;
            buyContentTxt = ComponentFactory.Instance.creatComponentByStylename("chickActivationFrame.contentTxt");
            buyContentTxt.text = LanguageMgr.GetTranslation("tank.chickActivation.inputTxtMsg3",moneyStr);
            buyChickActivationFrame.addToContent(buyContentTxt);
            _cell = CellFactory.instance.createShopCartItemCell() as ShopPlayerCell;
            _cell.info = buyItemInfo.TemplateInfo;
            PositionUtils.setPos(_cell,"chickActivationFrame.ShopPlayerCellPos");
            buyChickActivationFrame.addToContent(_cell);
            buyChickActivationFrame.addEventListener("response",__buyFrameResponse);
            LayerManager.Instance.addToLayer(buyChickActivationFrame,3,true,1);
         }
      }
      
      private function __buyFrameResponse(evt:FrameEvent) : void
      {
         var moneyValue:int = 0;
         SoundManager.instance.play("008");
         evt.currentTarget.removeEventListener("response",__buyFrameResponse);
         ObjectUtils.disposeAllChildren(evt.currentTarget as DisplayObjectContainer);
         ObjectUtils.disposeObject(evt.currentTarget);
         if(evt.responseCode == 2 || evt.responseCode == 3)
         {
            if(PlayerManager.Instance.Self.bagLocked)
            {
               BaglockedManager.Instance.show();
               return;
            }
            moneyValue = buyItemInfo.getItemPrice(1).bothMoneyValue;
            if(PlayerManager.Instance.Self.Money < moneyValue)
            {
               LeavePageManager.showFillFrame();
               return;
            }
            SocketManager.Instance.out.sendBuyGoods([buyItemInfo.GoodsID],[1],[""],[0],[false],[""],1,null,[false]);
         }
      }
      
      public function clickRateGo() : Boolean
      {
         var temp:Number = new Date().time;
         if(temp - _clickRate > 1000)
         {
            _clickRate = temp;
            return false;
         }
         MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.chickActivation.clickRateMsg"));
         return true;
      }
      
      private function __receiveBtnHandler(evt:MouseEvent) : void
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
         var gainId:int = getNowGainArrIndex() + 1;
         SocketManager.Instance.out.sendChickActivationGetAward(gainId,0);
      }
      
      private function playDropGoodsMovie(arr:Array) : void
      {
         var i:int = 0;
         var itemInfo:* = null;
         var beginPoint:Point = ComponentFactory.Instance.creatCustomObject("chickActivation.dropGoodsBeginPos");
         var endPoint:Point = ComponentFactory.Instance.creatCustomObject("chickActivation.dropGoodsEndPos");
         var tempArr:Array = [];
         for(i = 0; i < _ativationItems.arrData.length; )
         {
            itemInfo = ChickActivationManager.instance.model.getInventoryItemInfo(_ativationItems.arrData[i]);
            if(itemInfo)
            {
               tempArr.push(itemInfo);
            }
            i++;
         }
         DropGoodsManager.play(tempArr,beginPoint,endPoint,true);
      }
      
      private function getQualityKey() : String
      {
         var day:int = 0;
         var mainIndex:int = _group.selectIndex;
         var index:int = _groupTwo.selectIndex;
         var qualityKey:String = mainIndex + "," + index;
         if(index == 0)
         {
            day = 1;
            qualityKey = qualityKey + ("," + day);
         }
         else if(index == 2)
         {
            day = 5;
            qualityKey = qualityKey + ("," + day);
         }
         return qualityKey;
      }
      
      private function __clickLevelPacksHandler(evt:ChickActivationEvent) : void
      {
         var tempNum:int = 0;
         var totalPrestige:int = 0;
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
         var levelIndex:int = evt.resultData;
         var arr:Array = ServerConfigManager.instance.chickenActiveKeyLvAwardNeedPrestige;
         if(arr && arr.length > 0)
         {
            tempNum = arr[levelIndex - 1];
            totalPrestige = BattleGroudControl.Instance.orderdata.totalPrestige;
            if(totalPrestige < tempNum)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.chickActivation.totalPrestigeMsg",tempNum));
               return;
            }
         }
         SocketManager.Instance.out.sendChickActivationGetAward(12,levelIndex);
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
         var k:int = 0;
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
            for(k = 0; k < _promptMovies.length; )
            {
               _promptMovies[k].stop();
               ObjectUtils.disposeObject(_promptMovies[k]);
               k++;
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
