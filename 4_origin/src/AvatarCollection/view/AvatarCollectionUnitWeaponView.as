package AvatarCollection.view
{
   import com.pickgliss.ui.ComponentFactory;
   
   public class AvatarCollectionUnitWeaponView extends AvatarCollectionUnitView
   {
       
      
      public function AvatarCollectionUnitWeaponView(param1:int, param2:AvatarCollectionRightView)
      {
         super(param1,param2);
      }
      
      override protected function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("avatarColl.weaponUnitBg");
         _bg.visible = false;
         _list = ComponentFactory.Instance.creatComponentByStylename("avatarColl.unitCellList");
         _list.height = 330;
         _list.visible = false;
         addChild(_bg);
         addChild(_list);
      }
   }
}
