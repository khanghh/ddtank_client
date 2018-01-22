package vip.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.image.TiledImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   
   public class VipGiftDetail extends Sprite implements Disposeable
   {
       
      
      private var _bg:ScaleBitmapImage;
      
      private var _iconBg:DisplayObject;
      
      private var _line:TiledImage;
      
      private var _giftIcon:ScaleBitmapImage;
      
      private var _vipSubIcon:ScaleBitmapImage;
      
      private var _detailTxt:FilterFrameText;
      
      private var _index:int;
      
      public function VipGiftDetail()
      {
         super();
      }
      
      public function setData(param1:int) : void
      {
         _index = param1;
         updateView();
      }
      
      private function updateView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("vip.GiftContentView.BG");
         _iconBg = ComponentFactory.Instance.creatCustomObject("vip.GiftContentView.ItemCellBG");
         _line = ComponentFactory.Instance.creatComponentByStylename("vip.GiftContentView.Line");
         _giftIcon = ComponentFactory.Instance.creatComponentByStylename("vip.GiftContentView.GiftIcon");
         _vipSubIcon = ComponentFactory.Instance.creatComponentByStylename("vip.GiftContentView.VipSubIcon" + _index);
         _detailTxt = ComponentFactory.Instance.creatComponentByStylename("vip.GiftContentView.DetailTxt");
         var _loc1_:String = LanguageMgr.GetTranslation("ddt.vip.GifContentView.itemTxt" + _index);
         _detailTxt.text = _loc1_;
         addChild(_bg);
         addChild(_iconBg);
         addChild(_line);
         addChild(_giftIcon);
         addChild(_vipSubIcon);
         addChild(_detailTxt);
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_iconBg);
         _iconBg = null;
         ObjectUtils.disposeObject(_line);
         _line = null;
         ObjectUtils.disposeObject(_giftIcon);
         _giftIcon = null;
         ObjectUtils.disposeObject(_vipSubIcon);
         _vipSubIcon = null;
         ObjectUtils.disposeObject(_detailTxt);
         _detailTxt = null;
      }
   }
}
