package petsBag.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.analyze.PetconfigAnalyzer;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import pet.data.PetInfo;
   import petsBag.PetsBagManager;
   import petsBag.view.item.SkillItem;
   import road7th.data.DictionaryEvent;
   
   public class PetGameSkillPnl extends Sprite implements Disposeable
   {
      
      public static var LvVSLockArray:Array = [20,40,60];
       
      
      private var _bg:DisplayObject;
      
      private var _items:Vector.<SkillItem>;
      
      private var _pet:PetInfo;
      
      public function PetGameSkillPnl($pet:PetInfo = null)
      {
         super();
         _items = new Vector.<SkillItem>();
         initView();
         initEvent();
         pet = $pet;
      }
      
      private function initView() : void
      {
         var i:int = 0;
         var item:* = null;
         var point:* = null;
         _bg = ComponentFactory.Instance.creat("assets.petsBag.gameSkillPnl");
         addChild(_bg);
         for(i = 0; i < 5; )
         {
            item = new SkillItem(null,i,false);
            point = ComponentFactory.Instance.creatCustomObject("petsBag.gameSkillPnl.point" + i);
            item.x = point.x;
            item.y = point.y;
            item.McType = 2;
            item.setExclusiveSkillMc();
            addChild(item);
            _items.push(item);
            i++;
         }
      }
      
      private function initEvent() : void
      {
         var index:int = 0;
         for(index = 0; index < _items.length; )
         {
            _items[index].addEventListener("click",__skillItemClick);
            index++;
         }
         PetsBagManager.instance().petModel.addEventListener("change",__onChange);
      }
      
      private function __onChange(event:Event) : void
      {
         pet = PetsBagManager.instance().petModel.currentPetInfo;
      }
      
      private function removeEvent() : void
      {
         var index:int = 0;
         for(index = 0; index < _items.length; )
         {
            _items[index].removeEventListener("itemclick",__skillItemClick);
            index++;
         }
         PetsBagManager.instance().petModel.removeEventListener("change",__onChange);
         if(_pet)
         {
            _pet.equipdSkills.removeEventListener("update",__onUpdate);
         }
      }
      
      private function __skillItemClick(e:MouseEvent) : void
      {
         var alert:* = null;
         var showStr:* = null;
         var currentSkillItem:SkillItem = e.currentTarget as SkillItem;
         if(currentSkillItem)
         {
            if(currentSkillItem.skillID == -1)
            {
               if(currentSkillItem.index != 4)
               {
                  showStr = "";
                  switch(int(currentSkillItem.index) - 1)
                  {
                     case 0:
                        showStr = PetconfigAnalyzer.PetCofnig.skillOpenLevel[0];
                        break;
                     case 1:
                        showStr = PetconfigAnalyzer.PetCofnig.skillOpenLevel[1];
                        break;
                     case 2:
                        showStr = PetconfigAnalyzer.PetCofnig.skillOpenLevel[2];
                  }
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.petsBag.LevAction",showStr));
               }
               else
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.petsBag.VipAction"));
               }
               return;
            }
            SocketManager.Instance.out.sendEquipPetSkill(PetsBagManager.instance().petModel.currentPetInfo.Place,0,currentSkillItem.index);
         }
      }
      
      protected function __onAlertResponse(evt:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         var alert:BaseAlerFrame = evt.currentTarget as BaseAlerFrame;
         alert.removeEventListener("response",__onAlertResponse);
         switch(int(evt.responseCode) - 2)
         {
            case 0:
            case 1:
               if(PetsBagManager.instance().petModel.currentPetInfo)
               {
                  SocketManager.Instance.out.sendPaySkill(PetsBagManager.instance().petModel.currentPetInfo.Place);
                  break;
               }
         }
         alert.dispose();
      }
      
      public function set pet(value:PetInfo) : void
      {
         var i:int = 0;
         _pet = value;
         var _loc5_:int = 0;
         var _loc4_:* = _items;
         for each(var item in _items)
         {
            item.skillID = -1;
         }
         if(_pet)
         {
            for(i = 0; i < _pet.equipdSkills.length; )
            {
               _items[i].skillID = _pet.equipdSkills[i];
               i++;
            }
         }
      }
      
      private function __onUpdate(event:DictionaryEvent) : void
      {
         var i:int = 0;
         for(i = 0; i < _pet.equipdSkills.length; )
         {
            _items[i].skillID = _pet.equipdSkills[i];
            i++;
         }
      }
      
      private function lockByIndex(index:int) : void
      {
         if(index < 1 || index > 5)
         {
            return;
         }
         _items[index - 1].isLock = true;
         if(PetsBagManager.instance().petModel.currentPetInfo && PetsBagManager.instance().petModel.currentPetInfo.PaySkillCount > 0)
         {
            _items[index - 1].isLock = false;
         }
      }
      
      public function get UnLockItemIndex() : int
      {
         var flag:Boolean = true;
         var _loc4_:int = 0;
         var _loc3_:* = _items;
         for each(var item in _items)
         {
            if(!item.isLock && !item.info)
            {
               flag = false;
               return item.index;
            }
         }
         if(flag)
         {
            return 0;
         }
         return 0;
      }
      
      public function dispose() : void
      {
         removeEvent();
         var _loc3_:int = 0;
         var _loc2_:* = _items;
         for each(var item in _items)
         {
            if(item)
            {
               ObjectUtils.disposeObject(item);
               item = null;
            }
         }
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
            _bg = null;
         }
         _pet = null;
         ObjectUtils.disposeAllChildren(this);
      }
   }
}
