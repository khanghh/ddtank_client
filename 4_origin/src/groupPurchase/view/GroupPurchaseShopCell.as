package groupPurchase.view
{
   import bagAndInfo.cell.BagCell;
   import baglocked.BaglockedManager;
   import com.greensock.TweenLite;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import groupPurchase.GroupPurchaseManager;
   
   public class GroupPurchaseShopCell extends Sprite implements Disposeable
   {
       
      
      private var _itemCell:BagCell;
      
      private var _buyTipSprite:Sprite;
      
      private var _buyTipBg:Bitmap;
      
      private var _buyTipTxt:FilterFrameText;
      
      private var _shopItemId:int;
      
      private var _buyCellShine:MovieClip;
      
      public function GroupPurchaseShopCell()
      {
         super();
         this.buttonMode = true;
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         var sp:Sprite = new Sprite();
         sp.graphics.beginFill(16777215,0);
         sp.graphics.drawRect(0,0,75,75);
         sp.graphics.endFill();
         _shopItemId = GroupPurchaseManager.instance.itemId;
         _itemCell = new BagCell(1,ItemManager.Instance.getTemplateById(_shopItemId),true,sp,false);
         addChild(_itemCell);
         _buyTipBg = ComponentFactory.Instance.creatBitmap("asset.groupPurchase.itemBuyTipBg");
         _buyTipTxt = ComponentFactory.Instance.creatComponentByStylename("groupPurchase.buyTipTxt");
         _buyTipTxt.text = LanguageMgr.GetTranslation("ddt.groupPurchase.buyTipTxt");
         _buyTipSprite = new Sprite();
         PositionUtils.setPos(_buyTipSprite,"groupPurchase.buyTipSpritePos");
         _buyTipSprite.addChild(_buyTipBg);
         _buyTipSprite.addChild(_buyTipTxt);
         addChild(_buyTipSprite);
         _buyCellShine = ComponentFactory.Instance.creat("asset.ddtshop.RightItemLightMc");
         _buyCellShine.mouseEnabled = false;
         _buyCellShine.mouseChildren = false;
         _buyCellShine.buttonMode = false;
         PositionUtils.setPos(_buyCellShine,"groupPurchase.buyCellShinePos");
         addChild(_buyCellShine);
      }
      
      private function initEvent() : void
      {
         this.addEventListener("click",clickHandler,false,0,true);
      }
      
      private function clickHandler(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var _quick:GroupPurchaseQuickBuyFrame = ComponentFactory.Instance.creatComponentByStylename("groupPurchase.QuickFrame");
         _quick.setTitleText(LanguageMgr.GetTranslation("tank.view.store.matte.goldQuickBuy"));
         _quick.itemID = _shopItemId;
         var isMoney:Boolean = GroupPurchaseManager.instance.isUseMoney;
         var isBandMoney:Boolean = GroupPurchaseManager.instance.isUseBandMoney;
         if(isMoney && !isBandMoney)
         {
            _quick.hideSelectedBand();
         }
         else if(!isMoney && isBandMoney)
         {
            _quick.hideSelected();
         }
         LayerManager.Instance.addToLayer(_quick,2,true,1);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("click",clickHandler);
      }
      
      public function dispose() : void
      {
         removeEvent();
         TweenLite.killTweensOf(_buyTipSprite);
         ObjectUtils.disposeObject(_itemCell);
         _itemCell = null;
         ObjectUtils.disposeObject(_buyTipBg);
         _buyTipBg = null;
         ObjectUtils.disposeObject(_buyTipTxt);
         _buyTipTxt = null;
         ObjectUtils.disposeObject(_buyTipSprite);
         _buyTipSprite = null;
         ObjectUtils.disposeObject(_buyCellShine);
         _buyCellShine = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
