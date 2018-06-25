package ddtBuried.map
{
   import bagAndInfo.cell.BagCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.ItemManager;
   import ddtBuried.BuriedControl;
   import ddtBuried.BuriedManager;
   import ddtBuried.data.MapItemData;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.geom.Point;
   
   public class Scence1 extends MovieClip implements Disposeable
   {
       
      
      private var _content:Sprite;
      
      private var _mapArray:Array;
      
      private var _map:Maps;
      
      private var standArray:Array;
      
      public function Scence1(str:String, row:int, col:int)
      {
         _mapArray = [];
         super();
         initView(str,row,col);
      }
      
      private function initView(str:String, row:int, col:int) : void
      {
         _mapArray = BuriedControl.Instance.oneDegreeToTwoDegree(str,row,col);
         _map = new Maps(_mapArray,row,col);
         addChild(_map);
         initMapItem();
      }
      
      private function initMapItem() : void
      {
         var xIndex:int = 0;
         var yIndex:int = 0;
         var bitmap:* = null;
         var i:int = 0;
         var data:* = null;
         var spItem:* = null;
         if(BuriedManager.Instance.mapID == 1)
         {
            standArray = BuriedControl.Instance.mapArrays.standArray1;
         }
         else if(BuriedManager.Instance.mapID == 2)
         {
            standArray = BuriedControl.Instance.mapArrays.standArray2;
         }
         else
         {
            standArray = BuriedControl.Instance.mapArrays.standArray3;
         }
         var list:Vector.<MapItemData> = BuriedManager.Instance.mapdataList;
         var len:int = list.length;
         xIndex = standArray[0].x;
         yIndex = standArray[0].y;
         var spStart:Sprite = new Sprite();
         bitmap = ComponentFactory.Instance.creat("buried.shaizi.startPoint");
         var _loc14_:* = 0.8;
         bitmap.scaleY = _loc14_;
         bitmap.scaleX = _loc14_;
         spStart.addChild(bitmap);
         if(_map.getMapArray()[yIndex][xIndex].numChildren > 0)
         {
            _map.getMapArray()[yIndex][xIndex].removeChildAt(0);
         }
         _map.getMapArray()[yIndex][xIndex].addChild(spStart);
         var spEnd:Sprite = creatIcon(BuriedControl.Instance.getUpdateData(false).DestinationReward);
         xIndex = standArray[35].x;
         yIndex = standArray[35].y;
         var mc:MovieClip = ComponentFactory.Instance.creat("buried.over.light");
         _loc14_ = 0.7;
         mc.scaleY = _loc14_;
         mc.scaleX = _loc14_;
         mc.x = 347.15;
         mc.y = 201.85;
         _map.getMapArray()[yIndex][xIndex].addChild(mc);
         _map.getMapArray()[yIndex][xIndex].addChild(spEnd);
         for(i = 0; i < len; )
         {
            data = list[i];
            xIndex = standArray[data.type].x;
            yIndex = standArray[data.type].y;
            spItem = creatIcon(data.tempID);
            _map.getMapArray()[yIndex][xIndex].addChild(spItem);
            i++;
         }
         var manX:int = standArray[BuriedManager.Instance.nowPosition].x;
         var manY:int = standArray[BuriedManager.Instance.nowPosition].y;
         _map.setRoadMan(manX,manY);
      }
      
      public function getRoadPoint() : Point
      {
         var p:Point = new Point();
         var manX:int = standArray[0].x;
         var manY:int = standArray[0].y;
         p.x = _map.getMapArray()[manY][manX].x;
         p.y = _map.getMapArray()[manY][manX].y;
         return p;
      }
      
      public function updateRoadPoint(pos:int = 0) : void
      {
         var xIndex:int = 0;
         var yIndex:int = 0;
         var bitMap:Bitmap = ComponentFactory.Instance.creat("buried.shaizi.nothing");
         if(pos == 0)
         {
            xIndex = standArray[BuriedManager.Instance.nowPosition].x;
            yIndex = standArray[BuriedManager.Instance.nowPosition].y;
         }
         else
         {
            xIndex = standArray[pos].x;
            yIndex = standArray[pos].y;
         }
         _map.getMapArray()[yIndex][xIndex].addChild(bitMap);
      }
      
      private function creatIcon(id:int) : Sprite
      {
         var bitMap:* = undefined;
         var info:* = null;
         var cell:* = null;
         var sp:Sprite = new Sprite();
         switch(int(id) - -8)
         {
            case 0:
               bitMap = ComponentFactory.Instance.creat("buried.shaizi.newTask");
               break;
            case 1:
               bitMap = ComponentFactory.Instance.creat("buried.shaizi.openQue");
               break;
            case 2:
               bitMap = ComponentFactory.Instance.creat("buried.shaizi.renwu");
               break;
            case 3:
               bitMap = ComponentFactory.Instance.creat("buried.shaizi.stonePic");
               break;
            case 4:
               bitMap = ComponentFactory.Instance.creat("buried.shaizi.toOver");
               break;
            case 5:
               bitMap = ComponentFactory.Instance.creat("buried.shaizi.comStep");
               break;
            case 6:
               bitMap = ComponentFactory.Instance.creat("buried.shaizi.backStep");
               break;
            case 7:
               bitMap = ComponentFactory.Instance.creat("buried.shaizi.returnO");
               break;
            case 8:
               bitMap = ComponentFactory.Instance.creat("buried.shaizi.nothing");
         }
         if(bitMap)
         {
            bitMap.smoothing = true;
            bitMap.width = 50;
            bitMap.height = 50;
            sp.addChild(bitMap);
         }
         sp.x = 3;
         sp.y = 1;
         return sp;
      }
      
      public function selfFindPath(xpos:int, ypos:int) : void
      {
         _map.startMove(xpos,ypos);
      }
      
      public function dispose() : void
      {
         if(_map)
         {
            _map.dispose();
         }
         ObjectUtils.disposeObject(_map);
         while(numChildren)
         {
            ObjectUtils.disposeObject(getChildAt(0));
         }
         _map = null;
         standArray = null;
      }
   }
}
