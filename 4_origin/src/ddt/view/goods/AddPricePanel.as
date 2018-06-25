package ddt.view.goods
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.ComboBox;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ShopCarItemInfo;
   import ddt.data.goods.ShopItemInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ShopManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.CheckMoneyUtils;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.filters.ColorMatrixFilter;
   import flash.geom.Point;
   import flash.text.TextFormat;
   
   public class AddPricePanel extends Frame
   {
      
      private static var _instance:AddPricePanel;
       
      
      private var _infoLabel:FilterFrameText;
      
      private var _payButton:TextButton;
      
      private var _cancelButton:TextButton;
      
      private var _leftLabel:Bitmap;
      
      private var _moneyButton:SelectedButton;
      
      private var _ddtmoneyButton:SelectedButton;
      
      private var _petStoneButton:SelectedButton;
      
      private var _leagueButton:SelectedButton;
      
      private var _radioGroup:SelectedButtonGroup;
      
      private var _armShellClipButton:SelectedButton;
      
      private var _medalButton:SelectedButton;
      
      private var _payComBox:ComboBox;
      
      private var _isDress:Boolean;
      
      private var _info:InventoryItemInfo;
      
      private var _blueTF:TextFormat;
      
      private var _yellowTF:TextFormat;
      
      private var _grayFilter:ColorMatrixFilter;
      
      private var _currentAlert:BaseAlerFrame;
      
      private var _currentPayType:int;
      
      private var _currentPayTypeArr:Array;
      
      protected var _cartItemGroup:SelectedButtonGroup;
      
      protected var _cartItemSelectVBox:VBox;
      
      private var _bgLeft:ScaleBitmapImage;
      
      private var _bgRight:ScaleBitmapImage;
      
      private var _textI:FilterFrameText;
      
      private var _textII:FilterFrameText;
      
      private var _textIII:FilterFrameText;
      
      private var _textImg:Image;
      
      private var _moneyBg:ScaleBitmapImage;
      
      private var _ddtmoneyBg:ScaleBitmapImage;
      
      private var _petStoneBg:ScaleBitmapImage;
      
      private var _medalBg:ScaleBitmapImage;
      
      private var _leagueBg:ScaleBitmapImage;
      
      private var _armShellClipBg:ScaleBitmapImage;
      
      private var _moneyLogo:Bitmap;
      
      private var _ddtmoneyLogo:Bitmap;
      
      private var _petStoneLogo:Bitmap;
      
      private var _leagueLogo:Bitmap;
      
      private var _armShellClipLogo:Bitmap;
      
      private var _medalBitmapLogo:Bitmap;
      
      private var _moneyFFT:FilterFrameText;
      
      private var _petStoneFFT:FilterFrameText;
      
      private var _ddtmoneyFFT:FilterFrameText;
      
      private var _medalFFT:FilterFrameText;
      
      private var _leagueFFT:FilterFrameText;
      
      private var _armShellClipFFT:FilterFrameText;
      
      private var _isBand:Boolean = false;
      
      private var _type:int;
      
      private var _shopItems:Array;
      
      private var _currentShopItem:ShopCarItemInfo;
      
      private var _isXun:Boolean;
      
      private var thirdFFTPos:Point;
      
      private var thirdLogoPos:Point;
      
      private var thirdBgPos:Point;
      
      private var thirdButtonPos:Point;
      
      private var chooseType:int;
      
      public function AddPricePanel()
      {
         thirdFFTPos = new Point(85,164);
         thirdLogoPos = new Point(63,161);
         thirdBgPos = new Point(60,160);
         thirdButtonPos = new Point(34,161);
         super();
         if(_instance != null)
         {
            return;
         }
         configUI();
      }
      
      public static function get Instance() : AddPricePanel
      {
         if(_instance == null)
         {
            _instance = ComponentFactory.Instance.creatCustomObject("reNewPricePanel");
         }
         return _instance;
      }
      
      private function configUI() : void
      {
         _textImg = ComponentFactory.Instance.creat("reNew.TipsTextBg");
         addToContent(_textImg);
         _bgLeft = ComponentFactory.Instance.creat("renew.selectBtnbgI");
         addToContent(_bgLeft);
         PositionUtils.setPos(_bgLeft,"renew.leftPos");
         _bgRight = ComponentFactory.Instance.creat("renew.selectBtnbg");
         addToContent(_bgRight);
         PositionUtils.setPos(_bgRight,"renew.rightPos");
         _grayFilter = ComponentFactory.Instance.model.getSet("grayFilter");
         _blueTF = ComponentFactory.Instance.model.getSet("bagAndInfo.AddPrice.BlueTF");
         _yellowTF = ComponentFactory.Instance.model.getSet("bagAndInfo.AddPrice.YellowTF");
         titleText = LanguageMgr.GetTranslation("AlertDialog.Info");
         _textI = ComponentFactory.Instance.creat("renew.TextI");
         addToContent(_textI);
         _textI.text = LanguageMgr.GetTranslation("ddt.bagandinfo.renew.txtI");
         PositionUtils.setPos(_textI,"renew.txtPos1");
         _textII = ComponentFactory.Instance.creat("renew.TextII");
         addToContent(_textII);
         _textII.text = LanguageMgr.GetTranslation("ddt.bagandinfo.renew.txtII");
         PositionUtils.setPos(_textII,"renew.txtPos2");
         _textIII = ComponentFactory.Instance.creat("renew.TextIII");
         addToContent(_textIII);
         _textIII.text = LanguageMgr.GetTranslation("ddt.bagandinfo.renew.txtIII");
         PositionUtils.setPos(_textIII,"renew.txtPos3");
         _type = -1;
         _moneyButton = ComponentFactory.Instance.creatComponentByStylename("AddPricePanel.RenewalDianJuan");
         addToContent(_moneyButton);
         _ddtmoneyButton = ComponentFactory.Instance.creatComponentByStylename("AddPricePanel.RenewalGift");
         addToContent(_ddtmoneyButton);
         _petStoneButton = ComponentFactory.Instance.creatComponentByStylename("AddPricePanel.RenewalGift");
         _petStoneButton.visible = false;
         addToContent(_petStoneButton);
         _leagueButton = ComponentFactory.Instance.creatComponentByStylename("AddPricePanel.RenewalGift");
         _leagueButton.visible = false;
         addToContent(_leagueButton);
         _armShellClipButton = ComponentFactory.Instance.creatComponentByStylename("AddPricePanel.RenewalGift");
         _armShellClipButton.visible = false;
         _armShellClipButton.y = 161;
         addToContent(_armShellClipButton);
         _medalButton = ComponentFactory.Instance.creatComponentByStylename("AddPricePanel.RenewalGift");
         _medalButton.x = thirdButtonPos.x;
         _medalButton.y = thirdButtonPos.y;
         addToContent(_medalButton);
         _moneyBg = ComponentFactory.Instance.creat("bagAndInfo.moneyViewBG");
         addToContent(_moneyBg);
         PositionUtils.setPos(_moneyBg,"bagAndInfo.moneyViewBGPos1");
         _ddtmoneyBg = ComponentFactory.Instance.creat("bagAndInfo.moneyViewBG");
         addToContent(_ddtmoneyBg);
         PositionUtils.setPos(_ddtmoneyBg,"bagAndInfo.moneyViewBGPos2");
         _petStoneBg = ComponentFactory.Instance.creat("bagAndInfo.moneyViewBG");
         addToContent(_petStoneBg);
         PositionUtils.setPos(_petStoneBg,"bagAndInfo.moneyViewBGPos2");
         _medalBg = ComponentFactory.Instance.creat("bagAndInfo.moneyViewBG");
         addToContent(_medalBg);
         _medalBg.x = thirdBgPos.x;
         _medalBg.y = thirdBgPos.y;
         _leagueBg = ComponentFactory.Instance.creat("bagAndInfo.moneyViewBG");
         addToContent(_leagueBg);
         PositionUtils.setPos(_leagueBg,"bagAndInfo.moneyViewBGPos2");
         _armShellClipBg = ComponentFactory.Instance.creat("bagAndInfo.moneyViewBG");
         addToContent(_armShellClipBg);
         PositionUtils.setPos(_armShellClipBg,"bagAndInfo.moneyViewBGPos3");
         _moneyLogo = ComponentFactory.Instance.creatBitmap("bagAndInfo.info.PointCoupon");
         addToContent(_moneyLogo);
         PositionUtils.setPos(_moneyLogo,"renew.dianquanPos");
         _ddtmoneyLogo = ComponentFactory.Instance.creatBitmap("bagAndInfo.info.ddtMoney1");
         addToContent(_ddtmoneyLogo);
         PositionUtils.setPos(_ddtmoneyLogo,"renew.lijinPos");
         _petStoneLogo = ComponentFactory.Instance.creatBitmap("asset.petStone");
         addToContent(_petStoneLogo);
         PositionUtils.setPos(_petStoneLogo,"renew.lijinPos");
         _leagueLogo = ComponentFactory.Instance.creatBitmap("asset.league");
         addToContent(_leagueLogo);
         PositionUtils.setPos(_leagueLogo,"renew.lijinPos");
         _armShellClipLogo = ComponentFactory.Instance.creatBitmap("asset.armShellClip");
         _armShellClipLogo.y = 161;
         addToContent(_armShellClipLogo);
         PositionUtils.setPos(_armShellClipLogo,"renew.armShellClipPos");
         _medalBitmapLogo = ComponentFactory.Instance.creat("bagAndInfo.order");
         _medalBitmapLogo.x = thirdLogoPos.x;
         _medalBitmapLogo.y = thirdLogoPos.y;
         addToContent(_medalBitmapLogo);
         _moneyFFT = ComponentFactory.Instance.creat("renew.dianquanFFT");
         addToContent(_moneyFFT);
         _moneyFFT.text = LanguageMgr.GetTranslation("money");
         _ddtmoneyFFT = ComponentFactory.Instance.creat("renew.lijinFFT");
         addToContent(_ddtmoneyFFT);
         _ddtmoneyFFT.text = LanguageMgr.GetTranslation("ddtMoney");
         _medalFFT = ComponentFactory.Instance.creat("renew.lijinFFT");
         _medalFFT.text = LanguageMgr.GetTranslation("medalMoney");
         _medalFFT.x = thirdFFTPos.x;
         _medalFFT.y = thirdFFTPos.y;
         addToContent(_medalFFT);
         _leagueFFT = ComponentFactory.Instance.creat("renew.lijinFFT");
         addToContent(_leagueFFT);
         _leagueFFT.text = LanguageMgr.GetTranslation("ddt.league.moneyTypeTxt");
         _armShellClipFFT = ComponentFactory.Instance.creat("renew.lijinFFT");
         _armShellClipFFT.y = 164;
         addToContent(_armShellClipFFT);
         _armShellClipFFT.text = LanguageMgr.GetTranslation("ddt.armShellClip.moneyTypeTxt");
         _petStoneFFT = ComponentFactory.Instance.creat("renew.lijinFFT");
         addToContent(_petStoneFFT);
         _petStoneFFT.text = LanguageMgr.GetTranslation("buried.alertInfo.ligthStone");
         _radioGroup = new SelectedButtonGroup();
         _radioGroup.addSelectItem(_moneyButton);
         _radioGroup.addSelectItem(_ddtmoneyButton);
         _radioGroup.addSelectItem(_medalButton);
         _radioGroup.addSelectItem(_petStoneButton);
         _radioGroup.addSelectItem(_leagueButton);
         _radioGroup.addSelectItem(_armShellClipButton);
         _radioGroup.selectIndex = 0;
         _payButton = ComponentFactory.Instance.creatComponentByStylename("bagAndInfo.AddPrice.PayButton");
         _payButton.text = LanguageMgr.GetTranslation("tank.view.common.AddPricePanel.xu");
         addToContent(_payButton);
         _cancelButton = ComponentFactory.Instance.creatComponentByStylename("bagAndInfo.AddPrice.CancelButton");
         _cancelButton.text = LanguageMgr.GetTranslation("cancel");
         addToContent(_cancelButton);
         _cartItemGroup = new SelectedButtonGroup();
         _cartItemSelectVBox = ComponentFactory.Instance.creatComponentByStylename("renew.CartItemSelectVBox");
         addToContent(_cartItemSelectVBox);
      }
      
      public function setInfo(info:InventoryItemInfo, isDress:Boolean) : void
      {
         var i:int = 0;
         _info = info;
         _isDress = isDress;
         _shopItems = ShopManager.Instance.getShopRechargeItemByTemplateId(_info.TemplateID);
         _currentPayTypeArr = [];
         _currentShopItem = null;
         for(i = 0; i < _shopItems.length; )
         {
            if((_shopItems[i] as ShopItemInfo).getItemPrice(1).IsBothMoneyType)
            {
               _currentShopItem = fillToShopCarInfo(_shopItems[i]);
               _currentPayTypeArr.push(-1);
            }
            else if((_shopItems[i] as ShopItemInfo).getItemPrice(1).IsMoneyType)
            {
               _currentShopItem = fillToShopCarInfo(_shopItems[i]);
               _currentPayTypeArr.push(-8);
            }
            else if((_shopItems[i] as ShopItemInfo).getItemPrice(1).IsPetStoneType)
            {
               _currentShopItem = fillToShopCarInfo(_shopItems[i]);
               _currentPayTypeArr.push(-12);
            }
            else if((_shopItems[i] as ShopItemInfo).getItemPrice(1).isLeagueType)
            {
               _currentShopItem = fillToShopCarInfo(_shopItems[i]);
               _currentPayTypeArr.push(-1000);
            }
            else if((_shopItems[i] as ShopItemInfo).getItemPrice(1).isArmShellClipType)
            {
               _currentShopItem = fillToShopCarInfo(_shopItems[i]);
               _currentPayTypeArr.push(13000);
            }
            else if((_shopItems[i] as ShopItemInfo).getItemPrice(1).ddtMoneyValue)
            {
               _currentShopItem = fillToShopCarInfo(_shopItems[i]);
               _currentPayTypeArr.push(-2);
            }
            else if((_shopItems[i] as ShopItemInfo).getItemPrice(1).bandDdtMoneyValue)
            {
               _currentShopItem = fillToShopCarInfo(_shopItems[i]);
               _currentPayTypeArr.push(-9);
            }
            i++;
         }
         resetRadioBtn(_currentPayTypeArr);
         if(_currentShopItem == null)
         {
            _currentShopItem = fillToShopCarInfo(_shopItems[_shopItems.length - 1]);
         }
         cartItemSelectVBoxInit();
      }
      
      protected function cartItemSelectVBoxInit() : void
      {
         var i:int = 0;
         var cartItemSelectBtn:* = null;
         var vTimeString:* = null;
         var priceValue:int = 0;
         if(_cartItemGroup)
         {
            _cartItemGroup.removeEventListener("change",__cartItemGroupChange);
            _cartItemGroup = null;
         }
         _cartItemGroup = new SelectedButtonGroup();
         _cartItemGroup.addEventListener("change",__cartItemGroupChange);
         _cartItemSelectVBox.disposeAllChildren();
         for(i = 1; i < 4; )
         {
            if(_currentShopItem.getItemPrice(i).IsValid)
            {
               cartItemSelectBtn = ComponentFactory.Instance.creatComponentByStylename("reNewSelectBtn");
               vTimeString = _currentShopItem.getTimeToString(i) != LanguageMgr.GetTranslation("ddt.shop.buyTime1")?_currentShopItem.getTimeToString(i):LanguageMgr.GetTranslation("ddt.shop.buyTime2");
               if(_type == 0)
               {
                  _isBand = false;
                  priceValue = _currentShopItem.getItemPrice(i).bothMoneyValue;
                  if(chooseType == -9)
                  {
                     cartItemSelectBtn.text = priceValue + " " + LanguageMgr.GetTranslation("ddtMoney") + "/" + vTimeString;
                  }
                  else
                  {
                     cartItemSelectBtn.text = priceValue + " " + LanguageMgr.GetTranslation("money") + "/" + vTimeString;
                  }
               }
               else if(_type == 1)
               {
                  _isBand = false;
                  priceValue = _currentShopItem.getItemPrice(i).moneyValue;
                  cartItemSelectBtn.text = priceValue + " " + LanguageMgr.GetTranslation("money") + "/" + vTimeString;
               }
               else if(_type == 2)
               {
                  _isBand = true;
                  priceValue = _currentShopItem.getItemPrice(i).bandDdtMoneyValue;
                  cartItemSelectBtn.text = priceValue + " " + LanguageMgr.GetTranslation("ddtMoney") + "/" + vTimeString;
               }
               else if(_type == 3)
               {
                  _isBand = true;
                  priceValue = _currentShopItem.getItemPrice(i).ddtMoneyValue;
                  cartItemSelectBtn.text = priceValue + " " + LanguageMgr.GetTranslation("medalMoney") + "/" + vTimeString;
               }
               else if(_type == 4)
               {
                  _isBand = false;
                  priceValue = _currentShopItem.getItemPrice(i).petStoneValue;
                  cartItemSelectBtn.text = priceValue + " " + LanguageMgr.GetTranslation("buried.alertInfo.ligthStone") + "/" + vTimeString;
               }
               else if(_type == 5)
               {
                  _isBand = false;
                  priceValue = _currentShopItem.getItemPrice(i).leagueValue;
                  cartItemSelectBtn.text = priceValue + " " + LanguageMgr.GetTranslation("ddt.league.moneyTypeTxt") + "/" + vTimeString;
               }
               else if(_type == 6)
               {
                  _isBand = false;
                  priceValue = _currentShopItem.getItemPrice(i).armShellClipValue;
                  cartItemSelectBtn.text = priceValue + " " + LanguageMgr.GetTranslation("ddt.armShellClip.moneyTypeTxt") + "/" + vTimeString;
               }
               else
               {
                  priceValue = 0;
                  cartItemSelectBtn.text = "类型搞事情";
               }
               if(priceValue > 0)
               {
                  _cartItemSelectVBox.addChild(cartItemSelectBtn);
                  _cartItemGroup.addSelectItem(cartItemSelectBtn);
               }
            }
            i++;
         }
         _cartItemGroup.selectIndex = _cartItemSelectVBox.numChildren - 1;
      }
      
      protected function __cartItemGroupChange(event:Event) : void
      {
         SoundManager.instance.play("008");
         _currentShopItem.currentBuyType = _cartItemGroup.selectIndex + 1;
      }
      
      private function fillToShopCarInfo(item:ShopItemInfo) : ShopCarItemInfo
      {
         if(!item)
         {
            return null;
         }
         var t:ShopCarItemInfo = new ShopCarItemInfo(item.GoodsID,item.TemplateID,_info.CategoryID);
         ObjectUtils.copyProperties(t,item);
         return t;
      }
      
      private function resetRadioBtn(payType:Array) : void
      {
         var j:int = 0;
         var _loc4_:* = false;
         _moneyButton.visible = _loc4_;
         _loc4_ = _loc4_;
         _moneyBg.visible = _loc4_;
         _loc4_ = _loc4_;
         _moneyLogo.visible = _loc4_;
         _moneyFFT.visible = _loc4_;
         _loc4_ = false;
         _ddtmoneyBg.visible = _loc4_;
         _loc4_ = _loc4_;
         _ddtmoneyLogo.visible = _loc4_;
         _loc4_ = _loc4_;
         _ddtmoneyFFT.visible = _loc4_;
         _ddtmoneyButton.visible = _loc4_;
         _loc4_ = false;
         _medalButton.visible = _loc4_;
         _loc4_ = _loc4_;
         _medalBg.visible = _loc4_;
         _loc4_ = _loc4_;
         _medalBitmapLogo.visible = _loc4_;
         _medalFFT.visible = _loc4_;
         _loc4_ = false;
         _leagueBg.visible = _loc4_;
         _loc4_ = _loc4_;
         _leagueLogo.visible = _loc4_;
         _loc4_ = _loc4_;
         _leagueFFT.visible = _loc4_;
         _leagueButton.visible = _loc4_;
         _loc4_ = false;
         _petStoneLogo.visible = _loc4_;
         _loc4_ = _loc4_;
         _petStoneFFT.visible = _loc4_;
         _loc4_ = _loc4_;
         _petStoneBg.visible = _loc4_;
         _petStoneButton.visible = _loc4_;
         _loc4_ = false;
         _armShellClipFFT.visible = _loc4_;
         _loc4_ = _loc4_;
         _armShellClipLogo.visible = _loc4_;
         _loc4_ = _loc4_;
         _armShellClipBg.visible = _loc4_;
         _armShellClipButton.visible = _loc4_;
         var bool:Boolean = false;
         for(j = 0; j < payType.length; )
         {
            if(payType.length == 1)
            {
               bool = true;
            }
            if(payType[j] == -12)
            {
               _type = 4;
               _loc4_ = true;
               _petStoneLogo.visible = _loc4_;
               _loc4_ = _loc4_;
               _petStoneFFT.visible = _loc4_;
               _loc4_ = _loc4_;
               _petStoneBg.visible = _loc4_;
               _petStoneButton.visible = _loc4_;
               _radioGroup.selectIndex = 3;
            }
            else if(payType[j] == -1000)
            {
               _type = 5;
               _loc4_ = true;
               _leagueBg.visible = _loc4_;
               _loc4_ = _loc4_;
               _leagueLogo.visible = _loc4_;
               _loc4_ = _loc4_;
               _leagueFFT.visible = _loc4_;
               _leagueButton.visible = _loc4_;
               _radioGroup.selectIndex = 4;
            }
            else if(payType[j] == 13000)
            {
               _type = 6;
               _loc4_ = true;
               _moneyButton.visible = _loc4_;
               _loc4_ = _loc4_;
               _moneyBg.visible = _loc4_;
               _loc4_ = _loc4_;
               _moneyLogo.visible = _loc4_;
               _moneyFFT.visible = _loc4_;
               _loc4_ = true;
               _armShellClipFFT.visible = _loc4_;
               _loc4_ = _loc4_;
               _armShellClipLogo.visible = _loc4_;
               _loc4_ = _loc4_;
               _armShellClipBg.visible = _loc4_;
               _armShellClipButton.visible = _loc4_;
               _radioGroup.selectIndex = 0;
            }
            else if(payType[j] == -9)
            {
               _type = 2;
               _loc4_ = true;
               _ddtmoneyBg.visible = _loc4_;
               _loc4_ = _loc4_;
               _ddtmoneyLogo.visible = _loc4_;
               _loc4_ = _loc4_;
               _ddtmoneyFFT.visible = _loc4_;
               _ddtmoneyButton.visible = _loc4_;
               _radioGroup.selectIndex = 1;
            }
            else if(payType[j] == -8)
            {
               _type = 1;
               _loc4_ = true;
               _moneyButton.visible = _loc4_;
               _loc4_ = _loc4_;
               _moneyBg.visible = _loc4_;
               _loc4_ = _loc4_;
               _moneyLogo.visible = _loc4_;
               _moneyFFT.visible = _loc4_;
               _radioGroup.selectIndex = 0;
            }
            else if(payType[j] == -1)
            {
               _type = 0;
               _loc4_ = true;
               _moneyButton.visible = _loc4_;
               _loc4_ = _loc4_;
               _moneyBg.visible = _loc4_;
               _loc4_ = _loc4_;
               _moneyLogo.visible = _loc4_;
               _moneyFFT.visible = _loc4_;
               _loc4_ = true;
               _ddtmoneyBg.visible = _loc4_;
               _loc4_ = _loc4_;
               _ddtmoneyLogo.visible = _loc4_;
               _loc4_ = _loc4_;
               _ddtmoneyFFT.visible = _loc4_;
               _ddtmoneyButton.visible = _loc4_;
               _radioGroup.selectIndex = 0;
            }
            else if(payType[j] == -2)
            {
               _type = 3;
               _loc4_ = true;
               _medalButton.visible = _loc4_;
               _loc4_ = _loc4_;
               _medalBg.visible = _loc4_;
               _loc4_ = _loc4_;
               _medalBitmapLogo.visible = _loc4_;
               _medalFFT.visible = _loc4_;
               if(bool)
               {
                  _medalFFT.x = _ddtmoneyFFT.x;
                  _medalFFT.y = _ddtmoneyFFT.y;
                  _medalBitmapLogo.x = _ddtmoneyLogo.x;
                  _medalBitmapLogo.y = _ddtmoneyLogo.y;
                  _medalBg.x = _ddtmoneyBg.x;
                  _medalBg.y = _ddtmoneyBg.y;
                  _medalButton.x = _ddtmoneyButton.x;
                  _medalButton.y = _ddtmoneyButton.y;
               }
               else
               {
                  _medalFFT.x = thirdFFTPos.x;
                  _medalFFT.y = thirdFFTPos.y;
                  _medalBitmapLogo.x = thirdLogoPos.x;
                  _medalBitmapLogo.y = thirdLogoPos.y;
                  _medalBg.x = thirdBgPos.x;
                  _medalBg.y = thirdBgPos.y;
                  _medalButton.x = thirdButtonPos.x;
                  _medalButton.y = thirdButtonPos.y;
               }
               _radioGroup.selectIndex = 2;
            }
            j++;
         }
         chooseType = payType[payType.length - 1];
      }
      
      public function show() : void
      {
         addEvent();
         LayerManager.Instance.addToLayer(this,3,true,2);
      }
      
      private function __onSelectRadioBtn(evt:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(evt.currentTarget == _moneyButton)
         {
            _type = 1;
            chooseType = -8;
         }
         else if(evt.currentTarget == _ddtmoneyButton)
         {
            _type = 2;
            chooseType = -9;
         }
         else if(evt.currentTarget == _medalButton)
         {
            _type = 3;
            chooseType = -2;
         }
         else if(evt.currentTarget == _petStoneButton)
         {
            _type = 4;
            chooseType = -12;
         }
         else if(evt.currentTarget == _leagueButton)
         {
            _type = 5;
            chooseType = -1000;
         }
         else if(evt.currentTarget == _armShellClipButton)
         {
            _type = 6;
            chooseType = 13000;
         }
         updateCurrentShopItem();
         cartItemSelectVBoxInit();
      }
      
      private function updateCurrentShopItem() : void
      {
         var i:int = 0;
         _currentShopItem = null;
         for(i = 0; i < _shopItems.length; )
         {
            if(_shopItems[i].getItemPrice(1).PriceType == chooseType)
            {
               _currentShopItem = fillToShopCarInfo(_shopItems[i]);
               return;
            }
            if(chooseType == -8 || chooseType == -9)
            {
               if(_shopItems[i].getItemPrice(1).PriceType == -1)
               {
                  _type = 0;
                  _currentShopItem = fillToShopCarInfo(_shopItems[i]);
                  return;
               }
            }
            i++;
         }
      }
      
      private function addEvent() : void
      {
         _moneyButton.addEventListener("click",__onSelectRadioBtn);
         _ddtmoneyButton.addEventListener("click",__onSelectRadioBtn);
         _medalButton.addEventListener("click",__onSelectRadioBtn);
         _armShellClipButton.addEventListener("click",__onSelectRadioBtn);
         _petStoneButton.addEventListener("click",__onSelectRadioBtn);
         _leagueButton.addEventListener("click",__onSelectRadioBtn);
         _cancelButton.addEventListener("click",__onCancelClick);
         _payButton.addEventListener("click",__onPay);
         addEventListener("response",__response);
      }
      
      private function __response(evt:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         switch(int(evt.responseCode))
         {
            case 0:
            case 1:
               close();
               break;
            case 2:
            case 3:
            case 4:
               __onPay(null);
         }
      }
      
      private function removeEvent() : void
      {
         _moneyButton.removeEventListener("click",__onSelectRadioBtn);
         _ddtmoneyButton.removeEventListener("click",__onSelectRadioBtn);
         _medalButton.removeEventListener("click",__onSelectRadioBtn);
         _armShellClipButton.removeEventListener("click",__onSelectRadioBtn);
         _petStoneButton.removeEventListener("click",__onSelectRadioBtn);
         _leagueButton.removeEventListener("click",__onSelectRadioBtn);
         _cancelButton.removeEventListener("click",__onCancelClick);
         _payButton.addEventListener("click",__onPay);
         removeEventListener("response",__response);
      }
      
      private function __onPay(evt:MouseEvent) : void
      {
         var alert:* = null;
         var checkMoney:int = 0;
         var confirmFrame2:* = null;
         var needLeague:int = 0;
         var ownLeague:int = 0;
         var baseAlert:* = null;
         var needArmShellClip:int = 0;
         var ownArmShellClip:int = 0;
         var baseAlert2:* = null;
         SoundManager.instance.play("008");
         if(_radioGroup.selectIndex == 0)
         {
            checkMoney = _currentShopItem.getItemPrice(_cartItemGroup.selectIndex + 1).moneyValue == 0?_currentShopItem.getItemPrice(_cartItemGroup.selectIndex + 1).bothMoneyValue:int(_currentShopItem.getItemPrice(_cartItemGroup.selectIndex + 1).moneyValue);
            CheckMoneyUtils.instance.checkMoney(false,checkMoney,onCheckComplete);
         }
         else if(_radioGroup.selectIndex == 3)
         {
            confirmFrame2 = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("tank.view.common.AddPricePanel.pay"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,true,1);
            confirmFrame2.moveEnable = false;
            confirmFrame2.addEventListener("response",petStoneConfirmed,false,0,true);
         }
         else if(_radioGroup.selectIndex == 4)
         {
            needLeague = _currentShopItem.getItemPrice(_cartItemGroup.selectIndex + 1).leagueValue;
            ownLeague = PlayerManager.Instance.Self.leagueMoney;
            if(needLeague > ownLeague)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.league.unenoughMoneyTxpTxt"),0,false,1);
            }
            else
            {
               baseAlert = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("ddt.league.confirmToPayLeague",needLeague),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"));
               baseAlert.addEventListener("response",leagueConfirmHandler);
            }
         }
         else if(_radioGroup.selectIndex == 5)
         {
            needArmShellClip = _currentShopItem.getItemPrice(_cartItemGroup.selectIndex + 1).armShellClipValue;
            ownArmShellClip = PlayerManager.Instance.Self.PropBag.getItemCountByTemplateId(13000);
            if(needArmShellClip > ownArmShellClip)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.armShellClip.unenoughMoneyTxpTxt"),0,false,1);
            }
            else
            {
               baseAlert2 = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),LanguageMgr.GetTranslation("ddt.armShellClip.confirmToPayArmShellClip",needArmShellClip),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"));
               baseAlert2.addEventListener("response",armShellClipConfirmHandler);
            }
         }
         else if(_radioGroup.selectIndex == 2)
         {
            if(PlayerManager.Instance.Self.DDTMoney < _currentShopItem.getItemPrice(_cartItemGroup.selectIndex + 1).ddtMoneyValue)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("shop.view.madelLack"));
            }
            else
            {
               alert = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("tank.view.common.AddPricePanel.pay"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,false,2);
               alert.addEventListener("response",__onPayResponse);
            }
            close();
         }
         else if(_radioGroup.selectIndex == 1)
         {
            checkMoney = _currentShopItem.getItemPrice(_cartItemGroup.selectIndex + 1).bandDdtMoneyValue == 0?_currentShopItem.getItemPrice(_cartItemGroup.selectIndex + 1).bothMoneyValue:int(_currentShopItem.getItemPrice(_cartItemGroup.selectIndex + 1).moneyValue);
            if(PlayerManager.Instance.Self.BandMoney < checkMoney)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("bindMoneyPoorNote"));
            }
            else
            {
               onCheckComplete();
            }
         }
      }
      
      private function leagueConfirmHandler(evt:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         var confirmFrame:BaseAlerFrame = evt.currentTarget as BaseAlerFrame;
         confirmFrame.removeEventListener("response",leagueConfirmHandler);
         ObjectUtils.disposeObject(confirmFrame);
         if(evt.responseCode == 3 || evt.responseCode == 2)
         {
            doPay();
         }
      }
      
      private function armShellClipConfirmHandler(evt:FrameEvent) : void
      {
         var arr:* = null;
         SoundManager.instance.play("008");
         var confirmFrame:BaseAlerFrame = evt.currentTarget as BaseAlerFrame;
         confirmFrame.removeEventListener("response",armShellClipConfirmHandler);
         ObjectUtils.disposeObject(confirmFrame);
         if(evt.responseCode == 3 || evt.responseCode == 2)
         {
            arr = [];
            arr.push([_info.BagType,_info.Place,_currentShopItem.GoodsID,_cartItemGroup.selectIndex + 1,_isDress,13000]);
            SocketManager.Instance.out.sendGoodsContinue(arr);
         }
         close();
      }
      
      protected function petStoneConfirmed(evt:FrameEvent) : void
      {
         var needStoneNum:Number = NaN;
         var remainStoneNum:Number = NaN;
         var arr:* = null;
         SoundManager.instance.play("008");
         var confirmFrame:BaseAlerFrame = evt.currentTarget as BaseAlerFrame;
         confirmFrame.removeEventListener("response",petStoneConfirmed);
         ObjectUtils.disposeObject(confirmFrame);
         if(evt.responseCode == 3 || evt.responseCode == 2)
         {
            needStoneNum = _currentShopItem.getItemPrice(_cartItemGroup.selectIndex + 1).petStoneValue;
            remainStoneNum = PlayerManager.Instance.Self.getBag(1).getItemCountByTemplateId(11680);
            if(needStoneNum > remainStoneNum)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("shop.view.petStoneLack"));
            }
            else
            {
               this.parent && this.parent.removeChild(this);
               arr = [];
               arr.push([_info.BagType,_info.Place,_currentShopItem.GoodsID,1,_isDress,4]);
               SocketManager.Instance.out.sendGoodsContinue(arr);
            }
         }
      }
      
      protected function onCheckComplete() : void
      {
         var alert:* = null;
         close();
         alert = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("tank.view.common.AddPricePanel.pay"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,false,2);
         alert.addEventListener("response",__onPayResponse);
      }
      
      private function __onPayResponse(evt:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         var alert:BaseAlerFrame = evt.currentTarget as BaseAlerFrame;
         alert.removeEventListener("response",__onPayResponse);
         alert.dispose();
         if(evt.responseCode == 2 || evt.responseCode == 3)
         {
            doPay();
         }
      }
      
      private function __onCancelClick(evt:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         close();
      }
      
      override protected function __onCloseClick(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         close();
         super.__onCloseClick(event);
      }
      
      private function doPay() : void
      {
         var arr:* = null;
         if(_info)
         {
            arr = [];
            arr.push([_info.BagType,_info.Place,_currentShopItem.GoodsID,_cartItemGroup.selectIndex + 1,_isDress,_radioGroup.selectIndex + 1]);
            SocketManager.Instance.out.sendGoodsContinue(arr);
            close();
         }
      }
      
      public function close() : void
      {
         removeEvent();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
