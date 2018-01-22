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
         var _loc17_:MutipleImage = ComponentFactory.Instance.creat("auctionHouse.LeftBG2");
         addChild(_loc17_);
         var _loc14_:Bitmap = ComponentFactory.Instance.creatBitmap("asset.ddtauction.Sellbg");
         addChild(_loc14_);
         _loc14_.y = 57;
         var _loc12_:Bitmap = ComponentFactory.Instance.creatBitmap("asset.ddtauction.Sellbg");
         addChild(_loc12_);
         _loc12_.y = 302;
         var _loc16_:MovieImage = ComponentFactory.Instance.creatComponentByStylename("ddtauction.sellItemBG1");
         addChild(_loc16_);
         var _loc13_:MovieImage = ComponentFactory.Instance.creatComponentByStylename("ddtauction.sellItemBG2");
         addChild(_loc13_);
         var _loc18_:Scale9CornerImage = ComponentFactory.Instance.creatComponentByStylename("ddtauction.sellItemBG3");
         addChild(_loc18_);
         var _loc15_:Scale9CornerImage = ComponentFactory.Instance.creatComponentByStylename("ddtauction.sellItemBG4");
         addChild(_loc15_);
         var _loc2_:FilterFrameText = ComponentFactory.Instance.creatComponentByStylename("auctionHouse.SellViewTextI");
         _loc2_.text = LanguageMgr.GetTranslation("tank.ddtauctionHouse.view.text");
         addChild(_loc2_);
         var _loc1_:FilterFrameText = ComponentFactory.Instance.creatComponentByStylename("auctionHouse.SellViewTextII");
         _loc1_.text = LanguageMgr.GetTranslation("tank.ddtauctionHouse.view.text1");
         addChild(_loc1_);
         var _loc9_:FilterFrameText = ComponentFactory.Instance.creatComponentByStylename("auctionHouse.SellViewTextIII");
         _loc9_.text = LanguageMgr.GetTranslation("tank.ddtauctionHouse.view.text2");
         addChild(_loc9_);
         var _loc7_:FilterFrameText = ComponentFactory.Instance.creatComponentByStylename("auctionHouse.SellViewTextIIII");
         _loc7_.text = LanguageMgr.GetTranslation("tank.ddtauctionHouse.view.text3");
         addChild(_loc7_);
         var _loc5_:FilterFrameText = ComponentFactory.Instance.creatComponentByStylename("auctionHouse.SellViewTextIIIII");
         _loc5_.text = LanguageMgr.GetTranslation("tank.ddtauctionHouse.view.text4");
         addChild(_loc5_);
         var _loc19_:FilterFrameText = ComponentFactory.Instance.creatComponentByStylename("auctionHouse.SellViewtimerTextI");
         _loc19_.text = LanguageMgr.GetTranslation("tank.ddtauctionHouse.view.timer8");
         addChild(_loc19_);
         var _loc4_:FilterFrameText = ComponentFactory.Instance.creatComponentByStylename("auctionHouse.SellViewtimerTextII");
         _loc4_.text = LanguageMgr.GetTranslation("tank.ddtauctionHouse.view.timer24");
         addChild(_loc4_);
         var _loc3_:FilterFrameText = ComponentFactory.Instance.creatComponentByStylename("auctionHouse.SellViewtimerTextIII");
         _loc3_.text = LanguageMgr.GetTranslation("tank.ddtauctionHouse.view.timer48");
         addChild(_loc3_);
         var _loc11_:FilterFrameText = ComponentFactory.Instance.creatComponentByStylename("auctionHouse.SellViewhelpText");
         _loc11_.text = LanguageMgr.GetTranslation("tank.ddtauctionHouse.view.text5");
         addChild(_loc11_);
         var _loc10_:MutipleImage = ComponentFactory.Instance.creat("auctionHouse.SellLeftIcon0");
         addChild(_loc10_);
         var _loc8_:MutipleImage = ComponentFactory.Instance.creat("auctionHouse.SellLeftIcon1");
         addChild(_loc8_);
         var _loc6_:MutipleImage = ComponentFactory.Instance.creat("auctionHouse.SellLeftIcon2");
         addChild(_loc6_);
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
      
      private function __selectBidTimeII(param1:MouseEvent) : void
      {
         param1.stopImmediatePropagation();
         selectBidUpdate(param1.currentTarget as SelectedButton);
      }
      
      private function selectBidUpdate(param1:SelectedButton) : void
      {
         if(_currentTime != param1)
         {
            _currentTime.selected = false;
         }
         if(param1)
         {
            var _loc2_:* = param1.name;
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
      
      public function dragDrop(param1:DragEffect) : void
      {
         _cell.dragDrop(param1);
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
      
      private function _onAuctionObjectClicked(param1:Event) : void
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
      
      private function _onAuctionObjectOver(param1:Event) : void
      {
         if(_cell.info == null)
         {
            _selectObjectTip.x = localToGlobal(new Point(_auctionObject.x + _auctionObject.width / 2,_auctionObject.y + _auctionObject.height)).x + 10;
            _selectObjectTip.y = localToGlobal(new Point(_auctionObject.x + _auctionObject.width / 2,_auctionObject.y + _auctionObject.height)).y + _auctionObject.height - 5;
            LayerManager.Instance.addToLayer(_selectObjectTip,2);
         }
         _auctionObjectBg.alpha = 1;
      }
      
      private function _onAuctionObjectOut(param1:Event) : void
      {
         if(_selectObjectTip.parent)
         {
            _selectObjectTip.parent.removeChild(_selectObjectTip);
         }
         _auctionObjectBg.alpha = 0;
      }
      
      private function __setBidGood(param1:Event) : void
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
      
      private function __CellstartShine(param1:CellEvent) : void
      {
         if(_cell.info != null)
         {
            return;
         }
         _auctionObject.addEventListener("enterFrame",_auctionObjectflash);
      }
      
      private function __startShine(param1:CellEvent) : void
      {
         _auctionObject.addEventListener("enterFrame",_auctionObjectflash);
      }
      
      private function __stopShine(param1:CellEvent) : void
      {
         _auctionObject.removeEventListener("enterFrame",_auctionObjectflash);
         _auctionObjectBg.alpha = 0;
         _auctionObjectFrame = 0;
      }
      
      private function _auctionObjectflash(param1:Event) : void
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
      
      private function __selectGood(param1:Event) : void
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
         var _loc1_:* = null;
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
            _loc1_ = SharedManager.Instance.AuctionInfos[_cell.info.Name];
            if(_loc1_.itemType != _cell.info.Data || _loc1_.itemLevel != _cell.info.Level)
            {
               selectBidUpdate(null);
               return;
            }
            if(_loc1_)
            {
               _mouthfulM.text = _loc1_.mouthfulPrice == 0?"":_loc1_.mouthfulPrice;
               if(Number(_loc1_.startPrice) > Number(_startMoney.text))
               {
                  _startMoney.text = _loc1_.startPrice;
               }
               var _loc2_:* = _loc1_.time;
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
      
      private function __bid_btnOver(param1:MouseEvent) : void
      {
         _bidLight.visible = true;
      }
      
      private function __bid_btnOut(param1:MouseEvent) : void
      {
         _bidLight.visible = false;
      }
      
      private function __startBid(param1:MouseEvent) : void
      {
         event = param1;
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
               alert1.addEventListener("response",function(param1:FrameEvent):void
               {
                  if(param1.responseCode == 2 || param1.responseCode == 3)
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
      
      public function sendFastAuctionBugle(param1:int = 11101) : void
      {
         if(PlayerManager.Instance.Self.PropBag.getItemCountByTemplateId(param1,true) <= 0)
         {
            if(!_shopBugle || !_shopBugle.info)
            {
               _shopBugle = new NewShopBugleView(param1);
            }
            else if(_shopBugle.type != param1)
            {
               _shopBugle.dispose();
               _shopBugle = null;
               _shopBugle = new NewShopBugleView(param1);
            }
         }
         else
         {
            autionFunc();
         }
      }
      
      private function _responseV(param1:FrameEvent) : void
      {
         var _loc2_:* = null;
         SoundManager.instance.play("008");
         (param1.currentTarget as BaseAlerFrame).removeEventListener("response",_responseV);
         if(param1.responseCode == 3 || param1.responseCode == 2)
         {
            _loc2_ = ComponentFactory.Instance.creatComponentByStylename("ddtcore.QuickFrame");
            _loc2_.setTitleText(LanguageMgr.GetTranslation("tank.view.store.matte.goldQuickBuy"));
            _loc2_.itemID = 11233;
            LayerManager.Instance.addToLayer(_loc2_,2,true,1);
         }
         ObjectUtils.disposeObject(param1.currentTarget);
      }
      
      private function auctionGood() : void
      {
         var _loc3_:int = 0;
         var _loc7_:int = 0;
         var _loc2_:int = 0;
         var _loc1_:int = 0;
         var _loc4_:int = 0;
         var _loc6_:int = 0;
         var _loc5_:* = null;
         if(_cell.info)
         {
            _loc3_ = (_cell.info as InventoryItemInfo).BagType;
            _loc7_ = (_cell.info as InventoryItemInfo).Place;
            _loc2_ = Math.floor(Number(_startMoney.text));
            _loc1_ = _mouthfulM.text == ""?0:Number(Math.floor(Number(_mouthfulM.text)));
            _loc4_ = _selectRate - 1;
            _loc6_ = _cell.goodsCount;
            SocketManager.Instance.out.auctionGood(_loc3_,_loc7_,1,_loc2_,_loc1_,_loc4_,_loc6_,_sellLoudBtn.selected);
            _loc5_ = {};
            _loc5_.itemName = _cell.info.Name;
            _loc5_.itemType = _cell.info.Data;
            _loc5_.itemLevel = _cell.info.Level;
            _loc5_.startPrice = _loc2_;
            _loc5_.mouthfulPrice = _loc1_;
            _loc5_.time = _loc4_;
            SharedManager.Instance.AuctionInfos[_cell.info.Name] = _loc5_;
            SharedManager.Instance.save();
         }
         selectBidUpdate(null);
         _startMoney.stage.focus = null;
         _mouthfulM.stage.focus = null;
      }
      
      private function autionFunc() : void
      {
         var _loc1_:* = null;
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
            _loc1_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tank.room.RoomIIView2.notenoughmoney.title"),LanguageMgr.GetTranslation("tank.view.GoldInadequate"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,false,false,2);
            _loc1_.moveEnable = false;
            _loc1_.addEventListener("response",_responseV);
            return;
         }
         auctionGood();
      }
      
      private function __change(param1:Event) : void
      {
         if(Number(_startMoney.text) == 0)
         {
            _startMoney.text = "";
         }
         update();
      }
      
      private function __textInput(param1:TextEvent) : void
      {
         if(Number(_keep.text) + Number(param1.text) == 0)
         {
            if(_keep.selectedText.length <= 0)
            {
               param1.preventDefault();
            }
         }
      }
      
      private function __textInputMouth(param1:TextEvent) : void
      {
         var _loc2_:TextField = param1.target as TextField;
         if(Number(_loc2_.text) + Number(param1.text) == 0)
         {
            if(_loc2_.selectedText.length <= 0)
            {
               param1.preventDefault();
            }
         }
      }
      
      private function __timeChange(param1:Event) : void
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
