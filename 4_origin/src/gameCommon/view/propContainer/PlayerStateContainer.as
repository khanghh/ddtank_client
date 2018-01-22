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
      
      public function PlayerStateContainer(param1:Number = 10)
      {
         super(param1);
         hSpace = 6;
         vSpace = 4;
         mouseEnabled = false;
         mouseChildren = false;
      }
      
      public function get info() : TurnedLiving
      {
         return _info;
      }
      
      public function set info(param1:TurnedLiving) : void
      {
         if(_info == param1)
         {
            return;
         }
         if(_info)
         {
            _info.removeEventListener("addState",__addingState);
            _info.removeEventListener("usePetSkill",__usePetSkill);
            _info.removeEventListener("horseSkillUse",__useSkillHandler);
         }
         _info = param1;
         if(_info)
         {
            _info.addEventListener("addState",__addingState);
            _info.addEventListener("usePetSkill",__usePetSkill);
            _info.addEventListener("horseSkillUse",__useSkillHandler);
         }
      }
      
      private function __addingState(param1:LivingEvent) : void
      {
         var _loc3_:* = null;
         var _loc2_:* = null;
         var _loc4_:* = null;
         if(visible == false)
         {
            visible = true;
         }
         if(!_info.isLiving)
         {
            visible = false;
            return;
         }
         if(param1.value > 0)
         {
            _loc3_ = new InventoryItemInfo();
            _loc3_.TemplateID = param1.value;
            ItemManager.fill(_loc3_);
            if(_loc3_.CategoryID != 17 && _loc3_.CategoryID != 31)
            {
               addChild(new ItemCellView(0,PropItemView.createView(_loc3_.Pic,40,40)));
            }
            else
            {
               _loc2_ = PlayerManager.Instance.getDeputyWeaponIcon(_loc3_,1);
               addChild(new ItemCellView(0,_loc2_));
            }
         }
         else if(param1.value == -1)
         {
            _loc4_ = ComponentFactory.Instance.creatBitmap("game.crazyTank.view.specialKillAsset");
            _loc4_.width = 40;
            _loc4_.height = 40;
            addChild(new ItemCellView(0,_loc4_));
         }
         else if(param1.value == -2)
         {
            addChild(new ItemCellView(0,PropItemView.createView(param1.paras[0],40,40)));
         }
         else if(param1.value == 0)
         {
            addChild(new ItemCellView(0,PropItemView.createView("wish",40,40)));
         }
      }
      
      protected function __useSkillHandler(param1:LivingEvent) : void
      {
         var _loc2_:HorseSkillVo = HorseManager.instance.getHorseSkillInfoById(param1.paras[0]);
         if(_loc2_ && _loc2_.isActiveSkill && _loc2_.Pic != "-1")
         {
            addChild(new ItemCellView(0,PropItemView.createView(_loc2_.Pic,40,40)));
         }
      }
      
      private function __usePetSkill(param1:LivingEvent) : void
      {
         visible = true;
         if(!_info.isLiving)
         {
            visible = false;
            return;
         }
         var _loc2_:PetSkillTemplateInfo = PetSkillManager.getSkillByID(param1.value);
         if(_loc2_ && _loc2_.isActiveSkill)
         {
            addChild(new ItemCellView(0,new BitmapLoaderProxy(PathManager.solveSkillPicUrl(_loc2_.Pic),new Rectangle(0,0,40,40))));
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
