package shop.view
{
   import bagAndInfo.cell.CellFactory;
   import com.pickgliss.effect.EffectManager;
   import com.pickgliss.effect.IEffect;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.SelectedTextButton;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.utils.PositionUtils;
   import ddt.view.ColorEditor;
   import ddt.view.character.RoomCharacter;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   
   public class ShopLeftViewPropCollection
   {
      
      public static const PLAYER_MAX_EQUIP_CNT:uint = 8;
       
      
      private var itemList:Vector.<ShopCartItem>;
      
      public var bg:MutipleImage;
      
      public var btnClearLastEquip:BaseButton;
      
      public var cartList:VBox;
      
      public var cartScroll:ScrollPanel;
      
      public var cbHideGlasses:SelectedCheckButton;
      
      public var cbHideHat:SelectedCheckButton;
      
      public var cbHideSuit:SelectedCheckButton;
      
      public var cbHideWings:SelectedCheckButton;
      
      public var colorEditor:ColorEditor;
      
      public var dressView:Sprite;
      
      public var femaleCharacter:RoomCharacter;
      
      public var infoBg:DisplayObject;
      
      public var fittingRoomText:Bitmap;
      
      public var lastItem:ShopPlayerCell;
      
      public var maleCharacter:RoomCharacter;
      
      public var middlePanelBg:ScaleFrameImage;
      
      public var leftMoneyPanelBuyBtn:BaseButton;
      
      public var muteLock:Boolean;
      
      public var panelBtnGroup:SelectedButtonGroup;
      
      public var panelCartBtn:SelectedTextButton;
      
      public var panelColorBtn:SelectedTextButton;
      
      public var playerCells:Vector.<ShopPlayerCell>;
      
      public var playerGiftTxt:FilterFrameText;
      
      public var playerMoneyTxt:FilterFrameText;
      
      public var oderGiftTxt:FilterFrameText;
      
      public var presentBtn:BaseButton;
      
      public var purchaseBtn:IconButton;
      
      public var checkOutPanel:ShopCheckOutView;
      
      public var saveFigureBtn:BaseButton;
      
      public var addedManNewEquip:int = 0;
      
      public var addedWomanNewEquip:int = 0;
      
      public var purchaseView:Sprite;
      
      public var adjustColorView:Sprite;
      
      public var presentEffet:IEffect;
      
      public var purchaseEffet:IEffect;
      
      public var askBtnEffet:IEffect;
      
      public var saveFigureEffet:IEffect;
      
      public var colorEffet:IEffect;
      
      public var canShine:Boolean;
      
      public var cartItemList:Sprite;
      
      public var randomBtn:TextButton;
      
      private var moneyPanelTipText:FilterFrameText;
      
      private var playerNameText:FilterFrameText;
      
      private var rankingLabelText:FilterFrameText;
      
      private var rankingText:FilterFrameText;
      
      public var askBtn:SimpleBitmapButton;
      
      public function ShopLeftViewPropCollection()
      {
         super();
      }
      
      public function addItemToList($item:ShopCartItem) : void
      {
         var len:int = itemList.length;
         if(len > 0)
         {
            $item.y = itemList[len - 1].y + itemList[len - 1].height;
         }
         else
         {
            $item.y = 0;
         }
         itemList.push($item);
         $item.id = itemList.length - 1;
         cartItemList.addChild($item);
      }
      
      public function setup() : void
      {
         var i:int = 0;
         var cell:* = null;
         itemList = new Vector.<ShopCartItem>();
         cartItemList = new Sprite();
         panelBtnGroup = new SelectedButtonGroup();
         playerCells = new Vector.<ShopPlayerCell>();
         dressView = new Sprite();
         dressView.x = 1;
         dressView.y = -1;
         purchaseView = new Sprite();
         adjustColorView = new Sprite();
         lastItem = CellFactory.instance.createShopColorItemCell() as ShopPlayerCell;
         bg = ComponentFactory.Instance.creatComponentByStylename("ddtshop.LeftViewBg");
         infoBg = ComponentFactory.Instance.creatCustomObject("ddtshop.BodyInfoBg");
         fittingRoomText = ComponentFactory.Instance.creatBitmap("asset.ddtshop.FittingRoomText");
         playerNameText = ComponentFactory.Instance.creatComponentByStylename("ddtshop.PlayerNameText");
         playerNameText.text = PlayerManager.Instance.Self.NickName;
         rankingLabelText = ComponentFactory.Instance.creatComponentByStylename("ddtshop.RankingLabelText");
         rankingLabelText.text = LanguageMgr.GetTranslation("shop.ShopLeftView.BodyInfo.RankingtLabel");
         rankingText = ComponentFactory.Instance.creatComponentByStylename("ddtshop.RankingText");
         rankingText.text = PlayerManager.Instance.Self.Repute.toString();
         middlePanelBg = ComponentFactory.Instance.creatComponentByStylename("ddtshop.LeftMiddlePanelBg");
         leftMoneyPanelBuyBtn = ComponentFactory.Instance.creatComponentByStylename("ddtshop.LeftMoneyPanelBuyBtn");
         saveFigureBtn = ComponentFactory.Instance.creatComponentByStylename("ddtshop.BtnSaveFigure");
         presentBtn = ComponentFactory.Instance.creatComponentByStylename("ddtshop.BtnPresent");
         purchaseBtn = ComponentFactory.Instance.creatComponentByStylename("ddtshop.BtnPurchase");
         askBtn = ComponentFactory.Instance.creatComponentByStylename("asset.core.askGoodsBtn");
         panelCartBtn = ComponentFactory.Instance.creatComponentByStylename("ddtshop.BtnCartPanel");
         panelCartBtn.text = LanguageMgr.GetTranslation("shop.ShopLeftView.CartPaneText");
         panelColorBtn = ComponentFactory.Instance.creatComponentByStylename("ddtshop.BtnColorPanel");
         panelColorBtn.text = LanguageMgr.GetTranslation("shop.ShopLeftView.ColorPaneText");
         btnClearLastEquip = ComponentFactory.Instance.creatComponentByStylename("ddtshop.BtnClearLastEquip");
         btnClearLastEquip.tipData = LanguageMgr.GetTranslation("");
         moneyPanelTipText = ComponentFactory.Instance.creatComponentByStylename("ddtshop.MoneyPanelTipText");
         moneyPanelTipText.text = LanguageMgr.GetTranslation("shop.ShopLeftView.MoneyPanelTip");
         playerMoneyTxt = ComponentFactory.Instance.creatComponentByStylename("ddtshop.PlayerMoney");
         PositionUtils.setPos(playerMoneyTxt,"ddtshop.playerMoneyTxtPos");
         playerGiftTxt = ComponentFactory.Instance.creatComponentByStylename("ddtshop.PlayerGift");
         PositionUtils.setPos(playerGiftTxt,"ddtshop.playerGiftTxtPos");
         oderGiftTxt = ComponentFactory.Instance.creatComponentByStylename("ddtshop.PlayerGift");
         PositionUtils.setPos(oderGiftTxt,"ddtshop.oderGiftTxt");
         cartScroll = ComponentFactory.Instance.creatComponentByStylename("ddtshop.CartItemList");
         cartList = ComponentFactory.Instance.creatComponentByStylename("ddtshop.CartItemContainer");
         cbHideGlasses = ComponentFactory.Instance.creatComponentByStylename("ddtshop.HideGlassesCb");
         cbHideHat = ComponentFactory.Instance.creatComponentByStylename("ddtshop.HideHatCb");
         cbHideSuit = ComponentFactory.Instance.creatComponentByStylename("ddtshop.HideSuitCb");
         cbHideWings = ComponentFactory.Instance.creatComponentByStylename("ddtshop.HideWingsCb");
         colorEditor = ComponentFactory.Instance.creatCustomObject("ddtshop.ColorEdit");
         checkOutPanel = ComponentFactory.Instance.creatCustomObject("ddtshop.CheckOutView");
         presentEffet = EffectManager.Instance.creatEffect(3,presentBtn);
         purchaseEffet = EffectManager.Instance.creatEffect(3,purchaseBtn,{"color":"gold"});
         saveFigureEffet = EffectManager.Instance.creatEffect(2,saveFigureBtn,{"color":"gold"});
         askBtnEffet = EffectManager.Instance.creatEffect(3,askBtn,{"color":"gold"});
         btnClearLastEquip.tipData = LanguageMgr.GetTranslation("shop.ShopLeftView.BodyInfo.LastEquipTipText");
         muteLock = false;
         middlePanelBg.setFrame(1);
         cartScroll.vScrollProxy = 0;
         cartScroll.setView(cartItemList);
         cartScroll.invalidateViewport(true);
         cartScroll.vUnitIncrement = 15;
         cartScroll.visible = false;
         cartList.strictSize = 66;
         cartList.isReverAdd = true;
         panelBtnGroup.addSelectItem(panelCartBtn);
         panelBtnGroup.addSelectItem(panelColorBtn);
         var _loc3_:Boolean = false;
         panelColorBtn.displacement = _loc3_;
         panelCartBtn.displacement = _loc3_;
         panelBtnGroup.selectIndex = 0;
         saveFigureBtn.enable = false;
         presentBtn.enable = false;
         askBtn.enable = false;
         purchaseBtn.enable = false;
         panelColorBtn.enable = false;
         leftMoneyPanelBuyBtn.enable = false;
         playerMoneyTxt.text = String(PlayerManager.Instance.Self.Money);
         playerGiftTxt.text = String(PlayerManager.Instance.Self.BandMoney);
         oderGiftTxt.text = String(PlayerManager.Instance.Self.DDTMoney);
         colorEditor.visible = false;
         colorEditor.restorable = false;
         lastItem.visible = false;
         PositionUtils.setPos(lastItem,"ddtshop.LastItemPos");
         canShine = true;
         dressView.addChild(infoBg);
         dressView.addChild(saveFigureBtn);
         dressView.addChild(btnClearLastEquip);
         dressView.addChild(cbHideGlasses);
         dressView.addChild(cbHideHat);
         dressView.addChild(cbHideSuit);
         dressView.addChild(cbHideWings);
         purchaseView.addChild(moneyPanelTipText);
         purchaseView.addChild(playerMoneyTxt);
         purchaseView.addChild(playerGiftTxt);
         purchaseView.addChild(oderGiftTxt);
         purchaseView.addChild(leftMoneyPanelBuyBtn);
         for(i = 0; i < 8; )
         {
            cell = CellFactory.instance.createShopPlayerItemCell() as ShopPlayerCell;
            PositionUtils.setPos(cell,"ddtshop.PlayerCellPos_" + String(i));
            playerCells.push(cell);
            dressView.addChild(cell);
            i++;
         }
         randomBtn = ComponentFactory.Instance.creatComponentByStylename("ddtshop.BtnRandom");
         randomBtn.text = LanguageMgr.GetTranslation("shop.ShopLeftView.BodyInfo.RandomBtnText");
         randomBtn.tipData = LanguageMgr.GetTranslation("shop.ShopLeftView.BodyInfo.RandomBtnTipText");
      }
      
      public function addChildrenTo(display:DisplayObjectContainer) : void
      {
         display.addChild(bg);
         display.addChild(middlePanelBg);
         display.addChild(presentBtn);
         display.addChild(purchaseBtn);
         display.addChild(askBtn);
         display.addChild(panelCartBtn);
         display.addChild(panelColorBtn);
         display.addChild(dressView);
         display.addChild(colorEditor);
         display.addChild(purchaseView);
         display.addChild(cartScroll);
         display.addChild(lastItem);
         display.addChild(randomBtn);
         display.addChild(playerNameText);
         display.addChild(rankingLabelText);
         display.addChild(rankingText);
         display.addChild(fittingRoomText);
      }
      
      public function disposeAllChildrenFrom(display:DisplayObjectContainer) : void
      {
         var i:int = 0;
         EffectManager.Instance.removeEffect(presentEffet);
         EffectManager.Instance.removeEffect(purchaseEffet);
         EffectManager.Instance.removeEffect(saveFigureEffet);
         EffectManager.Instance.removeEffect(askBtnEffet);
         ObjectUtils.disposeAllChildren(colorEditor);
         ObjectUtils.disposeAllChildren(dressView);
         ObjectUtils.disposeAllChildren(purchaseView);
         ObjectUtils.disposeAllChildren(display);
         ObjectUtils.disposeObject(moneyPanelTipText);
         panelBtnGroup.dispose();
         panelBtnGroup = null;
         for(i = 0; i < playerCells.length; playerCells[i] = null,i++)
         {
         }
         dressView = null;
         purchaseView = null;
         display = null;
         playerCells = null;
         dressView = null;
         lastItem = null;
         bg = null;
         infoBg = null;
         middlePanelBg = null;
         leftMoneyPanelBuyBtn = null;
         saveFigureBtn = null;
         presentBtn = null;
         purchaseBtn = null;
         panelCartBtn = null;
         panelColorBtn = null;
         moneyPanelTipText = null;
         btnClearLastEquip = null;
         playerMoneyTxt = null;
         playerGiftTxt = null;
         cartScroll = null;
         cartList = null;
         cbHideGlasses = null;
         cbHideHat = null;
         cbHideSuit = null;
         colorEditor = null;
         randomBtn = null;
         askBtn = null;
      }
   }
}
