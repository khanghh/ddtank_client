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
         var _loc1_:Sprite = new Sprite();
         _loc1_.graphics.beginFill(16777215,0);
         _loc1_.graphics.drawRect(0,0,75,75);
         _loc1_.graphics.endFill();
         _shopItemId = GroupPurchaseManager.instance.itemId;
         _itemCell = new BagCell(1,ItemManager.Instance.getTemplateById(_shopItemId),true,_loc1_,false);
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
      
      private function clickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var _loc4_:GroupPurchaseQuickBuyFrame = ComponentFactory.Instance.creatComponentByStylename("groupPurchase.QuickFrame");
         _loc4_.setTitleText(LanguageMgr.GetTranslation("tank.view.store.matte.goldQuickBuy"));
         _loc4_.itemID = _shopItemId;
         var _loc2_:Boolean = GroupPurchaseManager.instance.isUseMoney;
         var _loc3_:Boolean = GroupPurchaseManager.instance.isUseBandMoney;
         if(_loc2_ && !_loc3_)
         {
            _loc4_.hideSelectedBand();
         }
         else if(!_loc2_ && _loc3_)
         {
            _loc4_.hideSelected();
         }
         LayerManager.Instance.addToLayer(_loc4_,2,true,1);
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
