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
         var i:int = 0;
         var item:* = null;
         itemList = new Vector.<EquipmentItem>();
         for(i = 0; i < 4; )
         {
            item = new EquipmentItem(i + 1);
            item.setData();
            item.x = 30 + 309 * (i % 2);
            item.y = 14 + 184 * Math.floor(i / 2);
            item.addEventListener("click",clickHandler);
            box.addChild(item);
            itemList.push(item);
            i++;
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
      
      private function levelUpArm(e:Event) : void
      {
         var i:int = 0;
         var item:* = null;
         for(i = 0; i < itemList.length; )
         {
            item = itemList[i] as EquipmentItem;
            item.setData();
            i++;
         }
         setProgress();
         var info:InventoryItemInfo = PlayerManager.Instance.Self.getBag(52).getItemAt(place) as InventoryItemInfo;
         if(info)
         {
            cell.setCount(info.Count);
            cell.info = info;
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
      
      public function cellChange(value:BagCell) : void
      {
         if(value)
         {
            cell.info = value.info;
            cell.setCount(value.getCount());
            place = value.place;
         }
         else
         {
            cell.info = null;
            place = 0;
         }
      }
      
      private function clickHandler(e:MouseEvent) : void
      {
         var i:int = 0;
         var item:* = null;
         for(i = 0; i < itemList.length; )
         {
            item = itemList[i] as EquipmentItem;
            item.selectedPic.visible = false;
            i++;
         }
         (e.currentTarget as EquipmentItem).selectedPic.visible = true;
         chooseType = (e.currentTarget as EquipmentItem).type;
         setProgress();
      }
      
      private function setProgress() : void
      {
         var current:int = 0;
         var total:* = 0;
         switch(int(chooseType) - 1)
         {
            case 0:
               if(MinesManager.instance.model.headLevel < MinesManager.instance.model.equipList.length)
               {
                  current = MinesManager.instance.model.headExp - MinesManager.instance.model.equipList[MinesManager.instance.model.headLevel - 1].headExp;
                  total = int(MinesManager.instance.model.equipList[MinesManager.instance.model.headLevel].headExp - MinesManager.instance.model.equipList[MinesManager.instance.model.headLevel - 1].headExp);
               }
               else
               {
                  current = MinesManager.instance.model.headExp - MinesManager.instance.model.equipList[MinesManager.instance.model.headLevel - 2].headExp;
                  total = current;
               }
               break;
            case 1:
               if(MinesManager.instance.model.clothLevel < MinesManager.instance.model.equipList.length)
               {
                  current = MinesManager.instance.model.clothExp - MinesManager.instance.model.equipList[MinesManager.instance.model.clothLevel - 1].clothExp;
                  total = int(MinesManager.instance.model.equipList[MinesManager.instance.model.clothLevel].clothExp - MinesManager.instance.model.equipList[MinesManager.instance.model.clothLevel - 1].clothExp);
               }
               else
               {
                  current = MinesManager.instance.model.clothExp - MinesManager.instance.model.equipList[MinesManager.instance.model.clothLevel - 2].clothExp;
                  total = current;
               }
               break;
            case 2:
               if(MinesManager.instance.model.weaponLevel < MinesManager.instance.model.equipList.length)
               {
                  current = MinesManager.instance.model.weaponExp - MinesManager.instance.model.equipList[MinesManager.instance.model.weaponLevel - 1].swordExp;
                  total = int(MinesManager.instance.model.equipList[MinesManager.instance.model.weaponLevel].swordExp - MinesManager.instance.model.equipList[MinesManager.instance.model.weaponLevel - 1].swordExp);
               }
               else
               {
                  current = MinesManager.instance.model.weaponExp - MinesManager.instance.model.equipList[MinesManager.instance.model.weaponLevel - 2].swordExp;
                  total = current;
               }
               break;
            case 3:
               if(MinesManager.instance.model.shieldLevel < MinesManager.instance.model.equipList.length)
               {
                  current = MinesManager.instance.model.shieldExp - MinesManager.instance.model.equipList[MinesManager.instance.model.shieldLevel - 1].shieldExp;
                  total = int(MinesManager.instance.model.equipList[MinesManager.instance.model.shieldLevel].shieldExp - MinesManager.instance.model.equipList[MinesManager.instance.model.shieldLevel - 1].shieldExp);
                  break;
               }
               current = MinesManager.instance.model.shieldExp - MinesManager.instance.model.equipList[MinesManager.instance.model.shieldLevel - 2].shieldExp;
               total = current;
               break;
         }
         progress.value = current / total;
         proLabel.text = String(current) + "/" + String(total);
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
