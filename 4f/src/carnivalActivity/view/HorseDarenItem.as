package carnivalActivity.view
{
   import carnivalActivity.CarnivalActivityControl;
   import com.pickgliss.ui.ComponentFactory;
   import ddt.loader.LoaderCreate;
   import ddt.manager.LanguageMgr;
   import ddt.utils.HelperDataModuleLoad;
   import horse.HorseManager;
   import wonderfulActivity.WonderfulActivityManager;
   import wonderfulActivity.data.GiftBagInfo;
   import wonderfulActivity.data.PlayerCurInfo;
   
   public class HorseDarenItem extends CarnivalActivityItem
   {
       
      
      private var _horseGrade:int;
      
      private var _horseStar:int;
      
      private var _horseSkillType:int;
      
      private var _horseSkillGrade:int;
      
      private var _reallyHorseGrade:int;
      
      public function HorseDarenItem(param1:int, param2:GiftBagInfo, param3:int){super(null,null,null);}
      
      override protected function initItem() : void{}
      
      override public function updateView() : void{}
   }
}
