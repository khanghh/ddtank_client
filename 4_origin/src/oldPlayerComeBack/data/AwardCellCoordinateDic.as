package oldPlayerComeBack.data
{
   import flash.geom.Point;
   
   public class AwardCellCoordinateDic
   {
       
      
      private var _cellDic:Array;
      
      private var _totalCell:int = 36;
      
      private var _cellWidth:int = 50;
      
      private var _cellHeight:int = 50;
      
      private var _node1:Point;
      
      private var _node2:Point;
      
      private var _node3:Point;
      
      private var _node4:Point;
      
      public function AwardCellCoordinateDic()
      {
         _node1 = new Point(0,0);
         _node2 = new Point(580,82);
         _node3 = new Point(580,424);
         _node4 = new Point(-81,424);
         super();
         initCellPostion();
      }
      
      private function initCellPostion() : void
      {
         _cellDic = [];
         _cellDic[0] = new Point(0,5);
         _cellDic[1] = new Point(60,10);
         _cellDic[2] = new Point(120,10);
         _cellDic[3] = new Point(179,11);
         _cellDic[4] = new Point(238,11);
         _cellDic[5] = new Point(297,11);
         _cellDic[6] = new Point(356,11);
         _cellDic[7] = new Point(416,11);
         _cellDic[8] = new Point(474,11);
         _cellDic[9] = new Point(533,11);
         _cellDic[10] = new Point(604,11);
         _cellDic[11] = new Point(604,84);
         _cellDic[12] = new Point(604,141);
         _cellDic[13] = new Point(604,199);
         _cellDic[14] = new Point(604,256);
         _cellDic[15] = new Point(604,316);
         _cellDic[16] = new Point(604,374);
         _cellDic[17] = new Point(604,445);
         _cellDic[18] = new Point(533,445);
         _cellDic[19] = new Point(476,445);
         _cellDic[20] = new Point(416,445);
         _cellDic[21] = new Point(358,445);
         _cellDic[22] = new Point(297,445);
         _cellDic[23] = new Point(238,445);
         _cellDic[24] = new Point(179,445);
         _cellDic[25] = new Point(121,445);
         _cellDic[26] = new Point(61,445);
         _cellDic[27] = new Point(2,445);
         _cellDic[28] = new Point(-66,445);
         _cellDic[29] = new Point(-66,373);
         _cellDic[30] = new Point(-66,316);
         _cellDic[31] = new Point(-66,257);
         _cellDic[32] = new Point(-66,199);
         _cellDic[33] = new Point(-66,142);
         _cellDic[34] = new Point(-66,84);
         _cellDic[35] = new Point(-66,10);
      }
      
      public function get cellsPostion() : Array
      {
         return _cellDic.concat();
      }
   }
}
