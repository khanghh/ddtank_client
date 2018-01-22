package ddt.view.tips
{
   import com.pickgliss.ui.ComponentFactory;
   
   public class GradeLimitTip extends OneLineTip
   {
       
      
      public function GradeLimitTip()
      {
         super();
      }
      
      override protected function init() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("core.commonTipBg");
         _contentTxt = ComponentFactory.Instance.creatComponentByStylename("core.goodTip.LimitGradeTxt");
         addChild(_bg);
         addChild(_contentTxt);
      }
   }
}
