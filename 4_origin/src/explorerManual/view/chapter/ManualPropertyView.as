package explorerManual.view.chapter
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.utils.PositionUtils;
   import explorerManual.data.ManualLevelProInfo;
   import flash.display.Sprite;
   
   public class ManualPropertyView extends Sprite implements Disposeable
   {
       
      
      private var _titleTxt:FilterFrameText;
      
      private var _magicAttack:FilterFrameText;
      
      private var _magicResistance:FilterFrameText;
      
      private var _boost:FilterFrameText;
      
      private var _proInfo:ManualLevelProInfo;
      
      public function ManualPropertyView()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _titleTxt = ComponentFactory.Instance.creatComponentByStylename("explorerManual.manualProperty.titleTxt");
         addChild(_titleTxt);
         PositionUtils.setPos(_titleTxt,"explorerManual.proTtilePos");
         _magicAttack = ComponentFactory.Instance.creatComponentByStylename("explorerManual.manualProperty.proNameTxt");
         addChild(_magicAttack);
         PositionUtils.setPos(_magicAttack,"explorerManual.magicAttackPos");
         _magicResistance = ComponentFactory.Instance.creatComponentByStylename("explorerManual.manualProperty.proNameTxt");
         addChild(_magicResistance);
         PositionUtils.setPos(_magicResistance,"explorerManual.magicResistancePos");
         _boost = ComponentFactory.Instance.creatComponentByStylename("explorerManual.manualProperty.proNameTxt");
         addChild(_boost);
         PositionUtils.setPos(_boost,"explorerManual.boostPos");
      }
      
      public function set info(param1:ManualLevelProInfo) : void
      {
         _proInfo = param1;
         update();
      }
      
      private function update() : void
      {
         if(_proInfo == null)
         {
            return;
         }
         if(_titleTxt)
         {
            _titleTxt.text = _proInfo.name;
         }
         if(_magicAttack)
         {
            _magicAttack.text = LanguageMgr.GetTranslation("explorerManual.magicAttackAdd") + _proInfo.magicAttack;
         }
         if(_magicResistance)
         {
            _magicResistance.text = LanguageMgr.GetTranslation("explorerManual.magicResistanceAdd") + _proInfo.magicResistance;
         }
         if(_boost)
         {
            _boost.text = LanguageMgr.GetTranslation("explorerManual.allPagePro") + "+" + _proInfo.boost + "%";
         }
      }
      
      public function dispose() : void
      {
         _proInfo = null;
         if(_titleTxt)
         {
            ObjectUtils.disposeObject(_titleTxt);
         }
         _titleTxt = null;
         if(_magicAttack)
         {
            ObjectUtils.disposeObject(_magicAttack);
         }
         _magicAttack = null;
         if(_magicResistance)
         {
            ObjectUtils.disposeObject(_magicResistance);
         }
         _magicResistance = null;
         if(_boost)
         {
            ObjectUtils.disposeObject(_boost);
         }
         _boost = null;
      }
   }
}
