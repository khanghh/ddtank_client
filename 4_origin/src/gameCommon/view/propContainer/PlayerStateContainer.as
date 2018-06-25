package gameCommon.view.propContainer
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.display.BitmapLoaderProxy;
   import ddt.events.LivingEvent;
   import ddt.manager.ItemManager;
   import ddt.manager.PathManager;
   import ddt.manager.PetSkillManager;
   import ddt.manager.PlayerManager;
   import ddt.view.PropItemView;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.geom.Rectangle;
   import gameCommon.model.TurnedLiving;
   import gameCommon.view.ItemCellView;
   import horse.HorseManager;
   import horse.data.HorseSkillVo;
   import pet.data.PetSkillTemplateInfo;
   
   public class PlayerStateContainer extends SimpleTileList
   {
       
      
      private var _info:TurnedLiving;
      
      public function PlayerStateContainer(column:Number = 10)
      {
         super(column);
         hSpace = 6;
         vSpace = 4;
         mouseEnabled = false;
         mouseChildren = false;
      }
      
      public function get info() : TurnedLiving
      {
         return _info;
      }
      
      public function set info(value:TurnedLiving) : void
      {
         if(_info == value)
         {
            return;
         }
         if(_info)
         {
            _info.removeEventListener("addState",__addingState);
            _info.removeEventListener("usePetSkill",__usePetSkill);
            _info.removeEventListener("horseSkillUse",__useSkillHandler);
         }
         _info = value;
         if(_info)
         {
            _info.addEventListener("addState",__addingState);
            _info.addEventListener("usePetSkill",__usePetSkill);
            _info.addEventListener("horseSkillUse",__useSkillHandler);
         }
      }
      
      private function __addingState(event:LivingEvent) : void
      {
         var temp:* = null;
         var dis:* = null;
         var special:* = null;
         if(visible == false)
         {
            visible = true;
         }
         if(!_info.isLiving)
         {
            visible = false;
            return;
         }
         if(event.value > 0)
         {
            temp = new InventoryItemInfo();
            temp.TemplateID = event.value;
            ItemManager.fill(temp);
            if(temp.CategoryID != 17 && temp.CategoryID != 31)
            {
               addChild(new ItemCellView(0,PropItemView.createView(temp.Pic,40,40)));
            }
            else
            {
               dis = PlayerManager.Instance.getDeputyWeaponIcon(temp,1);
               addChild(new ItemCellView(0,dis));
            }
         }
         else if(event.value == -1)
         {
            special = ComponentFactory.Instance.creatBitmap("game.crazyTank.view.specialKillAsset");
            special.width = 40;
            special.height = 40;
            addChild(new ItemCellView(0,special));
         }
         else if(event.value == -2)
         {
            addChild(new ItemCellView(0,PropItemView.createView(event.paras[0],40,40)));
         }
         else if(event.value == 0)
         {
            addChild(new ItemCellView(0,PropItemView.createView("wish",40,40)));
         }
      }
      
      protected function __useSkillHandler(event:LivingEvent) : void
      {
         var horseSkillVo:HorseSkillVo = HorseManager.instance.getHorseSkillInfoById(event.paras[0]);
         if(horseSkillVo && horseSkillVo.isActiveSkill && horseSkillVo.Pic != "-1")
         {
            addChild(new ItemCellView(0,PropItemView.createView(horseSkillVo.Pic,40,40)));
         }
      }
      
      private function __usePetSkill(event:LivingEvent) : void
      {
         visible = true;
         if(!_info.isLiving)
         {
            visible = false;
            return;
         }
         var skill:PetSkillTemplateInfo = PetSkillManager.getSkillByID(event.value);
         if(skill && skill.isActiveSkill)
         {
            addChild(new ItemCellView(0,new BitmapLoaderProxy(PathManager.solveSkillPicUrl(skill.Pic),new Rectangle(0,0,40,40))));
         }
      }
      
      override public function dispose() : void
      {
         super.dispose();
         info = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
