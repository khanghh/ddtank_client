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
      
      public function AwardCellMap(param1:Array){super();}
      
      private function initView() : void{}
      
      public function addItem(param1:int, param2:AwardCellItem) : void{}
      
      public function clearItem() : void{}
      
      public function setStartPos(param1:int) : void{}
      
      public function moveTargetPos(param1:int, param2:Function) : void{}
      
      private function ready() : void{}
      
      private function __toTargetHandler(param1:TimerEvent) : void{}
      
      private function moveToTarget(param1:Point) : void{}
      
      private function stop() : void{}
      
      private function showTip() : void{}
      
      public function dispose() : void{}
   }
}
