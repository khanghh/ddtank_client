package beadSystem.tips
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.tip.BaseTip;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.ServerConfigManager;
   
   public class BeadBtnTip extends BaseTip
   {
       
      
      private var _bg:ScaleBitmapImage;
      
      private var _nameTxt:FilterFrameText;
      
      private var _discTxt:FilterFrameText;
      
      private var _beadTipData:Object;
      
      private var _nameList:Array;
      
      private var _priceList:Array;
      
      public function BeadBtnTip()
      {
         super();
         initView();
         initData();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("beadSystem.getBead.requestBtn.tip.bg");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("beadSystem.getBead.requestBtn.tip.name");
         _discTxt = ComponentFactory.Instance.creatComponentByStylename("beadSystem.getBead.requestBtn.tip.disc");
         addChild(_bg);
         addChild(_nameTxt);
         addChild(_discTxt);
      }
      
      private function initData() : void
      {
         var nameListStr:String = LanguageMgr.GetTranslation("ddt.beadSystem.requestBeadNames");
         _nameList = nameListStr.split(",");
         _priceList = ServerConfigManager.instance.getRequestBeadPrice();
      }
      
      override public function get tipData() : Object
      {
         return _beadTipData;
      }
      
      override public function set tipData(data:Object) : void
      {
         var tmpName:* = null;
         var tmpDisc:int = 0;
         _beadTipData = data;
         var place:int = data;
         switch(int(place))
         {
            case 0:
               tmpName = _nameList[0];
               tmpDisc = _priceList[0];
               break;
            case 1:
               tmpName = _nameList[1];
               tmpDisc = _priceList[1];
               break;
            case 2:
               tmpName = _nameList[2];
               tmpDisc = _priceList[2];
               break;
            case 3:
               tmpName = _nameList[3];
               tmpDisc = _priceList[3];
         }
         _nameTxt.text = tmpName;
         _discTxt.text = LanguageMgr.GetTranslation("ddt.beadSystem.getBead.requestBtn.tip.disc") + tmpDisc.toString();
         updateSize();
      }
      
      private function updateSize() : void
      {
         _bg.width = Math.max(_discTxt.x + _discTxt.width,_nameTxt.x + _nameTxt.width) + 15;
         _bg.height = _discTxt.y + _discTxt.height + 10;
      }
      
      override public function dispose() : void
      {
         _beadTipData = null;
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
         }
         _bg = null;
         if(_nameTxt)
         {
            ObjectUtils.disposeObject(_nameTxt);
         }
         _nameTxt = null;
         if(_discTxt)
         {
            ObjectUtils.disposeObject(_discTxt);
         }
         _discTxt = null;
         super.dispose();
      }
   }
}
