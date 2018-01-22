package mines.view
{
   import bagAndInfo.cell.BagCell;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.utils.PositionUtils;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import mines.MinesManager;
   import mines.mornui.view.ToolViewUI;
   import morn.core.handlers.Handler;
   
   public class ToolView extends ToolViewUI
   {
       
      
      private var shape:Shape;
      
      private var nameList:Array;
      
      private var cell:MinesCell;
      
      private var place:int;
      
      public function ToolView()
      {
         shape = new Shape();
         nameList = LanguageMgr.GetTranslation("ddt.mines.toolView.nameList").split("|");
         super();
      }
      
      override protected function initialize() : void
      {
         upBtn.clickHandler = new Handler(levelUp);
         setData();
         cell = new MinesCell(new Sprite(),0);
         addChild(cell);
         PositionUtils.setPos(cell,"mines.toolView.cellPos");
         box.addChild(shape);
         MinesManager.instance.addEventListener(MinesManager.LEVEL_UP_TOOL,levelUpTool);
      }
      
      private function levelUpTool(param1:Event) : void
      {
         setData();
         var _loc2_:InventoryItemInfo = PlayerManager.Instance.Self.getBag(52).getItemAt(place) as InventoryItemInfo;
         if(_loc2_)
         {
            cell.setCount(_loc2_.Count);
            cell.info = _loc2_;
         }
         else
         {
            cell.info = null;
            place = 0;
         }
      }
      
      private function levelUp() : void
      {
         if(MinesManager.instance.model.toolLevel >= MinesManager.instance.model.toolList.length)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.mines.toolView.maxTool"));
            return;
         }
         if(cell.info)
         {
            if(allInCheckBtn.selected)
            {
               SocketManager.Instance.out.sendUpdataToolHandler(place,cell.getCount());
            }
            else
            {
               SocketManager.Instance.out.sendUpdataToolHandler(place,1);
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
      
      public function DrawSector(param1:Shape, param2:Number = 200, param3:Number = 200, param4:Number = 100, param5:Number = 27, param6:Number = 270, param7:Number = 16711680) : void
      {
         var _loc15_:int = 0;
         var _loc11_:Number = NaN;
         var _loc14_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc10_:Number = NaN;
         param1.graphics.clear();
         param1.graphics.beginFill(param7,0);
         param1.graphics.lineStyle(0,param7,0);
         param1.graphics.moveTo(param2,param3);
         param5 = Math.abs(param5) > 360?360:Number(param5);
         var _loc9_:Number = Math.ceil(Math.abs(param5) / 45);
         var _loc8_:Number = param5 / _loc9_;
         _loc8_ = _loc8_ * 3.14159265358979 / 180;
         param6 = param6 * 3.14159265358979 / 180;
         param1.graphics.lineTo(param2 + param4 * Math.cos(param6),param3 + param4 * Math.sin(param6));
         _loc15_ = 1;
         while(_loc15_ <= _loc9_)
         {
            param6 = param6 + _loc8_;
            _loc11_ = param6 - _loc8_ / 2;
            _loc14_ = param2 + param4 / Math.cos(_loc8_ / 2) * Math.cos(_loc11_);
            _loc13_ = param3 + param4 / Math.cos(_loc8_ / 2) * Math.sin(_loc11_);
            _loc12_ = param2 + param4 * Math.cos(param6);
            _loc10_ = param3 + param4 * Math.sin(param6);
            param1.graphics.curveTo(_loc14_,_loc13_,_loc12_,_loc10_);
            _loc15_++;
         }
         if(param5 != 360)
         {
            param1.graphics.lineTo(param2,param3);
         }
         param1.graphics.endFill();
      }
      
      private function setData() : void
      {
         var _loc2_:int = 0;
         var _loc1_:int = 0;
         var _loc4_:Number = NaN;
         var _loc5_:int = 0;
         var _loc3_:int = 0;
         toolName.text = nameList[MinesManager.instance.model.toolLevel - 1];
         if(MinesManager.instance.model.toolLevel >= nameList.length)
         {
            nextToolName.text = LanguageMgr.GetTranslation("ddt.mines.toolView.maxTool");
            round.mask = null;
            proLabel.text = MinesManager.instance.model.toolList[MinesManager.instance.model.toolList.length - 1].exp + "/" + MinesManager.instance.model.toolList[MinesManager.instance.model.toolList.length - 1].exp;
         }
         else
         {
            nextToolName.text = LanguageMgr.GetTranslation("ddt.mines.toolView.nextTool",nameList[MinesManager.instance.model.toolLevel]);
            _loc2_ = MinesManager.instance.model.toolExp - MinesManager.instance.model.toolList[MinesManager.instance.model.toolLevel - 1].exp;
            _loc1_ = MinesManager.instance.model.toolList[MinesManager.instance.model.toolLevel].exp - MinesManager.instance.model.toolList[MinesManager.instance.model.toolLevel - 1].exp;
            _loc4_ = 360 * _loc2_ / _loc1_;
            _loc5_ = round.x + round.width / 2;
            _loc3_ = round.y + round.height / 2;
            DrawSector(shape,_loc5_,_loc3_,2 + Math.ceil(round.width / 2),_loc4_,90);
            round.mask = shape;
            proLabel.text = String(_loc2_) + "/" + String(_loc1_);
         }
         toolImage.skin = "asset.mines.ToolView.tool" + String(MinesManager.instance.model.toolLevel);
      }
      
      override public function dispose() : void
      {
         MinesManager.instance.removeEventListener(MinesManager.LEVEL_UP_TOOL,levelUpTool);
         cell.dispose();
         super.dispose();
      }
   }
}
