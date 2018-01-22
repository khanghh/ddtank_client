package welfareCenter.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   
   public class OldPlayerGradeGiftBox extends BaseButton
   {
       
      
      private var _gainBg:Bitmap;
      
      private var _isGain:Boolean;
      
      private var _shine:MovieClip;
      
      private var _isShine:Boolean;
      
      public function OldPlayerGradeGiftBox()
      {
         super();
      }
      
      override protected function addChildren() : void
      {
         super.addChildren();
         if(_gainBg)
         {
            addChild(_gainBg);
         }
         if(_shine)
         {
            addChild(_shine);
         }
      }
      
      public function set isGain(param1:Boolean) : void
      {
         if(_isGain == param1)
         {
            return;
         }
         _isGain = param1;
         if(_isGain)
         {
            if(_gainBg == null)
            {
               _gainBg = ComponentFactory.Instance.creatBitmap("asset.welfareCeneter.gift.isGain");
            }
            _gainBg.x = (width - _gainBg.width) / 2;
            _gainBg.y = (height - _gainBg.height) / 2;
            _gainBg.visible = true;
            if(_back)
            {
               _back.filters = ComponentFactory.Instance.creatFilters("welfareCenter.boxFilter");
            }
            addChildren();
         }
         else
         {
            if(_gainBg)
            {
               _gainBg.visible = false;
            }
            if(_back)
            {
               _back.filters = [];
            }
         }
      }
      
      public function set isShine(param1:Boolean) : void
      {
         if(_isShine == param1)
         {
            return;
         }
         _isShine = param1;
         if(_isShine)
         {
            if(_shine == null)
            {
               _shine = ComponentFactory.Instance.creat("asset.welfareCeneter.iconItemShine");
               PositionUtils.setPos(_shine,"welfareCenter.gradeGiftView.boxShinePos");
            }
            _shine.visible = true;
            addChildren();
         }
         else if(_shine)
         {
            _shine.visible = false;
         }
      }
      
      public function get isShine() : Boolean
      {
         return _isShine;
      }
      
      public function get isGain() : Boolean
      {
         return _isGain;
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_shine);
         ObjectUtils.disposeObject(_gainBg);
         super.dispose();
         _gainBg = null;
         _shine = null;
      }
   }
}
