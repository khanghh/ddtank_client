package petsBag.petsAdvanced
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import flash.display.Sprite;
   
   public class PetsFormItemsTipItem extends Sprite implements Disposeable
   {
       
      
      private var _nameTxt:FilterFrameText;
      
      private var _valueTxt:FilterFrameText;
      
      private var _type:int;
      
      private var _isActive:Boolean;
      
      public function PetsFormItemsTipItem(param1:int)
      {
         super();
         _type = param1;
         initView();
      }
      
      private function initView() : void
      {
         _valueTxt = ComponentFactory.Instance.creatComponentByStylename("petsBag.form.petsTip.valueTxt" + _type);
         addChild(_valueTxt);
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("petsBag.form.petsTip.commonTxt");
         _nameTxt.text = LanguageMgr.GetTranslation("petsBag.form.petsTips" + _type);
         addChild(_nameTxt);
         _nameTxt.y = _valueTxt.y;
      }
      
      public function set isActive(param1:Boolean) : void
      {
         _isActive = param1;
      }
      
      public function set value(param1:String) : void
      {
         var _loc2_:int = 0;
         if(_type == 1)
         {
            _loc2_ = !!_isActive?_type + 1:_type;
            ObjectUtils.disposeObject(_valueTxt);
            _valueTxt = null;
            _valueTxt = ComponentFactory.Instance.creatComponentByStylename("petsBag.form.petsTip.valueTxt" + _loc2_);
            _valueTxt.x = 73;
            _valueTxt.y = 40;
            addChild(_valueTxt);
         }
         _valueTxt.text = param1;
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_nameTxt);
         _nameTxt = null;
         ObjectUtils.disposeObject(_valueTxt);
         _valueTxt = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
