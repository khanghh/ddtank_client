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
      
      public function setInfo(param1:InventoryItemInfo, param2:Boolean) : void
      {
         var _loc3_:int = 0;
         _info = param1;
         _isDress = param2;
         _shopItems = ShopManager.Instance.getShopRechargeItemByTemplateId(_info.TemplateID);
         _currentPayTypeArr = [];
         _currentShopItem = null;
         _loc3_ = 0;
         while(_loc3_ < _shopItems.length)
         {
            if((_shopItems[_loc3_] as ShopItemInfo).getItemPrice(1).IsBothMoneyType)
            {
               _currentShopItem = fillToShopCarInfo(_shopItems[_loc3_]);
               _currentPayTypeArr.push(-1);
            }
            else if((_shopItems[_loc3_] as ShopItemInfo).getItemPrice(1).IsMoneyType)
            {
               _currentShopItem = fillToShopCarInfo(_shopItems[_loc3_]);
               _currentPayTypeArr.push(-8);
            }
            else if((_shopItems[_loc3_] as ShopItemInfo).getItemPrice(1).IsPetStoneType)
            {
               _currentShopItem = fillToShopCarInfo(_shopItems[_loc3_]);
               _currentPayTypeArr.push(-12);
            }
            else if((_shopItems[_loc3_] as ShopItemInfo).getItemPrice(1).isLeagueType)
            {
               _currentShopItem = fillToShopCarInfo(_shopItems[_loc3_]);
               _currentPayTypeArr.push(-1000);
            }
            else if((_shopItems[_loc3_] as ShopItemInfo).getItemPrice(1).isArmShellClipType)
            {
               _currentShopItem = fillToShopCarInfo(_shopItems[_loc3_]);
               _currentPayTypeArr.push(13000);
            }
            else if((_shopItems[_loc3_] as ShopItemInfo).getItemPrice(1).ddtMoneyValue)
            {
               _currentShopItem = fillToShopCarInfo(_shopItems[_loc3_]);
               _currentPayTypeArr.push(-2);
            }
            else if((_shopItems[_loc3_] as ShopItemInfo).getItemPrice(1).bandDdtMoneyValue)
            {
               _currentShopItem = fillToShopCarInfo(_shopItems[_loc3_]);
               _currentPayTypeArr.push(-9);
            }
            _loc3_++;
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
         var _loc4_:int = 0;
         var _loc2_:* = null;
         var _loc1_:* = null;
         var _loc3_:int = 0;
         if(_cartItemGroup)
         {
            _cartItemGroup.removeEventListener("change",__cartItemGroupChange);
            _cartItemGroup = null;
         }
         _cartItemGroup = new SelectedButtonGroup();
         _cartItemGroup.addEventListener("change",__cartItemGroupChange);
         _cartItemSelectVBox.disposeAllChildren();
         _loc4_ = 1;
         while(_loc4_ < 4)
         {
            if(_currentShopItem.getItemPrice(_loc4_).IsValid)
            {
               _loc2_ = ComponentFactory.Instance.creatComponentByStylename("reNewSelectBtn");
               _loc1_ = _currentShopItem.getTimeToString(_loc4_) != LanguageMgr.GetTranslation("ddt.shop.buyTime1")?_currentShopItem.getTimeToString(_loc4_):LanguageMgr.GetTranslation("ddt.shop.buyTime2");
               if(_type == 0)
               {
                  _isBand = false;
                  _loc3_ = _currentShopItem.getItemPrice(_loc4_).bothMoneyValue;
                  if(chooseType == -9)
                  {
                     _loc2_.text = _loc3_ + " " + LanguageMgr.GetTranslation("ddtMoney") + "/" + _loc1_;
                  }
                  else
                  {
                     _loc2_.text = _loc3_ + " " + LanguageMgr.GetTranslation("money") + "/" + _loc1_;
                  }
               }
               else if(_type == 1)
               {
                  _isBand = false;
                  _loc3_ = _currentShopItem.getItemPrice(_loc4_).moneyValue;
                  _loc2_.text = _loc3_ + " " + LanguageMgr.GetTranslation("money") + "/" + _loc1_;
               }
               else if(_type == 2)
               {
                  _isBand = true;
                  _loc3_ = _currentShopItem.getItemPrice(_loc4_).bandDdtMoneyValue;
                  _loc2_.text = _loc3_ + " " + LanguageMgr.GetTranslation("ddtMoney") + "/" + _loc1_;
               }
               else if(_type == 3)
               {
                  _isBand = true;
                  _loc3_ = _currentShopItem.getItemPrice(_loc4_).ddtMoneyValue;
                  _loc2_.text = _loc3_ + " " + LanguageMgr.GetTranslation("medalMoney") + "/" + _loc1_;
               }
               else if(_type == 4)
               {
                  _isBand = false;
                  _loc3_ = _currentShopItem.getItemPrice(_loc4_).petStoneValue;
                  _loc2_.text = _loc3_ + " " + LanguageMgr.GetTranslation("buried.alertInfo.ligthStone") + "/" + _loc1_;
               }
               else if(_type == 5)
               {
                  _isBand = false;
                  _loc3_ = _currentShopItem.getItemPrice(_loc4_).leagueValue;
                  _loc2_.text = _loc3_ + " " + LanguageMgr.GetTranslation("ddt.league.moneyTypeTxt") + "/" + _loc1_;
               }
               else if(_type == 6)
               {
                  _isBand = false;
                  _loc3_ = _currentShopItem.getItemPrice(_loc4_).armShellClipValue;
                  _loc2_.text = _loc3_ + " " + LanguageMgr.GetTranslation("ddt.armShellClip.moneyTypeTxt") + "/" + _loc1_;
               }
               else
               {
                  _loc3_ = 0;
                  _loc2_.text = "类型搞事情";
               }
               if(_loc3_ > 0)
               {
                  _cartItemSelectVBox.addChild(_loc2_);
                  _cartItemGroup.addSelectItem(_loc2_);
               }
            }
            _loc4_++;
         }
         _cartItemGroup.selectIndex = _cartItemSelectVBox.numChildren - 1;
      }
      
      protected function __cartItemGroupChange(param1:Event) : void
      {
         SoundManager.instance.play("008");
         _currentShopItem.currentBuyType = _cartItemGroup.selectIndex + 1;
      }
      
      private function fillToShopCarInfo(param1:ShopItemInfo) : ShopCarItemInfo
      {
         if(!param1)
         {
            return null;
         }
         var _loc2_:ShopCarItemInfo = new ShopCarItemInfo(param1.GoodsID,param1.TemplateID,_info.CategoryID);
         ObjectUtils.copyProperties(_loc2_,param1);
         return _loc2_;
      }
      
      private function resetRadioBtn(param1:Array) : void
      {
         var _loc3_:int = 0;
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
         var _loc2_:Boolean = false;
         _loc3_ = 0;
         while(_loc3_ < param1.length)
         {
            if(param1.length == 1)
            {
               _loc2_ = true;
            }
            if(param1[_loc3_] == -12)
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
            else if(param1[_loc3_] == -1000)
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
            else if(param1[_loc3_] == 13000)
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
            else if(param1[_loc3_] == -9)
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
            else if(param1[_loc3_] == -8)
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
            else if(param1[_loc3_] == -1)
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
            else if(param1[_loc3_] == -2)
            {
               _type = 3;
               _loc4_ = true;
               _medalButton.visible = _loc4_;
               _loc4_ = _loc4_;
               _medalBg.visible = _loc4_;
               _loc4_ = _loc4_;
               _medalBitmapLogo.visible = _loc4_;
               _medalFFT.visible = _loc4_;
               if(_loc2_)
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
            _loc3_++;
         }
         chooseType = param1[param1.length - 1];
      }
      
      public function show() : void
      {
         addEvent();
         LayerManager.Instance.addToLayer(this,3,true,2);
      }
      
      private function __onSelectRadioBtn(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(param1.currentTarget == _moneyButton)
         {
            _type = 1;
            chooseType = -8;
         }
         else if(param1.currentTarget == _ddtmoneyButton)
         {
            _type = 2;
            chooseType = -9;
         }
         else if(param1.currentTarget == _medalButton)
         {
            _type = 3;
            chooseType = -2;
         }
         else if(param1.currentTarget == _petStoneButton)
         {
            _type = 4;
            chooseType = -12;
         }
         else if(param1.currentTarget == _leagueButton)
         {
            _type = 5;
            chooseType = -1000;
         }
         else if(param1.currentTarget == _armShellClipButton)
         {
            _type = 6;
            chooseType = 13000;
         }
         updateCurrentShopItem();
         cartItemSelectVBoxInit();
      }
      
      private function updateCurrentShopItem() : void
      {
         var _loc1_:int = 0;
         _currentShopItem = null;
         _loc1_ = 0;
         while(_loc1_ < _shopItems.length)
         {
            if(_shopItems[_loc1_].getItemPrice(1).PriceType == chooseType)
            {
               _currentShopItem = fillToShopCarInfo(_shopItems[_loc1_]);
               return;
            }
            if(chooseType == -8 || chooseType == -9)
            {
               if(_shopItems[_loc1_].getItemPrice(1).PriceType == -1)
               {
                  _type = 0;
                  _currentShopItem = fillToShopCarInfo(_shopItems[_loc1_]);
                  return;
               }
            }
            _loc1_++;
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
      
      private function __response(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         switch(int(param1.responseCode))
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
      
      private function __onPay(param1:MouseEvent) : void
      {
         var _loc6_:* = null;
         var _loc5_:int = 0;
         var _loc4_:* = null;
         var _loc9_:int = 0;
         var _loc7_:int = 0;
         var _loc3_:* = null;
         var _loc8_:int = 0;
         var _loc10_:int = 0;
         var _loc2_:* = null;
         SoundManager.instance.play("008");
         if(_radioGroup.selectIndex == 0)
         {
            _loc5_ = _currentShopItem.getItemPrice(_cartItemGroup.selectIndex + 1).moneyValue == 0?_currentShopItem.getItemPrice(_cartItemGroup.selectIndex + 1).bothMoneyValue:int(_currentShopItem.getItemPrice(_cartItemGroup.selectIndex + 1).moneyValue);
            CheckMoneyUtils.instance.checkMoney(false,_loc5_,onCheckComplete);
         }
         else if(_radioGroup.selectIndex == 3)
         {
            _loc4_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("tank.view.common.AddPricePanel.pay"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,true,1);
            _loc4_.moveEnable = false;
            _loc4_.addEventListener("response",petStoneConfirmed,false,0,true);
         }
         else if(_radioGroup.selectIndex == 4)
         {
            _loc9_ = _currentShopItem.getItemPrice(_cartItemGroup.selectIndex + 1).leagueValue;
            _loc7_ = PlayerManager.Instance.Self.leagueMoney;
            if(_loc9_ > _loc7_)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.league.unenoughMoneyTxpTxt"),0,false,1);
            }
            else
            {
               _loc3_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("ddt.league.confirmToPayLeague",_loc9_),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"));
               _loc3_.addEventListener("response",leagueConfirmHandler);
            }
         }
         else if(_radioGroup.selectIndex == 5)
         {
            _loc8_ = _currentShopItem.getItemPrice(_cartItemGroup.selectIndex + 1).armShellClipValue;
            _loc10_ = PlayerManager.Instance.Self.PropBag.getItemCountByTemplateId(13000);
            if(_loc8_ > _loc10_)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.armShellClip.unenoughMoneyTxpTxt"),0,false,1);
            }
            else
            {
               _loc2_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),LanguageMgr.GetTranslation("ddt.armShellClip.confirmToPayArmShellClip",_loc8_),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"));
               _loc2_.addEventListener("response",armShellClipConfirmHandler);
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
               _loc6_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("tank.view.common.AddPricePanel.pay"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,false,2);
               _loc6_.addEventListener("response",__onPayResponse);
            }
            close();
         }
         else if(_radioGroup.selectIndex == 1)
         {
            _loc5_ = _currentShopItem.getItemPrice(_cartItemGroup.selectIndex + 1).bandDdtMoneyValue == 0?_currentShopItem.getItemPrice(_cartItemGroup.selectIndex + 1).bothMoneyValue:int(_currentShopItem.getItemPrice(_cartItemGroup.selectIndex + 1).moneyValue);
            if(PlayerManager.Instance.Self.BandMoney < _loc5_)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("bindMoneyPoorNote"));
            }
            else
            {
               onCheckComplete();
            }
         }
      }
      
      private function leagueConfirmHandler(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:BaseAlerFrame = param1.currentTarget as BaseAlerFrame;
         _loc2_.removeEventListener("response",leagueConfirmHandler);
         ObjectUtils.disposeObject(_loc2_);
         if(param1.responseCode == 3 || param1.responseCode == 2)
         {
            doPay();
         }
      }
      
      private function armShellClipConfirmHandler(param1:FrameEvent) : void
      {
         var _loc2_:* = null;
         SoundManager.instance.play("008");
         var _loc3_:BaseAlerFrame = param1.currentTarget as BaseAlerFrame;
         _loc3_.removeEventListener("response",armShellClipConfirmHandler);
         ObjectUtils.disposeObject(_loc3_);
         if(param1.responseCode == 3 || param1.responseCode == 2)
         {
            _loc2_ = [];
            _loc2_.push([_info.BagType,_info.Place,_currentShopItem.GoodsID,_cartItemGroup.selectIndex + 1,_isDress,13000]);
            SocketManager.Instance.out.sendGoodsContinue(_loc2_);
         }
         close();
      }
      
      protected function petStoneConfirmed(param1:FrameEvent) : void
      {
         var _loc5_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc2_:* = null;
         SoundManager.instance.play("008");
         var _loc3_:BaseAlerFrame = param1.currentTarget as BaseAlerFrame;
         _loc3_.removeEventListener("response",petStoneConfirmed);
         ObjectUtils.disposeObject(_loc3_);
         if(param1.responseCode == 3 || param1.responseCode == 2)
         {
            _loc5_ = _currentShopItem.getItemPrice(_cartItemGroup.selectIndex + 1).petStoneValue;
            _loc4_ = PlayerManager.Instance.Self.getBag(1).getItemCountByTemplateId(11680);
            if(_loc5_ > _loc4_)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("shop.view.petStoneLack"));
            }
            else
            {
               this.parent && this.parent.removeChild(this);
               _loc2_ = [];
               _loc2_.push([_info.BagType,_info.Place,_currentShopItem.GoodsID,1,_isDress,4]);
               SocketManager.Instance.out.sendGoodsContinue(_loc2_);
            }
         }
      }
      
      protected function onCheckComplete() : void
      {
         var _loc1_:* = null;
         close();
         _loc1_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("tank.view.common.AddPricePanel.pay"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,false,2);
         _loc1_.addEventListener("response",__onPayResponse);
      }
      
      private function __onPayResponse(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:BaseAlerFrame = param1.currentTarget as BaseAlerFrame;
         _loc2_.removeEventListener("response",__onPayResponse);
         _loc2_.dispose();
         if(param1.responseCode == 2 || param1.responseCode == 3)
         {
            doPay();
         }
      }
      
      private function __onCancelClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         close();
      }
      
      override protected function __onCloseClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         close();
         super.__onCloseClick(param1);
      }
      
      private function doPay() : void
      {
         var _loc1_:* = null;
         if(_info)
         {
            _loc1_ = [];
            _loc1_.push([_info.BagType,_info.Place,_currentShopItem.GoodsID,_cartItemGroup.selectIndex + 1,_isDress,_radioGroup.selectIndex + 1]);
            SocketManager.Instance.out.sendGoodsContinue(_loc1_);
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
