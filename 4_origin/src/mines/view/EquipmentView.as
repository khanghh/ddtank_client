package mines.view
{
   import bagAndInfo.cell.BagCell;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.utils.PositionUtils;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import mines.MinesManager;
   import mines.mornui.view.EquipmentViewUI;
   import morn.core.handlers.Handler;
   
   public class EquipmentView extends EquipmentViewUI
   {
       
      
      private var itemList:Vector.<EquipmentItem>;
      
      private var cell:MinesCell;
      
      private var chooseType:int = 0;
      
      private var progress:MinesProgress;
      
      private var place:int;
      
      public function EquipmentView()
      {
         super();
      }
      
      override protected function initialize() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         itemList = new Vector.<EquipmentItem>();
         _loc2_ = 0;
         while(_loc2_ < 4)
         {
            _loc1_ = new EquipmentItem(_loc2_ + 1);
            _loc1_.setData();
            _loc1_.x = 30 + 309 * (_loc2_ % 2);
            _loc1_.y = 14 + 184 * Math.floor(_loc2_ / 2);
            _loc1_.addEventListener("click",clickHandler);
            box.addChild(_loc1_);
            itemList.push(_loc1_);
            _loc2_++;
         }
         levelUpBtn.clickHandler = new Handler(levelUpHandler);
         cell = new MinesCell(new Sprite(),0);
         addChild(cell);
         PositionUtils.setPos(cell,"mines.equipmentView.cellPos");
         progress = new MinesProgress("asset.mines.equipmentView.progress");
         box.addChild(progress);
         PositionUtils.setPos(progress,"mines.equipmentView.progressPos");
         progress.value = 0;
         proLabel.text = "";
         MinesManager.instance.addEventListener(MinesManager.LEVEL_UP_ARM,levelUpArm);
      }
      
      private function levelUpArm(param1:Event) : void
      {
         var _loc4_:int = 0;
         var _loc2_:* = null;
         _loc4_ = 0;
         while(_loc4_ < itemList.length)
         {
            _loc2_ = itemList[_loc4_] as EquipmentItem;
            _loc2_.setData();
            _loc4_++;
         }
         setProgress();
         var _loc3_:InventoryItemInfo = PlayerManager.Instance.Self.getBag(52).getItemAt(place) as InventoryItemInfo;
         if(_loc3_)
         {
            cell.setCount(_loc3_.Count);
            cell.info = _loc3_;
         }
         else
         {
            cell.info = null;
            place = 0;
         }
      }
      
      private function levelUpHandler() : void
      {
         if(chooseType == 0)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.mines.equipmentView.chooseFirst"));
            return;
         }
         switch(int(chooseType) - 1)
         {
            case 0:
               if(MinesManager.instance.model.headLevel >= MinesManager.instance.model.equipList.length)
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.mines.equipmentView.lvMax"));
                  return;
               }
               break;
            case 1:
               if(MinesManager.instance.model.clothLevel >= MinesManager.instance.model.equipList.length)
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.mines.equipmentView.lvMax"));
                  return;
               }
               break;
            case 2:
               if(MinesManager.instance.model.weaponLevel >= MinesManager.instance.model.equipList.length)
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.mines.equipmentView.lvMax"));
                  return;
               }
               break;
            case 3:
               if(MinesManager.instance.model.shieldLevel >= MinesManager.instance.model.equipList.length)
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.mines.equipmentView.lvMax"));
                  return;
               }
               break;
         }
         if(cell.info)
         {
            if(allInCheckBtn.selected)
            {
               SocketManager.Instance.out.sendEquipmentLevelUpHandler(chooseType,place,cell.getCount());
            }
            else
            {
               SocketManager.Instance.out.sendEquipmentLevelUpHandler(chooseType,place,1);
            }
         }
         else
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.mines.addMines"));
         }
      }
      
      public function cellChange(param1:BagCell) : void
      {
         if(param1)
         {
            cell.info = param1.info;
            cell.setCount(param1.getCount());
            place = param1.place;
         }
         else
         {
            cell.info = null;
            place = 0;
         }
      }
      
      private function clickHandler(param1:MouseEvent) : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = null;
         _loc3_ = 0;
         while(_loc3_ < itemList.length)
         {
            _loc2_ = itemList[_loc3_] as EquipmentItem;
            _loc2_.selectedPic.visible = false;
            _loc3_++;
         }
         (param1.currentTarget as EquipmentItem).selectedPic.visible = true;
         chooseType = (param1.currentTarget as EquipmentItem).type;
         setProgress();
      }
      
      private function setProgress() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = 0;
         switch(int(chooseType) - 1)
         {
            case 0:
               if(MinesManager.instance.model.headLevel < MinesManager.instance.model.equipList.length)
               {
                  _loc2_ = MinesManager.instance.model.headExp - MinesManager.instance.model.equipList[MinesManager.instance.model.headLevel - 1].headExp;
                  _loc1_ = int(MinesManager.instance.model.equipList[MinesManager.instance.model.headLevel].headExp - MinesManager.instance.model.equipList[MinesManager.instance.model.headLevel - 1].headExp);
               }
               else
               {
                  _loc2_ = MinesManager.instance.model.headExp - MinesManager.instance.model.equipList[MinesManager.instance.model.headLevel - 2].headExp;
                  _loc1_ = _loc2_;
               }
               break;
            case 1:
               if(MinesManager.instance.model.clothLevel < MinesManager.instance.model.equipList.length)
               {
                  _loc2_ = MinesManager.instance.model.clothExp - MinesManager.instance.model.equipList[MinesManager.instance.model.clothLevel - 1].clothExp;
                  _loc1_ = int(MinesManager.instance.model.equipList[MinesManager.instance.model.clothLevel].clothExp - MinesManager.instance.model.equipList[MinesManager.instance.model.clothLevel - 1].clothExp);
               }
               else
               {
                  _loc2_ = MinesManager.instance.model.clothExp - MinesManager.instance.model.equipList[MinesManager.instance.model.clothLevel - 2].clothExp;
                  _loc1_ = _loc2_;
               }
               break;
            case 2:
               if(MinesManager.instance.model.weaponLevel < MinesManager.instance.model.equipList.length)
               {
                  _loc2_ = MinesManager.instance.model.weaponExp - MinesManager.instance.model.equipList[MinesManager.instance.model.weaponLevel - 1].swordExp;
                  _loc1_ = int(MinesManager.instance.model.equipList[MinesManager.instance.model.weaponLevel].swordExp - MinesManager.instance.model.equipList[MinesManager.instance.model.weaponLevel - 1].swordExp);
               }
               else
               {
                  _loc2_ = MinesManager.instance.model.weaponExp - MinesManager.instance.model.equipList[MinesManager.instance.model.weaponLevel - 2].swordExp;
                  _loc1_ = _loc2_;
               }
               break;
            case 3:
               if(MinesManager.instance.model.shieldLevel < MinesManager.instance.model.equipList.length)
               {
                  _loc2_ = MinesManager.instance.model.shieldExp - MinesManager.instance.model.equipList[MinesManager.instance.model.shieldLevel - 1].shieldExp;
                  _loc1_ = int(MinesManager.instance.model.equipList[MinesManager.instance.model.shieldLevel].shieldExp - MinesManager.instance.model.equipList[MinesManager.instance.model.shieldLevel - 1].shieldExp);
                  break;
               }
               _loc2_ = MinesManager.instance.model.shieldExp - MinesManager.instance.model.equipList[MinesManager.instance.model.shieldLevel - 2].shieldExp;
               _loc1_ = _loc2_;
               break;
         }
         progress.value = _loc2_ / _loc1_;
         proLabel.text = String(_loc2_) + "/" + String(_loc1_);
      }
      
      override public function dispose() : void
      {
         MinesManager.instance.removeEventListener(MinesManager.LEVEL_UP_ARM,levelUpArm);
         progress.dispose();
         cell.dispose();
         super.dispose();
      }
   }
}
