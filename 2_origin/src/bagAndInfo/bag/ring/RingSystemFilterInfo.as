package bagAndInfo.bag.ring
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   
   public class RingSystemFilterInfo extends Component
   {
       
      
      private var _info:FilterFrameText;
      
      private var _index:int;
      
      public function RingSystemFilterInfo(index:int)
      {
         super();
         _index = index;
         tipStyle = "ddt.view.tips.OneLineTip";
         tipDirctions = "2";
         tipGapV = 4;
         _info = ComponentFactory.Instance.creatComponentByStylename("bagAndInfo.bag.RingSystemView.fightData");
         addChild(_info);
         _info.setFrame(index);
      }
      
      public function setInfoText(obj:Object) : void
      {
         _info.text = obj.info + LanguageMgr.GetTranslation("ddt.vip.PrivilegeViewItem.TimesUnit");
         tipData = obj.tipData;
         this.width = _info.width;
         this.height = _info.height;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         ObjectUtils.disposeObject(_info);
         _info = null;
      }
   }
}
