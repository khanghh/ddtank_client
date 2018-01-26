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
      
      public function ShopLeftViewPropCollection(){super();}
      
      public function addItemToList(param1:ShopCartItem) : void{}
      
      public function setup() : void{}
      
      public function addChildrenTo(param1:DisplayObjectContainer) : void{}
      
      public function disposeAllChildrenFrom(param1:DisplayObjectContainer) : void{}
   }
}
