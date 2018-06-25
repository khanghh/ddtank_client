package auctionHouse.view
{
   import auctionHouse.AuctionState;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.ShowTipManager;
   import com.pickgliss.ui.controls.cell.IListCell;
   import com.pickgliss.ui.controls.list.List;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.command.StripTip;
   import ddt.manager.LanguageMgr;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   
   [Event(name="selectStrip",type="auctionHouse.event.AuctionHouseEvent")]
   public class StripView extends BaseStripView implements IListCell
   {
       
      
      private var _seller:FilterFrameText;
      
      private var _lef:Sprite;
      
      private var _curPrice:StripCurPriceView;
      
      private var _vieTip:StripTip;
      
      private var _lefTip:StripTip;
      
      public function StripView()
      {
         super();
      }
      
      override protected function initView() : void
      {
         super.initView();
         _seller = ComponentFactory.Instance.creat("auctionHouse.BaseStripSeller");
         addChild(_seller);
         var _vie:Bitmap = ComponentFactory.Instance.creatBitmap("asset.auctionHouse.StripIocnAsset");
         _vieTip = ComponentFactory.Instance.creat("auctionHouse.view.StripIocn");
         _vieTip.setView(_vie);
         _vieTip.tipData = LanguageMgr.GetTranslation("tank.auctionHouse.view.auctioned");
         addChildAt(_vieTip,getChildIndex(_leftTime) + 1);
         _vieTip.visible = false;
         _lef = drawRect(_leftTime.textWidth,_leftTime.textHeight);
         _lef.alpha = 0;
         _lefTip = ComponentFactory.Instance.creat("auctionHouse.view.StripLeftTime");
         _lefTip.setView(_lef);
         addChild(_lefTip);
         _curPrice = ComponentFactory.Instance.creat("auctionHouse.view.StripCurPriceView");
         addChild(_curPrice);
         buttonMode = true;
      }
      
      private function drawRect(w:Number, h:Number) : Sprite
      {
         var sprite:Sprite = new Sprite();
         sprite.graphics.beginFill(16777215);
         sprite.graphics.drawRect(0,0,w,h);
         sprite.graphics.endFill();
         return sprite;
      }
      
      public function setListCellStatus(list:List, isSelected:Boolean, index:int) : void
      {
         isSelect = isSelected;
      }
      
      public function getCellValue() : *
      {
         return _info;
      }
      
      public function setCellValue(value:*) : void
      {
         info = value;
      }
      
      override protected function updateInfo() : void
      {
         var newStr:* = null;
         super.updateInfo();
         var str:String = (_info.Price / _info.BagItemInfo.Count).toString();
         var arr:Array = str.split(".");
         if(arr[1])
         {
            newStr = arr[0] + "." + arr[1].charAt(0);
         }
         else
         {
            newStr = str;
         }
         if(AuctionState.CURRENTSTATE == "sell")
         {
            if(_info.BuyerName == "")
            {
               _seller.text = newStr;
            }
            else
            {
               _seller.text = newStr;
            }
         }
         else
         {
            _seller.text = newStr;
            _vieTip.visible = _info.BuyerName != "";
         }
         var _loc4_:* = _leftTime.textWidth;
         _lefTip.width = _loc4_;
         _lef.width = _loc4_;
         _loc4_ = _leftTime.textHeight;
         _lefTip.height = _loc4_;
         _lef.height = _loc4_;
         _curPrice.info = _info;
         ShowTipManager.Instance.removeCurrentTip();
         _lefTip.tipData = _info.getSithTimeDescription();
         this.mouseEnabled = true;
      }
      
      override function clearSelectStrip() : void
      {
         super.clearSelectStrip();
         _seller.text = "";
         if(_curPrice && _curPrice.parent)
         {
            _curPrice.parent.removeChild(_curPrice);
         }
         if(_vieTip && _vieTip.parent)
         {
            _vieTip.parent.removeChild(_vieTip);
         }
         this.mouseEnabled = false;
      }
      
      public function asDisplayObject() : DisplayObject
      {
         return this;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         if(_seller)
         {
            ObjectUtils.disposeObject(_seller);
         }
         _seller = null;
         if(_vieTip)
         {
            ObjectUtils.disposeObject(_vieTip);
         }
         _vieTip = null;
         if(_lef)
         {
            ObjectUtils.disposeObject(_lef);
         }
         _lef = null;
         if(_curPrice)
         {
            ObjectUtils.disposeObject(_curPrice);
         }
         _curPrice = null;
         if(_lefTip)
         {
            ObjectUtils.disposeObject(_lefTip);
         }
         _lefTip = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
