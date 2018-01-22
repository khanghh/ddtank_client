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
      
      public function AwardCellMap(param1:Array)
      {
         _roadMcOffset = new Point(11,11);
         super();
         _cellsPos = param1;
         initView();
         _cellArr = new DictionaryData();
      }
      
      private function initView() : void
      {
         _cellSpri = new Sprite();
         addChild(_cellSpri);
         _roadTimer = new Timer(400,0);
      }
      
      public function addItem(param1:int, param2:AwardCellItem) : void
      {
         var _loc3_:* = null;
         var _loc4_:* = param2;
         if(_cellsPos)
         {
            _loc3_ = _cellsPos[param1];
            _loc4_.x = _loc3_.x;
            _loc4_.y = _loc3_.y;
            _cellArr.add(param1,_loc4_);
            _cellSpri.addChild(_loc4_);
         }
      }
      
      public function clearItem() : void
      {
         var _loc1_:Array = _cellArr.list;
         while(_loc1_.length > 0)
         {
            ObjectUtils.disposeObject(_loc1_.shift() as AwardCellItem);
         }
         if(_cellSpri.numChildren > 2)
         {
            _cellSpri.removeChildren(1,_cellSpri.numChildren - 1);
         }
      }
      
      public function setStartPos(param1:int) : void
      {
         var _loc2_:* = null;
         if(_roadMc == null)
         {
            _roadMc = ComponentFactory.Instance.creat("asset.oldPlayerComeBack.moveMc");
            _roadMc.visible = false;
            _cellSpri.addChild(_roadMc);
         }
         if(_cellsPos)
         {
            _loc2_ = _cellsPos[param1];
            _roadMc.x = _loc2_.x - _roadMcOffset.x;
            _roadMc.y = _loc2_.y - _roadMcOffset.y;
            _roadMc.visible = true;
            _nowPlace = param1;
         }
      }
      
      public function moveTargetPos(param1:int, param2:Function) : void
      {
         _callFun = param2;
         _targetPlace = _nowPlace + param1;
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
      
      private function __toTargetHandler(param1:TimerEvent) : void
      {
         var _loc2_:* = null;
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
            _loc2_ = _cellsPos[_nowPlace];
            moveToTarget(_loc2_);
         }
      }
      
      private function moveToTarget(param1:Point) : void
      {
         _roadMc.x = param1.x - _roadMcOffset.x;
         _roadMc.y = param1.y - _roadMcOffset.y;
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
         var _loc1_:Array = _cellArr.list;
         while(_loc1_.length > 0)
         {
            ObjectUtils.disposeObject(_loc1_.shift() as AwardCellItem);
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
