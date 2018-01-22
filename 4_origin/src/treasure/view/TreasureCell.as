package treasure.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PathManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.ui.Mouse;
   import treasure.controller.TreasureManager;
   import treasure.events.TreasureEvents;
   import treasure.model.TreasureModel;
   
   public class TreasureCell extends Sprite implements Disposeable
   {
       
      
      public var cell:TreasureFieldCell;
      
      private var _field:MovieClip;
      
      private var _tbxCount:FilterFrameText;
      
      public var cartoon:MovieClip;
      
      public var _fieldPos:int;
      
      private var cartoon_dig:MovieClip;
      
      private var cursor:Bitmap;
      
      public function TreasureCell(param1:int, param2:Boolean = true)
      {
         super();
         cursor = ComponentFactory.Instance.creatBitmap("asset.treasure.cursor");
         _fieldPos = param1;
         _field = ComponentFactory.Instance.creat("asset.treasure.field");
         if(TreasureModel.instance.itemList[_fieldPos - 1].pos > 0)
         {
            _field.gotoAndStop(2);
         }
         else
         {
            _field.gotoAndStop(1);
         }
         _field.alpha = 0;
         addChild(_field);
         if(param2 || TreasureModel.instance.itemList[_fieldPos - 1].pos > 0)
         {
            creatCartoon();
         }
         addChild(cursor);
         cursor.visible = false;
      }
      
      public function creatCartoon(param1:String = "show") : void
      {
         if(cartoon)
         {
            ObjectUtils.disposeObject(cartoon);
         }
         cartoon = null;
         if(param1 == "end")
         {
            removeEvent();
            outHandler(new MouseEvent("mouseMove"));
         }
         cartoon = ComponentFactory.Instance.creat("asset.treasure.cartoon1");
         var _loc2_:Sprite = new Sprite();
         _loc2_.graphics.beginFill(16777215,0);
         _loc2_.graphics.drawRect(0,0,78,78);
         _loc2_.graphics.endFill();
         _tbxCount = ComponentFactory.Instance.creatComponentByStylename("treasure.CountText");
         _tbxCount.mouseEnabled = false;
         PositionUtils.setPos(_tbxCount,"treasure.cell.numTf.pos");
         cell = new TreasureFieldCell(_loc2_,TreasureModel.instance.itemList[_fieldPos - 1]);
         cartoon.mc.addChild(cell);
         cartoon.mc.addChild(_tbxCount);
         cartoon.gotoAndPlay(param1);
         if(param1 == "end")
         {
            cartoon.addEventListener("enterFrame",__allOverHandler);
         }
         _tbxCount.text = String(TreasureModel.instance.itemList[_fieldPos - 1].Count);
         PositionUtils.setPos(cell,"treasure.cell.pos");
         addChild(cartoon);
         cartoon.visible = true;
         PositionUtils.setPos(cartoon,"cartoon1.pos");
      }
      
      private function __allOverHandler(param1:Event) : void
      {
         if(cartoon.currentFrame == cartoon.totalFrames)
         {
            cartoon.removeEventListener("enterFrame",__allOverHandler);
            TreasureModel.instance.isClick = true;
            if(!TreasureModel.instance.isEndTreasure && PlayerManager.Instance.Self.treasure + PlayerManager.Instance.Self.treasureAdd == 0 && TreasureModel.instance.friendHelpTimes >= PathManager.treasureHelpTimes)
            {
               SocketManager.Instance.out.endTreasure();
            }
         }
      }
      
      public function removeCell() : void
      {
         if(cartoon)
         {
            cartoon.mc.removeChild(cell);
            cartoon.mc.removeChild(_tbxCount);
         }
      }
      
      public function digBackHandler() : void
      {
         removeEvent();
         outHandler(new MouseEvent("mouseMove"));
         if(cartoon_dig)
         {
            cartoon_dig.visible = true;
         }
         else
         {
            cartoon_dig = ComponentFactory.Instance.creat("asset.treasure.cartoon3");
            addChild(cartoon_dig);
         }
         PositionUtils.setPos(cartoon_dig,"cartoon3.pos");
         cartoon_dig.addEventListener("enterFrame",cartoon_digHandler);
      }
      
      private function cartoon_digHandler(param1:Event) : void
      {
         if(cartoon_dig.currentFrame == cartoon_dig.totalFrames)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.fightLib.Award.GetMessage") + TreasureModel.instance.itemList[_fieldPos - 1].Name + "*" + String(TreasureModel.instance.itemList[_fieldPos - 1].Count));
            cartoon_dig.removeEventListener("enterFrame",cartoon_digHandler);
            cartoon_dig.visible = false;
            TreasureManager.instance.dispatchEvent(new TreasureEvents("fieldChange",{"pos":_fieldPos}));
            creatCartoon("end");
         }
      }
      
      private function removeEvent() : void
      {
         this.removeEventListener("click",clickHandler);
         this.removeEventListener("mouseOver",overHandler);
         this.removeEventListener("mouseOut",outHandler);
      }
      
      public function addEvent() : void
      {
         if(TreasureModel.instance.itemList[_fieldPos - 1].pos == 0 && TreasureModel.instance.isBeginTreasure && !TreasureModel.instance.isEndTreasure)
         {
            this.addEventListener("click",clickHandler);
            this.addEventListener("mouseOver",overHandler);
            this.addEventListener("mouseOut",outHandler);
         }
      }
      
      private function overHandler(param1:MouseEvent) : void
      {
         Mouse.hide();
         this.addEventListener("mouseMove",mouseMoveHandler);
      }
      
      private function outHandler(param1:MouseEvent) : void
      {
         Mouse.show();
         cursor.visible = false;
         this.removeEventListener("mouseMove",mouseMoveHandler);
      }
      
      private function mouseMoveHandler(param1:MouseEvent) : void
      {
         cursor.x = param1.localX;
         cursor.y = param1.localY - 18;
         param1.updateAfterEvent();
         cursor.visible = true;
      }
      
      private function clickHandler(param1:MouseEvent) : void
      {
         if(TreasureModel.instance.isClick)
         {
            if(PlayerManager.Instance.Self.treasure + PlayerManager.Instance.Self.treasureAdd > 0)
            {
               TreasureModel.instance.isClick = false;
               this.mouseEnabled = false;
               SocketManager.Instance.out.doTreasure(_fieldPos);
            }
            else if(TreasureModel.instance.friendHelpTimes < PathManager.treasureHelpTimes)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.treasure.warning"));
            }
            else
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.treasure.warning1"));
            }
         }
         else
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.treasure.warning1"));
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(cell)
         {
            ObjectUtils.disposeObject(cell);
         }
         cell = null;
         if(_field)
         {
            ObjectUtils.disposeObject(_field);
         }
         _field = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
