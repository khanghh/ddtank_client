package farm.viewx.newPet
{
   import com.greensock.TweenMax;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.analyze.PetconfigAnalyzer;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.events.Event;
   import pet.data.PetInfo;
   
   public class NewPetViewFrame extends Frame
   {
       
      
      private var _newPetItem:NewPetShowItem;
      
      private var _PetSkillPnl:NewPetSkillPanel;
      
      private var _yeziBmp:Bitmap;
      
      private var _huawen1:Bitmap;
      
      private var _huawen2:Bitmap;
      
      private var _huawen3:Bitmap;
      
      private var _huawen4:Bitmap;
      
      private var _titleBmp:Bitmap;
      
      private var _petSkillTxt:FilterFrameText;
      
      private var _petComeTxt:FilterFrameText;
      
      private var _newPetDesc:FilterFrameText;
      
      private var _newPetSkillBg:ScaleBitmapImage;
      
      private var _newPetLvTxt:FilterFrameText;
      
      public function NewPetViewFrame(){super();}
      
      private function initView() : void{}
      
      public function set petInfo(param1:PetInfo) : void{}
      
      private function initEvent() : void{}
      
      private function __responseHandler(param1:FrameEvent) : void{}
      
      private function OnTweenComplete() : void{}
      
      override public function dispose() : void{}
   }
}
