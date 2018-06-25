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
      
      private function levelUpTool(e:Event) : void
      {
         setData();
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
      
      public function DrawSector(shape:Shape, x:Number = 200, y:Number = 200, r:Number = 100, angle:Number = 27, startFrom:Number = 270, color:Number = 16711680) : void
      {
         var i:int = 0;
         var angleMid:Number = NaN;
         var bx:Number = NaN;
         var by:Number = NaN;
         var cx:Number = NaN;
         var cy:Number = NaN;
         shape.graphics.clear();
         shape.graphics.beginFill(color,0);
         shape.graphics.lineStyle(0,color,0);
         shape.graphics.moveTo(x,y);
         angle = Math.abs(angle) > 360?360:Number(angle);
         var n:Number = Math.ceil(Math.abs(angle) / 45);
         var angleA:Number = angle / n;
         angleA = angleA * 3.14159265358979 / 180;
         startFrom = startFrom * 3.14159265358979 / 180;
         shape.graphics.lineTo(x + r * Math.cos(startFrom),y + r * Math.sin(startFrom));
         for(i = 1; i <= n; )
         {
            startFrom = startFrom + angleA;
            angleMid = startFrom - angleA / 2;
            bx = x + r / Math.cos(angleA / 2) * Math.cos(angleMid);
            by = y + r / Math.cos(angleA / 2) * Math.sin(angleMid);
            cx = x + r * Math.cos(startFrom);
            cy = y + r * Math.sin(startFrom);
            shape.graphics.curveTo(bx,by,cx,cy);
            i++;
         }
         if(angle != 360)
         {
            shape.graphics.lineTo(x,y);
         }
         shape.graphics.endFill();
      }
      
      private function setData() : void
      {
         var current:int = 0;
         var total:int = 0;
         var angle:Number = NaN;
         var x:int = 0;
         var y:int = 0;
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
            current = MinesManager.instance.model.toolExp - MinesManager.instance.model.toolList[MinesManager.instance.model.toolLevel - 1].exp;
            total = MinesManager.instance.model.toolList[MinesManager.instance.model.toolLevel].exp - MinesManager.instance.model.toolList[MinesManager.instance.model.toolLevel - 1].exp;
            angle = 360 * current / total;
            x = round.x + round.width / 2;
            y = round.y + round.height / 2;
            DrawSector(shape,x,y,2 + Math.ceil(round.width / 2),angle,90);
            round.mask = shape;
            proLabel.text = String(current) + "/" + String(total);
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
