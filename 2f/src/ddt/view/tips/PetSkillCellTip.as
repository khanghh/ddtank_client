package ddt.view.tips
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.tip.BaseTip;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import flash.display.Sprite;
   import pet.data.PetSkillTemplateInfo;
   import road7th.utils.StringHelper;
   
   public class PetSkillCellTip extends BaseTip
   {
       
      
      private var _bg:ScaleBitmapImage;
      
      private var name_txt:FilterFrameText;
      
      private var ballType_txt:FilterFrameText;
      
      private var _lostLbl:FilterFrameText;
      
      private var _lostTxt:FilterFrameText;
      
      private var _descLbl:FilterFrameText;
      
      private var _descTxt:FilterFrameText;
      
      private var _coolDownTxt:FilterFrameText;
      
      private var _splitImg:ScaleBitmapImage;
      
      private var _splitImg2:ScaleBitmapImage;
      
      private var _tempData:PetSkillTemplateInfo;
      
      private var _container:Sprite;
      
      private var LEADING:int = 5;
      
      public function PetSkillCellTip(){super();}
      
      override protected function init() : void{}
      
      override protected function addChildren() : void{}
      
      override public function get tipData() : Object{return null;}
      
      override public function set tipData(param1:Object) : void{}
      
      private function updateView() : void{}
      
      private function fixPos() : void{}
      
      override public function dispose() : void{}
   }
}
