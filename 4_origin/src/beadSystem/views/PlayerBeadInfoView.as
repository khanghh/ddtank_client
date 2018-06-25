package beadSystem.views
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.player.PlayerInfo;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.geom.Point;
   import road7th.data.DictionaryData;
   import store.view.embed.EmbedStoneCell;
   
   public class PlayerBeadInfoView extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _beadCells:DictionaryData;
      
      private var _HoleOpen:DictionaryData;
      
      private var _pointArray:Vector.<Point>;
      
      private var _playerInfo:PlayerInfo;
      
      public function PlayerBeadInfoView()
      {
         super();
         _HoleOpen = new DictionaryData();
         _beadCells = new DictionaryData();
         getCellsPoint();
         initView();
      }
      
      private function initView() : void
      {
         var i:int = 0;
         var stoneCell:* = null;
         _bg = ComponentFactory.Instance.creatBitmap("beadSystem.playerBeadInfo.bg");
         addChild(_bg);
         var stoneAttackCell:EmbedStoneCell = ComponentFactory.Instance.creatCustomObject("ddtstore.StoreEmbedBG.EmbedStoneCell",[1,1]);
         stoneAttackCell.x = Point(ComponentFactory.Instance.creatCustomObject("bead.PlayerEmbedpoint1")).x;
         stoneAttackCell.y = Point(ComponentFactory.Instance.creatCustomObject("bead.PlayerEmbedpoint1")).y;
         stoneAttackCell.StoneType = 1;
         addChild(stoneAttackCell);
         _beadCells.add(1,stoneAttackCell);
         var stoneDefanceCell1:EmbedStoneCell = ComponentFactory.Instance.creatCustomObject("ddtstore.StoreEmbedBG.EmbedStoneCell",[2,2]);
         stoneDefanceCell1.x = Point(ComponentFactory.Instance.creatCustomObject("bead.PlayerEmbedpoint2")).x;
         stoneDefanceCell1.y = Point(ComponentFactory.Instance.creatCustomObject("bead.PlayerEmbedpoint2")).y;
         stoneDefanceCell1.StoneType = 2;
         addChild(stoneDefanceCell1);
         _beadCells.add(2,stoneDefanceCell1);
         var stoneDefanceCell2:EmbedStoneCell = ComponentFactory.Instance.creatCustomObject("ddtstore.StoreEmbedBG.EmbedStoneCell",[3,2]);
         stoneDefanceCell2.x = Point(ComponentFactory.Instance.creatCustomObject("bead.PlayerEmbedpoint3")).x;
         stoneDefanceCell2.y = Point(ComponentFactory.Instance.creatCustomObject("bead.PlayerEmbedpoint3")).y;
         stoneDefanceCell2.StoneType = 2;
         addChild(stoneDefanceCell2);
         _beadCells.add(3,stoneDefanceCell2);
         for(i = 4; i <= 12; )
         {
            stoneCell = ComponentFactory.Instance.creatCustomObject("ddtstore.StoreEmbedBG.EmbedStoneCell",[i,3]);
            stoneCell.StoneType = 3;
            stoneCell.x = _pointArray[i - 1].x;
            stoneCell.y = _pointArray[i - 1].y;
            addChild(stoneCell);
            _beadCells.add(i,stoneCell);
            i++;
         }
         var stoneNeedOpen1:EmbedStoneCell = ComponentFactory.Instance.creatCustomObject("ddtstore.StoreEmbedBG.EmbedStoneCell",[13,3]);
         stoneNeedOpen1.x = Point(ComponentFactory.Instance.creatCustomObject("bead.PlayerEmbedpoint13")).x;
         stoneNeedOpen1.y = Point(ComponentFactory.Instance.creatCustomObject("bead.PlayerEmbedpoint13")).y;
         stoneNeedOpen1.StoneType = 3;
         addChild(stoneNeedOpen1);
         _beadCells.add(13,stoneNeedOpen1);
         _HoleOpen.add(13,stoneNeedOpen1);
         var stoneNeedOpen2:EmbedStoneCell = ComponentFactory.Instance.creatCustomObject("ddtstore.StoreEmbedBG.EmbedStoneCell",[14,3]);
         stoneNeedOpen2.x = Point(ComponentFactory.Instance.creatCustomObject("bead.PlayerEmbedpoint14")).x;
         stoneNeedOpen2.y = Point(ComponentFactory.Instance.creatCustomObject("bead.PlayerEmbedpoint14")).y;
         stoneNeedOpen2.StoneType = 3;
         addChild(stoneNeedOpen2);
         _beadCells.add(14,stoneNeedOpen2);
         _HoleOpen.add(14,stoneNeedOpen2);
         var stoneNeedOpen3:EmbedStoneCell = ComponentFactory.Instance.creatCustomObject("ddtstore.StoreEmbedBG.EmbedStoneCell",[15,3]);
         stoneNeedOpen3.x = Point(ComponentFactory.Instance.creatCustomObject("bead.PlayerEmbedpoint15")).x;
         stoneNeedOpen3.y = Point(ComponentFactory.Instance.creatCustomObject("bead.PlayerEmbedpoint15")).y;
         stoneNeedOpen3.StoneType = 3;
         addChild(stoneNeedOpen3);
         _beadCells.add(15,stoneNeedOpen3);
         _HoleOpen.add(15,stoneNeedOpen3);
         var stoneNeedOpen4:EmbedStoneCell = ComponentFactory.Instance.creatCustomObject("ddtstore.StoreEmbedBG.EmbedStoneCell",[16,3]);
         stoneNeedOpen4.x = Point(ComponentFactory.Instance.creatCustomObject("bead.PlayerEmbedpoint16")).x;
         stoneNeedOpen4.y = Point(ComponentFactory.Instance.creatCustomObject("bead.PlayerEmbedpoint16")).y;
         stoneNeedOpen4.StoneType = 3;
         addChild(stoneNeedOpen4);
         _beadCells.add(16,stoneNeedOpen4);
         _HoleOpen.add(16,stoneNeedOpen4);
         var stoneNeedOpen5:EmbedStoneCell = ComponentFactory.Instance.creatCustomObject("ddtstore.StoreEmbedBG.EmbedStoneCell",[17,3]);
         stoneNeedOpen5.x = Point(ComponentFactory.Instance.creatCustomObject("bead.PlayerEmbedpoint17")).x;
         stoneNeedOpen5.y = Point(ComponentFactory.Instance.creatCustomObject("bead.PlayerEmbedpoint17")).y;
         stoneNeedOpen5.StoneType = 3;
         addChild(stoneNeedOpen5);
         _beadCells.add(17,stoneNeedOpen5);
         _HoleOpen.add(17,stoneNeedOpen5);
         var stoneNeedOpen6:EmbedStoneCell = ComponentFactory.Instance.creatCustomObject("ddtstore.StoreEmbedBG.EmbedStoneCell",[18,3]);
         stoneNeedOpen6.x = Point(ComponentFactory.Instance.creatCustomObject("bead.PlayerEmbedpoint18")).x;
         stoneNeedOpen6.y = Point(ComponentFactory.Instance.creatCustomObject("bead.PlayerEmbedpoint18")).y;
         stoneNeedOpen6.StoneType = 3;
         addChild(stoneNeedOpen6);
         _beadCells.add(18,stoneNeedOpen6);
         _HoleOpen.add(18,stoneNeedOpen6);
      }
      
      private function getCellsPoint() : void
      {
         var i:int = 0;
         var point:* = null;
         _pointArray = new Vector.<Point>();
         for(i = 1; i <= 18; )
         {
            point = ComponentFactory.Instance.creatCustomObject("bead.PlayerEmbedpoint" + i);
            _pointArray.push(point);
            i++;
         }
      }
      
      public function set playerInfo(value:PlayerInfo) : void
      {
         _playerInfo = value;
         if(value)
         {
            var _loc5_:int = 0;
            var _loc4_:* = _beadCells;
            for each(var o in _beadCells)
            {
               o.info = null;
            }
            var _loc7_:int = 0;
            var _loc6_:* = _beadCells;
            for each(var e in _beadCells)
            {
               e.otherPlayer = value;
               e.itemInfo = value.BeadBag.getItemAt(e.ID);
               e.info = value.BeadBag.getItemAt(e.ID);
               if(e.ID >= 13 && value.BeadBag.getItemAt(e.ID))
               {
                  e.open();
               }
            }
         }
      }
      
      public function dispose() : void
      {
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
         }
         _bg = null;
         var _loc3_:int = 0;
         var _loc2_:* = _beadCells;
         for each(var o in _beadCells)
         {
            ObjectUtils.disposeObject(o);
         }
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
