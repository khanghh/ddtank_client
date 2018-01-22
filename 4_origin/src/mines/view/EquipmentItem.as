package mines.view
{
   import ddt.manager.LanguageMgr;
   import mines.MinesManager;
   import mines.mornui.view.EquipmentItemUI;
   
   public class EquipmentItem extends EquipmentItemUI
   {
       
      
      public var type:int;
      
      public function EquipmentItem(param1:int)
      {
         type = param1;
         super();
      }
      
      override protected function initialize() : void
      {
         selectedPic.visible = false;
         weapon.skin = "asset.mines.equipmentView.weapon" + type;
         this.tipData = {"type":type};
      }
      
      public function setData() : void
      {
         switch(int(type) - 1)
         {
            case 0:
               lvLabel.text = LanguageMgr.GetTranslation("ddt.mines.equipmentView.lvlabel",MinesManager.instance.model.headLevel);
               break;
            case 1:
               lvLabel.text = LanguageMgr.GetTranslation("ddt.mines.equipmentView.lvlabel",MinesManager.instance.model.clothLevel);
               break;
            case 2:
               lvLabel.text = LanguageMgr.GetTranslation("ddt.mines.equipmentView.lvlabel",MinesManager.instance.model.weaponLevel);
               break;
            case 3:
               lvLabel.text = LanguageMgr.GetTranslation("ddt.mines.equipmentView.lvlabel",MinesManager.instance.model.shieldLevel);
         }
      }
   }
}
