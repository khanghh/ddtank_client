package AvatarCollection.view
{
   import AvatarCollection.data.AvatarCollectionItemVo;
   import bagAndInfo.cell.BagCell;
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.command.QuickBuyFrame;
   import ddt.events.PkgEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.CheckMoneyUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class AvatarCollectionItemCell extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _itemCell:BagCell;
      
      private var _btn:SimpleBitmapButton;
      
      private var _buyBtn:SimpleBitmapButton;
      
      private var _data:AvatarCollectionItemVo;
      
      public function AvatarCollectionItemCell()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.avatarColl.itemCell.bg");
         var _loc1_:Sprite = new Sprite();
         _loc1_.graphics.beginFill(16777215,0);
         _loc1_.graphics.drawRect(0,0,74,74);
         _loc1_.graphics.endFill();
         _itemCell = new BagCell(1,null,true,_loc1_,false);
         _btn = ComponentFactory.Instance.creatComponentByStylename("avatarColl.itemCell.btn");
         _btn.alpha = 0.8;
         _btn.visible = false;
         _buyBtn = ComponentFactory.Instance.creatComponentByStylename("avatarColl.itemCell.buyBtn");
         _buyBtn.alpha = 0.8;
         _buyBtn.visible = false;
         addChild(_bg);
         addChild(_itemCell);
         addChild(_btn);
         addChild(_buyBtn);
      }
      
      private function initEvent() : void
      {
         _btn.addEventListener("click",clickHandler,false,0,true);
         _buyBtn.addEventListener("click",buyClickHandler,false,0,true);
         this.addEventListener("mouseOver",overHandler,false,0,true);
         this.addEventListener("mouseOut",outHandler,false,0,true);
      }
      
      private function buyClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         if(_data.Type == 2 && PlayerManager.Instance.Self.Bag.getBagFullByIndex(31,80))
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("avatarCollection.bagFull"));
            return;
         }
         var _loc2_:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),LanguageMgr.GetTranslation("avatarCollection.buyConfirm.tipTxt",_data.buyPrice,_data.typeToString),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,true,2,null,"SimpleAlert",60,false,_data.priceType);
         _loc2_.addEventListener("response",onBuyConfirmResponse);
      }
      
      private function onBuyConfirmResponse(param1:FrameEvent) : void
      {
         var _loc2_:BaseAlerFrame = param1.currentTarget as BaseAlerFrame;
         _loc2_.removeEventListener("response",onBuyConfirmResponse);
         if(param1.responseCode == 2 || param1.responseCode == 3)
         {
            CheckMoneyUtils.instance.checkMoney(_loc2_.isBand,_data.buyPrice,onCheckComplete);
         }
         _loc2_.dispose();
      }
      
      protected function onCheckComplete() : void
      {
         SocketManager.Instance.addEventListener(PkgEvent.format(44),onBuyedGoods);
         var _loc2_:Array = [_data.goodsId];
         var _loc7_:Array = [1];
         var _loc4_:Array = [""];
         var _loc5_:Array = [""];
         var _loc6_:Array = [""];
         var _loc3_:Array = [_data.isDiscount];
         var _loc1_:Array = [CheckMoneyUtils.instance.isBind];
         SocketManager.Instance.out.sendBuyGoods(_loc2_,_loc7_,_loc4_,_loc6_,_loc5_,null,0,_loc3_,_loc1_);
      }
      
      private function onBuyedGoods(param1:PkgEvent) : void
      {
         SocketManager.Instance.removeEventListener(PkgEvent.format(44),onBuyedGoods);
         param1.pkg.position = 20;
         var _loc2_:int = param1.pkg.readInt();
         if(_loc2_ != 0)
         {
            sendActive();
         }
      }
      
      private function overHandler(param1:MouseEvent) : void
      {
         if(_data && !_data.isActivity && !_buyBtn.visible)
         {
            _btn.visible = true;
         }
      }
      
      private function outHandler(param1:MouseEvent) : void
      {
         if(_data && !_data.isHas)
         {
            _btn.visible = false;
         }
      }
      
      private function clickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         if(!_data.isHas)
         {
            if(_data.Type == 1)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("avatarCollection.doActive.donnotHas",_data.typeToString));
            }
            else
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("avatarCollection.doActive.donnotHas.type",_data.typeToString));
            }
            return;
         }
         var _loc2_:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("avatarCollection.activeItem.promptTxt",_data.needGold),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,true,1);
         _loc2_.moveEnable = false;
         _loc2_.addEventListener("response",__activeConfirm,false,0,true);
      }
      
      private function __activeConfirm(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:BaseAlerFrame = param1.currentTarget as BaseAlerFrame;
         _loc2_.removeEventListener("response",__activeConfirm);
         if(param1.responseCode == 3 || param1.responseCode == 2)
         {
            sendActive();
         }
      }
      
      private function sendActive() : void
      {
         if(!checkGoldEnough())
         {
            refreshView(_data);
            return;
         }
         SocketManager.Instance.out.sendAvatarCollectionActive(_data.id,_data.activateItem.TemplateID,_data.sex,_data.Type);
      }
      
      private function checkGoldEnough() : Boolean
      {
         var _loc1_:* = null;
         if(PlayerManager.Instance.Self.Gold < _data.needGold)
         {
            _loc1_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("tank.view.GoldInadequate"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,false,false,2);
            _loc1_.moveEnable = false;
            _loc1_.addEventListener("response",_responseV);
            return false;
         }
         return true;
      }
      
      private function _responseV(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         (param1.currentTarget as BaseAlerFrame).removeEventListener("response",_responseV);
         if(param1.responseCode == 3 || param1.responseCode == 2)
         {
            okFastPurchaseGold();
         }
         ObjectUtils.disposeObject(param1.currentTarget);
      }
      
      private function okFastPurchaseGold() : void
      {
         var _loc1_:QuickBuyFrame = ComponentFactory.Instance.creatComponentByStylename("ddtcore.QuickFrame");
         _loc1_.setTitleText(LanguageMgr.GetTranslation("tank.view.store.matte.goldQuickBuy"));
         _loc1_.itemID = 11233;
         LayerManager.Instance.addToLayer(_loc1_,2,true,1);
      }
      
      public function refreshView(param1:AvatarCollectionItemVo) : void
      {
         _data = param1;
         if(!_data)
         {
            _itemCell.info = null;
            _itemCell.tipStyle = null;
            _itemCell.tipData = null;
            _btn.visible = false;
            _buyBtn.visible = false;
            return;
         }
         _itemCell.info = _data.itemInfo;
         _itemCell.tipStyle = "AvatarCollection.view.AvatarCollectionItemTip";
         _itemCell.tipData = _data;
         if(_data.isActivity)
         {
            _btn.visible = false;
            _buyBtn.visible = false;
            _itemCell.lightPic();
         }
         else if(_data.isHas)
         {
            _btn.visible = true;
            _buyBtn.visible = false;
            _itemCell.lightPic();
         }
         else
         {
            if(_data.canBuyStatus == 1)
            {
               _buyBtn.visible = true;
            }
            else
            {
               _buyBtn.visible = false;
            }
            _btn.visible = false;
            _itemCell.grayPic();
         }
      }
      
      private function removeEvent() : void
      {
         _btn.removeEventListener("click",clickHandler);
         _buyBtn.removeEventListener("click",buyClickHandler);
         removeEventListener("mouseOver",overHandler);
         removeEventListener("mouseOut",outHandler);
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeAllChildren(this);
         _bg = null;
         _itemCell = null;
         _btn = null;
         _data = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
