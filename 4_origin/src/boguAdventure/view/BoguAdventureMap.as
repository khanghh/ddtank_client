package boguAdventure.view
{
   import boguAdventure.BoguAdventureControl;
   import boguAdventure.cell.BoguAdventureCell;
   import com.pickgliss.ui.UICreatShortcut;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.view.sceneCharacter.SceneCharacterDirection;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.PerspectiveProjection;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class BoguAdventureMap extends Sprite implements Disposeable
   {
      
      private static const MAP_WIDTH:int = 10;
      
      private static const MAP_HEIGHT:int = 7;
       
      
      private var _mapBg:Bitmap;
      
      private var _cellList:Vector.<BoguAdventureCell>;
      
      private var _control:BoguAdventureControl;
      
      public function BoguAdventureMap(control:BoguAdventureControl)
      {
         super();
         _control = control;
         init();
      }
      
      private function init() : void
      {
         this.transform.perspectiveProjection = new PerspectiveProjection();
         this.transform.perspectiveProjection.projectionCenter = new Point(500,300);
         this.rotationX = -38;
         _mapBg = UICreatShortcut.creatAndAdd("boguAdventure.gameView.Bg",this);
         createMapCell();
      }
      
      public function getCellPosIndex(index:int, focusPos:Point) : Point
      {
         if(index == 0)
         {
            return new Point(100,100);
         }
         var cell:BoguAdventureCell = getCellByIndex(index);
         var rect:Rectangle = cell.getRect(stage);
         var realPos:Point = this.localToGlobal(new Point(cell.x,cell.y));
         var endX:Number = realPos.x + int(rect.width * 0.5) - focusPos.x;
         var endY:Number = realPos.y + int(rect.height * 0.5) - focusPos.y;
         var str:String = index < 10?index.toString():index.toString().charAt(1);
         if(str == "1")
         {
            §§push(endX - 10);
         }
         else
         {
            if(str == "2")
            {
               §§push(endX - 8);
            }
            else
            {
               if(str == "3")
               {
                  endX = endX - 6;
                  §§push(endX - 6);
               }
               else
               {
                  §§push(Number(endX));
               }
               §§push(Number(§§pop()));
            }
            §§push(Number(§§pop()));
         }
         endX = §§pop();
         return new Point(endX,endY);
      }
      
      public function getCellByIndex(index:int) : BoguAdventureCell
      {
         return _cellList[index - 1];
      }
      
      public function playFineMineAction(index:int) : void
      {
         var cell:BoguAdventureCell = getCellByIndex(index);
         cell.playShineAction();
      }
      
      public function mouseClickClose() : void
      {
         this.mouseEnabled = false;
         this.mouseChildren = false;
      }
      
      public function mouseClickOpen() : void
      {
         this.mouseEnabled = true;
         this.mouseChildren = true;
      }
      
      private function createMapCell() : void
      {
         var cell:* = null;
         var i:int = 0;
         var j:int = 0;
         _cellList = new Vector.<BoguAdventureCell>();
         for(i = 0; i < 7; )
         {
            for(j = 0; j < 10; )
            {
               cell = new BoguAdventureCell();
               cell.addEventListener("click",__onClickCell);
               cell.addEventListener("playcomplete",__onPlayComplete);
               cell.x = 20 + j * cell.width;
               cell.y = 19 + i * cell.height;
               addChild(cell);
               _cellList.push(cell);
               j++;
            }
            i++;
         }
      }
      
      private function __onClickCell(e:MouseEvent) : void
      {
         if(!(e.target is BoguAdventureCell))
         {
            return;
         }
         var cell:BoguAdventureCell = e.target as BoguAdventureCell;
         if(_control.changeMouse)
         {
            return;
         }
         if(_control.checkGameOver())
         {
            return;
         }
         if(_control.currentIndex == cell.info.index)
         {
            return;
         }
         if(cell.info.state == 2)
         {
            if(cell.info.result == -1)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("boguAdventure.view.walkTip"));
               return;
            }
         }
         if(cell.info.state == 1)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("boguAdventure.view.isSign"));
            return;
         }
         mouseClickClose();
         boguWalk(cell.info.index);
      }
      
      private function boguWalk(index:int) : void
      {
         var hIndex:int = 0;
         var path:Array = [];
         var currentIndex:int = _control.currentIndex - 1 < 0?0:Number(_control.currentIndex - 1);
         var oldIndex:uint = index - 1 < 0?0:Number(index - 1);
         var old:String = currentIndex < 10?"0" + currentIndex:currentIndex.toString();
         var current:String = oldIndex < 10?"0" + oldIndex:oldIndex.toString();
         var dir:SceneCharacterDirection = null;
         if(_control.currentIndex == 0)
         {
            path.push(getCellPosIndex(1,_control.bogu.focusPos));
         }
         if(old.charAt(1) != current.charAt(1))
         {
            if(old.charAt(1) < current.charAt(1))
            {
               _control.bogu.dir = SceneCharacterDirection.RB;
            }
            else
            {
               _control.bogu.dir = SceneCharacterDirection.LB;
            }
            hIndex = int(current.charAt(0) + old.charAt(1)) + 1;
            path.push(getCellPosIndex(hIndex,_control.bogu.focusPos));
         }
         path.push(getCellPosIndex(index,_control.bogu.focusPos));
         _control.currentIndex = index;
         _control.walk(path);
      }
      
      private function __onPlayComplete(e:Event) : void
      {
         var cell:BoguAdventureCell = e.currentTarget as BoguAdventureCell;
         _control.playActionComplete({
            "type":"actionfintmine",
            "index":cell.info.index
         });
      }
      
      public function dispose() : void
      {
         var cell:* = null;
         while(_cellList.length)
         {
            cell = _cellList.pop();
            cell.removeEventListener("click",__onClickCell);
            cell.removeEventListener("playcomplete",__onPlayComplete);
            ObjectUtils.disposeObject(cell);
            cell = null;
         }
         _cellList = null;
         ObjectUtils.disposeObject(_mapBg);
         _mapBg = null;
         _control = null;
      }
   }
}
