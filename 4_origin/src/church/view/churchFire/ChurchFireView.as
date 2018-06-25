package church.view.churchFire
{
   import church.controller.ChurchRoomController;
   import church.events.WeddingRoomEvent;
   import church.model.ChurchRoomModel;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.command.QuickBuyFrame;
   import ddt.events.PlayerPropertyEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.ShopManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class ChurchFireView extends Sprite implements Disposeable
   {
      
      public static const FIRE_USE_GOLD:int = 200;
       
      
      private var _controller:ChurchRoomController;
      
      private var _model:ChurchRoomModel;
      
      private var _fireBg:Bitmap;
      
      private var _fireClose:BaseButton;
      
      private var _fireGlodLabel:FilterFrameText;
      
      private var _fireGlod:FilterFrameText;
      
      private var _fireGoldIcon:Bitmap;
      
      private var _fireIcon21002:Bitmap;
      
      private var _fireIcon21006:Bitmap;
      
      private var All_Fires:Array;
      
      private var All_FireIcons:Array;
      
      private var _fireListBox:HBox;
      
      private var _fireUseGold:int;
      
      private var _fireListFilter:Array;
      
      private var _alert:BaseAlerFrame;
      
      public function ChurchFireView(controller:ChurchRoomController, model:ChurchRoomModel)
      {
         super();
         _controller = controller;
         _model = model;
         initialize();
      }
      
      private function initialize() : void
      {
         setView();
         setEvent();
         getFireList();
      }
      
      private function setView() : void
      {
         _fireBg = ComponentFactory.Instance.creatBitmap("asset.church.room.fireBgAsset");
         addChild(_fireBg);
         _fireClose = ComponentFactory.Instance.creat("church.room.fireCloseAsset");
         _fireClose.buttonMode = true;
         addChild(_fireClose);
         _fireGlodLabel = ComponentFactory.Instance.creat("church.room.fireGlodLabelAsset");
         _fireGlodLabel.text = LanguageMgr.GetTranslation("church.view.churchFire.ChurchFireView");
         addChild(_fireGlodLabel);
         _fireGlod = ComponentFactory.Instance.creat("church.room.fireGlodAsset");
         _fireGlod.text = PlayerManager.Instance.Self.Gold.toString();
         addChild(_fireGlod);
         _fireGoldIcon = ComponentFactory.Instance.creatBitmap("asset.church.room.fireGoldIconAsset");
         addChild(_fireGoldIcon);
         _fireListBox = ComponentFactory.Instance.creat("church.room.fireListBoxAsset");
         addChild(_fireListBox);
         _fireUseGold = 200;
         _fireIcon21002 = ComponentFactory.Instance.creatBitmap("asset.church.room.fireIcon21002");
         _fireIcon21002.smoothing = true;
         _fireIcon21006 = ComponentFactory.Instance.creatBitmap("asset.church.room.fireIcon21006");
         _fireIcon21006.smoothing = true;
         All_Fires = _model.fireTemplateIDList;
         All_FireIcons = [_fireIcon21002,_fireIcon21006];
      }
      
      private function removeView() : void
      {
         All_Fires = null;
         All_FireIcons = null;
         if(_fireBg)
         {
            if(_fireBg.parent)
            {
               _fireBg.parent.removeChild(_fireBg);
            }
            _fireBg.bitmapData.dispose();
            _fireBg.bitmapData = null;
         }
         _fireBg = null;
         if(_fireClose)
         {
            if(_fireClose.parent)
            {
               _fireClose.parent.removeChild(_fireClose);
            }
            _fireClose.dispose();
         }
         _fireClose = null;
         if(_fireGlodLabel)
         {
            if(_fireGlodLabel.parent)
            {
               _fireGlodLabel.parent.removeChild(_fireGlodLabel);
            }
            _fireGlodLabel.dispose();
         }
         _fireGlodLabel = null;
         if(_fireGlod)
         {
            if(_fireGlod.parent)
            {
               _fireGlod.parent.removeChild(_fireGlod);
            }
            _fireGlod.dispose();
         }
         _fireGlod = null;
         if(_fireGoldIcon)
         {
            if(_fireGoldIcon.parent)
            {
               _fireGoldIcon.parent.removeChild(_fireGoldIcon);
            }
            _fireGoldIcon.bitmapData.dispose();
            _fireGoldIcon.bitmapData = null;
         }
         _fireGoldIcon = null;
         ObjectUtils.disposeObject(_fireIcon21002);
         _fireIcon21002 = null;
         ObjectUtils.disposeObject(_fireIcon21006);
         _fireIcon21006 = null;
         if(_fireListBox)
         {
            if(_fireListBox.parent)
            {
               _fireListBox.parent.removeChild(_fireListBox);
            }
            _fireListBox.dispose();
         }
         _fireListBox = null;
         _fireListFilter = null;
         if(parent)
         {
            this.parent.removeChild(this);
         }
      }
      
      private function setEvent() : void
      {
         _fireClose.addEventListener("click",onCloseClick);
         PlayerManager.Instance.Self.addEventListener("propertychange",updateGold);
         _model.addEventListener("room fire enable change",fireEnableChange);
      }
      
      private function removeEvent() : void
      {
         var i:int = 0;
         _fireClose.removeEventListener("click",onCloseClick);
         PlayerManager.Instance.Self.removeEventListener("propertychange",updateGold);
         _model.removeEventListener("room fire enable change",fireEnableChange);
         if(_fireListBox)
         {
            while(i < _fireListBox.numChildren)
            {
               _fireListBox.getChildAt(i).removeEventListener("click",itemClickHandler);
               i++;
            }
         }
      }
      
      private function getFireList() : void
      {
         var i:int = 0;
         var item:* = null;
         for(i = 0; i < All_Fires.length; )
         {
            item = new ChurchFireCell(All_FireIcons[i],ShopManager.Instance.getGoldShopItemByTemplateID(All_Fires[i]),All_Fires[i]);
            item.addEventListener("click",itemClickHandler);
            _fireListBox.addChild(item);
            i++;
         }
      }
      
      private function itemClickHandler(e:MouseEvent) : void
      {
         if(PlayerManager.Instance.Self.Gold < _fireUseGold)
         {
            SoundManager.instance.play("008");
            if(!_alert)
            {
               _alert = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tank.room.RoomIIView2.notenoughmoney.title"),LanguageMgr.GetTranslation("tank.view.GoldInadequate"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,false,false,1);
               _alert.addEventListener("response",_responseV);
               _alert.moveEnable = false;
               return;
            }
         }
         var item:ChurchFireCell = e.currentTarget as ChurchFireCell;
         _controller.useFire(PlayerManager.Instance.Self.ID,item.fireTemplateID);
         SocketManager.Instance.out.sendUseFire(PlayerManager.Instance.Self.ID,item.fireTemplateID);
      }
      
      private function _responseV(event:FrameEvent) : void
      {
         _alert.removeEventListener("response",_responseV);
         _alert.dispose();
         _alert = null;
         switch(int(event.responseCode) - 2)
         {
            case 0:
            case 1:
               okFastPurchaseGold();
         }
      }
      
      private function okFastPurchaseGold() : void
      {
         var _quick:QuickBuyFrame = ComponentFactory.Instance.creatComponentByStylename("ddtcore.QuickFrame");
         _quick.setTitleText(LanguageMgr.GetTranslation("tank.view.store.matte.goldQuickBuy"));
         _quick.itemID = 11233;
         LayerManager.Instance.addToLayer(_quick,2,true,1);
      }
      
      private function updateGold(evt:PlayerPropertyEvent) : void
      {
         _fireGlod.text = PlayerManager.Instance.Self.Gold.toString();
      }
      
      private function fireEnableChange(e:WeddingRoomEvent) : void
      {
         var i:int = 0;
         var j:int = 0;
         setButtnEnable(_fireListBox,_model.fireEnable);
         if(_model.fireEnable)
         {
            while(i < _fireListBox.numChildren)
            {
               _fireListBox.getChildAt(i).removeEventListener("click",itemClickHandler);
               _fireListBox.getChildAt(i).addEventListener("click",itemClickHandler);
               i++;
            }
         }
         else
         {
            while(j < _fireListBox.numChildren)
            {
               _fireListBox.getChildAt(j).removeEventListener("click",itemClickHandler);
               j++;
            }
         }
      }
      
      private function setButtnEnable(obj:Sprite, value:Boolean) : void
      {
         obj.mouseEnabled = value;
         _fireListFilter = ComponentFactory.Instance.creatFilters("grayFilter");
         obj.filters = !!value?[]:_fireListFilter;
      }
      
      private function onCloseClick(evt:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         removeView();
      }
   }
}
