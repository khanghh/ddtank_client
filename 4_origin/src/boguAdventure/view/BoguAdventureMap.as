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
      
      public function BoguAdventureMap(param1:BoguAdventureControl)
      {
         super();
         _control = param1;
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
      
      public function getCellPosIndex(param1:int, param2:Point) : Point
      {
         if(param1 == 0)
         {
            return new Point(100,100);
         }
         var _loc7_:BoguAdventureCell = getCellByIndex(param1);
         var _loc8_:Rectangle = _loc7_.getRect(stage);
         var _loc6_:Point = this.localToGlobal(new Point(_loc7_.x,_loc7_.y));
         var _loc4_:Number = _loc6_.x + int(_loc8_.width * 0.5) - param2.x;
         var _loc5_:Number = _loc6_.y + int(_loc8_.height * 0.5) - param2.y;
         var _loc3_:String = param1 < 10?param1.toString():param1.toString().charAt(1);
         if(_loc3_ == "1")
         {
            §§push(_loc4_ - 10);
         }
         else
         {
            if(_loc3_ == "2")
            {
               §§push(_loc4_ - 8);
            }
            else
            {
               if(_loc3_ == "3")
               {
                  _loc4_ = _loc4_ - 6;
                  §§push(_loc4_ - 6);
               }
               else
               {
                  §§push(Number(_loc4_));
               }
               §§push(Number(§§pop()));
            }
            §§push(Number(§§pop()));
         }
         _loc4_ = §§pop();
         return new Point(_loc4_,_loc5_);
      }
      
      public function getCellByIndex(param1:int) : BoguAdventureCell
      {
         return _cellList[param1 - 1];
      }
      
      public function playFineMineAction(param1:int) : void
      {
         var _loc2_:BoguAdventureCell = getCellByIndex(param1);
         _loc2_.playShineAction();
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
         var _loc1_:* = null;
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         _cellList = new Vector.<BoguAdventureCell>();
         _loc3_ = 0;
         while(_loc3_ < 7)
         {
            _loc2_ = 0;
            while(_loc2_ < 10)
            {
               _loc1_ = new BoguAdventureCell();
               _loc1_.addEventListener("click",__onClickCell);
               _loc1_.addEventListener("playcomplete",__onPlayComplete);
               _loc1_.x = 20 + _loc2_ * _loc1_.width;
               _loc1_.y = 19 + _loc3_ * _loc1_.height;
               addChild(_loc1_);
               _cellList.push(_loc1_);
               _loc2_++;
            }
            _loc3_++;
         }
      }
      
      private function __onClickCell(param1:MouseEvent) : void
      {
         if(!(param1.target is BoguAdventureCell))
         {
            return;
         }
         var _loc2_:BoguAdventureCell = param1.target as BoguAdventureCell;
         if(_control.changeMouse)
         {
            return;
         }
         if(_control.checkGameOver())
         {
            return;
         }
         if(_control.currentIndex == _loc2_.info.index)
         {
            return;
         }
         if(_loc2_.info.state == 2)
         {
            if(_loc2_.info.result == -1)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("boguAdventure.view.walkTip"));
               return;
            }
         }
         if(_loc2_.info.state == 1)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("boguAdventure.view.isSign"));
            return;
         }
         mouseClickClose();
         boguWalk(_loc2_.info.index);
      }
      
      private function boguWalk(param1:int) : void
      {
         var _loc2_:int = 0;
         var _loc8_:Array = [];
         var _loc4_:int = _control.currentIndex - 1 < 0?0:Number(_control.currentIndex - 1);
         var _loc3_:uint = param1 - 1 < 0?0:Number(param1 - 1);
         var _loc5_:String = _loc4_ < 10?"0" + _loc4_:_loc4_.toString();
         var _loc7_:String = _loc3_ < 10?"0" + _loc3_:_loc3_.toString();
         var _loc6_:SceneCharacterDirection = null;
         if(_control.currentIndex == 0)
         {
            _loc8_.push(getCellPosIndex(1,_control.bogu.focusPos));
         }
         if(_loc5_.charAt(1) != _loc7_.charAt(1))
         {
            if(_loc5_.charAt(1) < _loc7_.charAt(1))
            {
               _control.bogu.dir = SceneCharacterDirection.RB;
            }
            else
            {
               _control.bogu.dir = SceneCharacterDirection.LB;
            }
            _loc2_ = int(_loc7_.charAt(0) + _loc5_.charAt(1)) + 1;
            _loc8_.push(getCellPosIndex(_loc2_,_control.bogu.focusPos));
         }
         _loc8_.push(getCellPosIndex(param1,_control.bogu.focusPos));
         _control.currentIndex = param1;
         _control.walk(_loc8_);
      }
      
      private function __onPlayComplete(param1:Event) : void
      {
         var _loc2_:BoguAdventureCell = param1.currentTarget as BoguAdventureCell;
         _control.playActionComplete({
            "type":"actionfintmine",
            "index":_loc2_.info.index
         });
      }
      
      public function dispose() : void
      {
         var _loc1_:* = null;
         while(_cellList.length)
         {
            _loc1_ = _cellList.pop();
            _loc1_.removeEventListener("click",__onClickCell);
            _loc1_.removeEventListener("playcomplete",__onPlayComplete);
            ObjectUtils.disposeObject(_loc1_);
            _loc1_ = null;
         }
         _cellList = null;
         ObjectUtils.disposeObject(_mapBg);
         _mapBg = null;
         _control = null;
      }
   }
}
