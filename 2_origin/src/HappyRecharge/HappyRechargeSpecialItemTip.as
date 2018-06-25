package HappyRecharge
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.tip.BaseTip;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.utils.PositionUtils;
   import flash.geom.Point;
   
   public class HappyRechargeSpecialItemTip extends BaseTip
   {
       
      
      private var _bg:ScaleBitmapImage;
      
      private var _titleTxt:FilterFrameText;
      
      private var _bodyTxt:FilterFrameText;
      
      private var _line:ScaleBitmapImage;
      
      public function HappyRechargeSpecialItemTip()
      {
         super();
      }
      
      override protected function init() : void
      {
         _bg = ComponentFactory.Instance.creat("core.GoodsTipBg");
         _titleTxt = ComponentFactory.Instance.creatComponentByStylename("mainframe.specialitemtip.titleTxt");
         _bodyTxt = ComponentFactory.Instance.creatComponentByStylename("mainframe.specialitemtip.bodyTxt");
         _line = ComponentFactory.Instance.creatComponentByStylename("HRuleAsset");
         _line.width = 180;
         PositionUtils.setPos(_line,"mainframe.specialitemtip.line.pos");
         addChild(_line);
         var bgWidthAndHeight:Point = PositionUtils.creatPoint("mainframe.specialitemtip.tipwidthandheight");
         setBGWidth(bgWidthAndHeight.x);
         setBGHeight(bgWidthAndHeight.y);
         this.tipbackgound = _bg;
      }
      
      public function setBGWidth(bgWidth:int = 0) : void
      {
         _bg.width = bgWidth;
      }
      
      public function setBGHeight(bgHeight:int = 0) : void
      {
         _bg.height = bgHeight;
      }
      
      override public function set tipData(data:Object) : void
      {
         .super.tipData = data;
         var info:HappyRechargeSpecialItemTipInfo = data as HappyRechargeSpecialItemTipInfo;
         _titleTxt.text = info._title;
         _bodyTxt.htmlText = info._body;
      }
      
      override protected function addChildren() : void
      {
         super.addChildren();
         if(_titleTxt)
         {
            addChild(_titleTxt);
         }
         if(_line)
         {
            addChild(_line);
         }
         if(_bodyTxt)
         {
            addChild(_bodyTxt);
         }
      }
      
      override public function dispose() : void
      {
         super.dispose();
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
            _bg = null;
         }
         if(_titleTxt)
         {
            ObjectUtils.disposeObject(_titleTxt);
            _titleTxt = null;
         }
         if(_line)
         {
            ObjectUtils.disposeObject(_line);
            _line = null;
         }
         if(_bodyTxt)
         {
            ObjectUtils.disposeObject(_bodyTxt);
            _bodyTxt = null;
         }
      }
   }
}
