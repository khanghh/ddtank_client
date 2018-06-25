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
         var sp:Sprite = new Sprite();
         sp.graphics.beginFill(16777215,0);
         sp.graphics.drawRect(0,0,74,74);
         sp.graphics.endFill();
         _itemCell = new BagCell(1,null,true,sp,false);
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
      
      private function buyClickHandler(event:MouseEvent) : void
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
         var frame:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),LanguageMgr.GetTranslation("avatarCollection.buyConfirm.tipTxt",_data.buyPrice,_data.typeToString),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,true,2,null,"SimpleAlert",60,false,_data.priceType);
         frame.addEventListener("response",onBuyConfirmResponse);
      }
      
      private function onBuyConfirmResponse(e:FrameEvent) : void
      {
         var frame:BaseAlerFrame = e.currentTarget as BaseAlerFrame;
         frame.removeEventListener("response",onBuyConfirmResponse);
         if(e.responseCode == 2 || e.responseCode == 3)
         {
            CheckMoneyUtils.instance.checkMoney(frame.isBand,_data.buyPrice,onCheckComplete);
         }
         frame.dispose();
      }
      
      protected function onCheckComplete() : void
      {
         SocketManager.Instance.addEventListener(PkgEvent.format(44),onBuyedGoods);
         var items:Array = [_data.goodsId];
         var types:Array = [1];
         var colors:Array = [""];
         var dresses:Array = [""];
         var places:Array = [""];
         var goodsTypes:Array = [_data.isDiscount];
         var bands:Array = [CheckMoneyUtils.instance.isBind];
         SocketManager.Instance.out.sendBuyGoods(items,types,colors,places,dresses,null,0,goodsTypes,bands);
      }
      
      private function onBuyedGoods(event:PkgEvent) : void
      {
         SocketManager.Instance.removeEventListener(PkgEvent.format(44),onBuyedGoods);
         event.pkg.position = 20;
         var success:int = event.pkg.readInt();
         if(success != 0)
         {
            sendActive();
         }
      }
      
      private function overHandler(event:MouseEvent) : void
      {
         if(_data && !_data.isActivity && !_buyBtn.visible)
         {
            _btn.visible = true;
         }
      }
      
      private function outHandler(event:MouseEvent) : void
      {
         if(_data && !_data.isHas)
         {
            _btn.visible = false;
         }
      }
      
      private function clickHandler(event:MouseEvent) : void
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
         var confirmFrame:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("avatarCollection.activeItem.promptTxt",_data.needGold),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,true,1);
         confirmFrame.moveEnable = false;
         confirmFrame.addEventListener("response",__activeConfirm,false,0,true);
      }
      
      private function __activeConfirm(evt:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         var confirmFrame:BaseAlerFrame = evt.currentTarget as BaseAlerFrame;
         confirmFrame.removeEventListener("response",__activeConfirm);
         if(evt.responseCode == 3 || evt.responseCode == 2)
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
         var alert:* = null;
         if(PlayerManager.Instance.Self.Gold < _data.needGold)
         {
            alert = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("tank.view.GoldInadequate"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,false,false,2);
            alert.moveEnable = false;
            alert.addEventListener("response",_responseV);
            return false;
         }
         return true;
      }
      
      private function _responseV(evt:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         (evt.currentTarget as BaseAlerFrame).removeEventListener("response",_responseV);
         if(evt.responseCode == 3 || evt.responseCode == 2)
         {
            okFastPurchaseGold();
         }
         ObjectUtils.disposeObject(evt.currentTarget);
      }
      
      private function okFastPurchaseGold() : void
      {
         var _quick:QuickBuyFrame = ComponentFactory.Instance.creatComponentByStylename("ddtcore.QuickFrame");
         _quick.setTitleText(LanguageMgr.GetTranslation("tank.view.store.matte.goldQuickBuy"));
         _quick.itemID = 11233;
         LayerManager.Instance.addToLayer(_quick,2,true,1);
      }
      
      public function refreshView(data:AvatarCollectionItemVo) : void
      {
         _data = data;
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
