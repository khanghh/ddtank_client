package game.objects
{
   import flash.geom.Point;
   import game.view.map.MapView;
   import gameCommon.model.Bomb;
   import gameCommon.model.GameInfo;
   import gameCommon.model.Living;
   import phy.maps.Map;
   import phy.object.PhysicalObj;
   
   public class TowBomb extends SimpleBomb
   {
       
      
      private var _tempAction:Array;
      
      private var _tempMap:Map;
      
      public function TowBomb(param1:Bomb, param2:Living, param3:int = 0, param4:Boolean = false){super(null,null,null,null);}
      
      private function initData(param1:Bomb) : void{}
      
      private function actionSort(param1:BombAction, param2:BombAction) : int{return 0;}
      
      override public function setMap(param1:Map) : void{}
      
      override protected function isPillarCollide() : Boolean{return false;}
      
      override public function bomb() : void{}
      
      private function exeTempAction() : void{}
      
      override public function dispose() : void{}
   }
}
