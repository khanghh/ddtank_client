package vip.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import flash.display.Sprite;
   
   public class GrowthRuleView extends Sprite implements Disposeable
   {
       
      
      private var _bg1:Image;
      
      private var _bg2:Image;
      
      private var _descriptionItem1:Image;
      
      private var _descriptionItem2:Image;
      
      private var _descriptionItem3:Image;
      
      private var _descriptionTxt1:FilterFrameText;
      
      private var _descriptionTxt2:FilterFrameText;
      
      private var _descriptionTxt3:FilterFrameText;
      
      private var _ruleTxtBg:Image;
      
      private var _ruleTitleTxt:FilterFrameText;
      
      private var _ruleTxt:FilterFrameText;
      
      public function GrowthRuleView()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _bg1 = ComponentFactory.Instance.creatComponentByStylename("vip.GrowthRuleViewBg");
         _descriptionItem1 = ComponentFactory.Instance.creatComponentByStylename("vip.GrowthRuleView.DescItem1");
         _descriptionItem2 = ComponentFactory.Instance.creatComponentByStylename("vip.GrowthRuleView.DescItem2");
         _descriptionItem3 = ComponentFactory.Instance.creatComponentByStylename("vip.GrowthRuleView.DescItem3");
         _descriptionTxt1 = ComponentFactory.Instance.creatComponentByStylename("vip.GrowthRuleView.DescTxt1");
         _descriptionTxt1.text = LanguageMgr.GetTranslation("ddt.vip.GrowthRuleView.DescTxt1");
         _descriptionTxt2 = ComponentFactory.Instance.creatComponentByStylename("vip.GrowthRuleView.DescTxt2");
         _descriptionTxt2.text = LanguageMgr.GetTranslation("ddt.vip.GrowthRuleView.DescTxt2");
         _descriptionTxt3 = ComponentFactory.Instance.creatComponentByStylename("vip.GrowthRuleView.DescTxt3");
         _descriptionTxt3.text = LanguageMgr.GetTranslation("ddt.vip.GrowthRuleView.DescTxt3");
         _bg2 = ComponentFactory.Instance.creatComponentByStylename("vip.GrowthRuleViewBg2");
         _ruleTxtBg = ComponentFactory.Instance.creatComponentByStylename("vip.GrowthRuleView.RuleTxtBg");
         _ruleTitleTxt = ComponentFactory.Instance.creatComponentByStylename("vip.GrowthRuleView.RuleTxtTitle");
         _ruleTitleTxt.text = LanguageMgr.GetTranslation("ddt.vip.GrowthRuleView.RuleTitleTxt");
         _ruleTxt = ComponentFactory.Instance.creatComponentByStylename("vip.GrowthRuleView.RuleTxt");
         _ruleTxt.text = LanguageMgr.GetTranslation("ddt.vip.GrowthRuleView.RuleTxt1") + LanguageMgr.GetTranslation("ddt.vip.GrowthRuleView.RuleTxt2") + LanguageMgr.GetTranslation("ddt.vip.GrowthRuleView.RuleTxt3") + LanguageMgr.GetTranslation("ddt.vip.GrowthRuleView.RuleTxt4") + LanguageMgr.GetTranslation("ddt.vip.GrowthRuleView.RuleTxt5");
         addChild(_bg1);
         addChild(_descriptionItem1);
         addChild(_descriptionItem2);
         addChild(_descriptionItem3);
         addChild(_descriptionTxt1);
         addChild(_descriptionTxt2);
         addChild(_descriptionTxt3);
         addChild(_bg2);
         addChild(_ruleTxtBg);
         addChild(_ruleTitleTxt);
         addChild(_ruleTxt);
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_bg1);
         ObjectUtils.disposeObject(_bg2);
         ObjectUtils.disposeObject(_descriptionItem1);
         ObjectUtils.disposeObject(_descriptionItem2);
         ObjectUtils.disposeObject(_descriptionItem3);
         ObjectUtils.disposeObject(_descriptionTxt1);
         ObjectUtils.disposeObject(_descriptionTxt2);
         ObjectUtils.disposeObject(_descriptionTxt3);
         ObjectUtils.disposeObject(_ruleTxtBg);
         ObjectUtils.disposeObject(_ruleTitleTxt);
         ObjectUtils.disposeObject(_ruleTxt);
         _bg1 = null;
         _bg2 = null;
         _descriptionItem1 = null;
         _descriptionItem2 = null;
         _descriptionItem3 = null;
         _descriptionTxt1 = null;
         _descriptionTxt2 = null;
         _descriptionTxt3 = null;
         _ruleTxtBg = null;
         _ruleTitleTxt = null;
         _ruleTxt = null;
      }
   }
}
