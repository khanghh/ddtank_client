package bagAndInfo.ddtKingGrade
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.tip.BaseTip;
   import com.pickgliss.ui.tip.ITip;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.utils.PositionUtils;
   
   public class DDTKingGradeTips extends BaseTip implements Disposeable, ITip
   {
       
      
      private var _line:Image;
      
      private var _currentText:FilterFrameText;
      
      private var _nextText:FilterFrameText;
      
      private var _needText:FilterFrameText;
      
      private var _currentValue:FilterFrameText;
      
      private var _nextValue:FilterFrameText;
      
      private var _needValue:FilterFrameText;
      
      private var _maxLevelText:FilterFrameText;
      
      private var _bg:ScaleBitmapImage;
      
      public function DDTKingGradeTips()
      {
         super();
      }
      
      override protected function init() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("core.GoodsTipBg");
         _bg.width = 173;
         addChild(_bg);
         _line = ComponentFactory.Instance.creatComponentByStylename("HRuleAsset");
         _line.width = 140;
         PositionUtils.setPos(_line,"ddtKingGrade.linePos");
         addChild(_line);
         _currentText = ComponentFactory.Instance.creatComponentByStylename("ddtkinggrade.tipsText");
         _currentText.text = LanguageMgr.GetTranslation("ddtKingGrade.currentProperty");
         PositionUtils.setPos(_currentText,"ddtKingGrade.tipsText1");
         addChild(_currentText);
         _nextText = ComponentFactory.Instance.creatComponentByStylename("ddtkinggrade.tipsText");
         _nextText.text = LanguageMgr.GetTranslation("ddtKingGrade.nextProperty");
         PositionUtils.setPos(_nextText,"ddtKingGrade.tipsText2");
         addChild(_nextText);
         _needText = ComponentFactory.Instance.creatComponentByStylename("ddtkinggrade.tipsText");
         _needText.text = LanguageMgr.GetTranslation("ddtKingGrade.needCount");
         PositionUtils.setPos(_needText,"ddtKingGrade.tipsText3");
         addChild(_needText);
         _currentValue = ComponentFactory.Instance.creatComponentByStylename("ddtkinggrade.tipsValue");
         PositionUtils.setPos(_currentValue,"ddtKingGrade.tipsValue1");
         addChild(_currentValue);
         _nextValue = ComponentFactory.Instance.creatComponentByStylename("ddtkinggrade.tipsValue");
         PositionUtils.setPos(_nextValue,"ddtKingGrade.tipsValue2");
         addChild(_nextValue);
         _needValue = ComponentFactory.Instance.creatComponentByStylename("ddtkinggrade.tipsValue");
         PositionUtils.setPos(_needValue,"ddtKingGrade.tipsValue3");
         addChild(_needValue);
         _maxLevelText = ComponentFactory.Instance.creatComponentByStylename("ddtkinggrade.maxLevelText");
         _maxLevelText.text = LanguageMgr.GetTranslation("ddtKingGrade.maxProperty");
         addChild(_maxLevelText);
         super.init();
      }
      
      override public function set tipData(param1:Object) : void
      {
         if(param1 == null)
         {
            return;
         }
         _tipData = param1;
         var _loc7_:int = _tipData.cost;
         var _loc6_:DDTKingGradeInfo = DDTKingGradeManager.Instance.getInfoByCost(_loc7_);
         var _loc2_:int = _loc6_.Level;
         var _loc5_:int = _tipData.currentCost;
         var _loc4_:DDTKingGradeInfo = DDTKingGradeManager.Instance.data[_loc2_ + 1];
         var _loc3_:Array = ["Attack","Defence","Agility","Lucky","MagicAttack","MagicDefence"];
         _currentValue.text = _loc6_[_loc3_[_tipData.type]] / 10 + "%";
         if(_loc4_)
         {
            _bg.height = 100;
            _nextText.visible = true;
            _needText.visible = true;
            _nextValue.visible = true;
            _needValue.visible = true;
            _maxLevelText.visible = false;
            _nextValue.text = _loc4_[_loc3_[_tipData.type]] / 10 + "%";
            _needValue.text = (_loc4_.Cost - _loc7_).toString();
            if(_loc4_.Cost > _loc7_ + _loc5_)
            {
               _needValue.setFrame(3);
            }
            else
            {
               _needValue.setFrame(2);
            }
         }
         else
         {
            _bg.height = 75;
            _maxLevelText.visible = true;
            _nextText.visible = false;
            _needText.visible = false;
            _nextValue.visible = false;
            _needValue.visible = false;
         }
         updateView();
      }
      
      private function updateView() : void
      {
      }
      
      override public function get tipData() : Object
      {
         return _tipData;
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_line);
         _line = null;
         ObjectUtils.disposeObject(_currentText);
         _currentText = null;
         ObjectUtils.disposeObject(_nextText);
         _nextText = null;
         ObjectUtils.disposeObject(_needText);
         _needText = null;
         ObjectUtils.disposeObject(_currentValue);
         _currentValue = null;
         ObjectUtils.disposeObject(_nextValue);
         _nextValue = null;
         ObjectUtils.disposeObject(_needValue);
         _needValue = null;
         super.dispose();
      }
   }
}
