package petsBag.view.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.tip.BaseTip;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PetInfoManager;
   import ddt.utils.PositionUtils;
   import petsBag.data.PetAtlasInfo;
   
   public class PetAtlasTips extends BaseTip
   {
       
      
      private var _info:PetAtlasInfo;
      
      private var _nameText:FilterFrameText;
      
      private var _line1:ScaleBitmapImage;
      
      private var _activateText:FilterFrameText;
      
      private var _atkText:FilterFrameText;
      
      private var _defText:FilterFrameText;
      
      private var _spdText:FilterFrameText;
      
      private var _lukText:FilterFrameText;
      
      private var _line2:ScaleBitmapImage;
      
      private var _activate:FilterFrameText;
      
      public function PetAtlasTips(){super();}
      
      override protected function init() : void{}
      
      override public function set tipData(param1:Object) : void{}
      
      private function update() : void{}
      
      override public function get tipData() : Object{return null;}
   }
}
