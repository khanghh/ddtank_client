package gradeBuy.view
{
   import bagAndInfo.cell.BagCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.events.CEvent;
   import ddt.manager.LanguageMgr;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class GradeBuyItem extends Sprite implements Disposeable
   {
      
      public static const BUY:String = "gb_buy";
       
      
      private var _bg:Bitmap;
      
      private var _titleTxt:FilterFrameText;
      
      private var _bagCell:BagCell;
      
      private var _origiPriceTxt:FilterFrameText;
      
      private var _curPriceTxt:FilterFrameText;
      
      private var _crossBitmap:Bitmap;
      
      private var _moneyIcon:Bitmap;
      
      private var _buyBtn:SimpleBitmapButton;
      
      private var _boughtTxt:FilterFrameText;
      
      private var _typeInfo:ItemTemplateInfo;
      
      public function GradeBuyItem(level:int)
      {
         super();
         _bg = ComponentFactory.Instance.creatBitmap("gradeBuy.item.bg");
         addChild(_bg);
         _titleTxt = ComponentFactory.Instance.creat("gradeBuy.item.titleTxt" + level.toString());
         addChild(_titleTxt);
         _bagCell = new BagCell(0);
         _bagCell.width = 68;
         _bagCell.height = 68;
         PositionUtils.setPos(_bagCell,"gradeBuy.item.cell.pt");
         addChild(_bagCell);
         _origiPriceTxt = ComponentFactory.Instance.creat("gradeBuy.Item.origiPriceTxt");
         addChild(_origiPriceTxt);
         _curPriceTxt = ComponentFactory.Instance.creat("gradeBuy.Item.curPriceTxt");
         addChild(_curPriceTxt);
         _crossBitmap = ComponentFactory.Instance.creatBitmap("ast.gb.cross");
         addChild(_crossBitmap);
         _moneyIcon = ComponentFactory.Instance.creatBitmap("ast.gb.moneyIcon");
         addChild(_moneyIcon);
         _buyBtn = ComponentFactory.Instance.creat("gradeBuy.item.buy");
         _buyBtn.addEventListener("click",onBuyClick);
         addChild(_buyBtn);
         _boughtTxt = ComponentFactory.Instance.creat("gradeBuy.Item.boughtTxt");
         _boughtTxt.text = LanguageMgr.GetTranslation("worldboss.buyBuff.haveBuy");
         addChild(_boughtTxt);
      }
      
      protected function onBuyClick(e:MouseEvent) : void
      {
         dispatchEvent(new CEvent("gb_buy",[_typeInfo.TemplateID,_bagCell.info],true));
      }
      
      public function update(typeInfo:ItemTemplateInfo, info:ItemTemplateInfo, canBuy:Boolean) : void
      {
         _typeInfo = typeInfo;
         _titleTxt.text = info.Name;
         _bagCell.info = info;
         _origiPriceTxt.text = LanguageMgr.GetTranslation("gradeBuy.item.originalPrice") + info.Property2;
         _moneyIcon.x = _origiPriceTxt.x + _origiPriceTxt.textWidth + 3;
         _curPriceTxt.text = info.Property3;
         _buyBtn.visible = canBuy;
         _boughtTxt.visible = !canBuy;
      }
      
      public function dispose() : void
      {
         _buyBtn && _buyBtn.removeEventListener("click",onBuyClick);
         ObjectUtils.disposeAllChildren(this);
         _bg = null;
         _titleTxt = null;
         _bagCell = null;
         _origiPriceTxt = null;
         _curPriceTxt = null;
         _crossBitmap = null;
         _moneyIcon = null;
         _buyBtn = null;
         _boughtTxt = null;
      }
   }
}
