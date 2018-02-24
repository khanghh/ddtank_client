package store
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import consortiaDomain.ConsortiaDomainManager;
   import consortiaDomain.EachBuildInfo;
   import ddt.command.StripTip;
   import ddt.manager.LanguageMgr;
   import ddt.utils.PositionUtils;
   import flash.display.Sprite;
   
   public class ShowSuccessExp extends Sprite
   {
       
      
      private var _bg:ScaleFrameImage;
      
      private var _showTxtI:FilterFrameText;
      
      private var _showTxtIII:FilterFrameText;
      
      private var _showTxtIV:FilterFrameText;
      
      private var _showTxtVIP:FilterFrameText;
      
      private var _showTxtILabel:FilterFrameText;
      
      private var _showTxtIIILabel:FilterFrameText;
      
      private var _showTxtIVLabel:FilterFrameText;
      
      private var _showTxtVipLabel:FilterFrameText;
      
      private var _showStripI:StripTip;
      
      private var _showStripIII:StripTip;
      
      private var _showStripIV:StripTip;
      
      private var _showStripVIP:StripTip;
      
      public function ShowSuccessExp(){super();}
      
      private function _init() : void{}
      
      public function showVIPRate() : void{}
      
      public function showAllTips(param1:String, param2:String, param3:String) : void{}
      
      public function showVIPTip(param1:String) : void{}
      
      public function showAllNum(param1:Number, param2:Number, param3:Number, param4:Number) : void{}
      
      private function setTxtIIIText(param1:String) : void{}
      
      public function dispose() : void{}
   }
}
