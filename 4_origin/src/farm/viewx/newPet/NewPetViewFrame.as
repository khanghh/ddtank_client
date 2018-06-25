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
      
      public function NewPetViewFrame()
      {
         super();
         initEvent();
         initView();
      }
      
      private function initView() : void
      {
         _titleBmp = ComponentFactory.Instance.creatBitmap("assets.farm.newPetCome");
         addToContent(_titleBmp);
         _huawen1 = ComponentFactory.Instance.creatBitmap("assets.farm.newPetHuawen");
         _huawen1.x = 20;
         _huawen1.y = 15;
         _huawen2 = ComponentFactory.Instance.creatBitmap("assets.farm.newPetHuawen");
         _huawen2.rotation = 90;
         _huawen2.x = 203;
         _huawen2.y = 15;
         _huawen3 = ComponentFactory.Instance.creatBitmap("assets.farm.newPetHuawen");
         _huawen3.rotation = 180;
         _huawen3.x = 203;
         _huawen3.y = 135;
         _huawen4 = ComponentFactory.Instance.creatBitmap("assets.farm.newPetHuawen");
         _huawen4.rotation = -90;
         _huawen4.x = 20;
         _huawen4.y = 135;
         addToContent(_huawen1);
         addToContent(_huawen2);
         addToContent(_huawen3);
         addToContent(_huawen4);
         _newPetSkillBg = ComponentFactory.Instance.creatComponentByStylename("farm.newPetSkill.bg");
         addToContent(_newPetSkillBg);
         _PetSkillPnl = ComponentFactory.Instance.creat("farm.petSkillPnl");
         _PetSkillPnl.scrollVisble = false;
         addToContent(_PetSkillPnl);
         _petSkillTxt = ComponentFactory.Instance.creatComponentByStylename("farm.pet.newPetSkillTxt");
         _petSkillTxt.text = LanguageMgr.GetTranslation("ddt.farm.newPet.SkillTxt");
         addToContent(_petSkillTxt);
         _petComeTxt = ComponentFactory.Instance.creatComponentByStylename("farm.pet.newPetComeTxt");
         _petComeTxt.text = LanguageMgr.GetTranslation("ddt.farm.newPet.Come");
         addToContent(_petComeTxt);
         _newPetDesc = ComponentFactory.Instance.creatComponentByStylename("farm.pet.newPetDescTxt");
         _newPetDesc.text = PetconfigAnalyzer.PetCofnig.NewPetDescribe;
         addToContent(_newPetDesc);
         _newPetLvTxt = ComponentFactory.Instance.creatComponentByStylename("farm.pet.newPetLvTxt");
         _newPetLvTxt.text = LanguageMgr.GetTranslation("ddt.farm.newPet.LvTxt");
         addToContent(_newPetLvTxt);
      }
      
      public function set petInfo(value:PetInfo) : void
      {
         if(!_newPetItem)
         {
            _newPetItem = new NewPetShowItem(value);
            _newPetItem.x = 69;
            _newPetItem.y = 25;
            addToContent(_newPetItem);
         }
         _PetSkillPnl.itemInfo = value.skills;
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__responseHandler);
      }
      
      private function __responseHandler(event:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         if(!int(event.responseCode))
         {
            TweenMax.to(this,0.2,{
               "x":250,
               "onComplete":OnTweenComplete
            });
         }
      }
      
      private function OnTweenComplete() : void
      {
         dispatchEvent(new Event("newPetFrameClose"));
         dispose();
      }
      
      override public function dispose() : void
      {
         removeEventListener("response",__responseHandler);
         if(_huawen1)
         {
            ObjectUtils.disposeObject(_huawen1);
         }
         _huawen1 = null;
         if(_huawen2)
         {
            ObjectUtils.disposeObject(_huawen2);
         }
         _huawen2 = null;
         if(_huawen3)
         {
            ObjectUtils.disposeObject(_huawen3);
         }
         _huawen3 = null;
         if(_huawen4)
         {
            ObjectUtils.disposeObject(_huawen4);
         }
         _huawen4 = null;
         if(_PetSkillPnl)
         {
            ObjectUtils.disposeObject(_PetSkillPnl);
         }
         _PetSkillPnl = null;
         if(_newPetItem)
         {
            ObjectUtils.disposeObject(_newPetItem);
         }
         _newPetItem = null;
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
