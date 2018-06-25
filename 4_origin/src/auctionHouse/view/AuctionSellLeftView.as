package auctionHouse.view
{
   import bagAndInfo.bag.BagFrame;
   import bagAndInfo.cell.DragEffect;
   import beadSystem.beadSystemManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MovieImage;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.StringUtils;
   import ddt.command.QuickBuyFrame;
   import ddt.data.EquipType;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.events.CellEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SharedManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.view.tips.MultipleLineTip;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import flash.geom.Point;
   import flash.text.TextField;
   import shop.view.NewShopBugleView;
   
   public class AuctionSellLeftView extends Sprite implements Disposeable
   {
       
      
      private var _bid_btn:BaseButton;
      
      private var _bidLight:Bitmap;
      
      private var _keep:FilterFrameText;
      
      private var _startMoney:FilterFrameText;
      
      private var _mouthfulM:FilterFrameText;
      
      private var name_txt:FilterFrameText;
      
      private var _selectRate:Number = 1;
      
      private var _bidTime1:SelectedCheckButton;
      
      private var _bidTime2:SelectedCheckButton;
      
      private var _bidTime3:SelectedCheckButton;
      
      private var _sellLoudBtn:SelectedCheckButton;
      
      private var _sellLoudBtnTxt:FilterFrameText;
      
      private var _currentTime:SelectedButton;
      
      private var _cellsItems:Vector.<AuctionCellView>;
      
      private var _cell:AuctionCellView;
      
      private var _dragArea:AuctionDragInArea;
      
      private var _bag:BagFrame;
      
      private var _cellGoodsID:int;
      
      private var _auctionObjectBg:BaseButton;
      
      private var _auctionObject:Sprite;
      
      private var _selectObjectTip:MultipleLineTip;
      
      private var _auctionObjectFrame:int = 0;
      
      private var _lowestPrice:Number;
      
      private var _selectCheckBtn:SelectedCheckButton;
      
      private var _cellShowTipAble:Boolean = false;
      
      private var _shopBugle:NewShopBugleView;
      
      public function AuctionSellLeftView()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         var bg:MutipleImage = ComponentFactory.Instance.creat("auctionHouse.LeftBG2");
         addChild(bg);
         var _Sellbg:Bitmap = ComponentFactory.Instance.creatBitmap("asset.ddtauction.Sellbg");
         addChild(_Sellbg);
         _Sellbg.y = 57;
         var _Sellbg1:Bitmap = ComponentFactory.Instance.creatBitmap("asset.ddtauction.Sellbg");
         addChild(_Sellbg1);
         _Sellbg1.y = 302;
         var _SellItembg:MovieImage = ComponentFactory.Instance.creatComponentByStylename("ddtauction.sellItemBG1");
         addChild(_SellItembg);
         var _SellItembg1:MovieImage = ComponentFactory.Instance.creatComponentByStylename("ddtauction.sellItemBG2");
         addChild(_SellItembg1);
         var _textInputBg:Scale9CornerImage = ComponentFactory.Instance.creatComponentByStylename("ddtauction.sellItemBG3");
         addChild(_textInputBg);
         var _textInputBg1:Scale9CornerImage = ComponentFactory.Instance.creatComponentByStylename("ddtauction.sellItemBG4");
         addChild(_textInputBg1);
         var _Selltext:FilterFrameText = ComponentFactory.Instance.creatComponentByStylename("auctionHouse.SellViewTextI");
         _Selltext.text = LanguageMgr.GetTranslation("tank.ddtauctionHouse.view.text");
         addChild(_Selltext);
         var _Selltext1:FilterFrameText = ComponentFactory.Instance.creatComponentByStylename("auctionHouse.SellViewTextII");
         _Selltext1.text = LanguageMgr.GetTranslation("tank.ddtauctionHouse.view.text1");
         addChild(_Selltext1);
         var _Selltext2:FilterFrameText = ComponentFactory.Instance.creatComponentByStylename("auctionHouse.SellViewTextIII");
         _Selltext2.text = LanguageMgr.GetTranslation("tank.ddtauctionHouse.view.text2");
         addChild(_Selltext2);
         var _Selltext3:FilterFrameText = ComponentFactory.Instance.creatComponentByStylename("auctionHouse.SellViewTextIIII");
         _Selltext3.text = LanguageMgr.GetTranslation("tank.ddtauctionHouse.view.text3");
         addChild(_Selltext3);
         var _Selltext4:FilterFrameText = ComponentFactory.Instance.creatComponentByStylename("auctionHouse.SellViewTextIIIII");
         _Selltext4.text = LanguageMgr.GetTranslation("tank.ddtauctionHouse.view.text4");
         addChild(_Selltext4);
         var _timerText:FilterFrameText = ComponentFactory.Instance.creatComponentByStylename("auctionHouse.SellViewtimerTextI");
         _timerText.text = LanguageMgr.GetTranslation("tank.ddtauctionHouse.view.timer8");
         addChild(_timerText);
         var _timerText1:FilterFrameText = ComponentFactory.Instance.creatComponentByStylename("auctionHouse.SellViewtimerTextII");
         _timerText1.text = LanguageMgr.GetTranslation("tank.ddtauctionHouse.view.timer24");
         addChild(_timerText1);
         var _timerText2:FilterFrameText = ComponentFactory.Instance.creatComponentByStylename("auctionHouse.SellViewtimerTextIII");
         _timerText2.text = LanguageMgr.GetTranslation("tank.ddtauctionHouse.view.timer48");
         addChild(_timerText2);
         var _helpText:FilterFrameText = ComponentFactory.Instance.creatComponentByStylename("auctionHouse.SellViewhelpText");
         _helpText.text = LanguageMgr.GetTranslation("tank.ddtauctionHouse.view.text5");
         addChild(_helpText);
         var icon0:MutipleImage = ComponentFactory.Instance.creat("auctionHouse.SellLeftIcon0");
         addChild(icon0);
         var icon1:MutipleImage = ComponentFactory.Instance.creat("auctionHouse.SellLeftIcon1");
         addChild(icon1);
         var icon2:MutipleImage = ComponentFactory.Instance.creat("auctionHouse.SellLeftIcon2");
         addChild(icon2);
         _bid_btn = ComponentFactory.Instance.creat("auctionHouse.StartBid_btn");
         _bid_btn.enable = false;
         addChild(_bid_btn);
         _bidLight = ComponentFactory.Instance.creatBitmap("asset.auctionHouse.StartBidLightbtn");
         _bidLight.visible = false;
         addChild(_bidLight);
         _keep = ComponentFactory.Instance.creat("auctionHouse.SellkeepText");
         addChild(_keep);
         _startMoney = ComponentFactory.Instance.creat("auctionHouse.startMoneyText");
         addChild(_startMoney);
         _mouthfulM = ComponentFactory.Instance.creat("auctionHouse.mouthfulText");
         addChild(_mouthfulM);
         var _loc20_:* = "0-9";
         _mouthfulM.restrict = _loc20_;
         _loc20_ = _loc20_;
         _startMoney.restrict = _loc20_;
         _keep.restrict = _loc20_;
         _loc20_ = 9;
         _mouthfulM.maxChars = _loc20_;
         _startMoney.maxChars = _loc20_;
         name_txt = ComponentFactory.Instance.creat("auctionHouse.NameText");
         _bidTime1 = ComponentFactory.Instance.creat("auctionHouse.bidTime1_btn");
         addChild(_bidTime1);
         _bidTime2 = ComponentFactory.Instance.creat("auctionHouse.bidTime2_btn");
         addChild(_bidTime2);
         _bidTime3 = ComponentFactory.Instance.creat("auctionHouse.bidTime3_btn");
         addChild(_bidTime3);
         _currentTime = _bidTime1;
         _selectRate = 1;
         _sellLoudBtn = ComponentFactory.Instance.creatComponentByStylename("auctionHouse.SellLouderBtn");
         _sellLoudBtnTxt = ComponentFactory.Instance.creat("asset.auctionHouse.sellLouderBtnTxt");
         _sellLoudBtnTxt.text = LanguageMgr.GetTranslation("tank.auctionHouse.view.AuctionSellLeftView.fastAuction");
         _sellLoudBtn.addChild(_sellLoudBtnTxt);
         addChild(_sellLoudBtn);
         _cellsItems = new Vector.<AuctionCellView>();
         _cell = ComponentFactory.Instance.creatCustomObject("auctionHouse.AuctionCellView");
         _cell.buttonMode = true;
         _cellsItems.push(_cell);
         _auctionObject = new Sprite();
         _auctionObjectBg = ComponentFactory.Instance.creat("auctionHouse.auctionObjCell");
         _auctionObjectBg.alpha = 0;
         _auctionObject.addChild(_auctionObjectBg);
         _auctionObject.addChild(name_txt);
         addChild(_auctionObject);
         addChild(_cell);
         _selectObjectTip = ComponentFactory.Instance.creatCustomObject("auctionHouse.SellSelectedBtn");
         _selectObjectTip.tipData = LanguageMgr.GetTranslation("tank.auctionHouse.view.AuctionSellLeftView.Choose");
         _selectObjectTip.mouseChildren = false;
         _selectObjectTip.mouseEnabled = false;
         _dragArea = new AuctionDragInArea(_cellsItems);
         addChildAt(_dragArea,0);
         _bag = ComponentFactory.Instance.creat("auctionHouse.view.GoodsBagFrame");
         _bag.titleText = LanguageMgr.GetTranslation("tank.auctionHouse.view.BagFrame.Choose");
         _bag.moveEnable = true;
         _bag.bagView.cellDoubleClickEnable = false;
         clear();
      }
      
      private function addEvent() : void
      {
         _cell.addEventListener("selectBidGood",__setBidGood);
         _cell.addEventListener("change",__selectGood);
         _bid_btn.addEventListener("click",__startBid);
         _bid_btn.addEventListener("mouseOver",__bid_btnOver);
         _bid_btn.addEventListener("mouseOut",__bid_btnOut);
         _startMoney.addEventListener("change",__change);
         _mouthfulM.addEventListener("change",__change);
         _startMoney.addEventListener("textInput",__textInput);
         _mouthfulM.addEventListener("textInput",__textInputMouth);
         _auctionObject.addEventListener("click",_onAuctionObjectClicked);
         _cell.addEventListener("Cell_mouseOver",_onAuctionObjectOver);
         _cell.addEventListener("Cell_mouseOut",_onAuctionObjectOut);
         _bidTime1.addEventListener("click",__selectBidTimeII);
         _bidTime2.addEventListener("click",__selectBidTimeII);
         _bidTime3.addEventListener("click",__selectBidTimeII);
         _bag.addEventListener("dragStart",__startShine);
         _bag.addEventListener("dragStop",__stopShine);
         _bag.addEventListener("bagClose",__CellstartShine);
      }
      
      private function __selectBidTimeII(evt:MouseEvent) : void
      {
         evt.stopImmediatePropagation();
         selectBidUpdate(evt.currentTarget as SelectedButton);
      }
      
      private function selectBidUpdate(button:SelectedButton) : void
      {
         if(_currentTime != button)
         {
            _currentTime.selected = false;
         }
         if(button)
         {
            var _loc2_:* = button.name;
            if(_bidTime1.name !== _loc2_)
            {
               if(_bidTime2.name !== _loc2_)
               {
                  if(_bidTime3.name !== _loc2_)
                  {
                     _currentTime = _bidTime1;
                     _selectRate = 1;
                  }
                  else
                  {
                     _currentTime = _bidTime3;
                     _selectRate = 3;
                     SoundManager.instance.play("008");
                  }
               }
               else
               {
                  _currentTime = _bidTime2;
                  _selectRate = 2;
                  SoundManager.instance.play("008");
               }
            }
            else
            {
               _currentTime = _bidTime1;
               _selectRate = 1;
               SoundManager.instance.play("008");
            }
         }
         else
         {
            _currentTime = _bidTime1;
            _selectRate = 1;
         }
         if(_currentTime)
         {
            _currentTime.selected = true;
         }
         update();
      }
      
      private function removeEvent() : void
      {
         _cell.removeEventListener("selectBidGood",__setBidGood);
         _cell.removeEventListener("change",__selectGood);
         _bid_btn.removeEventListener("click",__startBid);
         _bid_btn.removeEventListener("mouseOver",__bid_btnOver);
         _bid_btn.removeEventListener("mouseOut",__bid_btnOut);
         _startMoney.removeEventListener("change",__change);
         _mouthfulM.removeEventListener("change",__change);
         _startMoney.removeEventListener("textInput",__textInput);
         _mouthfulM.removeEventListener("textInput",__textInputMouth);
         _auctionObject.removeEventListener("click",_onAuctionObjectClicked);
         _cell.removeEventListener("Cell_mouseOver",_onAuctionObjectOver);
         _cell.removeEventListener("Cell_mouseOut",_onAuctionObjectOut);
         _bidTime1.removeEventListener("click",__selectBidTimeII);
         _bidTime2.removeEventListener("click",__selectBidTimeII);
         _bidTime3.removeEventListener("click",__selectBidTimeII);
         _bag.removeEventListener("dragStart",__startShine);
         _bag.removeEventListener("dragStop",__stopShine);
         _bag.removeEventListener("bagClose",__startShine);
      }
      
      function addStage() : void
      {
         _currentTime = _bidTime1;
         _selectRate = 1;
         update();
      }
      
      public function dragDrop(effect:DragEffect) : void
      {
         _cell.dragDrop(effect);
      }
      
      function clear() : void
      {
         name_txt.text = "";
         _startMoney.text = "";
         _mouthfulM.text = "";
         _keep.text = "";
         if(_cell.getSource() && _cell.info)
         {
            _cell.clearLinkCell();
         }
         _startMoney.mouseEnabled = false;
         _mouthfulM.mouseEnabled = false;
         __selectBidTimeII(new MouseEvent("click"));
         __stopShine(null);
      }
      
      function hideReady() : void
      {
         _bag.hide();
      }
      
      public function openBagFrame() : void
      {
         _bag.show();
      }
      
      private function update() : void
      {
         _keep.text = getKeep();
      }
      
      private function getRate() : int
      {
         return this._selectRate;
      }
      
      private function getKeep() : String
      {
         if(_selectRate == 1)
         {
            return "100";
         }
         if(_selectRate == 2)
         {
            return "200";
         }
         if(_selectRate == 3)
         {
            return "300";
         }
         return "100";
      }
      
      private function _onAuctionObjectClicked(evt:Event) : void
      {
         _auctionObject.mouseChildren = false;
         _auctionObject.mouseEnabled = false;
         if(_cell.info && _bag.parent)
         {
            _cell.onObjectClicked();
            return;
         }
         __setBidGood(null);
      }
      
      private function _onAuctionObjectOver(evt:Event) : void
      {
         if(_cell.info == null)
         {
            _selectObjectTip.x = localToGlobal(new Point(_auctionObject.x + _auctionObject.width / 2,_auctionObject.y + _auctionObject.height)).x + 10;
            _selectObjectTip.y = localToGlobal(new Point(_auctionObject.x + _auctionObject.width / 2,_auctionObject.y + _auctionObject.height)).y + _auctionObject.height - 5;
            LayerManager.Instance.addToLayer(_selectObjectTip,2);
         }
         _auctionObjectBg.alpha = 1;
      }
      
      private function _onAuctionObjectOut(evt:Event) : void
      {
         if(_selectObjectTip.parent)
         {
            _selectObjectTip.parent.removeChild(_selectObjectTip);
         }
         _auctionObjectBg.alpha = 0;
      }
      
      private function __setBidGood(event:Event) : void
      {
         if(_cell && _cell.info)
         {
            _cellGoodsID = _cell.info.TemplateID;
         }
         if(!_cell.info || !_bag.parent)
         {
            openBagFrame();
            SoundManager.instance.play("047");
         }
         __stopShine(null);
      }
      
      private function __CellstartShine(e:CellEvent) : void
      {
         if(_cell.info != null)
         {
            return;
         }
         _auctionObject.addEventListener("enterFrame",_auctionObjectflash);
      }
      
      private function __startShine(e:CellEvent) : void
      {
         _auctionObject.addEventListener("enterFrame",_auctionObjectflash);
      }
      
      private function __stopShine(e:CellEvent) : void
      {
         _auctionObject.removeEventListener("enterFrame",_auctionObjectflash);
         _auctionObjectBg.alpha = 0;
         _auctionObjectFrame = 0;
      }
      
      private function _auctionObjectflash(e:Event) : void
      {
         _auctionObjectFrame = _auctionObjectFrame + 1;
         if(_auctionObjectFrame == 6)
         {
            _auctionObjectBg.alpha = 1;
         }
         else if(_auctionObjectFrame == 12)
         {
            _auctionObjectBg.alpha = 0;
            _auctionObjectFrame = 0;
         }
      }
      
      private function __selectGood(event:Event) : void
      {
         if(_cell.info)
         {
            initInfo();
         }
         else
         {
            clear();
            _bid_btn.enable = false;
         }
      }
      
      private function initInfo() : void
      {
         var obj:* = null;
         if(EquipType.isBead(int(_cell.info.Property1)))
         {
            name_txt.text = beadSystemManager.Instance.getBeadName(_cell.itemInfo);
         }
         else
         {
            name_txt.text = _cell.info.Name;
         }
         _startMoney.mouseEnabled = true;
         if(!isNaN(_cell.info.FloorPrice))
         {
            _lowestPrice = _cell.goodsCount * _cell.info.FloorPrice;
            _startMoney.text = String(_cell.goodsCount * _cell.info.FloorPrice);
         }
         _mouthfulM.mouseEnabled = true;
         _bid_btn.enable = true;
         if(SharedManager.Instance.AuctionInfos != null && SharedManager.Instance.AuctionInfos[_cell.info.Name] != null)
         {
            obj = SharedManager.Instance.AuctionInfos[_cell.info.Name];
            if(obj.itemType != _cell.info.Data || obj.itemLevel != _cell.info.Level)
            {
               selectBidUpdate(null);
               return;
            }
            if(obj)
            {
               _mouthfulM.text = obj.mouthfulPrice == 0?"":obj.mouthfulPrice;
               if(Number(obj.startPrice) > Number(_startMoney.text))
               {
                  _startMoney.text = obj.startPrice;
               }
               var _loc2_:* = obj.time;
               if(0 !== _loc2_)
               {
                  if(1 !== _loc2_)
                  {
                     if(2 !== _loc2_)
                     {
                        selectBidUpdate(_bidTime1);
                     }
                     else
                     {
                        selectBidUpdate(_bidTime3);
                     }
                  }
                  else
                  {
                     selectBidUpdate(_bidTime2);
                  }
               }
               else
               {
                  selectBidUpdate(_bidTime1);
               }
            }
         }
         else
         {
            selectBidUpdate(null);
         }
      }
      
      private function __bid_btnOver(e:MouseEvent) : void
      {
         _bidLight.visible = true;
      }
      
      private function __bid_btnOut(e:MouseEvent) : void
      {
         _bidLight.visible = false;
      }
      
      private function __startBid(event:MouseEvent) : void
      {
         event = event;
         SoundManager.instance.play("047");
         if(_sellLoudBtn.selected)
         {
            if(SharedManager.Instance.isAuctionHouseTodayUseBugle)
            {
               if(_selectCheckBtn == null)
               {
                  _selectCheckBtn = ComponentFactory.Instance.creatComponentByStylename("auctionHouse.noMoraAlert");
                  _selectCheckBtn.text = LanguageMgr.GetTranslation("dice.alert.nextPrompt");
               }
               var alert1:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("tank.auctionHouse.view.AuctionSellLeftView.UseBugle"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,false,false,2);
               alert1.moveEnable = false;
               alert1.addChild(_selectCheckBtn);
               alert1.addEventListener("response",function(e:FrameEvent):void
               {
                  if(e.responseCode == 2 || e.responseCode == 3)
                  {
                     if(_selectCheckBtn.selected)
                     {
                        SharedManager.Instance.isAuctionHouseTodayUseBugle = !_selectCheckBtn.selected;
                     }
                     sendFastAuctionBugle();
                  }
                  alert1.dispose();
                  _selectCheckBtn.dispose();
                  _selectCheckBtn = null;
               });
            }
            else
            {
               autionFunc();
            }
         }
         else
         {
            autionFunc();
         }
      }
      
      public function sendFastAuctionBugle(type:int = 11101) : void
      {
         if(PlayerManager.Instance.Self.PropBag.getItemCountByTemplateId(type,true) <= 0)
         {
            if(!_shopBugle || !_shopBugle.info)
            {
               _shopBugle = new NewShopBugleView(type);
            }
            else if(_shopBugle.type != type)
            {
               _shopBugle.dispose();
               _shopBugle = null;
               _shopBugle = new NewShopBugleView(type);
            }
         }
         else
         {
            autionFunc();
         }
      }
      
      private function _responseV(evt:FrameEvent) : void
      {
         var _quick:* = null;
         SoundManager.instance.play("008");
         (evt.currentTarget as BaseAlerFrame).removeEventListener("response",_responseV);
         if(evt.responseCode == 3 || evt.responseCode == 2)
         {
            _quick = ComponentFactory.Instance.creatComponentByStylename("ddtcore.QuickFrame");
            _quick.setTitleText(LanguageMgr.GetTranslation("tank.view.store.matte.goldQuickBuy"));
            _quick.itemID = 11233;
            LayerManager.Instance.addToLayer(_quick,2,true,1);
         }
         ObjectUtils.disposeObject(evt.currentTarget);
      }
      
      private function auctionGood() : void
      {
         var mouthful:int = 0;
         var price:int = 0;
         var validTime:int = 0;
         var goodsCount:int = 0;
         var bagType:int = 0;
         var place:int = 0;
         var itemID:int = 0;
         var obj:* = null;
         if(_cell.info)
         {
            if(_cell.info.CategoryID != 74)
            {
               bagType = (_cell.info as InventoryItemInfo).BagType;
               place = (_cell.info as InventoryItemInfo).Place;
               price = Math.floor(Number(_startMoney.text));
               mouthful = _mouthfulM.text == ""?0:Number(Math.floor(Number(_mouthfulM.text)));
               validTime = _selectRate - 1;
               goodsCount = _cell.goodsCount;
               SocketManager.Instance.out.auctionGood(bagType,place,1,price,mouthful,validTime,goodsCount,_sellLoudBtn.selected);
            }
            else
            {
               bagType = (_cell.info as InventoryItemInfo).BagType;
               itemID = (_cell.info as InventoryItemInfo).ItemID;
               price = Math.floor(Number(_startMoney.text));
               mouthful = _mouthfulM.text == ""?0:Number(Math.floor(Number(_mouthfulM.text)));
               validTime = _selectRate - 1;
               goodsCount = 1;
               SocketManager.Instance.out.auctionGood(bagType,itemID,1,price,mouthful,validTime,goodsCount,_sellLoudBtn.selected);
            }
            obj = {};
            obj.itemName = _cell.info.Name;
            obj.itemType = _cell.info.Data;
            obj.itemLevel = _cell.info.Level;
            obj.startPrice = price;
            obj.mouthfulPrice = mouthful;
            obj.time = validTime;
            SharedManager.Instance.AuctionInfos[_cell.info.Name] = obj;
            SharedManager.Instance.save();
         }
         selectBidUpdate(null);
         _startMoney.stage.focus = null;
         _mouthfulM.stage.focus = null;
      }
      
      private function autionFunc() : void
      {
         var alert:* = null;
         if(!_cell.info)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.auctionHouse.view.AuctionSellLeftView.ChooseTwo"));
            return;
         }
         if(_startMoney.text == "")
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.auctionHouse.view.AuctionSellLeftView.Price"));
            return;
         }
         if(_mouthfulM.text != "" || _startMoney.text != "")
         {
            if(Number(_startMoney.text) < _lowestPrice || Number(_startMoney.text) <= 0)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.auctionHouse.view.AuctionSellLeftView.Lowest",String(_lowestPrice)));
               return;
            }
            if(StringUtils.trim(_mouthfulM.text) != "" && Number(_startMoney.text) >= Number(_mouthfulM.text))
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.auctionHouse.view.AuctionSellLeftView.PriceTwo"));
               return;
            }
         }
         if(Number(_keep.text) > PlayerManager.Instance.Self.Gold)
         {
            alert = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tank.room.RoomIIView2.notenoughmoney.title"),LanguageMgr.GetTranslation("tank.view.GoldInadequate"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,false,false,2);
            alert.moveEnable = false;
            alert.addEventListener("response",_responseV);
            return;
         }
         auctionGood();
      }
      
      private function __change(event:Event) : void
      {
         if(Number(_startMoney.text) == 0)
         {
            _startMoney.text = "";
         }
         update();
      }
      
      private function __textInput(event:TextEvent) : void
      {
         if(Number(_keep.text) + Number(event.text) == 0)
         {
            if(_keep.selectedText.length <= 0)
            {
               event.preventDefault();
            }
         }
      }
      
      private function __textInputMouth(event:TextEvent) : void
      {
         var txt:TextField = event.target as TextField;
         if(Number(txt.text) + Number(event.text) == 0)
         {
            if(txt.selectedText.length <= 0)
            {
               event.preventDefault();
            }
         }
      }
      
      private function __timeChange(event:Event) : void
      {
         update();
      }
      
      public function dispose() : void
      {
         removeEvent();
         _cellsItems = null;
         if(_dragArea)
         {
            ObjectUtils.disposeObject(_dragArea);
         }
         _dragArea = null;
         if(_bid_btn)
         {
            ObjectUtils.disposeObject(_bid_btn);
         }
         _bid_btn = null;
         if(_keep)
         {
            ObjectUtils.disposeObject(_keep);
         }
         _keep = null;
         if(_startMoney)
         {
            ObjectUtils.disposeObject(_startMoney);
         }
         _startMoney = null;
         if(_mouthfulM)
         {
            ObjectUtils.disposeObject(_mouthfulM);
         }
         _mouthfulM = null;
         if(_bag)
         {
            ObjectUtils.disposeObject(_bag);
         }
         _bag = null;
         if(name_txt)
         {
            ObjectUtils.disposeObject(name_txt);
         }
         name_txt = null;
         if(_selectObjectTip)
         {
            ObjectUtils.disposeObject(_selectObjectTip);
         }
         _selectObjectTip = null;
         if(_auctionObject)
         {
            ObjectUtils.disposeObject(_auctionObject);
         }
         _auctionObject = null;
         if(_bidTime1)
         {
            ObjectUtils.disposeObject(_bidTime1);
         }
         _bidTime1 = null;
         if(_bidTime2)
         {
            ObjectUtils.disposeObject(_bidTime1);
         }
         _bidTime2 = null;
         if(_bidTime3)
         {
            ObjectUtils.disposeObject(_bidTime1);
         }
         _bidTime3 = null;
         if(_currentTime)
         {
            ObjectUtils.disposeObject(_bidTime1);
         }
         _currentTime = null;
         if(_cell)
         {
            ObjectUtils.disposeObject(_cell);
         }
         _cell = null;
         if(_auctionObjectBg)
         {
            ObjectUtils.disposeObject(_auctionObjectBg);
         }
         _auctionObjectBg = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
