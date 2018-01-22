package gemstone.items
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.tip.BaseTip;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import flash.text.TextFormat;
   import gemstone.info.GemstoneTipVO;
   
   public class GemstoneLeftViewTip extends BaseTip
   {
       
      
      private var _bg:ScaleBitmapImage;
      
      private var _tempData:Object;
      
      private var _titleTxt:FilterFrameText;
      
      private var _curPropertyTxt:FilterFrameText;
      
      private var _nextTxt:FilterFrameText;
      
      private var _nextPropertyTxt:FilterFrameText;
      
      private var _line1:Image;
      
      private var _line2:Image;
      
      public function GemstoneLeftViewTip(){super();}
      
      override protected function init() : void{}
      
      override public function set tipData(param1:Object) : void{}
      
      override public function get tipData() : Object{return null;}
      
      private function updateView() : void{}
      
      override public function dispose() : void{}
   }
}
