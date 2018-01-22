package game.view.buff.tips
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
      }
      
      override protected function initView() : void
      {
         super.initView();
         titleTxt = LanguageMgr.GetTranslation("ddt.gameView.buff.trialBuffTip");
         conditionTxt = LanguageMgr.GetTranslation("ddt.gameView.buff.trialBuffConditionTxt");
      }
      
      override public function set tipData(param1:Object) : void
      {
         var _loc2_:int = 0;
         .super.tipData = param1;
         setBgWidth(215);
         var _loc5_:Array = String(param1).split(",");
         var _loc3_:Array = getProName();
         var _loc4_:String = "";
         var _loc6_:int = _loc3_.length;
         _loc2_ = 0;
         for(; _loc2_ < _loc6_; _loc2_++)
         {
            if(_loc5_.length > 0 && _loc5_.length == _loc6_)
            {
               if(_loc5_[_loc2_] > 0)
               {
                  _proTxt = ComponentFactory.Instance.creatComponentByStylename("game.kingbless.tipView.valueTxt");
                  _loc4_ = int(_loc5_[_loc2_]) >= 0?"+" + int(_loc5_[_loc2_]):"-" + int(_loc5_[_loc2_]);
                  _proTxt.text = _loc3_[_loc2_] + _loc4_;
               }
               else
               {
                  continue;
               }
            }
            else
            {
               _proTxt = ComponentFactory.Instance.creatComponentByStylename("game.kingbless.tipView.valueTxt");
               _proTxt.text = _loc3_[_loc2_];
            }
            _proTxt.y = _propertySpri.numChildren * 20;
            _propertySpri.addChild(_proTxt);
            _bg.height = _propertySpri.height + 88;
            _conditionTxt.y = _bg.height - 27;
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
