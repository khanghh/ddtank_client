package campbattle.view
{
   import campbattle.CampBattleControl;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class CampBattleTitle extends Sprite implements Disposeable
   {
       
      
      private var _backPic:Bitmap;
      
      private var _titleTxt1:FilterFrameText;
      
      private var _titleTxt2:FilterFrameText;
      
      private var _titleTxt3:FilterFrameText;
      
      private var _titleTxt4:FilterFrameText;
      
      public function CampBattleTitle(){super();}
      
      private function initView() : void{}
      
      public function setTitleTxt4(param1:String) : void{}
      
      public function setTitleTxt2(param1:String) : void{}
      
      public function dispose() : void{}
   }
}
