package farm.viewx.newPet
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import flash.geom.Point;
   import pet.data.PetSkillTemplateInfo;
   import petsBag.view.item.SkillItem;
   
   public class NewPetSkillPanel extends Sprite implements Disposeable
   {
       
      
      private var _petSkill:SimpleTileList;
      
      private var _petSkillScroll:ScrollPanel;
      
      private var _itemInfoVec:Array;
      
      private var _itemViewVec:Vector.<PetSkillItem>;
      
      public function NewPetSkillPanel()
      {
         super();
         _itemInfoVec = [];
         _itemViewVec = new Vector.<PetSkillItem>();
         creatView();
      }
      
      private function creatView() : void
      {
         _petSkillScroll = ComponentFactory.Instance.creatComponentByStylename("farm.scrollPanel.petSkillPnl");
         addChild(_petSkillScroll);
         _petSkill = ComponentFactory.Instance.creatCustomObject("farm.simpleTileList.petSkill",[4]);
         _petSkillScroll.setView(_petSkill);
      }
      
      public function set itemInfo(petSkillAll:Array) : void
      {
         _itemInfoVec = petSkillAll;
         _itemInfoVec.sortOn("ID",16);
         update();
      }
      
      public function update() : void
      {
         removeItems();
         creatItems();
      }
      
      protected function creatItems() : void
      {
         var cell:* = null;
         var i:int = 0;
         var count:int = 8;
         var _loc6_:int = 0;
         var _loc5_:* = _itemInfoVec;
         for each(var itemInfo in _itemInfoVec)
         {
            if(itemInfo)
            {
               i++;
               cell = new PetSkillItem(itemInfo,i);
               cell.DoubleClickEnabled = true;
               cell.iconPos = new Point(2.5,2.5);
               _petSkill.addChild(cell);
               _itemViewVec.push(cell);
            }
         }
         count = 8;
         while(i < count)
         {
            i++;
            cell = new PetSkillItem(null,i);
            cell.iconPos = new Point(3,3);
            cell.mouseChildren = false;
            cell.mouseEnabled = false;
            _petSkill.addChild(cell);
            _itemViewVec.push(cell);
         }
      }
      
      public function set scrollVisble(value:Boolean) : void
      {
         _petSkillScroll.vScrollbar.visible = value;
      }
      
      private function removeItems() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = _itemViewVec;
         for each(var item in _itemViewVec)
         {
            if(item)
            {
               ObjectUtils.disposeObject(item);
               item = null;
            }
         }
         _itemViewVec.splice(0,_itemViewVec.length);
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_petSkill);
         _petSkill = null;
         ObjectUtils.disposeObject(_petSkillScroll);
         _petSkillScroll = null;
         _itemInfoVec = null;
         _itemViewVec = null;
         ObjectUtils.disposeAllChildren(this);
      }
   }
}
