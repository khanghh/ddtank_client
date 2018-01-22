package changeColor.view
{
   import baglocked.BaglockedManager;
   import com.pickgliss.effect.EffectManager;
   import com.pickgliss.effect.IEffect;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.ChangeColorModel;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ShopManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   
   public class ChangeColorRightView extends Sprite implements Disposeable
   {
       
      
      private var _bag:ColorChangeBagListView;
      
      private var _bg:ScaleBitmapImage;
      
      private var _bg1:MutipleImage;
      
      private var _btnBg:ScaleBitmapImage;
      
      private var _text1Img:FilterFrameText;
      
      private var _textImg:FilterFrameText;
      
      private var _shineEffect:IEffect;
      
      private var _changeColorBtn:BaseButton;
      
      private var _model:ChangeColorModel;
      
      public function ChangeColorRightView()
      {
         super();
         addEventListener("addedToStage",__addToStage);
         init();
      }
      
      public function dispose() : void
      {
         _model.removeEventListener("setColor",__updateBtn);
         _changeColorBtn.removeEventListener("click",__changeColor);
         ObjectUtils.disposeAllChildren(this);
         _changeColorBtn = null;
         _bag = null;
         _model = null;
         EffectManager.Instance.removeEffect(_shineEffect);
         _shineEffect = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      public function set model(param1:ChangeColorModel) : void
      {
         _model = param1;
         dataUpdate();
      }
      
      private function __alertChangeColor(param1:FrameEvent) : void
      {
         param1.currentTarget.removeEventListener("response",__alertChangeColor);
         SoundManager.instance.play("008");
         if(param1.responseCode == 3 || param1.responseCode == 2)
         {
            if(PlayerManager.Instance.Self.DDTMoney < ShopManager.Instance.getGiftShopItemByTemplateID(11999).getItemPrice(1).ddtMoneyValue)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("shop.view.noOrder"));
               return;
            }
            sendChangeColor();
         }
      }
      
      private function __changeColor(param1:MouseEvent) : void
      {
         var _loc2_:* = null;
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         if(_model.place != -1)
         {
            sendChangeColor();
            _model.place = -1;
         }
         else if(hasColorCard() != -1)
         {
            _model.place = hasColorCard();
            sendChangeColor();
            _model.place = -1;
         }
         else
         {
            _loc2_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tank.consortia.myconsortia.frame.MyConsortiaTax.info"),LanguageMgr.GetTranslation("tank.view.changeColor.lackCard",ShopManager.Instance.getGiftShopItemByTemplateID(11999).getItemPrice(1).ddtMoneyValue),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,false,false,2);
            _loc2_.addEventListener("response",__alertChangeColor);
         }
         _changeColorBtn.enable = false;
      }
      
      private function __updateBtn(param1:Event) : void
      {
         if(!_model.changed)
         {
            _changeColorBtn.enable = false;
         }
         else
         {
            _changeColorBtn.enable = true;
         }
      }
      
      private function dataUpdate() : void
      {
         _model.addEventListener("setColor",__updateBtn);
         _bag.setData(_model.colorEditableBag);
      }
      
      private function hasColorCard() : int
      {
         if(PlayerManager.Instance.Self.PropBag.getItemCountByTemplateId(11999) > 0)
         {
            return PlayerManager.Instance.Self.PropBag.findFistItemByTemplateId(11999).Place;
         }
         return -1;
      }
      
      private function init() : void
      {
         var _loc1_:* = null;
         _bg = ComponentFactory.Instance.creatComponentByStylename("changeColor.rightViewBg");
         _loc1_ = ComponentFactory.Instance.creatCustomObject("changeColor.rightViewBgRec");
         ObjectUtils.copyPropertyByRectangle(_bg,_loc1_);
         addChild(_bg);
         _bg1 = ComponentFactory.Instance.creatComponentByStylename("ColorBGAsset4");
         _loc1_ = ComponentFactory.Instance.creatCustomObject("changeColor.rightViewBgRec1");
         ObjectUtils.copyPropertyByRectangle(_bg1,_loc1_);
         addChild(_bg1);
         _text1Img = ComponentFactory.Instance.creatComponentByStylename("asset.changeColor.text1");
         _text1Img.text = LanguageMgr.GetTranslation("tank.view.changeColor.text4");
         _loc1_ = ComponentFactory.Instance.creatCustomObject("changeColor.text1ImgRec");
         ObjectUtils.copyPropertyByRectangle(_text1Img,_loc1_);
         addChild(_text1Img);
         _textImg = ComponentFactory.Instance.creatComponentByStylename("asset.changeColor.text2");
         _textImg.text = LanguageMgr.GetTranslation("tank.view.changeColor.text5");
         _loc1_ = ComponentFactory.Instance.creatCustomObject("changeColor.textImgRec");
         ObjectUtils.copyPropertyByRectangle(_textImg,_loc1_);
         addChild(_textImg);
         _bag = new ColorChangeBagListView();
         _loc1_ = ComponentFactory.Instance.creatCustomObject("changeColor.bagListViewRec");
         ObjectUtils.copyPropertyByRectangle(_bag,_loc1_);
         addChild(_bag);
         _btnBg = ComponentFactory.Instance.creatComponentByStylename("changeColor.changeColorBtn.bg");
         _loc1_ = ComponentFactory.Instance.creatCustomObject("changeColor.buttonBgRec");
         ObjectUtils.copyPropertyByRectangle(_btnBg,_loc1_);
         addChild(_btnBg);
         _changeColorBtn = ComponentFactory.Instance.creatComponentByStylename("changeColor.changeColorBtn");
         _loc1_ = ComponentFactory.Instance.creatCustomObject("changeColor.changeColorBtnRec");
         ObjectUtils.copyPropertyByRectangle(_changeColorBtn,_loc1_);
         _changeColorBtn.enable = false;
         addChild(_changeColorBtn);
         _changeColorBtn.addEventListener("click",__changeColor);
      }
      
      private function __addToStage(param1:Event) : void
      {
         removeEventListener("addedToStage",__addToStage);
         var _loc2_:Rectangle = ComponentFactory.Instance.creatCustomObject("changeColor.textImgGlowRec");
         _shineEffect = EffectManager.Instance.creatEffect(1,this,"asset.changeColor.shine",_loc2_);
         _shineEffect.stop();
      }
      
      private function sendChangeColor() : void
      {
         var _loc7_:int = 1;
         var _loc2_:int = _model.place;
         var _loc5_:int = _model.currentItem.BagType;
         var _loc4_:int = _model.currentItem.Place;
         var _loc3_:String = _model.currentItem.Color;
         var _loc6_:String = _model.currentItem.Skin;
         var _loc1_:int = 11999;
         _model.initColor = _loc3_;
         _model.initSkinColor = _loc6_;
         SocketManager.Instance.out.sendChangeColor(_loc7_,_loc2_,_loc5_,_loc4_,_loc3_,_loc6_,_loc1_);
         _model.savaItemInfo();
      }
      
      public function get bag() : ColorChangeBagListView
      {
         return _bag;
      }
   }
}
