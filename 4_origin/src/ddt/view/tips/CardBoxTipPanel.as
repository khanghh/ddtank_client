package ddt.view.tips
{
   import cardSystem.CardManager;
   import cardSystem.data.SetsInfo;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.tip.BaseTip;
   import com.pickgliss.ui.tip.ITip;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.data.goods.QualityType;
   import ddt.data.goods.ShopItemInfo;
   import ddt.manager.LanguageMgr;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   
   public class CardBoxTipPanel extends BaseTip implements ITip, Disposeable
   {
      
      public static const THISWIDTH:int = 300;
       
      
      private var _cardName:FilterFrameText;
      
      private var _cardTypeBit:Bitmap;
      
      private var _cardType:FilterFrameText;
      
      private var _cardSetsBit:Bitmap;
      
      private var _cardSets:FilterFrameText;
      
      private var _cardDescript:FilterFrameText;
      
      private var _bg:ScaleBitmapImage;
      
      private var _band:ScaleFrameImage;
      
      private var _rule:ScaleBitmapImage;
      
      private var _validity:FilterFrameText;
      
      private var _templateInfo:ItemTemplateInfo;
      
      private var isShowed:Boolean = false;
      
      public function CardBoxTipPanel()
      {
         super();
      }
      
      override protected function init() : void
      {
         _bg = ComponentFactory.Instance.creat("core.GoodsTipBg");
         _cardName = ComponentFactory.Instance.creatComponentByStylename("CardBoxTipPanel.name");
         _cardTypeBit = ComponentFactory.Instance.creatBitmap("asset.core.tip.GoodsType");
         PositionUtils.setPos(_cardTypeBit,"CardBoxTipPanel.typePos");
         _cardType = ComponentFactory.Instance.creatComponentByStylename("CardBoxTipPanel.cardType");
         _cardSetsBit = ComponentFactory.Instance.creatBitmap("asset.core.tip.cardsTipPanel.sets");
         PositionUtils.setPos(_cardSetsBit,"CardBoxTipPanel.setsBitPos");
         _cardSets = ComponentFactory.Instance.creatComponentByStylename("CardBoxTipPanel.cardSets");
         _cardDescript = ComponentFactory.Instance.creatComponentByStylename("CardBoxTipPanel.descrip");
         _band = ComponentFactory.Instance.creatComponentByStylename("tipPanel.band");
         _rule = ComponentFactory.Instance.creatComponentByStylename("HRuleAsset");
         PositionUtils.setPos(_rule,"CardBoxTipPanel.rulePos");
         _rule.width = 160;
         _validity = ComponentFactory.Instance.creatComponentByStylename("CardsTipPanel.basePropTitle");
         _validity.x = 10;
         super.init();
         .super.tipbackgound = _bg;
      }
      
      override protected function addChildren() : void
      {
         super.addChildren();
         addChild(_cardName);
         addChild(_cardTypeBit);
         addChild(_cardType);
         addChild(_cardSetsBit);
         addChild(_cardSets);
         addChild(_cardDescript);
         addChild(_band);
         addChild(_rule);
         addChild(_validity);
         mouseChildren = false;
         mouseEnabled = false;
      }
      
      override public function get tipData() : Object
      {
         return _tipData;
      }
      
      override public function set tipData(data:Object) : void
      {
         if(data is ShopItemInfo)
         {
            _templateInfo = data.TemplateInfo as ItemTemplateInfo;
            this.visible = true;
            _tipData = _templateInfo;
            showTip();
         }
         else if(data)
         {
            _templateInfo = data as ItemTemplateInfo;
            this.visible = true;
            _tipData = _templateInfo;
            showTip();
         }
         else
         {
            this.visible = false;
            _tipData = null;
         }
      }
      
      private function showTip() : void
      {
         var n:int = 0;
         if(_templateInfo is InventoryItemInfo)
         {
            _band.visible = true;
            _band.setFrame(!!(_templateInfo as InventoryItemInfo).IsBinds?1:2);
         }
         else
         {
            _band.visible = false;
         }
         _cardName.text = _templateInfo.Name;
         _cardName.textColor = QualityType.QUALITY_COLOR[4];
         _cardType.text = CardsTipPanel.CARDTYPE[int(_templateInfo.Property6)] + "(" + CardsTipPanel.CARDTYPE_VICE_MAIN[int(_templateInfo.Property8)] + ")";
         var setsInfoVec:Vector.<SetsInfo> = CardManager.Instance.model.setsSortRuleVector;
         var len:int = setsInfoVec.length;
         var setsName:String = "";
         for(n = 0; n < len; )
         {
            if(setsInfoVec[n].ID == _templateInfo.Property7)
            {
               setsName = setsInfoVec[n].name;
               break;
            }
            n++;
         }
         _cardSets.text = setsName;
         if(_templateInfo.TemplateID == 20150 || _templateInfo.TemplateID == 201266)
         {
            _cardType.visible = false;
            _cardSets.visible = false;
            _cardTypeBit.visible = false;
            _cardSetsBit.visible = false;
            _band.y = 11;
            _band.x = 97;
            _rule.y = 40;
            _cardDescript.y = 48;
            _validity.visible = false;
            _cardDescript.text = _templateInfo.Description;
            upBackground();
         }
         else
         {
            _band.y = 35;
            _band.x = _cardType.x + _cardType.width + 10;
            _rule.y = 90;
            _cardDescript.y = 98;
            _cardType.visible = true;
            _cardSets.visible = true;
            _cardTypeBit.visible = true;
            _cardSetsBit.visible = true;
            _validity.visible = true;
            _cardDescript.text = _templateInfo.Description;
            _validity.text = LanguageMgr.GetTranslation("tank.view.bagII.GoodsTipPanel.use");
            _validity.textColor = 16776960;
            _validity.y = _cardDescript.y + _cardDescript.textHeight + 10;
            upBackground();
         }
      }
      
      private function upBackground() : void
      {
         _bg.width = 300 > _band.x + _band.width?300 + 30:Number(_band.x + _band.width + 30);
         if(_templateInfo.TemplateID == 20150 || _templateInfo.TemplateID == 201266)
         {
            _bg.height = _cardDescript.y + _validity.textHeight + 40;
         }
         else
         {
            _bg.height = _validity.y + _validity.textHeight + 10;
         }
         updateWH();
      }
      
      private function updateWH() : void
      {
         _width = _bg.width;
         _height = _bg.height;
      }
      
      override public function dispose() : void
      {
         _templateInfo = null;
         ObjectUtils.disposeAllChildren(this);
         _cardName = null;
         _cardTypeBit = null;
         _cardType = null;
         _cardSetsBit = null;
         _cardSets = null;
         _cardDescript = null;
         _bg = null;
         _band = null;
         _rule = null;
         _validity = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
         super.dispose();
      }
   }
}
