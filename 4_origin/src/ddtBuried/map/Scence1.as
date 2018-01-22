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
      
      public function Scence1(param1:String, param2:int, param3:int)
      {
         _mapArray = [];
         super();
         initView(param1,param2,param3);
      }
      
      private function initView(param1:String, param2:int, param3:int) : void
      {
         _mapArray = BuriedControl.Instance.oneDegreeToTwoDegree(param1,param2,param3);
         _map = new Maps(_mapArray,param2,param3);
         addChild(_map);
         initMapItem();
      }
      
      private function initMapItem() : void
      {
         var _loc8_:int = 0;
         var _loc12_:int = 0;
         var _loc2_:* = null;
         var _loc7_:int = 0;
         var _loc4_:* = null;
         var _loc3_:* = null;
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
         var _loc5_:Vector.<MapItemData> = BuriedManager.Instance.mapdataList;
         var _loc6_:int = _loc5_.length;
         _loc8_ = standArray[0].x;
         _loc12_ = standArray[0].y;
         var _loc13_:Sprite = new Sprite();
         _loc2_ = ComponentFactory.Instance.creat("buried.shaizi.startPoint");
         var _loc14_:* = 0.8;
         _loc2_.scaleY = _loc14_;
         _loc2_.scaleX = _loc14_;
         _loc13_.addChild(_loc2_);
         if(_map.getMapArray()[_loc12_][_loc8_].numChildren > 0)
         {
            _map.getMapArray()[_loc12_][_loc8_].removeChildAt(0);
         }
         _map.getMapArray()[_loc12_][_loc8_].addChild(_loc13_);
         var _loc1_:Sprite = creatIcon(BuriedControl.Instance.getUpdateData(false).DestinationReward);
         _loc8_ = standArray[35].x;
         _loc12_ = standArray[35].y;
         var _loc9_:MovieClip = ComponentFactory.Instance.creat("buried.over.light");
         _loc14_ = 0.7;
         _loc9_.scaleY = _loc14_;
         _loc9_.scaleX = _loc14_;
         _loc9_.x = 347.15;
         _loc9_.y = 201.85;
         _map.getMapArray()[_loc12_][_loc8_].addChild(_loc9_);
         _map.getMapArray()[_loc12_][_loc8_].addChild(_loc1_);
         _loc7_ = 0;
         while(_loc7_ < _loc6_)
         {
            _loc4_ = _loc5_[_loc7_];
            _loc8_ = standArray[_loc4_.type].x;
            _loc12_ = standArray[_loc4_.type].y;
            _loc3_ = creatIcon(_loc4_.tempID);
            _map.getMapArray()[_loc12_][_loc8_].addChild(_loc3_);
            _loc7_++;
         }
         var _loc11_:int = standArray[BuriedManager.Instance.nowPosition].x;
         var _loc10_:int = standArray[BuriedManager.Instance.nowPosition].y;
         _map.setRoadMan(_loc11_,_loc10_);
      }
      
      public function getRoadPoint() : Point
      {
         var _loc3_:Point = new Point();
         var _loc2_:int = standArray[0].x;
         var _loc1_:int = standArray[0].y;
         _loc3_.x = _map.getMapArray()[_loc1_][_loc2_].x;
         _loc3_.y = _map.getMapArray()[_loc1_][_loc2_].y;
         return _loc3_;
      }
      
      public function updateRoadPoint(param1:int = 0) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:Bitmap = ComponentFactory.Instance.creat("buried.shaizi.nothing");
         if(param1 == 0)
         {
            _loc2_ = standArray[BuriedManager.Instance.nowPosition].x;
            _loc3_ = standArray[BuriedManager.Instance.nowPosition].y;
         }
         else
         {
            _loc2_ = standArray[param1].x;
            _loc3_ = standArray[param1].y;
         }
         _map.getMapArray()[_loc3_][_loc2_].addChild(_loc4_);
      }
      
      private function creatIcon(param1:int) : Sprite
      {
         var _loc4_:* = undefined;
         var _loc5_:* = null;
         var _loc3_:* = null;
         var _loc2_:Sprite = new Sprite();
         switch(int(param1) - -8)
         {
            case 0:
               _loc4_ = ComponentFactory.Instance.creat("buried.shaizi.newTask");
               break;
            case 1:
               _loc4_ = ComponentFactory.Instance.creat("buried.shaizi.openQue");
               break;
            case 2:
               _loc4_ = ComponentFactory.Instance.creat("buried.shaizi.renwu");
               break;
            case 3:
               _loc4_ = ComponentFactory.Instance.creat("buried.shaizi.stonePic");
               break;
            case 4:
               _loc4_ = ComponentFactory.Instance.creat("buried.shaizi.toOver");
               break;
            case 5:
               _loc4_ = ComponentFactory.Instance.creat("buried.shaizi.comStep");
               break;
            case 6:
               _loc4_ = ComponentFactory.Instance.creat("buried.shaizi.backStep");
               break;
            case 7:
               _loc4_ = ComponentFactory.Instance.creat("buried.shaizi.returnO");
               break;
            case 8:
               _loc4_ = ComponentFactory.Instance.creat("buried.shaizi.nothing");
         }
         if(_loc4_)
         {
            _loc4_.smoothing = true;
            _loc4_.width = 50;
            _loc4_.height = 50;
            _loc2_.addChild(_loc4_);
         }
         _loc2_.x = 3;
         _loc2_.y = 1;
         return _loc2_;
      }
      
      public function selfFindPath(param1:int, param2:int) : void
      {
         _map.startMove(param1,param2);
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
