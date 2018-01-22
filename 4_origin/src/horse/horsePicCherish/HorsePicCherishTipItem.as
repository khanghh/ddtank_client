package horse.horsePicCherish
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import flash.display.Sprite;
   
   public class HorsePicCherishTipItem extends Sprite implements Disposeable
   {
       
      
      private var _nameTxt:FilterFrameText;
      
      private var _valueTxt:FilterFrameText;
      
      private var _type:int;
      
      private var _isActive:Boolean;
      
      public function HorsePicCherishTipItem(param1:int)
      {
         super();
         _type = param1;
         initView();
      }
      
      private function initView() : void
      {
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("horsePicCherish.commonTxt");
         _nameTxt.text = LanguageMgr.GetTranslation("horse.pic.txt" + _type);
         addChild(_nameTxt);
         _valueTxt = ComponentFactory.Instance.creatComponentByStylename("horsePicCherish.valueTxt" + _type);
         if(_type == 1 || _type == 4)
         {
            _valueTxt.x = 66;
         }
         else
         {
            _valueTxt.x = 59;
         }
         addChild(_valueTxt);
      }
      
      public function set isActive(param1:Boolean) : void
      {
         _isActive = param1;
      }
      
      public function set value(param1:String) : void
      {
         var _loc2_:int = 0;
         if(_type == 1 || _type == 4)
         {
            _loc2_ = !!_isActive?_type + 1:_type;
            ObjectUtils.disposeObject(_valueTxt);
            _valueTxt = null;
            _valueTxt = ComponentFactory.Instance.creatComponentByStylename("horsePicCherish.valueTxt" + _loc2_);
            _valueTxt.x = 66;
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
