package petsBag.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.SocketManager;
   import flash.display.Sprite;
   import flash.geom.Point;
   import pet.data.PetSkill;
   import pet.data.PetSkillTemplateInfo;
   import petsBag.PetsBagManager;
   import petsBag.event.PetItemEvent;
   import petsBag.view.item.SkillItem;
   
   public class PetSkillPnl extends Sprite implements Disposeable
   {
       
      
      private var _petSkill:SimpleTileList;
      
      private var _petSkillScroll:ScrollPanel;
      
      private var _isWatch:Boolean = false;
      
      private var _itemInfoVec:Array;
      
      private var _itemViewVec:Vector.<SkillItem>;
      
      public function PetSkillPnl(isWatch:Boolean)
      {
         _isWatch = isWatch;
         super();
         _itemInfoVec = [];
         _itemViewVec = new Vector.<SkillItem>();
         creatView();
      }
      
      private function creatView() : void
      {
         if(!_isWatch)
         {
            _petSkillScroll = ComponentFactory.Instance.creatComponentByStylename("petsBag.scrollPanel.petSkillPnl");
            addChild(_petSkillScroll);
            _petSkill = ComponentFactory.Instance.creatCustomObject("petsBag.simpleTileList.petSkill",[4]);
            _petSkillScroll.setView(_petSkill);
         }
         else
         {
            _petSkillScroll = ComponentFactory.Instance.creatComponentByStylename("petsBag.scrollPanel.petSkillPnlWatch");
            addChild(_petSkillScroll);
            _petSkill = ComponentFactory.Instance.creatCustomObject("petsBag.simpleTileList.petSkill",[7]);
            _petSkillScroll.setView(_petSkill);
         }
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
               cell = new SkillItem(itemInfo,i,true,_isWatch);
               cell.DoubleClickEnabled = true;
               cell.McType = 1;
               cell.iconPos = new Point(2.5,2.5);
               cell.setExclusiveSkillImg();
               _petSkill.addChild(cell);
               _itemViewVec.push(cell);
            }
         }
         count = !!_isWatch?14:8;
         while(i < count)
         {
            i++;
            cell = new SkillItem(null,i,true,_isWatch);
            cell.iconPos = new Point(3,3);
            cell.mouseChildren = false;
            cell.mouseEnabled = false;
            cell.McType = 1;
            cell.setExclusiveSkillImg();
            _petSkill.addChild(cell);
            _itemViewVec.push(cell);
         }
         if(!_isWatch)
         {
            initEvent();
         }
      }
      
      public function set scrollVisble(value:Boolean) : void
      {
         _petSkillScroll.vScrollbar.visible = value;
      }
      
      private function removeItems() : void
      {
         removeEvent();
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
      
      private function initEvent() : void
      {
         var index:int = 0;
         for(index = 0; index < _itemViewVec.length; )
         {
            _itemViewVec[index].addEventListener("itemclick",__skillItemClick);
            index++;
         }
      }
      
      private function removeEvent() : void
      {
         var index:int = 0;
         for(index = 0; index < _itemViewVec.length; )
         {
            _itemViewVec[index].removeEventListener("itemclick",__skillItemClick);
            index++;
         }
      }
      
      private function __skillItemClick(e:PetItemEvent) : void
      {
         if(_isWatch)
         {
            return;
         }
         var currentSkillInfo:PetSkill = (e.data as SkillItem).info as PetSkill;
         if(currentSkillInfo && PetsBagManager.instance().petModel.currentPetInfo)
         {
            SocketManager.Instance.out.sendEquipPetSkill(PetsBagManager.instance().petModel.currentPetInfo.Place,currentSkillInfo.ID,PetsBagManager.instance().getEquipdSkillIndex());
            if(PetsBagManager.instance().petModel.petGuildeOptionOnOff[117] > 0)
            {
               PetsBagManager.instance().clearCurrentPetFarmGuildeArrow(117);
               PetsBagManager.instance().petModel.petGuildeOptionOnOff[117] = 0;
            }
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         removeItems();
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
