package horse.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.tip.BaseTip;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import flash.display.Sprite;
   import horse.data.HorseSkillVo;
   
   public class HorseSkillCellTip extends BaseTip
   {
       
      
      private var _bg:ScaleBitmapImage;
      
      private var _nameTxt:FilterFrameText;
      
      private var _consumeTitleTxt:FilterFrameText;
      
      private var _consumeContentTxt:FilterFrameText;
      
      private var _descTitleTxt:FilterFrameText;
      
      private var _descContentTxt:FilterFrameText;
      
      private var _coolDownTxt:FilterFrameText;
      
      private var _lineImg:ScaleBitmapImage;
      
      private var _lineImg2:ScaleBitmapImage;
      
      private var _container:Sprite;
      
      private var _tipInfo:HorseSkillVo;
      
      private var LEADING:int = 5;
      
      public function HorseSkillCellTip(){super();}
      
      override protected function init() : void{}
      
      override protected function addChildren() : void{}
      
      override public function get tipData() : Object{return null;}
      
      override public function set tipData(param1:Object) : void{}
      
      private function updateView() : void{}
      
      private function fixPos() : void{}
      
      override public function dispose() : void{}
   }
}
