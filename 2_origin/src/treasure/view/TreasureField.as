package treasure.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.utils.PositionUtils;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import treasure.controller.TreasureManager;
   import treasure.events.TreasureEvents;
   import treasure.model.TreasureModel;
   
   public class TreasureField extends Sprite implements Disposeable
   {
       
      
      private var X:Number = 236;
      
      private var Y:Number = 281;
      
      private var W:Number = 61;
      
      private var H:Number = 45;
      
      private var _fieldList:Vector.<TreasureCell>;
      
      private var cartoon:MovieClip;
      
      private var _fieldMc:MovieClip;
      
      private var _fieldMcList:Array;
      
      public function TreasureField(place:Sprite)
      {
         super();
         place.addChild(this);
         initListener();
      }
      
      private function initListener() : void
      {
         TreasureManager.instance.addEventListener("fieldChange",__fieldChangeHandler);
      }
      
      public function setField(dis:Boolean) : void
      {
         var i:int = 0;
         var j:int = 0;
         var cell:* = null;
         creatField();
         _fieldList = new Vector.<TreasureCell>();
         var index:int = 0;
         for(i = 0; i < 4; )
         {
            for(j = 0; j < 4; )
            {
               cell = new TreasureCell(index + 1,dis);
               cell.x = X + (cell.width + 2 - W) * i + W * j;
               cell.y = Y + (cell.height - 4 - H) * i - H * j;
               addChild(cell);
               cell.addEvent();
               _fieldList.push(cell);
               index++;
               j++;
            }
            i++;
         }
      }
      
      private function creatField() : void
      {
         var i:int = 0;
         var j:int = 0;
         var index:int = 0;
         _fieldMcList = [];
         for(i = 0; i < 4; )
         {
            for(j = 0; j < 4; )
            {
               _fieldMc = ComponentFactory.Instance.creat("asset.treasure.field");
               _fieldMc.x = X + (_fieldMc.width + 2 - W) * i + W * j;
               _fieldMc.y = Y + (_fieldMc.height - 4 - H) * i - H * j;
               if(TreasureModel.instance.itemList[index].pos > 0)
               {
                  _fieldMc.gotoAndStop(2);
               }
               else
               {
                  _fieldMc.gotoAndStop(1);
               }
               addChild(_fieldMc);
               _fieldMcList.push(_fieldMc);
               index++;
               j++;
            }
            i++;
         }
      }
      
      private function __fieldChangeHandler(e:TreasureEvents) : void
      {
         _fieldMcList[e.info.pos - 1].gotoAndStop(2);
      }
      
      public function endGameShow() : void
      {
         var i:int = 0;
         for(i = 0; i < _fieldList.length; )
         {
            if(TreasureModel.instance.itemList[_fieldList[i]._fieldPos - 1].pos == 0)
            {
               _fieldList[i].creatCartoon("end");
            }
            i++;
         }
      }
      
      public function playStartCartoon() : void
      {
         var j:int = 0;
         var i:int = 0;
         var cell:* = null;
         for(j = 0; j < _fieldList.length; )
         {
            _fieldList[j].cartoon.visible = false;
            j++;
         }
         cartoon = ComponentFactory.Instance.creat("asset.treasure.cartoon2");
         var s:Sprite = new Sprite();
         s.graphics.beginFill(16777215,0);
         s.graphics.drawRect(0,0,43,43);
         s.graphics.endFill();
         for(i = 1; i <= TreasureModel.instance.itemList.length; )
         {
            cell = new TreasureFieldCell(s,TreasureModel.instance.itemList[i - 1]);
            cartoon["mc" + i].addChild(cell);
            i++;
         }
         addChild(cartoon);
         PositionUtils.setPos(cartoon,"cartoon2.pos");
         cartoon.addEventListener("enterFrame",onCompleteHandeler);
      }
      
      public function digField(pos:int) : void
      {
         swapChildren(_fieldList[pos - 1],_fieldList[_fieldList.length - 1]);
         _fieldList[pos - 1].digBackHandler();
      }
      
      private function onCompleteHandeler(e:Event) : void
      {
         var j:int = 0;
         if(cartoon != null && cartoon.currentFrame == cartoon.totalFrames)
         {
            cartoon.removeEventListener("enterFrame",onCompleteHandeler);
            if(cartoon)
            {
               ObjectUtils.disposeObject(cartoon);
            }
            cartoon = null;
            for(j = 0; j < _fieldList.length; )
            {
               _fieldList[j].addEvent();
               j++;
            }
         }
      }
      
      private function removeListener() : void
      {
         TreasureManager.instance.removeEventListener("fieldChange",__fieldChangeHandler);
      }
      
      public function dispose() : void
      {
         removeListener();
         if(cartoon)
         {
            ObjectUtils.disposeObject(cartoon);
         }
         cartoon = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
