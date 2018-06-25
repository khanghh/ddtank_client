package oldPlayerComeBack.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.utils.Timer;
   import road7th.data.DictionaryData;
   
   public class AwardCellMap extends Sprite
   {
       
      
      private var _cellsPos:Array;
      
      private var _cellSpri:Sprite;
      
      private var _roadMc:Bitmap;
      
      private var _roadMcOffset:Point;
      
      private var _roadTimer:Timer;
      
      private var _nowPlace:int;
      
      private var _targetPlace:int;
      
      private var _callFun:Function;
      
      private var _cellArr:DictionaryData;
      
      public function AwardCellMap(cellsPos:Array)
      {
         _roadMcOffset = new Point(11,11);
         super();
         _cellsPos = cellsPos;
         initView();
         _cellArr = new DictionaryData();
      }
      
      private function initView() : void
      {
         _cellSpri = new Sprite();
         addChild(_cellSpri);
         _roadTimer = new Timer(400,0);
      }
      
      public function addItem(place:int, item:AwardCellItem) : void
      {
         var temPos:* = null;
         var cell:* = item;
         if(_cellsPos)
         {
            temPos = _cellsPos[place];
            cell.x = temPos.x;
            cell.y = temPos.y;
            _cellArr.add(place,cell);
            _cellSpri.addChild(cell);
         }
      }
      
      public function clearItem() : void
      {
         var temArr:Array = _cellArr.list;
         while(temArr.length > 0)
         {
            ObjectUtils.disposeObject(temArr.shift() as AwardCellItem);
         }
         if(_cellSpri.numChildren > 2)
         {
            _cellSpri.removeChildren(1,_cellSpri.numChildren - 1);
         }
      }
      
      public function setStartPos(place:int) : void
      {
         var pos:* = null;
         if(_roadMc == null)
         {
            _roadMc = ComponentFactory.Instance.creat("asset.oldPlayerComeBack.moveMc");
            _roadMc.visible = false;
            _cellSpri.addChild(_roadMc);
         }
         if(_cellsPos)
         {
            pos = _cellsPos[place];
            _roadMc.x = pos.x - _roadMcOffset.x;
            _roadMc.y = pos.y - _roadMcOffset.y;
            _roadMc.visible = true;
            _nowPlace = place;
         }
      }
      
      public function moveTargetPos(place:int, callFun:Function) : void
      {
         _callFun = callFun;
         _targetPlace = _nowPlace + place;
         ready();
      }
      
      private function ready() : void
      {
         if(!_roadMc.visible)
         {
            _roadMc.visible = true;
         }
         _roadTimer.stop();
         _roadTimer.addEventListener("timer",__toTargetHandler);
         _roadTimer.start();
      }
      
      private function __toTargetHandler(evt:TimerEvent) : void
      {
         var nexPos:* = null;
         if(_cellsPos)
         {
            _nowPlace = _nowPlace + 1;
            if(_nowPlace > _targetPlace)
            {
               stop();
               if(_callFun)
               {
                  _callFun(_nowPlace);
               }
               _callFun = null;
               return;
            }
            nexPos = _cellsPos[_nowPlace];
            moveToTarget(nexPos);
         }
      }
      
      private function moveToTarget(pos:Point) : void
      {
         _roadMc.x = pos.x - _roadMcOffset.x;
         _roadMc.y = pos.y - _roadMcOffset.y;
      }
      
      private function stop() : void
      {
         _nowPlace = _targetPlace;
         _roadTimer.stop();
         _roadTimer.removeEventListener("timer",__toTargetHandler);
         showTip();
      }
      
      private function showTip() : void
      {
         if(_cellArr && _cellArr.list.length > 0 && _cellArr[_nowPlace])
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("oldPlayerComeBack.diceAwardTipMsg",_cellArr[_nowPlace].getInfo().Name));
         }
      }
      
      public function dispose() : void
      {
         _cellsPos = [];
         if(_roadMc)
         {
            ObjectUtils.disposeObject(_roadMc);
         }
         _roadMc = null;
         _roadTimer = null;
         _callFun = null;
         var temArr:Array = _cellArr.list;
         while(temArr.length > 0)
         {
            ObjectUtils.disposeObject(temArr.shift() as AwardCellItem);
         }
         _cellArr = null;
         if(_cellSpri && _cellSpri.numChildren > 0)
         {
            _cellSpri.removeChildren(0,_cellSpri.numChildren - 1);
            _cellSpri = null;
         }
      }
   }
}
