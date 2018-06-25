package bagAndInfo.bag
{
   import bagAndInfo.cell.BaseCell;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.QualityType;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class SellGoodsFrame extends Frame
   {
      
      public static const OK:String = "ok";
      
      public static const CANCEL:String = "cancel";
       
      
      private var _itemInfo:InventoryItemInfo;
      
      private var _confirm:TextButton;
      
      private var _cancel:TextButton;
      
      private var _cell:BaseCell;
      
      private var _nameTxt:FilterFrameText;
      
      private var _descript:FilterFrameText;
      
      private var _price:FilterFrameText;
      
      public function SellGoodsFrame()
      {
         super();
         initView();
         addEventListener("response",__responseHandler);
         _confirm.addEventListener("click",__confirmhandler);
         _cancel.addEventListener("click",__cancelHandler);
      }
      
      protected function __confirmhandler(event:MouseEvent) : void
      {
         ok();
      }
      
      protected function __cancelHandler(event:MouseEvent) : void
      {
         cancel();
      }
      
      protected function __responseHandler(event:FrameEvent) : void
      {
         switch(int(event.responseCode))
         {
            case 0:
            case 1:
               cancel();
               break;
            case 2:
            case 3:
            case 4:
               ok();
         }
      }
      
      private function ok() : void
      {
         SoundManager.instance.play("008");
         SocketManager.Instance.out.reclaimGoods(_itemInfo.BagType,_itemInfo.Place,_itemInfo.Count);
         dispatchEvent(new Event("ok"));
         dispose();
      }
      
      private function cancel() : void
      {
         SoundManager.instance.play("008");
         dispatchEvent(new Event("cancel"));
         dispose();
      }
      
      public function set itemInfo(info:InventoryItemInfo) : void
      {
         _itemInfo = info;
         _cell.info = info;
         if(info.Name.length > 22)
         {
            _nameTxt.text = info.Name.substr(0,22) + "...";
         }
         else
         {
            _nameTxt.text = info.Name;
         }
         if(info.CategoryID == 18)
         {
            _nameTxt.textColor = QualityType.QUALITY_COLOR[info.Quality + 1];
         }
         else
         {
            _nameTxt.textColor = QualityType.QUALITY_COLOR[info.Quality];
         }
         var type:String = info.ReclaimType == 1?LanguageMgr.GetTranslation("shop.ShopIIShoppingCarItem.gold"):info.ReclaimType == 2?LanguageMgr.GetTranslation("tank.gameover.takecard.gifttoken"):"";
         var str:String = "                                                       ";
         _descript.htmlText = LanguageMgr.GetTranslation("bagAndInfo.sellFrame.explainTxt",info.Count) + "              " + str.substr(0,_price.text.length * 2 + 2) + type;
         _price.text = info.Count * info.ReclaimValue + "";
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("AlertDialog.Info");
         _confirm = ComponentFactory.Instance.creatComponentByStylename("sellGoodsFrame.ok");
         _confirm.text = LanguageMgr.GetTranslation("ok");
         _cancel = ComponentFactory.Instance.creatComponentByStylename("sellGoodsFrame.cancel");
         _cancel.text = LanguageMgr.GetTranslation("cancel");
         _cell = new BaseCell(ClassUtils.CreatInstance("asset.core.ItemCellBG"));
         PositionUtils.setPos(_cell,"sellFrame.cellPos");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("sellGoodsFrame.name");
         PositionUtils.setPos(_nameTxt,"sellFrame.namePos");
         _descript = ComponentFactory.Instance.creatComponentByStylename("sellGoodsFrame.explain");
         _price = ComponentFactory.Instance.creatComponentByStylename("sellGoodsFrame.price");
         addToContent(_confirm);
         addToContent(_cancel);
         addToContent(_cell);
         addToContent(_nameTxt);
         addToContent(_descript);
         addToContent(_price);
      }
      
      override public function dispose() : void
      {
         removeEventListener("response",__responseHandler);
         if(_confirm)
         {
            _confirm.removeEventListener("click",__confirmhandler);
         }
         if(_cancel)
         {
            _cancel.removeEventListener("click",__cancelHandler);
         }
         super.dispose();
         _itemInfo = null;
         if(_confirm)
         {
            ObjectUtils.disposeObject(_confirm);
         }
         _confirm = null;
         if(_cancel)
         {
            ObjectUtils.disposeObject(_cancel);
         }
         _cancel = null;
         if(_cell)
         {
            ObjectUtils.disposeObject(_cell);
         }
         _cell = null;
         if(_nameTxt)
         {
            ObjectUtils.disposeObject(_nameTxt);
         }
         _nameTxt = null;
         if(_descript)
         {
            ObjectUtils.disposeObject(_descript);
         }
         _descript = null;
         if(_price)
         {
            ObjectUtils.disposeObject(_price);
         }
         _price = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
