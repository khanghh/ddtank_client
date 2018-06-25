package gameStarling.view.buff.tips
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.view.tips.BaseBuffPropertyTip;
   
   public class TrialBuffTip extends BaseBuffPropertyTip
   {
       
      
      private var _proTxt:FilterFrameText;
      
      public function TrialBuffTip()
      {
         super();
         titleTxt = LanguageMgr.GetTranslation("ddt.gameView.buff.trialBuffTip");
         conditionTxt = LanguageMgr.GetTranslation("ddt.gameView.buff.trialBuffConditionTxt");
      }
      
      override public function set tipData(data:Object) : void
      {
         var index:int = 0;
         .super.tipData = data;
         var proValue:Array = String(data).split(",");
         var proName:Array = getProName();
         var temValue:String = "";
         var temLen:int = proName.length;
         for(index = 0; index < temLen; index++)
         {
            if(proValue.length > 0 && proValue.length == temLen)
            {
               if(proValue[index] > 0)
               {
                  _proTxt = ComponentFactory.Instance.creatComponentByStylename("game.kingbless.tipView.valueTxt");
                  temValue = int(proValue[index]) >= 0?"+" + int(proValue[index]):"-" + int(proValue[index]);
                  _proTxt.text = proName[index] + temValue;
               }
               else
               {
                  continue;
               }
            }
            else
            {
               _proTxt = ComponentFactory.Instance.creatComponentByStylename("game.kingbless.tipView.valueTxt");
               _proTxt.text = proName[index];
            }
            _proTxt.y = _propertySpri.numChildren * 20;
            _propertySpri.addChild(_proTxt);
         }
      }
      
      override protected function getProName() : Array
      {
         return LanguageMgr.GetTranslation("ddt.gameView.buff.trialBuff.propertyTxt").split(",");
      }
      
      override public function dispose() : void
      {
         super.dispose();
         if(_proTxt)
         {
            ObjectUtils.disposeObject(_proTxt);
         }
         _proTxt = null;
      }
   }
}
