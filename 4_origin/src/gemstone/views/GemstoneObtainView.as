package gemstone.views
{
   import bagAndInfo.cell.PersonalInfoCell;
   import baglocked.BaglockedManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.ShopManager;
   import ddt.manager.SocketManager;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class GemstoneObtainView extends Frame
   {
       
      
      private var _buyBtn:SimpleBitmapButton;
      
      private var _pic:Bitmap;
      
      private var _figGetTxt:FilterFrameText;
      
      private var _shopTxt:FilterFrameText;
      
      private var _othersTxt:FilterFrameText;
      
      private var _inputTxt1:FilterFrameText;
      
      private var _inputTxt2:FilterFrameText;
      
      private var _killBoss:FilterFrameText;
      
      private var _effect:FilterFrameText;
      
      private var _road:FilterFrameText;
      
      private var _effDescri:FilterFrameText;
      
      private var _bg:Bitmap;
      
      private var _numBg1:Bitmap;
      
      private var _numBg2:Bitmap;
      
      private var _line:Bitmap;
      
      private var price:int;
      
      private var icon:Bitmap;
      
      private var item:PersonalInfoCell;
      
      private var _goodsNumTxt:FilterFrameText;
      
      private var _priceTxt:FilterFrameText;
      
      public function GemstoneObtainView()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("gemstone.rightr");
         addChild(_bg);
         _numBg1 = ComponentFactory.Instance.creatBitmap("gemstone.num");
         _numBg1.x = 85;
         _numBg1.y = 87;
         addChild(_numBg1);
         _numBg2 = ComponentFactory.Instance.creatBitmap("gemstone.num");
         _numBg2.x = 85;
         _numBg2.y = 118;
         addChild(_numBg2);
         _line = ComponentFactory.Instance.creatBitmap("gemstone.line");
         addChild(_line);
         _figGetTxt = ComponentFactory.Instance.creatComponentByStylename("zhanhunTxt");
         _figGetTxt.text = LanguageMgr.GetTranslation("ddt.gemstone.curInfo.figGetTxt");
         addChild(_figGetTxt);
         _shopTxt = ComponentFactory.Instance.creatComponentByStylename("gemstoneShopTxt");
         _shopTxt.text = LanguageMgr.GetTranslation("ddt.gemstone.curInfo.shopTxt");
         addChild(_shopTxt);
         _othersTxt = ComponentFactory.Instance.creatComponentByStylename("othersTxt");
         _othersTxt.text = LanguageMgr.GetTranslation("ddt.gemstone.curInfo.othersTxt");
         addChild(_othersTxt);
         _goodsNumTxt = ComponentFactory.Instance.creatComponentByStylename("gemstone.num");
         _goodsNumTxt.text = LanguageMgr.GetTranslation("ddt.gemstone.obtain.num");
         addChild(_goodsNumTxt);
         _priceTxt = ComponentFactory.Instance.creatComponentByStylename("gemstone.liquan");
         _priceTxt.text = LanguageMgr.GetTranslation("ddt.gemstone.obtain.lijuan");
         addChild(_priceTxt);
         _road = ComponentFactory.Instance.creatComponentByStylename("zhanhunshuoming");
         _road.x = 9;
         _road.y = 250;
         _road.text = LanguageMgr.GetTranslation("ddt.gemstone.obtain.road");
         addChild(_road);
         _effect = ComponentFactory.Instance.creatComponentByStylename("zhanhunUsed");
         _effect.text = LanguageMgr.GetTranslation("ddt.gemstone.obtain.effect");
         _effect.y = 315;
         _effect.x = 9;
         addChild(_effect);
         _effDescri = ComponentFactory.Instance.creatComponentByStylename("zhanhunshuoming");
         _effDescri.x = 9;
         _effDescri.y = 344;
         _effDescri.width = 280;
         _effDescri.text = LanguageMgr.GetTranslation("ddt.gemstone.obtain.effectdescrip2");
         addChild(_effDescri);
         _pic = ComponentFactory.Instance.creatBitmap("gemstone.goodscontent");
         addChild(_pic);
         item = new PersonalInfoCell();
         item.info = ItemManager.Instance.getTemplateById(100100);
         price = ShopManager.Instance.getShopItemByGoodsID(10010001).AValue1;
         item.x = 25;
         item.y = 93;
         addChild(item);
         _inputTxt1 = ComponentFactory.Instance.creatComponentByStylename("gemstone.numinput");
         _inputTxt1.addEventListener("change",inputChangeHander);
         _inputTxt1.restrict = "0-9";
         _inputTxt1.text = "10";
         addChild(_inputTxt1);
         _inputTxt2 = ComponentFactory.Instance.creatComponentByStylename("gemstone.liquanNum");
         _inputTxt2.addEventListener("change",inputChangeHander);
         _inputTxt2.text = String(price * int(_inputTxt1.text));
         addChild(_inputTxt2);
         _buyBtn = ComponentFactory.Instance.creatComponentByStylename("buyButton");
         addChild(_buyBtn);
         _buyBtn.addEventListener("click",saleClickHander);
      }
      
      protected function inputChangeHander(event:Event) : void
      {
         if(int(_inputTxt1.text) > 50)
         {
            _inputTxt1.text = "50";
         }
         else if(_inputTxt1.text == "" || int(_inputTxt1.text) <= 0)
         {
            _inputTxt1.text = "1";
         }
         _inputTxt2.text = String(int(_inputTxt1.text) * price);
      }
      
      protected function saleClickHander(event:MouseEvent) : void
      {
         var i:int = 0;
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var items:Array = [];
         var types:Array = [];
         var colors:Array = [];
         var dresses:Array = [];
         var places:Array = [];
         var goodsTypes:Array = [];
         var len:int = _inputTxt1.text;
         for(i = 0; i < int(_inputTxt1.text); )
         {
            items.push(10010001);
            types.push(1);
            colors.push("");
            dresses.push("");
            places.push("");
            goodsTypes.push(1);
            i++;
         }
         SocketManager.Instance.out.sendBuyGoods(items,types,colors,places,dresses,null,0,goodsTypes);
      }
      
      override public function dispose() : void
      {
         _buyBtn.removeEventListener("click",saleClickHander);
         if(_buyBtn)
         {
            ObjectUtils.disposeObject(_buyBtn);
         }
         _buyBtn = null;
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
         }
         _bg = null;
         if(_numBg1)
         {
            ObjectUtils.disposeObject(_numBg1);
         }
         _numBg1 = null;
         if(_numBg2)
         {
            ObjectUtils.disposeObject(_numBg2);
         }
         _numBg2 = null;
         if(_line)
         {
            ObjectUtils.disposeObject(_line);
         }
         _line = null;
         if(_figGetTxt)
         {
            ObjectUtils.disposeObject(_figGetTxt);
         }
         _figGetTxt = null;
         if(_shopTxt)
         {
            ObjectUtils.disposeObject(_shopTxt);
         }
         _shopTxt = null;
         if(_othersTxt)
         {
            ObjectUtils.disposeObject(_othersTxt);
         }
         _othersTxt = null;
         if(_inputTxt1)
         {
            ObjectUtils.disposeObject(_inputTxt1);
         }
         _inputTxt1 = null;
         if(_inputTxt2)
         {
            ObjectUtils.disposeObject(_inputTxt2);
         }
         _inputTxt2 = null;
         if(_road)
         {
            ObjectUtils.disposeObject(_road);
         }
         _road = null;
         if(_effect)
         {
            ObjectUtils.disposeObject(_effect);
         }
         _effect = null;
         if(_effDescri)
         {
            ObjectUtils.disposeObject(_effDescri);
         }
         _effDescri = null;
         if(_pic)
         {
            ObjectUtils.disposeObject(_pic);
         }
         _pic = null;
         if(_inputTxt2)
         {
            ObjectUtils.disposeObject(_inputTxt2);
         }
         _inputTxt2 = null;
      }
   }
}
