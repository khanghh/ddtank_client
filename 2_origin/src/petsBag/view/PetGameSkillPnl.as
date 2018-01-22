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
      
      public function PetGameSkillPnl(param1:PetInfo = null)
      {
         super();
         _items = new Vector.<SkillItem>();
         initView();
         initEvent();
         pet = param1;
      }
      
      private function initView() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = null;
         var _loc1_:* = null;
         _bg = ComponentFactory.Instance.creat("assets.petsBag.gameSkillPnl");
         addChild(_bg);
         _loc3_ = 0;
         while(_loc3_ < 5)
         {
            _loc2_ = new SkillItem(null,_loc3_,false);
            _loc1_ = ComponentFactory.Instance.creatCustomObject("petsBag.gameSkillPnl.point" + _loc3_);
            _loc2_.x = _loc1_.x;
            _loc2_.y = _loc1_.y;
            _loc2_.McType = 2;
            _loc2_.setExclusiveSkillMc();
            addChild(_loc2_);
            _items.push(_loc2_);
            _loc3_++;
         }
      }
      
      private function initEvent() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < _items.length)
         {
            _items[_loc1_].addEventListener("click",__skillItemClick);
            _loc1_++;
         }
         PetsBagManager.instance().petModel.addEventListener("change",__onChange);
      }
      
      private function __onChange(param1:Event) : void
      {
         pet = PetsBagManager.instance().petModel.currentPetInfo;
      }
      
      private function removeEvent() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < _items.length)
         {
            _items[_loc1_].removeEventListener("itemclick",__skillItemClick);
            _loc1_++;
         }
         PetsBagManager.instance().petModel.removeEventListener("change",__onChange);
         if(_pet)
         {
            _pet.equipdSkills.removeEventListener("update",__onUpdate);
         }
      }
      
      private function __skillItemClick(param1:MouseEvent) : void
      {
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc2_:SkillItem = param1.currentTarget as SkillItem;
         if(_loc2_)
         {
            if(_loc2_.skillID == -1)
            {
               if(_loc2_.index != 4)
               {
                  _loc4_ = "";
                  switch(int(_loc2_.index) - 1)
                  {
                     case 0:
                        _loc4_ = PetconfigAnalyzer.PetCofnig.skillOpenLevel[0];
                        break;
                     case 1:
                        _loc4_ = PetconfigAnalyzer.PetCofnig.skillOpenLevel[1];
                        break;
                     case 2:
                        _loc4_ = PetconfigAnalyzer.PetCofnig.skillOpenLevel[2];
                  }
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.petsBag.LevAction",_loc4_));
               }
               else
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.petsBag.VipAction"));
               }
               return;
            }
            SocketManager.Instance.out.sendEquipPetSkill(PetsBagManager.instance().petModel.currentPetInfo.Place,0,_loc2_.index);
         }
      }
      
      protected function __onAlertResponse(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:BaseAlerFrame = param1.currentTarget as BaseAlerFrame;
         _loc2_.removeEventListener("response",__onAlertResponse);
         switch(int(param1.responseCode) - 2)
         {
            case 0:
            case 1:
               if(PetsBagManager.instance().petModel.currentPetInfo)
               {
                  SocketManager.Instance.out.sendPaySkill(PetsBagManager.instance().petModel.currentPetInfo.Place);
                  break;
               }
         }
         _loc2_.dispose();
      }
      
      public function set pet(param1:PetInfo) : void
      {
         var _loc3_:int = 0;
         _pet = param1;
         var _loc5_:int = 0;
         var _loc4_:* = _items;
         for each(var _loc2_ in _items)
         {
            _loc2_.skillID = -1;
         }
         if(_pet)
         {
            _loc3_ = 0;
            while(_loc3_ < _pet.equipdSkills.length)
            {
               _items[_loc3_].skillID = _pet.equipdSkills[_loc3_];
               _loc3_++;
            }
         }
      }
      
      private function __onUpdate(param1:DictionaryEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < _pet.equipdSkills.length)
         {
            _items[_loc2_].skillID = _pet.equipdSkills[_loc2_];
            _loc2_++;
         }
      }
      
      private function lockByIndex(param1:int) : void
      {
         if(param1 < 1 || param1 > 5)
         {
            return;
         }
         _items[param1 - 1].isLock = true;
         if(PetsBagManager.instance().petModel.currentPetInfo && PetsBagManager.instance().petModel.currentPetInfo.PaySkillCount > 0)
         {
            _items[param1 - 1].isLock = false;
         }
      }
      
      public function get UnLockItemIndex() : int
      {
         var _loc1_:Boolean = true;
         var _loc4_:int = 0;
         var _loc3_:* = _items;
         for each(var _loc2_ in _items)
         {
            if(!_loc2_.isLock && !_loc2_.info)
            {
               _loc1_ = false;
               return _loc2_.index;
            }
         }
         if(_loc1_)
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
         for each(var _loc1_ in _items)
         {
            if(_loc1_)
            {
               ObjectUtils.disposeObject(_loc1_);
               _loc1_ = null;
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
