package petsBag.view.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.tip.BaseTip;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.analyze.PetconfigAnalyzer;
   import ddt.manager.LanguageMgr;
   import flash.display.Sprite;
   import pet.data.PetInfo;
   
   public class PetTip extends BaseTip
   {
       
      
      private var _name:FilterFrameText;
      
      private var _descTxt:FilterFrameText;
      
      protected var _attackLbl:FilterFrameText;
      
      protected var _attackTxt:FilterFrameText;
      
      protected var _defenceLbl:FilterFrameText;
      
      protected var _defenceTxt:FilterFrameText;
      
      protected var _HPLbl:FilterFrameText;
      
      protected var _HPTxt:FilterFrameText;
      
      protected var _agilitykLbl:FilterFrameText;
      
      protected var _agilityTxt:FilterFrameText;
      
      protected var _luckLbl:FilterFrameText;
      
      protected var _luckTxt:FilterFrameText;
      
      private var _splitImg:ScaleBitmapImage;
      
      private var _splitImg2:ScaleBitmapImage;
      
      protected var _bg:ScaleBitmapImage;
      
      private var _container:Sprite;
      
      private var _info:PetInfo;
      
      private var LEADING:int = 5;
      
      public function PetTip(){super();}
      
      override protected function init() : void{}
      
      private function fixPos() : void{}
      
      override protected function addChildren() : void{}
      
      override public function get tipData() : Object{return null;}
      
      override public function set tipData(param1:Object) : void{}
      
      private function updateView() : void{}
      
      override public function dispose() : void{}
   }
}
